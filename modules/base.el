(use-package recentf
  :init
  (recentf-mode))

(use-package winner
  :init
  (winner-mode))

(use-package org
  :defer t
  :config
  (setq org-log-done 'time))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package avy
  :ensure t)

(use-package consult
  :ensure t
  :init
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (setq consult-async-input-debounce 0.8))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

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
