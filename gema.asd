
(defsystem "gema"
  :author "Héctor Galbis Sanchis"
  :description "GEneric MAcros for Common Lisp."
  :license "MIT"
  :components ((:module "src"
                :components ((:file "package")
                             (:file "gema")))))

(defsystem "gema/docs"
  :author "Héctor Galbis Sanchis"
  :description "GEMA's documentation."
  :license "MIT"
  :build-operation "adp-github-op"
  :defsystem-depends-on ("adp-github")
  :depends-on ("gema")
  :components ((:module "scribble"
                :components ((:scribble "reference")
                             (:scribble "README")))))
