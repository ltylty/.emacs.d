;; Evil: vi emulation
(use-package evil
  :ensure t

  :init
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)

  (setq evil-want-keybinding nil)

  :config
  (evil-mode)
  
  ;;; Leader
  (define-prefix-command 'my-leader-map)

  (keymap-set evil-motion-state-map "SPC" 'my-leader-map)
  (keymap-set evil-normal-state-map "SPC" 'my-leader-map)
  (keymap-set evil-emacs-state-map "SPC" 'my-leader-map)

  (evil-define-key nil my-leader-map
      ;; buffer
      "bb" 'consult-buffer
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
      "fs" 'save-buffer
      "fr" 'consult-recent-file
      "fd" 'dired
      ;; search
      "ss" 'consult-line
      "si" 'consult-imenu
      "sd" 'consult-ripgrep
      ;; git
      "gg" 'magit
      ;; jump
      "jw" 'avy-goto-char-timer
      "jl" 'avy-goto-line
      ;; project
      "pp" 'project-switch-project
      "pf" 'consult-fd
      ;; open
      "oe" 'eshell
      "oo" '(lambda () (interactive) (browse-url default-directory))
      ;; hlep
      "hk" 'describe-key
      ;; quit
      "qq" '("Quit" . save-buffers-kill-terminal))

  (evil-define-key 'normal org-mode-map
    [tab] 'org-cycle
    [S-tab] 'org-shifttab)

  ;; (evil-define-key 'motion org-mode-map
  ;;   "{" 'org-backward-paragraph
  ;;   "}" 'org-forward-paragraph
  ;;   "(" 'org-backward-sentence
  ;;   ")" 'org-forward-sentence)
  
  ;; Configuring initial major mode for some modes
  (evil-set-initial-state 'vterm-mode 'emacs))

;; (use-package evil-collection
;;   :ensure t
;;   :after evil
;;   :custom
;;   (evil-collection-key-blacklist '("SPC"))
;;   (evil-collection-mode-list '(org))
;;   :init
;;   (evil-collection-init))
