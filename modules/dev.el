(use-package emacs
  :config
  :hook
  ((prog-mode . electric-pair-mode)))

;; (use-package project
;;     :custom
;;     (project-switch-commands
;; 	'((project-find-file "find file")
;; 	  (project-dired "dired"))))

(use-package tabspaces
  :ensure t)

(use-package magit
  :ensure t)

(use-package markdown-mode
  :hook ((markdown-mode . visual-line-mode)))

(use-package yaml-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package eglot
  :hook
  (((python-ts-mode java-ts-mode-hook) . eglot-ensure)))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(use-package treemacs
  :ensure t
  :defer t
  :config
  (treemacs-project-follow-mode t)
  (treemacs-follow-mode t))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)
