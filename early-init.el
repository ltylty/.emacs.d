(setq
 ;; set a high value before initialization, and it should be reduced to a proper value after init
 gc-cons-threshold most-positive-fixnum
 gc-cons-percentage 0.3
 read-process-output-max (* 10 1024 1024))

(setq inhibit-startup-message t)
(setq initial-major-mode 'fundamental-mode)
(setq custom-file (make-temp-file "emacs-custom"))
(setq-default frame-title-format '(("  GC: " (:eval (number-to-string gcs-done)) " - " (:eval (number-to-string gc-elapsed)) "s")
				   "  %f" 
				   (:eval (if (buffer-modified-p) "  ✍️"))))
(prefer-coding-system 'utf-8)

(setq default-frame-alist
      '((fullscreen . maximized)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (horizontal-scroll-bars)
        (vertical-scroll-bars)))
