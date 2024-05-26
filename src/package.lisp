
(defpackage #:gema
  (:use :cl)
  (:export
   #:define-generic-macro

   #:do-all-symbols #:lambda #:incf #:loop-finish #:call-method #:pushnew #:define-symbol-macro #:defclass
   #:defun #:multiple-value-bind #:nth-value #:defsetf #:untrace #:dolist #:with-hash-table-iterator #:assert
   #:with-compilation-unit #:defmethod #:pop #:setf #:defconstant #:define-method-combination #:decf #:typecase
   #:prog #:loop #:with-input-from-string #:time #:step #:trace #:with-open-stream #:ccase
   #:pprint-logical-block #:push #:formatter #:with-slots #:psetq #:handler-bind #:restart-case
   #:with-package-iterator #:defstruct #:do-symbols #:prog* #:with-accessors #:prog2 #:do* #:cond #:defvar
   #:do-external-symbols #:check-type #:defgeneric #:declaim #:deftype #:defmacro #:ecase
   #:print-unreadable-object #:defparameter #:defpackage #:multiple-value-list #:handler-case #:unless #:remf
   #:rotatef #:pprint-exit-if-list-exhausted #:restart-bind #:or #:ctypecase #:pprint-pop
   #:with-condition-restarts #:case #:define-compiler-macro #:etypecase #:prog1 #:multiple-value-setq
   #:with-open-file #:when #:with-standard-io-syntax #:do #:in-package #:ignore-errors #:define-modify-macro
   #:with-output-to-string #:with-simple-restart #:define-condition #:and #:return #:define-setf-expander
   #:shiftf #:psetf #:destructuring-bind #:dotimes)
  (:shadow
   #:do-all-symbols #:lambda #:incf #:loop-finish #:call-method #:pushnew #:define-symbol-macro #:defclass
   #:defun #:multiple-value-bind #:nth-value #:defsetf #:untrace #:dolist #:with-hash-table-iterator #:assert
   #:with-compilation-unit #:defmethod #:pop #:setf #:defconstant #:define-method-combination #:decf #:typecase
   #:prog #:loop #:with-input-from-string #:time #:step #:trace #:with-open-stream #:ccase
   #:pprint-logical-block #:push #:formatter #:with-slots #:psetq #:handler-bind #:restart-case
   #:with-package-iterator #:defstruct #:do-symbols #:prog* #:with-accessors #:prog2 #:do* #:cond #:defvar
   #:do-external-symbols #:check-type #:defgeneric #:declaim #:deftype #:defmacro #:ecase
   #:print-unreadable-object #:defparameter #:defpackage #:multiple-value-list #:handler-case #:unless #:remf
   #:rotatef #:pprint-exit-if-list-exhausted #:restart-bind #:or #:ctypecase #:pprint-pop
   #:with-condition-restarts #:case #:define-compiler-macro #:etypecase #:prog1 #:multiple-value-setq
   #:with-open-file #:when #:with-standard-io-syntax #:do #:in-package #:ignore-errors #:define-modify-macro
   #:with-output-to-string #:with-simple-restart #:define-condition #:and #:return #:define-setf-expander
   #:shiftf #:psetf #:destructuring-bind #:dotimes))
