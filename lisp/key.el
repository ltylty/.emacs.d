(use-package evil :ensure t
  :init
  (setq evil-disable-insert-state-bindings t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-shift-width 2)
  (setq evil-symbol-word-search t)
  :config
  (setq evil-emacs-state-modes '(ediff-mode color-rg-mode))
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  (evil-select-search-module 'evil-search-module 'evil-search)
  (evil-mode))
  
(use-package evil-textobj-line :ensure t :after evil)

(use-package evil-textobj-entire :ensure t :after evil
  :config
  (define-key evil-outer-text-objects-map "g" 'evil-entire-entire-buffer)
  (define-key evil-inner-text-objects-map "g" 'evil-entire-entire-buffer))

(use-package evil-textobj-anyblock :ensure t :after evil
  :config
  (define-key evil-inner-text-objects-map "q" 'evil-textobj-anyblock-inner-block)
  (define-key evil-outer-text-objects-map "q" 'evil-textobj-anyblock-a-block))

(use-package evil-textobj-tree-sitter :ensure t :after (evil treesit-auto)
  :config
  (define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
  (define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner")))

(use-package evil-surround :ensure t :after evil
  :init
  (global-evil-surround-mode 1))

(use-package evil-visualstar :ensure t :after evil
  :init
  (global-evil-visualstar-mode))

(use-package evil-multiedit :ensure t :after evil
  :init
  (setq iedit-toggle-key-default nil)
  (setq iedit-overlay-priority 2) ;; higher than highlight-thing, lower than region.
  :config
  (evil-multiedit-default-keybinds))

;; space leader key
(define-prefix-command 'space-leader-map)
(keymap-set evil-motion-state-map "SPC" 'space-leader-map)
(keymap-set evil-normal-state-map "SPC" 'space-leader-map)

(evil-define-key nil space-leader-map
  (kbd "SPC") 'execute-extended-command
  (kbd "RET") 'consult-bookmark
  "0" 'treemacs-select-window
  ;; buffer
  "bb" 'consult-buffer
  "bi" 'ibuffer
  "bd" 'evil-delete-buffer
  "bl" 'evil-switch-to-windows-last-buffer
  "bx" #'(lambda () (interactive) (switch-to-buffer "*scratch*"))
  ;; window
  "wd" 'evil-window-delete
  "ww" 'evil-window-next
  "wm" 'delete-other-windows
  "ws" 'evil-window-split
  "wv" 'evil-window-vsplit
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
  ;; search
  "ss" 'consult-line
  "sD" 'color-rg-search-symbol
  "sF" 'color-rg-search-symbol-in-current-file
  "sP" 'color-rg-search-symbol-in-project
  "sd" 'color-rg-search-input
  "sf" 'color-rg-search-input-in-current-file
  "sp" 'color-rg-search-input-in-project
  "si" 'consult-imenu
  "so" 'consult-outline
  ;; code
  "ce" 'consult-flymake
  ;; git
  "gg" 'magit-status
  "gL" 'magit-log-buffer-file
  "gd" 'vc-ediff
  ;; jump
  "jj" 'avy-goto-word-1
  "jl" 'avy-goto-line
  "jw" 'ace-select-window
  ;; project
  "pp" 'project-switch-project
  "pd" 'project-kill-buffers
  "pl" 'tab-switch
  "pf" 'project-find-file
  "pb" 'project-switch-to-buffer
  "ps" 'consult-ripgrep
  "pt" 'treemacs
  ;; open
  "oe" 'eshell
  "oo" #'(lambda () (interactive) (browse-url default-directory))
  "of" #'(lambda () (interactive) (browse-url buffer-file-name))
  "od" 'dired
  "oD" 'dired-jump
  "ol" 'ielm
  ;; help
  "hk" 'describe-key
  "hf" 'describe-function
  "hv" 'describe-variable
  "hm" 'describe-mode
  "hp" 'describe-package
  ;; quit
  "qq" '("Quit" . save-buffers-kill-terminal))

(add-hook 'buffer-list-update-hook #'(lambda () (interactive) (keymap-set space-leader-map "m" (symbol-value (intern-soft (format "%s-map" major-mode))))))

(define-key evil-motion-state-map (kbd "RET") nil)
(evil-define-key 'normal text-mode-map (kbd "RET") #'embark-dwim)
(evil-define-key 'normal prog-mode-map (kbd "RET") #'embark-dwim)
(evil-define-key 'normal special-mode-map "q" #'quit-window)

(define-key minibuffer-local-map (kbd "C-v") 'yank)
(define-key minibuffer-local-map (kbd "C-w") 'evil-delete-backward-word)
(define-key minibuffer-local-map (kbd "C-u") 'evil-delete-back-to-indentation)
(define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "M-,") 'evil-jump-backward)
(global-set-key (kbd "C-M-,") 'evil-jump-forward)

(global-set-key (kbd "C-;") 'macrursors-mark-all-lines-or-instances)
(define-key evil-normal-state-map (kbd "M-p") 'macrursors-mark-previous-line)
(define-key evil-normal-state-map (kbd "M-n") 'macrursors-mark-next-line)

; evil define key
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

(defun exit-insert-state ()
  (cua-mode -1)
  (corfu-quit)
  (setq org-support-shift-select nil))
(defun entry-insert-state ()
  (cua-mode 1)
  (setq org-support-shift-select 'always))
(add-hook 'evil-insert-state-entry-hook #'entry-insert-state)
(add-hook 'evil-insert-state-exit-hook #'exit-insert-state)
(add-hook 'evil-visual-state-entry-hook (lambda () (cua-mode -1))) 
(advice-add 'evil-force-normal-state :before #'evil-ex-nohighlight)

(evil-define-key '(normal motion visual) global-map "gh" #'evil-first-non-blank)
(evil-define-key '(normal motion visual) global-map "gl" #'evil-last-non-blank)
(evil-define-key 'normal global-map "gr" #'citre-jump-to-reference)
(evil-define-key 'normal dired-mode-map (kbd "<backspace>") #'dired-up-directory)
(evil-define-key 'insert eshell-mode-map (kbd "C-r") #'consult-history)
(evil-define-key 'insert eshell-mode-map (kbd "C-w") #'evil-delete-backward-word)
(evil-define-key 'insert eshell-mode-map (kbd "C-u") #'eshell-kill-input)
