;; -*- lexical-binding: t; -*-
(setq package-check-signature nil)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(if (find-font (font-spec :name "Maple Mono NF CN"))
  (set-face-attribute 'default nil :font "Maple Mono NF CN" :height 110))
(if (find-font (font-spec :name "Segoe UI Emoji"))
  (set-fontset-font t 'emoji (font-spec :family "Segoe UI Emoji")))
(if (find-font (font-spec :name "Segoe UI Symbol"))
  (set-fontset-font t 'symbol (font-spec :family "Segoe UI Symbol")))

(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file) (load custom-file))

(load-file (expand-file-name "lisp/base.el" user-emacs-directory))
(load-file (expand-file-name "lisp/dev.el" user-emacs-directory))
(load-file (expand-file-name "lisp/mavc.el" user-emacs-directory))
(load-file (expand-file-name "lisp/key.el" user-emacs-directory))
