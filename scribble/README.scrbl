
(in-package #:adp-github)

@select-output-file["README"]

@header[]{GEneric MAcros}

Welcome to GEMA!

GEMA is a tiny project that tries to define generic macros. Actually there is not such a think like generic macros, but we can try to simulate it.

A generic macro in GEMA is just a bunch of regular macros that one of them will be selected depending on the arguments at the time the macro is used. Behind the scenes, each macro belonging to that set is tried to be macroexpanded. If the macroexpansion fails, the next is macroexpanded. And so on until a valid macroexpansion is found. A macroexpansion is considered a failure if it raises an @bold{error}.

Currently, no collision check is made. I.e, the same macro can be duplicated in the bunch of regular macros belonging to one of the generic macros.


@subheader[]{Getting Started}

The macro @fref[gema:define-generic-macro] is the macro that allows you to define a generic macro. It has the same syntax as @code{defmacro}.

As an example, let's define a macro that behaves as a @code{let} except when a @code{pathname} is received. First, we define @code{my-let} as a simplification of @code{let}:

@example|{
(gema:define-generic-macro my-let (((var val)) &body body)
  (check-type var symbol)
  (when (pathnamep val) (error "This version does not accept a pathname."))
  `(let ((,var ,val))
     ,@body))
}|

Let's test our new macro:

@example{
(my-let ((x 5)) (print x))
}

Now, let's define the version receiving a pathname:

@example|{
(gema:define-generic-macro my-let (((var val)) &body body)
  (check-type var symbol)
  (check-type val pathname)
  `(progn
     (format t "Pathname used: ~s" ,val)
     (let ((,var ,val))
       ,@body)))
}|

Now, we have two different versions of @code{my-let}. Depending on the type of object we use one of those version will be used:

@example{
(my-let ((p #p"/path/to/file.txt"))
  (declare (ignore p))
  (print "Yay!"))
}

Let's try to use the first version again:

@example{
(my-let ((x 'sym))
  (declare (ignore x))
  (print "Just 1 print again!"))
}


@subheader[]{Documentation}

@list[
@item{@href[api-reference]}
]


@subheader{All CL generic macros}

GEMA also exports every macro from the package @code{common-lisp} as a generic macro.

@example|{
(gema:define-generic-macro gema:defun ((debug-sym name) &rest args)
  (check-type debug-sym symbol)
  (check-type name symbol)
  (unless (eq debug-sym 'debug)
    (error "Expected the symbol DEBUG before NAME"))
  `(progn
     (format t "Function with arguments: ~s" ',(car args))
     (cl:defun ,name ,@args)))
}|

Now we have two versions of @code{gema:defun}:

@example{
(gema:defun regular-add (a b)
  (+ a b))

(gema:defun (debug debug-add) (a b)
  (+ a b))
}

Note that the debug message is printed.
