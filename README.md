

<a id="header-adp-github-headertag613"></a>
# GEneric MAcros

Welcome to GEMA\!

GEMA is a tiny project that tries to define generic macros\. Actually there is not such a think like generic macros\, but we can try to simulate it\.

A generic macro in GEMA is just a bunch of regular macros that one of them will be selected depending on the arguments at the time the macro is used\. Behind the scenes\, each macro belonging to that set is tried to be macroexpanded\. If the macroexpansion fails\, the next is macroexpanded\. And so on until a valid macroexpansion is found\. A macroexpansion is considered a failure if it raises an **error**\.

Currently\, no collision check is made\. I\.e\, the same macro can be duplicated in the bunch of regular macros belonging to one of the generic macros\.


<a id="header-adp-github-headertag614"></a>
## Getting Started

The macro [gema\:define\-generic\-macro](/docs/scribble/reference.md#function-gema-define-generic-macro) is the macro that allows you to define a generic macro\. It has the same syntax as ``` defmacro ```\.

As an example\, let\'s define a macro that behaves as a ``` let ``` except when a ``` pathname ``` is received\. First\, we define ``` my-let ``` as a simplification of ``` let ```\:

`````common-lisp
(gema:define-generic-macro my-let (((var val)) &body body)
  (check-type var symbol)
  (when (pathnamep val) (error "This version does not accept a pathname."))
  `(let ((,var ,val))
     ,@body))
`````
`````common-lisp
my-let
`````

Let\'s test our new macro\:

`````common-lisp
(my-let ((x 5)) (print x))
`````
`````text

5 
`````
`````common-lisp
5
`````

Now\, let\'s define the version receiving a pathname\:

`````common-lisp
(gema:define-generic-macro my-let (((var val)) &body body)
  (check-type var symbol)
  (check-type val pathname)
  `(progn
     (format t "Pathname used: ~s" ,val)
     (let ((,var ,val))
       ,@body)))
`````
`````common-lisp
my-let
`````

Now\, we have two different versions of ``` my-let ```\. Depending on the type of object we use one of those version will be used\:

`````common-lisp
(my-let ((p #p"/path/to/file.txt"))
  (declare (ignore p))
  (print "Yay!"))
`````
`````text
Pathname used: #P"/path/to/file.txt"
"Yay!" 
`````
`````common-lisp
"Yay!"
`````

Let\'s try to use the first version again\:

`````common-lisp
(my-let ((x 'sym))
  (declare (ignore x))
  (print "Just 1 print again!"))
`````
`````text

"Just 1 print again!" 
`````
`````common-lisp
"Just 1 print again!"
`````


<a id="header-adp-github-headertag625"></a>
## Documentation

(#<adpgh:item {1002AA84A3}>)


<a id="header-adp-github-headertag626"></a>
## All CL generic macros

GEMA also exports every macro from the package ``` common-lisp ``` as a generic macro\.

`````common-lisp
(gema:define-generic-macro gema:defun ((debug-sym name) &rest args)
  (check-type debug-sym symbol)
  (check-type name symbol)
  (unless (eq debug-sym 'debug)
    (error "Expected the symbol DEBUG before NAME"))
  `(progn
     (format t "Function with arguments: ~s" ',(car args))
     (cl:defun ,name ,@args)))
`````
`````common-lisp
gema:defun
`````

Now we have two versions of ``` gema:defun ```\:

`````common-lisp
(gema:defun regular-add (a b)
  (+ a b))

(gema:defun (debug debug-add) (a b)
  (+ a b))
`````
`````text
Function with arguments: (A B)
`````
`````common-lisp
debug-add
`````

Note that the debug message is printed\.