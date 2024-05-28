(with-eval-after-load 'eglot
  (with-eval-after-load 'java-ts-mode  
    (unless (package-installed-p 'eglot-java-lombok)
      (package-vc-install "https://github.com/ltylty/eglot-java-lombok"))
    (require 'eglot-java-lombok)
    (eglot-java-lombok/init)))

(unless (package-installed-p 'macrursors)
  (package-vc-install "https://github.com/corytertel/macrursors"))
(use-package macrursors :defer t
  :config
  (dolist (mode '(corfu-mode))
    (add-hook 'macrursors-pre-finish-hook mode)
    (add-hook 'macrursors-post-finish-hook mode)))
;; (require 'macrursors)
;; (dolist (mode '(corfu-mode))
;;     (add-hook 'macrursors-pre-finish-hook mode)
;;     (add-hook 'macrursors-post-finish-hook mode))

(unless (package-installed-p 'color-rg)
     (package-vc-install "https://github.com/manateelazycat/color-rg"))
(use-package color-rg :defer 1
  :config
  (when (eq system-type 'windows-nt)
  (setq color-rg-command-prefix "powershell")))
;; (require 'color-rg)
;; (when (eq system-type 'windows-nt)
;;   (setq color-rg-command-prefix "powershell"))
