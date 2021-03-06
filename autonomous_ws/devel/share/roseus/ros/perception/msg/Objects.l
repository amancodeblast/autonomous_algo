;; Auto-generated. Do not edit!


(when (boundp 'perception::Objects)
  (if (not (find-package "PERCEPTION"))
    (make-package "PERCEPTION"))
  (shadow 'Objects (find-package "PERCEPTION")))
(unless (find-package "PERCEPTION::OBJECTS")
  (make-package "PERCEPTION::OBJECTS"))

(in-package "ROS")
;;//! \htmlinclude Objects.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass perception::Objects
  :super ros::object
  :slots (_header _objects _frame ))

(defmethod perception::Objects
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:objects __objects) (let (r) (dotimes (i 0) (push (instance perception::Object :init) r)) r))
    ((:frame __frame) (instance sensor_msgs::Image :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _objects __objects)
   (setq _frame __frame)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:objects
   (&rest __objects)
   (if (keywordp (car __objects))
       (send* _objects __objects)
     (progn
       (if __objects (setq _objects (car __objects)))
       _objects)))
  (:frame
   (&rest __frame)
   (if (keywordp (car __frame))
       (send* _frame __frame)
     (progn
       (if __frame (setq _frame (car __frame)))
       _frame)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; perception/Object[] _objects
    (apply #'+ (send-all _objects :serialization-length)) 4
    ;; sensor_msgs/Image _frame
    (send _frame :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; perception/Object[] _objects
     (write-long (length _objects) s)
     (dolist (elem _objects)
       (send elem :serialize s)
       )
     ;; sensor_msgs/Image _frame
       (send _frame :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; perception/Object[] _objects
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objects (let (r) (dotimes (i n) (push (instance perception::Object :init) r)) r))
     (dolist (elem- _objects)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; sensor_msgs/Image _frame
     (send _frame :deserialize buf ptr-) (incf ptr- (send _frame :serialization-length))
   ;;
   self)
  )

(setf (get perception::Objects :md5sum-) "f6393f2ba536fb9c0b95348c35d4a1c9")
(setf (get perception::Objects :datatype-) "perception/Objects")
(setf (get perception::Objects :definition-)
      "std_msgs/Header header
Object[] objects

sensor_msgs/Image frame

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: perception/Object
std_msgs/Header                 header
uint32                          id
string                          label
int32                           class_num
float32                         score   #Score as defined by the detection, Optional
############### 2D Rect
int32                           xmin           # X coord in image space(pixel) of the initial point of the Rect
int32                           ymin           # Y coord in image space(pixel) of the initial point of the Rect
int32                           xmax       # Width of the Rect in pixels
int32                           ymax      # Height of the Rect in pixels


================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

")



(provide :perception/Objects "f6393f2ba536fb9c0b95348c35d4a1c9")


