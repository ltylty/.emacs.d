(setopt use-short-answers t)
(setq org-log-done 'time)
(setq recentf-max-saved-items 500)
(recentf-mode)
(global-hl-line-mode)
(winner-mode)
(save-place-mode)
(savehist-mode)
(global-auto-revert-mode)

(use-package which-key :ensure t
  :hook (after-init . which-key-mode))

(use-package avy :ensure t)

(use-package consult :ensure t
  :init
  (setq consult-async-input-debounce 0.8)
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

(use-package embark :ensure t
  :bind
  (("C-c a" . embark-act))
  (:map minibuffer-mode-map ("C-c C-e" . embark-export)))

(use-package embark-consult :ensure t)

(use-package wgrep :ensure t
  :bind
  (:map grep-mode-map ("C-x C-q" . wgrep-change-to-wgrep-mode))
  :config
  (setq wgrep-auto-save-buffer t))

(use-package corfu :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-quit-no-match t)
  (corfu-preselect 'prompt)
  :init
  (global-corfu-mode))

(use-package cape :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package orderless :ensure t
  :config
  (setq completion-styles '(orderless flex)))

(use-package undo-fu-session :ensure t :defer t
  :hook (after-init . undo-fu-session-global-mode))

(use-package hilit-chg
  :custom-face
  (highlight-changes-delete ((t (:underline nil)))) 
  :config
  (global-highlight-changes-mode)
  (defun clear-highlight-changes-after-save()
    (if highlight-changes-mode
        (progn
          (call-interactively 'highlight-changes-mode)
          (call-interactively 'highlight-changes-mode))))
  (add-hook 'after-save-hook 'clear-highlight-changes-after-save))
