(use-package emacs
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  :hook
  ((prog-mode . electric-pair-mode)))

(use-package eglot
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

(use-package project-tab-groups
  :ensure
  :config
  (project-tab-groups-mode 1))

(use-package magit
  :ensure t
  :defer t)

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
  (treemacs-project-follow-mode t)
  (treemacs-follow-mode t))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package highlight-thing
  :ensure t
  :config
  (setq highlight-thing-exclude-thing-under-point t)
  (custom-set-faces
    '(highlight-thing ((t (:background "dark slate gray" :foreground "white")))))
  (add-hook 'prog-mode-hook 'highlight-thing-mode))

(unless (package-installed-p 'color-rg)
  (package-vc-install "https://github.com/manateelazycat/color-rg"))
(require 'color-rg)
(setq color-rg-command-prefix "powershell")
