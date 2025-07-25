;; -*- lexical-binding: t; -*-
(setq gc-cons-percentage 0.5
      gc-cons-threshold (* 128 1024 1024)
      read-process-output-max (* 4 1024 1024))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'modus-vivendi-tinted t)
(prefer-coding-system 'utf-8)
(setq inhibit-startup-message t)
(setq initial-major-mode 'fundamental-mode)
(setq-default frame-title-format '("  %f" (:eval (if (buffer-modified-p) "  ✍️")))) 
(setopt use-short-answers t)
(setq default-frame-alist '((fullscreen . maximized)))
