(use-package company-c-headers          ;supposed to show c headers
  :defer t
  :config
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/4.8/")

  )


(provide 'c-mode-loads)
