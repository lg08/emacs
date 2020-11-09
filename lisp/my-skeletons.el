
(define-skeleton template-tag-skeleton
  "fills our template tags"
  "inside the template tag: "
  "{% " str " %}")

(define-skeleton template-block-skeleton
  "creates a block in template tags"
  "name of block: "
  "{% block " str " %}" \n \n \n  _ \n \n \n "{% endblock %}")

(define-skeleton template-for-loop-skeleton
  "creates a for loop in template tags"
  "for: "
  "{% for " str " %}" \n _ \n "{% endfor %}")

(define-skeleton template-url-skeleton
  "creates a url template"
  ""
  "{% url '" _ "' %}")

(define-skeleton template-if-skeleton
  "creates a url template"
  ""
  "{% if " _ " %}" \n \n "{% else %}" \n \n "{% endif %}")

(define-skeleton org-code-template
  "sets up the template to insert code"
  "what language bitch: "
  "#+BEGIN_SRC " str \n \n _ \n \n "#+END_SRC")

(define-skeleton use-package-template
  "basic use-package setup"
  "package: "
  "(use-package " str \n ":defer t" \n ":config" \n _ \n ")")

(provide 'my-skeletons)
