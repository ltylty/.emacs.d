(setq gc-cons-threshold most-positive-fixnum)
(setq inhibit-startup-message t)
(setq initial-major-mode 'fundamental-mode)
(setq custom-file (make-temp-file "emacs-custom"))
(setq-default frame-title-format '("%f    [" mode-name "]" (:eval (if (buffer-modified-p) " ✍️"))))
(prefer-coding-system 'utf-8)

(setq default-frame-alist
      '((fullscreen . maximized)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (horizontal-scroll-bars)
        (vertical-scroll-bars)))
