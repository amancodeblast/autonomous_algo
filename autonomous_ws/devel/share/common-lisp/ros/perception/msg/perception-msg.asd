
(cl:in-package :asdf)

(defsystem "perception-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :sensor_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Object" :depends-on ("_package_Object"))
    (:file "_package_Object" :depends-on ("_package"))
    (:file "Objects" :depends-on ("_package_Objects"))
    (:file "_package_Objects" :depends-on ("_package"))
  ))