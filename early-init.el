(setq inhibit-startup-message t)
(setq custom-file (make-temp-file "emacs-custom"))
(setq-default frame-title-format '("%f    [" mode-name "]"))

;; no menu bar, toolbar, scroll bar
(setq default-frame-alist
      '((fullscreen . maximized)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (horizontal-scroll-bars)
        (vertical-scroll-bars)))
