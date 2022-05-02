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

