(unless (package-installed-p 'macrursors)
  (package-vc-install "https://github.com/corytertel/macrursors"))
(use-package macrursors :defer t
  :bind
  (("C-;" . macrursors-mark-all-lines-or-instances))
  :config
  (dolist (mode '(corfu-mode))
    (add-hook 'macrursors-pre-finish-hook mode)
    (add-hook 'macrursors-post-finish-hook mode)))

(unless (package-installed-p 'color-rg)
  (package-vc-install "https://github.com/manateelazycat/color-rg"))
(use-package color-rg :defer 1
  :config
  (when (eq system-type 'windows-nt)
    (setq color-rg-command-prefix "powershell")))
