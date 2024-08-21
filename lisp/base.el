(setopt use-short-answers t)
(setq org-log-done 'time)
(setq recentf-max-saved-items 500)
(recentf-mode)
(global-hl-line-mode)
(winner-mode)
(save-place-mode)
(savehist-mode)
(global-auto-revert-mode)
(auto-save-visited-mode t)
(which-key-mode)

(use-package avy :ensure t :defer t)

(use-package consult :ensure t :defer t
  :init
  (setq consult-async-input-debounce 1.0)
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package vertico :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package marginalia :ensure t
  :hook (after-init . marginalia-mode))

(use-package embark :ensure t :defer t
  :bind
  (("C-c a" . embark-act))
  (:map minibuffer-mode-map ("C-c C-e" . embark-export)))

(use-package embark-consult :ensure t :after (embark consult))

(use-package wgrep :ensure t :defer t
  :bind
  (:map grep-mode-map ("C-x C-q" . wgrep-change-to-wgrep-mode))
  :config
  (setq wgrep-auto-save-buffer t))

(use-package corfu :ensure t :defer t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-quit-no-match t)
  (corfu-preselect 'prompt)
  (text-mode-ispell-word-completion nil)
  :init
  (global-corfu-mode))

(use-package cape :ensure t :after corfu
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package orderless :ensure t
  :config
  (setq completion-styles '(basic orderless flex)))

(use-package undo-fu-session :ensure t :defer t
  :hook (after-init . undo-fu-session-global-mode))

(use-package nyan-mode :ensure t :defer t
  :hook (after-init . nyan-mode))
