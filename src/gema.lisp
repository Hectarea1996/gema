
(in-package #:gema)

(eval-when (:compile-toplevel :load-toplevel :execute)

  (cl:defun add-macro-specialization (generic-name specialization-name)
    (cl:when (not (get generic-name 'specializations))
      (cl:setf (get generic-name 'specializations) nil))
    (cl:push specialization-name (get generic-name 'specializations)))
  
  (cl:defun expand-specialization (specialization-name args)
    (cl:handler-case (let ((result (macroexpand (cons specialization-name args))))
                       (values result t))
      (error (c)
        (declare (ignore c))
        (values nil nil))))
  
  (cl:defun expand-generic-macro (generic-name args)
    (let ((specializations (get generic-name 'specializations)))
      (cl:loop for specialization in specializations
         do (cl:multiple-value-bind (result expanded) (expand-specialization specialization args)
              (cl:when expanded
                (return-from expand-generic-macro result))))
      (error "No suitable specialization for the macro ~s." generic-name))))

(cl:defmacro define-generic-macro (name macro-lambda-list &body body)
  "Defines a new generic macro. If the generic macro already exists, then a new specialization is added.
When using the generic macro, the last specialization defined that does not fail at macroexpansion is used."
  `(progn
     ,@(cl:when (not (get name 'specializations))
         (let ((args (gensym "ARGS")))
           `((cl:defmacro ,name (&rest ,args)
               (expand-generic-macro ',name ,args)))))
     ,@(let ((specialization (gentemp (symbol-name name))))
         `((cl:defmacro ,specialization ,macro-lambda-list
             ,@body)
           (eval-when (:compile-toplevel :load-toplevel :execute)
             (cl:when (not (member ',specialization (get ',name 'specializations)))
               (add-macro-specialization ',name ',specialization)))))
     (values ',name)))

(cl:defmacro define-cl-generic-macros ()
  (let ((generic-macro-definitions '()))
    (cl:do-external-symbols (sym :cl)
      (let ((macro-func (macro-function sym))
            (rest-args (gensym "REST-ARGS")))
        (cl:when macro-func
          (cl:push `(define-generic-macro ,(find-symbol (symbol-name sym) '#:gema) (&rest ,rest-args)
                     `(,',sym ,@,rest-args))
                generic-macro-definitions))))
    (cons 'progn generic-macro-definitions)))

(define-cl-generic-macros)
