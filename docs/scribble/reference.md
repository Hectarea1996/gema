
<a id="header-adp-github-api-reference"></a>
# API reference

<a id="function-gema-define-generic-macro"></a>
#### Macro: gema:define-generic-macro (name macro-lambda-list &body body)

`````text
Defines a new generic macro. If the generic macro already exists, then a new specialization is added.
When using the generic macro, the last specialization defined that does not fail at macroexpansion is used.
`````