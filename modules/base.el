(use-package recentf
  :init
  (recentf-mode)
  :config
  (setq recentf-max-saved-items 200))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package avy
  :ensure t)

(use-package consult
  :ensure t
  :config
  (setq consult-async-input-debounce 0.8))

(use-package embark
  :ensure t
  :bind
  (("C-c a" . embark-act))
  (:map minibuffer-mode-map ("C-c C-e" . embark-export)))

(use-package embark-consult
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package wgrep
  :ensure t
  :config
  (setq wgrep-auto-save-buffer t))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-preselect 'prompt)
  :init
  (global-corfu-mode)
  :bind
  (:map corfu-map
    ("<escape>" . corfu-quit)
    ("C-n" . corfu-next)
    ("C-p" . corfu-previous)))

(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))
