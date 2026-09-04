;; -*- lexical-binding: t; -*-
;; 性能优化
(setq gc-cons-threshold (* 128 1024 1024))
(setq read-process-output-max (* 1024 1024))
(setq inhibit-compacting-font-caches t)

(let ((default-file-name-handler-alist file-name-handler-alist)
      (default-load-suffixes load-suffixes)
      (default-load-file-rep-suffixes load-file-rep-suffixes))
  (setq file-name-handler-alist nil
        load-suffixes '(".elc" ".el")
        load-file-rep-suffixes '(""))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq load-suffixes default-load-suffixes
                    load-file-rep-suffixes default-load-file-rep-suffixes
                    file-name-handler-alist default-file-name-handler-alist))))

(when (eq system-type 'windows-nt)
  (setq w32-get-true-file-attributes nil))   ; decrease file IO workload

;; 初始化
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(prefer-coding-system 'utf-8)
(setq inhibit-startup-message t)
(setq initial-major-mode 'fundamental-mode)
(setq-default frame-title-format '("  %f" (:eval (if (buffer-modified-p) "  ✍️"))))
(load-theme 'modus-vivendi-tinted t)
(setq default-frame-alist '((fullscreen . maximized)))
