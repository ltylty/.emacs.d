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

(use-package vc :defer t
  :config
  (defun vc-dir-current-should-skip-p ()
 "判断当前行是否需要跳过"
    (when vc-ewoc
      (let* ((node (ewoc-locate vc-ewoc))
             (data (ewoc-data node)))
        (when data
          (vc-dir-fileinfo->directory data)))))
  (defun vc-dir-next-and-diff ()
    "移动到下一个文件并显示 diff，跳过文件夹。如果在最后一个文件则跳转到第一个文件。"
    (interactive)
    (let ((start-node (and vc-ewoc (ewoc-locate vc-ewoc)))
          (first-visited nil))
      (catch 'done
        (while t
          (vc-dir-next-line 1)
          (let ((cur-node (and vc-ewoc (ewoc-locate vc-ewoc))))
            ;; ewoc 节点回环检测：回到起始节点说明已遍历一圈
            (when (eq cur-node start-node)
              (if first-visited
                  (progn (message "No edited files found") (throw 'done nil))
                (setq first-visited t)
                (goto-char (point-min))
                (vc-dir-next-line 1)
                (setq cur-node (and vc-ewoc (ewoc-locate vc-ewoc)))))
            (unless (vc-dir-current-should-skip-p)
              (throw 'done nil))
            ;; 二次回到起始节点（已 wrap 过）
            (when (eq cur-node start-node)
              (message "No edited files found")
              (throw 'done nil))))))
    (save-selected-window
      (vc-diff)))
  (defun vc-dir-prev-and-diff ()
    "移动到上一个文件并显示 diff，跳过文件夹。"
    (interactive)
    (let ((start-node (and vc-ewoc (ewoc-locate vc-ewoc))))
      (catch 'done
        (while t
          (vc-dir-previous-line 1)
          (unless (vc-dir-current-should-skip-p)
            (throw 'done nil))
          (when (eq (ewoc-locate vc-ewoc) start-node)
            (message "No edited files found")
            (throw 'done nil)))))
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
  (add-hook 'vc-dir-mode-hook #'vc-dir-hide-up-to-date)
  (with-eval-after-load 'vc-dir
    (define-key vc-dir-mode-map "e" 'vc-ediff)
    (define-key vc-dir-mode-map "d" 'vc-diff)
    (define-key vc-dir-mode-map "k" 'vc-revert)
    (define-key vc-dir-mode-map "c" 'vc-dir-quick-commit-all)
    (define-key vc-dir-mode-map (kbd "<tab>") 'vc-dir-next-and-diff)
    (define-key vc-dir-mode-map (kbd "<backtab>") 'vc-dir-prev-and-diff)
    (define-key vc-dir-mode-map "F" 'vc-pull)))
