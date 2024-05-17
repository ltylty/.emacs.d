(setq inhibit-startup-message t)
(setq custom-file (make-temp-file "emacs-custom"))
(setq-default frame-title-format '("%f    [" mode-name "]"))
(set-language-environment "UTF-8")

(setq default-frame-alist
      '((fullscreen . maximized)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (horizontal-scroll-bars)
        (vertical-scroll-bars)))

;; 优化 Emacs 的启动速度
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda () (setq gc-cons-threshold 800000)))
