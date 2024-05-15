(add-hook 'prog-mode-hook 'electric-pair-mode)

(use-package eglot
  :custom
  (eglot-autoshutdown t)  ;; shutdown language server after closing last file
  (eldoc-echo-area-use-multiline-p nil) ;; eldoc-documentation-function should only return a single line 
  :config
  ;; (add-to-list
  ;;  'eglot-server-programs
  ;;  '(java-ts-mode .
  ;;     ("jdtls"
  ;;     "-XX:+UseG1GC"
  ;;     "--jvm-arg=-javaagent:c:/Users/Administrator/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar")))
  (add-hook 'java-ts-mode-hook 'eglot-ensure)
  (add-hook 'python-ts-mode-hook 'eglot-ensure))

(unless (package-installed-p 'eglot-java-lombok)
     (package-vc-install "https://github.com/ltylty/eglot-java-lombok"))
(require 'eglot-java-lombok)
(setq eglot-java-lombok/enabled t)
(eglot-java-lombok/init)

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
  (setq magit-status-margin '(t "%Y-%m-%d %H:%M:%S " magit-log-margin-width t 18))
  (setq magit-log-margin '(t "%Y-%m-%d %H:%M:%S " magit-log-margin-width t 18))
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
