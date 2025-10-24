;; -*- lexical-binding: t; -*-
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
  (project-switch-commands 'project-dired)
  :config
  (setq project-vc-extra-root-markers '(".dir-locals.el")))

(use-package eglot :defer t
  :custom
  (eglot-autoshutdown t)  ;; shutdown language server after closing last file
  (eldoc-echo-area-use-multiline-p nil) ;; eldoc-documentation-function should only return a single line
  :custom-face
  (eglot-highlight-symbol-face ((t (:inherit nil :weight bold :foreground "yellow3"))))
  :hook
  ((python-mode python-ts-mode) . eglot-ensure))

(use-package eglot-java :ensure t :defer t
  :hook (java-mode . eglot-java-mode) (java-ts-mode . eglot-java-mode))

(use-package eglot-java-lombok :ensure t :after eglot-java 
  :vc (:url "https://github.com/ltylty/eglot-java-lombok" :branch "main" :rev :newest)
  :config
  (eglot-java-lombok/init))

(use-package magit :ensure t :defer t
  :config
  (setq magit-ediff-dwim-show-on-hunks t))

(use-package magit-prime :ensure t :after magit
  :config
  (add-hook 'magit-pre-refresh-hook 'magit-prime-refresh-cache))

(use-package diff-hl :ensure t :defer 0.3
  :custom (diff-hl-draw-borders nil)
  :config
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (with-eval-after-load 'magit
    (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)))

(use-package markdown-mode :ensure t :defer t)

(use-package json-mode :ensure t :defer t)

(use-package nerd-icons-dired :ensure t :defer t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package dired-sidebar :ensure t :defer t
  :config
  (setq dired-sidebar-window-fixed nil)
  (setq dired-sidebar-theme 'nerd-icons))

(use-package highlight-thing :ensure t :defer t
  :hook ((sql-mode sh-mode emacs-lisp-mode) . highlight-thing-mode)
  :custom-face
  (highlight-thing ((t (:inherit isearch))))
  :config
  (setq highlight-thing-exclude-thing-under-point t))

(use-package color-rg :ensure t :defer 0.3
  :vc (:url "https://github.com/manateelazycat/color-rg" :branch "main" :rev :newest)
  :custom
  (color-rg-mac-load-path-from-shell nil)
  (color-rg-search-ignore-rules nil)
  (color-rg-search-no-ignore-file nil))

(use-package gt :ensure t :defer t
  :config
  (setq gt-default-translator
	(gt-translator
	 :taker   (gt-taker :text 'word :prompt t)
	 :engines (list (gt-bing-engine) (gt-youdao-dict-engine))
	 :render  (gt-buffer-render)))
  (setq gt-langs '(en zh)))

(use-package sqlformat :ensure t :after sql
  :config
  (define-key sql-mode-map (kbd "C-c C-f") 'sqlformat))

(use-package highlight-parentheses :ensure t :defer t
  :hook (prog-mode . highlight-parentheses-mode)
  :custom
  (highlight-parentheses-colors '("green" "yellow" "purple" "orange" "red")))

(use-package copilot :ensure t :defer t
  :hook (prog-mode . copilot-mode)
  :custom
  (copilot-indent-offset-warning-disable t)
  (copilot-max-char-warning-disable t)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion)))

(use-package aidermacs :ensure t :defer t
  :custom
  ;; (aidermacs-default-model "openrouter/deepseek/deepseek-chat-v3.1:free")
  (aidermacs-program "aider")
  (aidermacs-default-model "gemini")
  (aidermacs-default-chat-mode 'architect))

(use-package dumb-jump :ensure t :defer t
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :config
  (add-to-list 'dumb-jump-project-denoters ".dir-locals.el"))

(use-package ws-butler :ensure t :defer t
	:hook ((prog-mode text-mode) . ws-butler-mode))
