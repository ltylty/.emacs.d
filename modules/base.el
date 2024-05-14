(recentf-mode)
(winner-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(setq org-log-done 'time)

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
  (when (eq system-type 'windows-nt)
    ;; 解决Windows下 consult-ripgrep 乱码和卡死
    (add-to-list 'process-coding-system-alist '("[gG][rR][eE][pP]" . (utf-8 . gbk-dos)))
    (add-to-list 'process-coding-system-alist '("[rR][gG]" . (utf-8 . gbk-dos)))
    (setq consult-async-input-debounce 0.8)))

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
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
  (corfu-quit-at-boundary t)
  (corfu-quit-no-match t) 
  :init
  (global-corfu-mode))

(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless flex)))

(use-package embark
  :ensure t
  :bind
  (("C-c a" . embark-act))
  (:map minibuffer-mode-map ("C-c C-e" . embark-export)))

(use-package wgrep
  :ensure t
  :bind
  (:map grep-mode-map ("C-x C-q" . wgrep-change-to-wgrep-mode))
  :config
  (setq wgrep-auto-save-buffer t))
