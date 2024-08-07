(unless (package-installed-p 'macrursors)
  (package-vc-install "https://github.com/corytertel/macrursors"))
(use-package macrursors :defer t
  :bind
  (("C-;" . macrursors-mark-all-lines-or-instances))
  :config
  (dolist (mode '(corfu-mode))
    (add-hook 'macrursors-pre-finish-hook mode)
    (add-hook 'macrursors-post-finish-hook mode)))
