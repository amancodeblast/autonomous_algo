; Auto-generated. Do not edit!


(cl:in-package perception-msg)


;//! \htmlinclude Objects.msg.html

(cl:defclass <Objects> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (objects
    :reader objects
    :initarg :objects
    :type (cl:vector perception-msg:Object)
   :initform (cl:make-array 0 :element-type 'perception-msg:Object :initial-element (cl:make-instance 'perception-msg:Object)))
   (frame
    :reader frame
    :initarg :frame
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image)))
)

(cl:defclass Objects (<Objects>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Objects>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Objects)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name perception-msg:<Objects> is deprecated: use perception-msg:Objects instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Objects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception-msg:header-val is deprecated.  Use perception-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'objects-val :lambda-list '(m))
(cl:defmethod objects-val ((m <Objects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception-msg:objects-val is deprecated.  Use perception-msg:objects instead.")
  (objects m))

(cl:ensure-generic-function 'frame-val :lambda-list '(m))
(cl:defmethod frame-val ((m <Objects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception-msg:frame-val is deprecated.  Use perception-msg:frame instead.")
  (frame m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Objects>) ostream)
  "Serializes a message object of type '<Objects>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objects))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'frame) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Objects>) istream)
  "Deserializes a message object of type '<Objects>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'perception-msg:Object))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'frame) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Objects>)))
  "Returns string type for a message object of type '<Objects>"
  "perception/Objects")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Objects)))
  "Returns string type for a message object of type 'Objects"
  "perception/Objects")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Objects>)))
  "Returns md5sum for a message object of type '<Objects>"
  "f6393f2ba536fb9c0b95348c35d4a1c9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Objects)))
  "Returns md5sum for a message object of type 'Objects"
  "f6393f2ba536fb9c0b95348c35d4a1c9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Objects>)))
  "Returns full string definition for message of type '<Objects>"
  (cl:format cl:nil "std_msgs/Header header~%Object[] objects~%~%sensor_msgs/Image frame~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: perception/Object~%std_msgs/Header                 header~%uint32                          id~%string                          label~%int32                           class_num~%float32                         score   #Score as defined by the detection, Optional~%############### 2D Rect~%int32                           xmin           # X coord in image space(pixel) of the initial point of the Rect~%int32                           ymin           # Y coord in image space(pixel) of the initial point of the Rect~%int32                           xmax       # Width of the Rect in pixels~%int32                           ymax      # Height of the Rect in pixels~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Objects)))
  "Returns full string definition for message of type 'Objects"
  (cl:format cl:nil "std_msgs/Header header~%Object[] objects~%~%sensor_msgs/Image frame~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: perception/Object~%std_msgs/Header                 header~%uint32                          id~%string                          label~%int32                           class_num~%float32                         score   #Score as defined by the detection, Optional~%############### 2D Rect~%int32                           xmin           # X coord in image space(pixel) of the initial point of the Rect~%int32                           ymin           # Y coord in image space(pixel) of the initial point of the Rect~%int32                           xmax       # Width of the Rect in pixels~%int32                           ymax      # Height of the Rect in pixels~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Objects>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'frame))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Objects>))
  "Converts a ROS message object to a list"
  (cl:list 'Objects
    (cl:cons ':header (header msg))
    (cl:cons ':objects (objects msg))
    (cl:cons ':frame (frame msg))
))
