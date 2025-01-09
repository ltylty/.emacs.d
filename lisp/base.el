(setopt use-short-answers t)
(winner-mode)
(save-place-mode)
(savehist-mode)
(global-auto-revert-mode)
(auto-save-visited-mode)
(which-key-mode)

(use-package recentf
  :custom
  (recentf-max-saved-items 300)
  :hook (after-init . recentf-mode))

(use-package org :defer 0.1
  :config
  (setq org-modules nil)
  (setq org-log-done 'time))

(use-package avy :ensure t :defer t)

(use-package consult :ensure t :defer t
  :init
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package vertico :ensure t :defer t
  :custom
  (vertico-cycle t)
  :hook (after-init . vertico-mode))

(use-package marginalia :ensure t :defer t
  :hook (after-init . marginalia-mode))

(use-package embark :ensure t :defer t
  :bind
  (:map minibuffer-mode-map
	("C-c C-e" . embark-export)
	("C-c C-a" . embark-act)))

(use-package embark-consult :ensure t :after (embark consult))

(use-package wgrep :ensure t :defer t
  :bind
  (:map grep-mode-map ("C-x C-q" . wgrep-change-to-wgrep-mode))
  :config
  (setq wgrep-auto-save-buffer t))

(use-package company :ensure t :defer t
  :hook (after-init . global-company-mode)
  :config
  (setq company-backends '((:separate company-capf company-dabbrev-code))
	company-global-modes '(not shell-mode)
	company-minimum-prefix-length 1
	company-dabbrev-code-ignore-case t
	company-dabbrev-code-modes t
	company-dabbrev-code-everywhere t
	company-dabbrev-code-completion-styles '(substring flex)))

(use-package orderless :ensure t :after vertico
  :config
  (setq completion-styles '(substring orderless flex)))

(use-package undo-fu-session :ensure t :defer t
  :hook (after-init . undo-fu-session-global-mode))

(use-package nyan-mode :ensure t :defer t
  :hook (after-init . nyan-mode))
