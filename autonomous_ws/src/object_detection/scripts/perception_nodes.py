#!/usr/bin/env python3
import numpy as np
import rospy 
import cv2
from sensor_msgs.msg import Image
from rospy.numpy_msg import numpy_msg

from perception.msg import Object
from perception.msg import Objects
import time
import torch
from torch.backends import cudnn
from backbone import HybridNetsBackbone
import cv2
import numpy as np
from glob import glob
from utils.utils import letterbox, scale_coords, postprocess, BBoxTransform, ClipBoxes, restricted_float, \
    boolean_string, Params
from utils.plot import STANDARD_COLORS, standard_to_bgr, get_index_label, plot_one_box
import os
from torchvision import transforms
import argparse

import rospkg
rp = rospkg.RosPack()
#finding the package in the directory using ros package
path_to_scripts = rp.get_path('perception')+'/scripts/'
#loading the parameter from the config file
params = Params(path_to_scripts+'projects/bdd100k.yml')
#loading the parameter using the parameter server 
compound_coef = rospy.get_param("/compound_coef")#args.compound_coef
weight = path_to_scripts + rospy.get_param("/load_weights") #args.load_weights
input_imgs = []
shapes = []

anchors_ratios = params.anchors_ratios
anchors_scales = params.anchors_scales

threshold = rospy.get_param("/nms_thresh") #args.nms_thresh
iou_threshold = rospy.get_param("/iou_thresh") #args.iou_thresh

use_cuda = rospy.get_param("/cuda") #args.cuda
use_float16 = rospy.get_param("/float16") #args.float16
camera_topic= rospy.get_param("/camera_topic")
detection_topic=rospy.get_param("/final_detection_topic")
output_image_topic=rospy.get_param("/final_image_topic")
cudnn.fastest = True
cudnn.benchmark = True

obj_list = params.obj_list
seg_list = params.seg_list

color_list = standard_to_bgr(STANDARD_COLORS)
resized_shape = params.model['image_size']
if isinstance(resized_shape, list):
    resized_shape = max(resized_shape)
normalize = transforms.Normalize(
    mean=params.mean, std=params.std
)
transform = transforms.Compose([
    transforms.ToTensor(),
    normalize,
])
# print(x.shape)

model = HybridNetsBackbone(compound_coef=compound_coef, num_classes=len(obj_list),
                           ratios=eval(anchors_ratios), scales=eval(anchors_scales), seg_classes=len(seg_list))
try:
    model.load_state_dict(torch.load(weight, map_location='cuda' if use_cuda else 'cpu'))
except:
    model.load_state_dict(torch.load(weight, map_location='cuda' if use_cuda else 'cpu')['model'])
model.requires_grad_(False)
model.eval()

if use_cuda:
    model = model.cuda()
if use_float16:
    model = model.half()

count=0
def img_publishing(pub,frame):
    msg = Image()
    msg.header.stamp = rospy.Time.now()
    msg.height = frame.shape[:2][0]
    msg.width = frame.shape[:2][1]
    msg.encoding = "rgb8"
    msg.is_bigendian = False
    msg.step = 3 * frame.shape[:2][1]
    msg.data = np.array(frame).tobytes()
    pub.publish(msg)
def detection(frame,header):
    start=time.time()
    image_bb_pub = rospy.Publisher(detection_topic,Objects,queue_size=1)
    pub = rospy.Publisher(output_image_topic, Image, queue_size=10)
    global count
    
    frame= cv2.resize(frame, (1280,720), interpolation = cv2.INTER_AREA)
  
    # frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    h0, w0 = frame.shape[:2]  # orig hw
    print("original width and height",h0,w0)
    r = resized_shape / max(h0, w0)  # resize image to img_size

    input_img = cv2.resize(frame, (int(w0 * r), int(h0 * r)), interpolation=cv2.INTER_AREA)
    h, w = input_img.shape[:2]
    print("original width and height",h,w)
    (input_img, _, _), ratio, pad = letterbox((input_img, input_img.copy(), input_img.copy()), resized_shape, auto=True,
                                                scaleup=False)

    shapes = ((h0, w0), ((h / h0, w / w0), pad))

    if use_cuda:
        x = transform(input_img).cuda()
    else:
        x = transform(input_img)

    x = x.to(torch.float32 if not use_float16 else torch.float16)
    x.unsqueeze_(0)
    with torch.no_grad():
        features, regression, classification, anchors, seg = model(x)

        seg = seg[:, :, 12:372, :]
        da_seg_mask = torch.nn.functional.interpolate(seg, size=[h0, w0], mode='nearest')
        _, da_seg_mask = torch.max(da_seg_mask, 1)
        da_seg_mask_ = da_seg_mask[0].squeeze().cpu().numpy().round()

        color_area = np.zeros((da_seg_mask_.shape[0], da_seg_mask_.shape[1], 3), dtype=np.uint8)
        color_area[da_seg_mask_ == 1] = [0, 255, 0]
        color_area[da_seg_mask_ == 2] = [0, 0, 255]
        color_seg = color_area[..., ::-1]
        
        # cv2.imwrite('seg_only_{}.jpg'.format(i), color_seg)

        color_mask = np.mean(color_seg, 2)
        
     
        frame[color_mask != 0] = frame[color_mask != 0] * 0.5 + color_seg[color_mask != 0] * 0.5
        frame = frame.astype(np.uint8)
        # cv2.imwrite('seg_{}.jpg'.format(i), ori_img)
        print("Type of the segmentation",frame.shape)
        print("Type of the segmentation",color_mask.shape)
        regressBoxes = BBoxTransform()
        clipBoxes = ClipBoxes()
        out = postprocess(x,
                            anchors, regression, classification,
                            regressBoxes, clipBoxes,
                            threshold, iou_threshold)
        out = out[0]
        out['rois'] = scale_coords(frame[:2], out['rois'], shapes[0], shapes[1])
        bbxes = Objects()
        # bbxes.frame  = frame
        bbxes.header = header
        for j in range(len(out['rois'])):
            bbx=Object()
            x1, y1, x2, y2 = out['rois'][j].astype(int)
            obj = obj_list[out['class_ids'][j]]
            score = float(out['scores'][j])
            intbox = map(int, (x1, y1, x2, y2))
            bbx.xmin, bbx.ymin, bbx.xmax, bbx.ymax = intbox
            # print("This is the bbox",bbx.xmin, bbx.ymin, bbx.xmax, bbx.ymax)
            bbx.label=obj
            bbxes.objects.append(bbx)
            # if bbx.ymin <0 or bbx.ymax<0:
            #     bbx.ymin=max(0,bbx.ymin)
            #     bbx.ymax=max(0,bbx.ymax)
            #     print("This is the bbox",bbx.xmin, bbx.ymin, bbx.xmax, bbx.ymax)
                
                
            plot_one_box(frame, [x1, y1, x2, y2], label=obj, score=score,
                            color=color_list[get_index_label(obj, obj_list)])
        # cv2.imwrite(f'output/{count}.jpg',frame)
        #publishing image for testing purpose
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        img_publishing(pub,frame)
        print(type(frame))
        # print(bbxes)
        image_bb_pub.publish(bbxes)

  
    count+=1
    print("yes!!")
    final=time.time()
    print(1/(final-start))
def vis_callback( data ):
  im = np.frombuffer(data.data, dtype=np.uint8).reshape(data.height, data.width, -1)
  detection(im,data.header)

rospy.init_node('perception_nodes', anonymous=True)

sub_vis = rospy.Subscriber(camera_topic, numpy_msg(Image), vis_callback)

rospy.spin()