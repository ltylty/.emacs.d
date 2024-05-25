(with-eval-after-load 'eglot
  (with-eval-after-load 'java-ts-mode  
    (unless (package-installed-p 'eglot-java-lombok)
      (package-vc-install "https://github.com/ltylty/eglot-java-lombok"))
    (require 'eglot-java-lombok)
    (eglot-java-lombok/init)))

(unless (package-installed-p 'macrursors)
  (package-vc-install "https://github.com/corytertel/macrursors"))
(require 'macrursors)
(dolist (mode '(corfu-mode))
    (add-hook 'macrursors-pre-finish-hook mode)
    (add-hook 'macrursors-post-finish-hook mode))
(define-key evil-normal-state-map (kbd "C-;") 'macrursors-mark-all-lines-or-instances)
(define-key evil-normal-state-map (kbd "M-p") 'macrursors-mark-previous-line)
(define-key evil-normal-state-map (kbd "M-n") 'macrursors-mark-next-line)

(unless (package-installed-p 'color-rg)
     (package-vc-install "https://github.com/manateelazycat/color-rg"))
(require 'color-rg)
(when (eq system-type 'windows-nt)
  (setq color-rg-command-prefix "powershell"))
