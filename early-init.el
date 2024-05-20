(setq gc-cons-threshold most-positive-fixnum)
(setq inhibit-startup-message t)
(setq custom-file (make-temp-file "emacs-custom"))
(setq-default frame-title-format '("%f    [" mode-name "]"))
;; (set-language-environment "UTF-8")

;; (set-charset-priority 'unicode)
(prefer-coding-system 'utf-8)
;; (setq system-time-locale "C")

(setq default-frame-alist
      '((fullscreen . maximized)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (horizontal-scroll-bars)
        (vertical-scroll-bars)))
