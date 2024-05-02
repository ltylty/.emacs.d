(use-package emacs
  :config
  :hook
  ((prog-mode . electric-pair-mode)))

(use-package project
    :custom
    (project-switch-commands 'project-dired))

(use-package tabspaces
  :ensure t)

(use-package magit
  :ensure t)

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

(use-package markdown-mode
  :ensure t
  :hook ((markdown-mode . visual-line-mode)))

(use-package json-mode
  :ensure t)

(use-package eglot
  :hook
  (((python-ts-mode java-ts-mode-hook) . eglot-ensure)))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(use-package treemacs
  :ensure t
  :defer t
  :config
  (treemacs-project-follow-mode t)
  (treemacs-follow-mode t))
