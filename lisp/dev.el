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

(use-package treesit-auto :ensure t :after project
  :config
  (global-treesit-auto-mode))

(use-package magit :ensure t :defer t
  :config
  (setq magit-ediff-dwim-show-on-hunks t))

(use-package diff-hl :ensure t :after project
  :custom (diff-hl-draw-borders nil)
  :config
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (with-eval-after-load 'magit
      (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
      (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)))

(use-package markdown-mode :ensure t :defer t)

(use-package json-mode :ensure t :defer t)

(use-package nerd-icons-dired :ensure t :defer t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package dired-sidebar :ensure t :defer t
  :config
  (setq dired-sidebar-window-fixed nil)
  (setq dired-sidebar-resize-on-open nil)
  (setq dired-sidebar-should-follow-file t)
  (setq dired-sidebar-theme 'nerd-icons))

(use-package highlight-thing :ensure t :after project
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

(use-package citre :ensure t :after project
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

(use-package color-rg :after project
  :vc (:url "https://github.com/manateelazycat/color-rg" :branch "main" :rev :newest)
  :config
  (setq color-rg-search-ignore-rules nil)
  (setq color-rg-search-no-ignore-file nil))

(use-package fanyi :ensure t :defer t)

(use-package copilot :ensure t :defer t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))
  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))
  (add-to-list 'copilot-indentation-alist '(special-mode 2)))

(use-package aidermacs :ensure t :defer t
  :bind (("C-c a" . aidermacs-transient-menu))  
  :custom
  ; See the Configuration section below
  (aidermacs-use-architect-mode t)
  (aidermacs-default-model "gemini-exp"))
