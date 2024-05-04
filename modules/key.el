(use-package evil
  :ensure t
  :init
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-w-delete t)
  :config
  (evil-mode))
  
(use-package evil-collection
  :ensure t
  :after evil
  :init
  (evil-collection-init)
  (setq evil-collection-key-blacklist '("SPC")))

(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode 1))

(use-package evil-textobj-line
  :ensure t
  :after evil)

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

;; (use-package general
;;   :ensure t
;;   :after evil)

;; (general-create-definer global-leader
;;     :keymaps 'override
;;     :states '(normal visual motion insert emacs)
;;     :prefix "SPC"
;;     :non-normal-prefix "C-SPC")

;; (global-leader
;;       "SPC" 'execute-extended-command
;;       ;; buffer
;;       "bb" 'project-switch-to-buffer
;;       "bB" 'consult-buffer
;;       "bi" 'ibuffer
;;       "bd" 'evil-delete-buffer
;;       "bl" 'evil-switch-to-windows-last-buffer
;;       ;; window
;;       "wd" 'evil-window-delete
;;       "ww" 'evil-window-next
;;       "wm" 'delete-other-windows
;;       "ws" 'evil-window-split
;;       "wv" 'evil-window-vsplit
;;       "wh" 'evil-window-left
;;       "wj" 'evil-window-down
;;       "wk" 'evil-window-up
;;       "wl" 'evil-window-right
;;       "0" 'treemacs-select-window
;;       ;; file
;;       "ff" 'find-file
;;       "fF" 'consult-fd
;;       "fs" 'save-buffer
;;       "fr" 'consult-recent-file
;;       "fd" 'dired
;;       ;; search
;;       "ss" 'consult-line
;;       "si" 'consult-imenu
;;       "sd" '(lambda () (interactive) (consult-ripgrep default-directory))
;;       "so" 'consult-outline
;;       ;; git
;;       "gg" 'magit
;;       ;; jump
;;       "jw" 'avy-goto-char-timer
;;       "jl" 'avy-goto-line
;;       "jr" 'color-rg-search-symbol-in-project
;;       ;; project
;;       "pp" 'project-switch-project
;;       "pd" 'project-kill-buffers
;;       "pP" 'tab-switch
;;       "pf" 'project-find-file
;;       "ps" 'consult-ripgrep
;;       "pt" 'treemacs
;;       ;; open
;;       "oe" 'eshell
;;       "oo" '(lambda () (interactive) (browse-url default-directory))
;;       ;; help
;;       "hk" 'describe-key
;;       "hf" 'describe-function
;;       "hv" 'describe-variable
;;       "hm" 'describe-mode
;;       ;; quit
;;       "qq" '("Quit" . save-buffers-kill-terminal))


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

(define-key minibuffer-local-map (kbd "C-v") 'yank)
(define-key minibuffer-local-map (kbd "C-w") 'evil-delete-backward-word)
(define-key minibuffer-local-map (kbd "C-u") 'evil-delete-back-to-indentation)
 
(evil-set-leader '(normal visual replace operator motion emacs) (kbd "SPC"))
(evil-define-key '(normal visual replace operator motion emacs) 'global
    (kbd "<leader>SPC")'execute-extended-command
    ;; buffer
    (kbd "<leader>bb")'project-switch-to-buffer
    (kbd "<leader>bB")'consult-buffer
    (kbd "<leader>bi")'ibuffer
    (kbd "<leader>bd")'evil-delete-buffer
    (kbd "<leader>bl")'evil-switch-to-windows-last-buffer
    ;; window
    (kbd "<leader>wd")'evil-window-delete
    (kbd "<leader>ww")'evil-window-next
    (kbd "<leader>wm")'delete-other-windows
    (kbd "<leader>ws")'evil-window-split
    (kbd "<leader>wv")'evil-window-vsplit
    (kbd "<leader>wh")'evil-window-left
    (kbd "<leader>wj")'evil-window-down
    (kbd "<leader>wk")'evil-window-up
    (kbd "<leader>wl")'evil-window-right
    (kbd "<leader>0")'treemacs-select-window
    ;; file
    (kbd "<leader>ff")'find-file
    (kbd "<leader>fF")'consult-fd
    (kbd "<leader>fs")'save-buffer
    (kbd "<leader>fr")'consult-recent-file
    (kbd "<leader>fd")'dired
    ;; search
    (kbd "<leader>ss")'consult-line
    (kbd "<leader>si")'consult-imenu
    (kbd "<leader>sd")'(lambda () (interactive) (consult-ripgrep default-directory))
    (kbd "<leader>so")'consult-outline
    ;; git
    (kbd "<leader>gg")'magit
    ;; jump
    (kbd "<leader>jw")'avy-goto-char-timer
    (kbd "<leader>jl")'avy-goto-line
    (kbd "<leader>jr")'color-rg-search-symbol-in-project
    ;; project
    (kbd "<leader>pp")'project-switch-project
    (kbd "<leader>pd")'project-kill-buffers
    (kbd "<leader>pP")'tab-switch
    (kbd "<leader>pf")'project-find-file
    (kbd "<leader>ps")'consult-ripgrep
    (kbd "<leader>pt")'treemacs
    ;; open
    (kbd "<leader>oe")'eshell
    (kbd "<leader>oo")'(lambda () (interactive) (browse-url default-directory))
    ;; help
    (kbd "<leader>hk")'describe-key
    (kbd "<leader>hf")'describe-function
    (kbd "<leader>hv")'describe-variable
    (kbd "<leader>hm")'describe-mode
    ;; quit
    (kbd "<leader>qq")'("Quit" . save-buffers-kill-terminal))


(evil-define-key '(normal visual replace operator motion emacs) magit-mode-map
    (kbd "<leader>SPC")'execute-extended-command
    ;; buffer
    (kbd "<leader>bb")'project-switch-to-buffer
    (kbd "<leader>bB")'consult-buffer
    (kbd "<leader>bi")'ibuffer
    (kbd "<leader>bd")'evil-delete-buffer
    (kbd "<leader>bl")'evil-switch-to-windows-last-buffer
    ;; window
    (kbd "<leader>wd")'evil-window-delete
    (kbd "<leader>ww")'evil-window-next
    (kbd "<leader>wm")'delete-other-windows
    (kbd "<leader>ws")'evil-window-split
    (kbd "<leader>wv")'evil-window-vsplit
    (kbd "<leader>wh")'evil-window-left
    (kbd "<leader>wj")'evil-window-down
    (kbd "<leader>wk")'evil-window-up
    (kbd "<leader>wl")'evil-window-right
    (kbd "<leader>0")'treemacs-select-window
    ;; file
    (kbd "<leader>ff")'find-file
    (kbd "<leader>fF")'consult-fd
    (kbd "<leader>fs")'save-buffer
    (kbd "<leader>fr")'consult-recent-file
    (kbd "<leader>fd")'dired
    ;; search
    (kbd "<leader>ss")'consult-line
    (kbd "<leader>si")'consult-imenu
    (kbd "<leader>sd")'(lambda () (interactive) (consult-ripgrep default-directory))
    (kbd "<leader>so")'consult-outline
    ;; git
    (kbd "<leader>gg")'magit
    ;; jump
    (kbd "<leader>jw")'avy-goto-char-timer
    (kbd "<leader>jl")'avy-goto-line
    (kbd "<leader>jr")'color-rg-search-symbol-in-project
    ;; project
    (kbd "<leader>pp")'project-switch-project
    (kbd "<leader>pd")'project-kill-buffers
    (kbd "<leader>pP")'tab-switch
    (kbd "<leader>pf")'project-find-file
    (kbd "<leader>ps")'consult-ripgrep
    (kbd "<leader>pt")'treemacs
    ;; open
    (kbd "<leader>oe")'eshell
    (kbd "<leader>oo")'(lambda () (interactive) (browse-url default-directory))
    ;; help
    (kbd "<leader>hk")'describe-key
    (kbd "<leader>hf")'describe-function
    (kbd "<leader>hv")'describe-variable
    (kbd "<leader>hm")'describe-mode
    ;; quit
    (kbd "<leader>qq")'("Quit" . save-buffers-kill-terminal))
