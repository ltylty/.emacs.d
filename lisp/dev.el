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
  :config
  (custom-set-faces
    '(eglot-highlight-symbol-face ((t (:background "dark slate gray" :foreground "white")))))
  :hook
  (((python-ts-mode) . eglot-ensure)))

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

(use-package treemacs-evil :ensure t :after (treemacs evil))
(use-package treemacs-magit :ensure t :after (treemacs magit))
(use-package treemacs-tab-bar :ensure t :after (treemacs tab-bar))

(use-package highlight-thing :ensure t :defer t
  :config
  (setq highlight-thing-exclude-thing-under-point t)
  (custom-set-faces
    '(highlight-thing ((t (:background "dark slate gray" :foreground "white")))))
  :hook
  (((sql-mode conf-mode) . highlight-thing-mode)))

(use-package citre :ensure t :defer t
  :init
  (require 'citre-config)
  :config
  (setq xref-prompt-for-identifier nil)
  (setq
   citre-default-create-tags-file-location 'global-cache
   citre-gtags-args nil
   citre-auto-enable-citre-mode-modes '(prog-mode)))
