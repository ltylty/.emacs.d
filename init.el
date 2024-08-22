(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(load-theme 'modus-vivendi-tinted t)

(load-file (expand-file-name "lisp/base.el" user-emacs-directory))
(load-file (expand-file-name "lisp/dev.el" user-emacs-directory))
(load-file (expand-file-name "lisp/extra.el" user-emacs-directory))
(load-file (expand-file-name "lisp/key.el" user-emacs-directory))

(setq initial-scratch-message (concat "enjoy coding *^____^* emacs startup in " (emacs-init-time)))
(setq gc-cons-threshold (* 100 1024 1024))
