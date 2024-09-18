(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.3
      read-process-output-max (* 10 1024 1024))

(prefer-coding-system 'utf-8)
(setq inhibit-startup-message t)
(setq initial-major-mode 'fundamental-mode)
(setq-default frame-title-format '("  %f" (:eval (if (buffer-modified-p) "  ✍️"))))
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file) (load custom-file))

(add-to-list 'default-frame-alist
	     '(font . "Maple Mono SC NF"))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
