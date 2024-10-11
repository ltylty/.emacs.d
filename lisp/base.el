(recentf-mode)
(global-hl-line-mode)
(winner-mode)
(save-place-mode)
(savehist-mode)
(global-auto-revert-mode)
(auto-save-visited-mode)
(which-key-mode)
(setopt use-short-answers t)
(setq org-log-done 'time)
(setq recentf-max-saved-items 500)

(use-package avy :ensure t :defer t)

(use-package consult :ensure t :defer t
  :init
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (setq consult-async-input-debounce 0.5)
  (consult-customize
   consult-line
   :default (selected-region-or-symbol-at-point)))

(use-package vertico :ensure t :defer t
  :custom
  (vertico-cycle t)
  :hook (after-init . vertico-mode))

(use-package marginalia :ensure t :defer t
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

(use-package company :ensure t :defer t
  :hook (after-init . global-company-mode)
  :config
  (define-key company-active-map [escape] 'company-abort)
  (setq company-backends '((company-capf company-dabbrev-code))
	company-minimum-prefix-length 1
	company-dabbrev-code-ignore-case t
	company-dabbrev-code-modes t
	company-dabbrev-code-everywhere t
	company-dabbrev-code-completion-styles '(basic substring flex)))

(use-package orderless :ensure t
  :config
  (setq completion-styles '(basic substring orderless flex)))

(use-package nyan-mode :ensure t :defer t
  :hook (after-init . nyan-mode))
