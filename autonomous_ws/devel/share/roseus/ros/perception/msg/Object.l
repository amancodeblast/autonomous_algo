;; Auto-generated. Do not edit!


(when (boundp 'perception::Object)
  (if (not (find-package "PERCEPTION"))
    (make-package "PERCEPTION"))
  (shadow 'Object (find-package "PERCEPTION")))
(unless (find-package "PERCEPTION::OBJECT")
  (make-package "PERCEPTION::OBJECT"))

(in-package "ROS")
;;//! \htmlinclude Object.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass perception::Object
  :super ros::object
  :slots (_header _id _label _class_num _score _xmin _ymin _xmax _ymax ))

(defmethod perception::Object
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:id __id) 0)
    ((:label __label) "")
    ((:class_num __class_num) 0)
    ((:score __score) 0.0)
    ((:xmin __xmin) 0)
    ((:ymin __ymin) 0)
    ((:xmax __xmax) 0)
    ((:ymax __ymax) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _id (round __id))
   (setq _label (string __label))
   (setq _class_num (round __class_num))
   (setq _score (float __score))
   (setq _xmin (round __xmin))
   (setq _ymin (round __ymin))
   (setq _xmax (round __xmax))
   (setq _ymax (round __ymax))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:label
   (&optional __label)
   (if __label (setq _label __label)) _label)
  (:class_num
   (&optional __class_num)
   (if __class_num (setq _class_num __class_num)) _class_num)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:xmin
   (&optional __xmin)
   (if __xmin (setq _xmin __xmin)) _xmin)
  (:ymin
   (&optional __ymin)
   (if __ymin (setq _ymin __ymin)) _ymin)
  (:xmax
   (&optional __xmax)
   (if __xmax (setq _xmax __xmax)) _xmax)
  (:ymax
   (&optional __ymax)
   (if __ymax (setq _ymax __ymax)) _ymax)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _id
    4
    ;; string _label
    4 (length _label)
    ;; int32 _class_num
    4
    ;; float32 _score
    4
    ;; int32 _xmin
    4
    ;; int32 _ymin
    4
    ;; int32 _xmax
    4
    ;; int32 _ymax
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _id
       (write-long _id s)
     ;; string _label
       (write-long (length _label) s) (princ _label s)
     ;; int32 _class_num
       (write-long _class_num s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _xmin
       (write-long _xmin s)
     ;; int32 _ymin
       (write-long _ymin s)
     ;; int32 _xmax
       (write-long _xmax s)
     ;; int32 _ymax
       (write-long _ymax s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _class_num
     (setq _class_num (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _xmin
     (setq _xmin (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _ymin
     (setq _ymin (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _xmax
     (setq _xmax (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _ymax
     (setq _ymax (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get perception::Object :md5sum-) "49dce74e1d117448f821a4b639562a8e")
(setf (get perception::Object :datatype-) "perception/Object")
(setf (get perception::Object :definition-)
      "std_msgs/Header                 header
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

")



(provide :perception/Object "49dce74e1d117448f821a4b639562a8e")


