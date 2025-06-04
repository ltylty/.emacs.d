;; -*- lexical-binding: t; -*-
(use-package evil :ensure t :defer t
  :hook
  (after-init . evil-mode)
  :init
  (setq evil-disable-insert-state-bindings t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-symbol-word-search t)
  (setq evil-toggle-key "C-M-z")
  :config
  (setq evil-emacs-state-modes '(ediff-mode))
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  (evil-select-search-module 'evil-search-module 'evil-search)

  (define-prefix-command 'space-leader-map)
  (keymap-set evil-motion-state-map "SPC" 'space-leader-map)
  (keymap-set evil-normal-state-map "SPC" 'space-leader-map)

  (defun transient-major-mode-map ()
    (interactive)
    (message (format "transient %s-map" major-mode))
    (set-transient-map (symbol-value (intern-soft (format "%s-map" major-mode)))))
  
  (evil-define-key nil space-leader-map
    (kbd "SPC") 'execute-extended-command
    (kbd "RET") 'consult-bookmark
    "m" 'transient-major-mode-map
    "0" 'treemacs-select-window
    "u" 'universal-argument
    "a" 'embark-act
    "x" ctl-x-map
    ;; buffer
    "bb" 'consult-buffer
    "bi" 'ibuffer
    "bd" 'evil-delete-buffer
    "bl" 'evil-switch-to-windows-last-buffer
    "br" 'revert-buffer
    "bx" #'(lambda () (interactive) (switch-to-buffer "*scratch*"))
    ;; window
    "wd" 'evil-window-delete
    "ww" 'evil-window-next
    "wm" 'delete-other-windows
    "w-" 'evil-window-split
    "w|" 'evil-window-vsplit
    "wh" 'evil-window-left
    "wj" 'evil-window-down
    "wk" 'evil-window-up
    "wl" 'evil-window-right
    "wu" 'winner-undo
    "wr" 'winner-redo
    ;; file
    "ff" 'find-file
    "fd" #'(lambda () (interactive) (consult-fd default-directory))
    "fs" 'save-buffer
    "fr" 'recentf
    "ft" 'treemacs
    ;; search
    "ss" 'consult-line
    "sd" 'color-rg-search-input
    "sp" 'color-rg-search-input-in-project
    "si" 'consult-imenu
    "so" 'consult-outline
    "sm" 'consult-mark
    "st" 'fanyi-dwim
    ;; code
    "cca" 'lsp-execute-code-action
    "ccf" 'lsp-format-region
    "ccr" 'lsp-rename
    "ctc" 'citre-update-this-tags-file
    "ctg" 'citre-global-update-database
    "ca" 'aidermacs-transient-menu
    ;; git
    "gg" 'magit-status
    "gL" 'magit-log-buffer-file
    "gd" 'vc-ediff
    "gp" 'magit-blob-previous
    "gn" 'magit-blob-next
    ;; jump
    "jj" 'avy-goto-word-1
    "jl" 'avy-goto-line
    "jw" 'ace-select-window
    ;; project
    "pp" 'project-switch-project
    "pk" #'(lambda () (interactive) (project-kill-buffers) (tab-close))
    "pf" 'project-find-file
    "pb" 'project-switch-to-buffer
    "ps" 'consult-ripgrep
    ;; tab
    "tt" 'tab-recent
    ;; open
    "oe" 'eshell
    "oo" #'(lambda () (interactive) (browse-url default-directory))
    "of" #'(lambda () (interactive) (browse-url buffer-file-name))
    "od" 'dired-jump
    ;; help
    "hk" 'describe-key
    "hf" 'describe-function
    "hv" 'describe-variable
    "hm" 'describe-mode
    "hp" 'describe-package
    ;; quit
    "qr" 'restart-emacs
    "qq" '("Quit" . save-buffers-kill-terminal))

  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-normal-state-map [mouse-2] nil)
  (evil-define-key 'normal prog-mode-map (kbd "RET") #'embark-dwim)
  (evil-define-key 'normal org-mode-map (kbd "RET") #'embark-dwim)
  (evil-define-key 'normal markdown-mode-map (kbd "RET") #'embark-dwim)
  (evil-define-key 'normal special-mode-map "q" #'quit-window)

  (define-key minibuffer-local-map (kbd "C-w") 'evil-delete-backward-word)
  (define-key minibuffer-local-map (kbd "C-u") 'evil-delete-back-to-indentation)
  (define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)

  (global-set-key (kbd "M-,") 'evil-jump-backward)
  (global-set-key (kbd "C-M-,") 'evil-jump-forward)
  (global-set-key (kbd "C-z") 'undo)

  (evil-define-key '(normal motion visual) global-map "gh" #'evil-first-non-blank)
  (evil-define-key '(normal motion visual) global-map "gl" #'evil-last-non-blank)
  (evil-define-key 'normal global-map "gr" #'xref-find-references)
  (evil-define-key 'normal dired-mode-map (kbd "<backspace>") #'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "i") #'dired-subtree-cycle)
  (evil-define-key 'insert eshell-mode-map (kbd "C-r") #'consult-history)
  (evil-define-key 'insert eshell-mode-map (kbd "C-w") #'evil-delete-backward-word)
  (evil-define-key 'insert eshell-mode-map (kbd "C-u") #'eshell-kill-input)

  (define-key evil-visual-state-map (kbd ">") 'evil-shift-right-visual)
  (define-key evil-visual-state-map (kbd "<") 'evil-shift-left-visual)
  (defun evil-shift-left-visual ()
    (interactive)
    (evil-shift-left (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore))
  (defun evil-shift-right-visual ()
    (interactive)
    (evil-shift-right (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore))

  (cua-mode)
  (defun entry-insert-state ()
    (setq-local cua-enable-cua-keys t)
    (when (derived-mode-p 'org-mode) (setq-local org-support-shift-select 'always)))
  (defun entry-nomal-state ()
    (setq-local cua-enable-cua-keys nil)
    (when (derived-mode-p 'org-mode) (setq-local org-support-shift-select nil)))
  (add-hook 'evil-insert-state-entry-hook #'entry-insert-state)
  (add-hook 'evil-emacs-state-entry-hook #'entry-insert-state)
  (add-hook 'evil-normal-state-entry-hook #'entry-nomal-state)
  (add-hook 'evil-insert-state-exit-hook #'company-abort)

  (advice-add 'evil-force-normal-state :before #'evil-ex-nohighlight)

  (evil-define-text-object evil-entire-entire-buffer (count &optional beg end type)
    "Select entire buffer"
    (evil-range (point-min) (point-max)))
  (define-key evil-outer-text-objects-map "g" 'evil-entire-entire-buffer)
  (define-key evil-inner-text-objects-map "g" 'evil-entire-entire-buffer)
  (define-key evil-inner-text-objects-map "q" 'evil-inner-single-quote)
  (define-key evil-outer-text-objects-map "q" 'evil-a-single-quote))

(use-package evil-textobj-line :ensure t :after evil)

(use-package evil-surround :ensure t :after evil 
  :config (global-evil-surround-mode))

(use-package evil-visualstar :ensure t :after evil 
  :config (global-evil-visualstar-mode))

(use-package evil-anzu :ensure t :after evil
  :config (global-anzu-mode +1))

(use-package evil-multiedit :ensure t :after evil
  :custom
  (iedit-toggle-key-default nil)  
  :custom-face
  (iedit-occurrence ((t (:inherit underline))))
  :config
  (evil-multiedit-default-keybinds))

(use-package evil-mc :ensure t :after evil
  :custom
  (evil-mc-cursors-keymap-prefix "gz")
  :config
  (global-evil-mc-mode  1))

(use-package mwim :ensure t :after evil
  :config
  (define-key evil-insert-state-map (kbd "<home>") 'mwim-beginning)
  (define-key evil-insert-state-map (kbd "<end>") 'mwim-end))
