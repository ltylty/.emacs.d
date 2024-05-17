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
(global-set-key (kbd "C-;") 'macrursors-mark-all-lines-or-instances)
