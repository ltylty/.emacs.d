(add-hook 'prog-mode-hook 'electric-pair-mode)

(use-package eglot
  :custom
  (eglot-autoshutdown t)  ;; shutdown language server after closing last file
  :config
  (add-hook 'java-ts-mode-hook 'eglot-ensure)
  (add-hook 'python-ts-mode-hook 'eglot-ensure))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(use-package project
  :custom
  (project-switch-commands 'project-dired))

(use-package ediff
  :hook
  ((ediff-quit . winner-undo))
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain
	ediff-split-window-function 'split-window-horizontally))

(use-package project-tab-groups
  :ensure
  :config
  (project-tab-groups-mode 1))

(use-package magit
  :ensure t
  :defer t
  :config
  (setq magit-status-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))
  (setq magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))
  (setq magit-ediff-dwim-show-on-hunks t))

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

(use-package markdown-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-show-cursor t)
  (treemacs-project-follow-mode t)
  (treemacs-follow-mode t))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package dumb-jump
  :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package highlight-thing
  :ensure t
  :config
  (setq highlight-thing-exclude-thing-under-point t)
  (custom-set-faces
    '(highlight-thing ((t (:background "dark slate gray" :foreground "white")))))
  (add-hook 'prog-mode-hook 'highlight-thing-mode))
