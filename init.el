;; -*- lexical-binding: t; -*-
(setq package-check-signature nil)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

;; (use-package persistent-cached-load-filter :ensure t
;;   :vc (:url "https://github.com/include-yy/persistent-cached-load-filter" :branch "main" :rev :newest)
;;   :config
;;   (persistent-cached-load-filter-easy-setup))

(load-theme 'modus-vivendi-tinted t)
(when (member "Maple Mono NF CN" (font-family-list))
  (set-face-attribute 'default nil :font "Maple Mono NF CN" :height 110))
(when (member "Segoe UI Emoji" (font-family-list))
  (set-fontset-font t 'emoji (font-spec :family "Segoe UI Emoji")))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file) (load custom-file))

(load-file (expand-file-name "lisp/base.el" user-emacs-directory))
(load-file (expand-file-name "lisp/dev.el" user-emacs-directory))
(load-file (expand-file-name "lisp/key.el" user-emacs-directory))
(load-file (expand-file-name "lisp/extra.el" user-emacs-directory))

(setq initial-scratch-message (concat "enjoy coding *^____^* emacs startup in " (emacs-init-time)))
