;; -*- lexical-binding: t; -*-
(add-hook 'prog-mode-hook 'electric-pair-local-mode) ;括号配对
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
  ((python-mode . eglot-ensure)
   (python-ts-mode . eglot-ensure)))

(use-package vc :defer t
  :config
  (defun vc-dir-next-and-diff ()
    "移动到下一行并显示当前文件的 diff，同时保持光标在列表。"
    (interactive)
    (vc-dir-next-line 1)
    (save-selected-window
      (vc-diff)))
  (defun vc-dir-prev-and-diff ()
    "移动到前一行并显示当前文件的 diff，同时保持光标在列表。"
    (interactive)
    (vc-dir-previous-line 1)
    (save-selected-window
      (vc-diff)))
  (defun vc-dir-quick-commit-all ()
    "标记所有已跟踪且修改过的文件并进入提交界面"
    (interactive)
    (vc-dir-unmark-all-files 1)
    (dolist (state '(edited added removed))
      (vc-dir-mark-state-files state))
    (let ((files (vc-dir-marked-files)))
      (if files
          (vc-next-action nil)
        (message "No files to commit"))))
  (with-eval-after-load 'vc-dir
    (define-key vc-dir-mode-map "e" 'vc-ediff)
    (define-key vc-dir-mode-map "d" 'vc-diff)
    (define-key vc-dir-mode-map "k" 'vc-revert)
    (define-key vc-dir-mode-map "c" 'vc-dir-quick-commit-all)
    (define-key vc-dir-mode-map (kbd "<tab>") 'vc-dir-next-and-diff)
    (define-key vc-dir-mode-map (kbd "<backtab>") 'vc-dir-prev-and-diff)
    (define-key vc-dir-mode-map "F" 'vc-pull)))

(use-package consult-vc-modified-files :ensure t :defer t)

(use-package dumb-jump :ensure t :defer t
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :config
  (add-to-list 'dumb-jump-project-denoters ".dir-locals.el"))

(use-package magit :ensure t :defer t)

(use-package diff-hl :ensure t :defer t
  :hook ((after-init . global-diff-hl-mode)
         (after-init . global-diff-hl-show-hunk-mouse-mode))
  :custom (diff-hl-draw-borders nil)
  :config
  (diff-hl-flydiff-mode))

(use-package markdown-mode :ensure t :defer t)

(use-package json-mode :ensure t :defer t)

(use-package highlight-thing :ensure t :defer t
  :hook ((sql-mode sh-mode emacs-lisp-mode java-mode java-ts-mode) . highlight-thing-mode)
  :custom-face
  (highlight-thing ((t (:inherit isearch))))
  :config
  (setq highlight-thing-exclude-thing-under-point t))

(use-package color-rg :ensure t :defer 0.3
  :vc (:url "https://github.com/manateelazycat/color-rg" :branch "master" :rev :newest)
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

(use-package ws-butler :ensure t :defer t
	:hook ((prog-mode text-mode) . ws-butler-mode))

(use-package eshell-toggle :ensure t :defer t)

(use-package nerd-icons :ensure t :defer t)

(use-package dired :defer t
  :config
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  (setq dired-dwim-target t))

(use-package dirvish :ensure t :defer t
  :hook (after-init . dirvish-override-dired-mode)
  :custom
  (dirvish-side-window-parameters '((no-delete-other-windows . nil) (no-other-window . t)))
  (dirvish-reuse-session t)
  :bind
  (:map dirvish-mode-map
        ("<mouse-1>" . dirvish-subtree-toggle-or-open)
        ("<mouse-2>" . dired-mouse-find-file-other-window)
        ("<mouse-3>" . dired-mouse-find-file)
        ("TAB" . dirvish-subtree-toggle))
  :config
  (dirvish-side-follow-mode)
  (setq dirvish-attributes
        '(vc-state subtree-state nerd-icons file-time file-size))
  (setq dirvish-side-attributes
        '(vc-state subtree-state nerd-icons)))

(use-package agent-shell :ensure t :defer t)
;; Configure agent-shell-qwen to not require login every time
(with-eval-after-load 'agent-shell-qwen
  (setq agent-shell-qwen-authentication
        (agent-shell-qwen-make-authentication :none t)))
