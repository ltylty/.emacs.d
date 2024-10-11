(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.3
      read-process-output-max (* 10 1024 1024))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'modus-vivendi-tinted t)
(prefer-coding-system 'utf-8)
(setq inhibit-startup-message t)
(setq initial-major-mode 'fundamental-mode)
(setq-default frame-title-format '("  %f" (:eval (if (buffer-modified-p) "  ✍️"))))
(setq-default mode-line-format (add-to-list 'mode-line-format '(:eval (if (buffer-modified-p) " ●" " ○"))))
(setq default-frame-alist '((fullscreen . maximized) (font . "Maple Mono SC NF")))
