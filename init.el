(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(use-package ef-themes :ensure t
  :config
  (load-theme 'ef-maris-dark :no-confirm))

(when (member "Maple Mono SC NF" (font-family-list))
  (set-face-attribute 'default nil :font "Maple Mono SC NF"))

(load-file (expand-file-name "lisp/base.el" user-emacs-directory))
(load-file (expand-file-name "lisp/dev.el" user-emacs-directory))
(load-file (expand-file-name "lisp/key.el" user-emacs-directory))
(load-file (expand-file-name "lisp/extra.el" user-emacs-directory))

(setq initial-scratch-message (concat "enjoy coding *^____^* emacs startup in " (emacs-init-time)))

(use-package gcmh :ensure t 
  :hook (after-init . gcmh-mode))
