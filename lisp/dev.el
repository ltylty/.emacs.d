(add-hook 'prog-mode-hook 'electric-pair-mode) ;括号配对
(add-hook 'prog-mode-hook 'hs-minor-mode) ;代码折叠

(use-package ediff :defer t
  :hook
  (ediff-quit . winner-undo)
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
  ((python-ts-mode) . eglot-ensure))

(use-package treesit-auto :ensure t :defer 1
  :config
  (global-treesit-auto-mode))

(use-package magit :ensure t :defer t
  :config
  (setq magit-ediff-dwim-show-on-hunks t))

(use-package diff-hl :ensure t :defer 1
  :custom (diff-hl-draw-borders nil)
  :config
  (global-diff-hl-mode)
  (with-eval-after-load 'magit
      (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
      (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)))

(use-package markdown-mode :ensure t :defer t)

(use-package json-mode :ensure t :defer t)

(use-package dired-sidebar :ensure t :defer t
  :config
  (setq dired-sidebar-window-fixed nil))

(use-package highlight-thing :ensure t :defer 1
  :hook (prog-mode . highlight-thing-mode)
  :custom-face
  (highlight-thing ((t (:inherit isearch))))
  :config
  (setq highlight-thing-exclude-thing-under-point t))

(use-package xref :defer t
  :config
  ;; always find references of symbol at point
  (setq xref-prompt-for-identifier nil)
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref))

(use-package citre :ensure t :defer 1
  :init
  (require 'citre-config)
  :config
  (setq-default citre-enable-imenu-integration nil)
  (setq-default citre-enable-capf-integration nil)
  (setq
   citre-default-create-tags-file-location 'global-cache
   citre-gtags-args '("--compact")
   citre-edit-ctags-options-manually nil
   citre-auto-enable-citre-mode-modes '(java-ts-mode sql-mode)))

(use-package color-rg :defer 1
  :vc (:url "https://github.com/manateelazycat/color-rg" :branch "main" :rev :newest)
  :config
  (setq color-rg-search-ignore-rules nil)
  (setq color-rg-search-no-ignore-file nil))

(use-package fanyi :ensure t :defer t)
