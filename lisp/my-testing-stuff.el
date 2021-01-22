
(setq frame-title-format
      '("" invocation-name ": "
        (:eval
         (if buffer-file-name
             (abbreviate-file-name buffer-file-name)
           "%b"))))


(use-package minimap
  :defer t
  :config

  )


(provide 'my-testing-stuff)
