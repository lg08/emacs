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

(define-skeleton latex-basic-setup-template
  "basic latex setup template"
  ""
  "
#+latex_class: article
#+latex_class_options:
#+latex_header:
#+latex_header_extra:
#+description:
#+keywords:
#+subtitle:
#+latex_compiler: pdflatex
#+date:
#+OPTIONS: toc:nil        (no default TOC at all)
#+OPTIONS: indentfirst = true
#+title:
#+author: Lucas Gen
#+LATEX_HEADER: \\usepackage{setspace}
#+LATEX_HEADER: \\doublespacing
#+LATEX_HEADER: \\usepackage{indentfirst}
"
  _
  )

(define-skeleton begin/end_org
  ""
  "what?"
  "#+BEGIN_" str \n _ \n "#+END_" str
  )

(define-skeleton surround-text
  ""
  "surround with?:"
  ""
  )




(provide 'my-skeletons)
