(use-package macrursors :defer t
  :vc (:url "https://github.com/corytertel/macrursors"
       :branch "main")
  :bind
  (("C-;" . macrursors-mark-all-lines-or-instances))
  :config
  (dolist (mode '(corfu-mode))
    (add-hook 'macrursors-pre-finish-hook mode)
    (add-hook 'macrursors-post-finish-hook mode)))
