(add-hook 'prog-mode-hook 'electric-pair-mode) ;括号配对
(add-hook 'prog-mode-hook 'hs-minor-mode) ;代码折叠

(use-package ediff :defer t
  :hook
  ((ediff-quit . winner-undo))
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain
	ediff-split-window-function 'split-window-horizontally))

(use-package project :defer t
  :custom
  (project-switch-commands 'project-dired))

(use-package eglot :defer t
  :custom
  (eglot-autoshutdown t)  ;; shutdown language server after closing last file
  (eldoc-echo-area-use-multiline-p nil) ;; eldoc-documentation-function should only return a single line 
  :hook
  (((java-ts-mode python-ts-mode) . eglot-ensure)))

(with-eval-after-load 'eglot
  (with-eval-after-load 'java-ts-mode  
    (unless (package-installed-p 'eglot-java-lombok)
      (package-vc-install "https://github.com/ltylty/eglot-java-lombok"))
    (require 'eglot-java-lombok)
    (eglot-java-lombok/init)))

(use-package treesit-auto :ensure t :defer 1
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(use-package project-tab-groups :ensure t :after project
  :config
  (project-tab-groups-mode 1))

(use-package magit :ensure t :defer t
  :config
  (setq magit-status-margin '(t "%Y-%m-%d %H:%M:%S " magit-log-margin-width t 18))
  (setq magit-log-margin '(t "%Y-%m-%d %H:%M:%S " magit-log-margin-width t 18))
  (setq magit-ediff-dwim-show-on-hunks t))

(use-package git-gutter :ensure t :defer 1
  :init
  (global-git-gutter-mode +1))

(use-package markdown-mode :ensure t :defer t)

(use-package json-mode :ensure t :defer t)

(use-package treemacs :ensure t :defer t
  :config
  (setq treemacs-show-cursor t)
  (setq treemacs-is-never-other-window t)
  (treemacs-project-follow-mode t)
  (treemacs-follow-mode t))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package dumb-jump :ensure t :defer 1
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package highlight-thing :ensure t :defer 1
  :config
  (setq highlight-thing-exclude-thing-under-point t)
  (custom-set-faces
    '(highlight-thing ((t (:background "dark slate gray" :foreground "white")))))
  (add-hook 'prog-mode-hook 'highlight-thing-mode))
