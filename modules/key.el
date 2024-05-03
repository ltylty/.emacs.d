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

(use-package general
  :ensure t
  :after evil)

(general-create-definer global-leader
    :keymaps 'override
    :states '(normal visual motion insert emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

(global-leader
      "SPC" 'execute-extended-command
      ;; buffer
      "bb" 'tabspaces-switch-to-buffer
      "bi" 'ibuffer
      "bO" 'tabspaces-clear-buffers
      "bB" 'consult-buffer
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
      "fF" 'consult-fd
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
      "jw" 'avy-goto-char-timer
      "jl" 'avy-goto-line
      ;; project
      "pp" 'tabspaces-open-or-create-project-and-workspace
      "pd" 'tabspaces-kill-buffers-close-workspace
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
