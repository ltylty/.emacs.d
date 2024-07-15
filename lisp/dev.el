(add-hook 'prog-mode-hook 'electric-pair-mode) ;括号配对
(add-hook 'prog-mode-hook 'hs-minor-mode) ;代码折叠
(add-hook 'prog-mode-hook 'display-line-numbers-mode) ;显示行号

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
  :custom-face
  (eglot-highlight-symbol-face ((t (:inherit nil :weight bold :foreground "yellow3"))))
  :hook
  (((python-ts-mode) . eglot-ensure)))

(use-package treesit-auto :ensure t :after project
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

(use-package diff-hl :ensure t :after project
  :custom (diff-hl-draw-borders nil)
  :config
  (global-diff-hl-mode)
  (with-eval-after-load 'magit
      (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
      (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)))

(use-package markdown-mode :ensure t :defer t)

(use-package json-mode :ensure t :defer t)

(use-package dired-sidebar :ensure t :defer t)

(use-package highlight-thing :ensure t :after project
  :custom-face
  (highlight-thing ((t (:inherit nil :background "dark slate gray"))))
  :config
  (setq highlight-thing-exclude-thing-under-point t)
  (add-hook 'prog-mode-hook 'highlight-thing-mode))

(use-package citre :ensure t :defer t
  :init
  (require 'citre-config)
  :config
  (setq xref-prompt-for-identifier nil)
  (setq
   citre-default-create-tags-file-location 'global-cache
   citre-gtags-args '("--compact")
   citre-edit-ctags-options-manually nil
   citre-auto-enable-citre-mode-modes '(java-ts-mode sql-mode)))
