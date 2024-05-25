
(in-package #:gema)

(eval-when (:compile-toplevel :load-toplevel :execute)

  (defun add-macro-specialization (generic-name specialization-name)
    (when (not (get generic-name 'specializations))
      (setf (get generic-name 'specializations) nil))
    (push specialization-name (get generic-name 'specializations)))
  
  (defun expand-specialization (specialization-name args)
    (handler-case (let ((result (macroexpand (cons specialization-name args))))
                    (values result t))
      (error (c)
        (declare (ignore c))
        (values nil nil))))
  
  (defun expand-generic-macro (generic-name args)
    (let ((specializations (get generic-name 'specializations)))
      (loop for specialization in specializations
            do (multiple-value-bind (result expanded) (expand-specialization specialization args)
                 (when expanded
                   (return-from expand-generic-macro result))))
      (error "No suitable specialization for the macro ~s." generic-name))))

(defmacro define-generic-macro (name macro-lambda-list &body body)
  `(progn
     ,@(when (not (get name 'specializations))
        (let ((args (gensym "ARGS")))
          `((defmacro ,name (&rest ,args)
              (expand-generic-macro ',name ,args)))))
     ,@(let ((specialization (gensym (symbol-name name))))
         `((defmacro ,specialization ,macro-lambda-list
             ,@body)
           (eval-when (:compile-toplevel :load-toplevel :execute)
             (add-macro-specialization ',name ',specialization))))
     (values ',name)))

(defmacro define-cl-generic-macros ()
  (let ((generic-macro-definitions '()))
    (do-external-symbols (sym :cl)
      (let ((macro-func (macro-function sym))
            (rest-args (gensym "REST-ARGS")))
        (when macro-func
          (shadow sym)
          (export (find-symbol (symbol-name sym)))
          (push `(define-generic-macro ,(intern (symbol-name sym)) (&rest ,rest-args)
                   `(,',sym ,@,rest-args))
                generic-macro-definitions))))
    (cons 'progn generic-macro-definitions)))

(define-cl-generic-macros)
