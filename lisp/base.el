;; -*- lexical-binding: t; -*-
(use-package emacs :defer 0.1
  :custom
  (dired-dwim-target t)
  :config
  (winner-mode)
  (save-place-mode)
  (savehist-mode)
  (global-auto-revert-mode)
  (auto-save-visited-mode)
  (global-hl-line-mode)
  (which-key-mode))

(use-package org :defer 0.2
  :custom
  (org-modules '(org-tempo))
  (org-log-done 'time))

(use-package recentf :defer t
  :custom
  (recentf-max-saved-items 300)
  :hook (after-init . recentf-mode))

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
  (setq company-backends '((company-capf company-dabbrev-code))
	company-global-modes '(not shell-mode eshell-mode org-mode aidermacs-comint-mode)
	company-minimum-prefix-length 1
	company-dabbrev-code-ignore-case t
	company-dabbrev-code-modes t
	company-dabbrev-code-everywhere t
	company-dabbrev-code-completion-styles '(substring flex)))

(use-package company-box :ensure t :defer t
  :hook (company-mode . company-box-mode))

(use-package completion-preview :defer t
  :custom (completion-preview-minimum-symbol-length 2)
  :hook ((shell-mode . completion-preview-mode) (eshell-mode . completion-preview-mode)))

(use-package orderless :ensure t :defer 0.1
  :config
  (setq completion-styles '(substring orderless flex)))

(use-package undo-fu-session :ensure t :defer t
  :hook (after-init . undo-fu-session-global-mode))

(use-package nyan-mode :ensure t :defer t
  :hook (after-init . nyan-mode))

(use-package doom-modeline :ensure t :defer t
  :hook (after-init . doom-modeline-mode))
