(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.3
      read-process-output-max (* 10 1024 1024))

(prefer-coding-system 'utf-8)
(setq inhibit-startup-message t)
(setq initial-major-mode 'fundamental-mode)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq-default frame-title-format '("  %f" (:eval (if (buffer-modified-p) "  ✍️"))))

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
