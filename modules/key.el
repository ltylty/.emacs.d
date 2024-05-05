(use-package evil
  :ensure t
  :init
  (setq evil-disable-insert-state-bindings t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-w-delete t)
  (setq evil-want-C-i-jump nil)
  (setq evil-shift-width 2)
  :config
  (setq evil-emacs-state-modes '(ediff-mode ediff-meta-mode color-rg-mode))
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  (evil-select-search-module 'evil-search-module 'evil-search)
  (evil-mode))
  
(use-package evil-surround
  :ensure t
  :after evil
  :init
  (global-evil-surround-mode 1))

(use-package evil-textobj-line
  :ensure t
  :after evil)

(use-package evil-textobj-anyblock
  :ensure t
  :after evil
  :config
  (setq evil-textobj-anyblock-blocks
        '(("'" . "'")
	  ("\"" . "\"")
	  ("`" . "`")
	  ("‘" . "’")
	  ("“" . "”")))
  (define-key evil-inner-text-objects-map "q" 'evil-textobj-anyblock-inner-block)
  (define-key evil-outer-text-objects-map "q" 'evil-textobj-anyblock-a-block))

(use-package evil-visualstar
  :ensure t
  :after evil
  :init
  (global-evil-visualstar-mode))

(use-package evil-mc
  :ensure t
  :defer t
  :after evil
  :init
  (global-evil-mc-mode 1))

;; space leader key
(define-prefix-command 'space-leader-map)
(keymap-set evil-motion-state-map "SPC" 'space-leader-map)
(keymap-set evil-normal-state-map "SPC" 'space-leader-map)

(evil-define-key nil space-leader-map
  (kbd "SPC") 'execute-extended-command
  ;; buffer
  "bb" 'project-switch-to-buffer
  "bB" 'consult-buffer
  "bi" 'ibuffer
  "bd" 'evil-delete-buffer
  "bl" 'evil-switch-to-windows-last-buffer
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
  "0" 'treemacs-select-window
  ;; file
  "ff" 'find-file
  "fF" '(lambda () (interactive) (consult-fd default-directory))
  "fs" 'save-buffer
  "fr" 'consult-recent-file
  "fd" 'dired
  ;; search
  "ss" 'consult-line
  "si" 'consult-imenu
  "sd" '(lambda () (interactive) (consult-ripgrep default-directory))
  "so" 'consult-outline
  ;; git
  "gg" 'magit
  ;; jump
  "jc" 'avy-goto-char-timer
  "jl" 'avy-goto-line
  "jw" 'ace-select-window
  "jb" 'evil-jump-backward
  "jf" 'evil-jump-forward
  "jrp" 'color-rg-search-symbol-in-project
  "jrd" 'color-rg-search-symbol
  "jrf" 'color-rg-search-symbol-in-current-file
  ;; project
  "pp" 'project-switch-project
  "pd" 'project-kill-buffers
  "pP" 'tab-switch
  "pf" 'project-find-file
  "ps" 'consult-ripgrep
  "pt" 'treemacs
  ;; open
  "oe" 'eshell
  "oo" '(lambda () (interactive) (browse-url default-directory))
  ;; help
  "hk" 'describe-key
  "hf" 'describe-function
  "hv" 'describe-variable
  "hm" 'describe-mode
  ;; quit
  "qq" '("Quit" . save-buffers-kill-terminal))

;; emacs key
(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-normal-state-map))
    (define-key (eval map) "q" nil)
    (define-key (eval map) (kbd "RET") nil)))

(add-hook 'buffer-list-update-hook '(lambda () (interactive) (keymap-set space-leader-map "m" (symbol-value (intern-soft (format "%s-map" major-mode))))))

(defun exit-insert-state ()
  (cua-mode -1)
  (setq org-support-shift-select nil))
(defun entry-insert-state ()
  (cua-mode 1)
  (setq org-support-shift-select 'always))
(add-hook 'evil-insert-state-entry-hook #'entry-insert-state)
(add-hook 'evil-insert-state-exit-hook  #'exit-insert-state)
(evil-define-key '(normal motion) global-map "gh" #'evil-first-non-blank)
(evil-define-key '(normal motion) global-map "gl" #'evil-end-of-line)
(evil-define-key 'insert eshell-mode-map (kbd "C-r") #'consult-history)
(evil-define-key 'insert shell-mode-map (kbd "C-r") #'consult-history)

(define-key minibuffer-local-map (kbd "C-v") 'yank)
(define-key minibuffer-local-map (kbd "C-w") 'evil-delete-backward-word)
(define-key minibuffer-local-map (kbd "C-u") 'evil-delete-back-to-indentation)
(define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)
