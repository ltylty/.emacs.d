(require 'package)
(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-maris-dark :no-confirm))

(load-file (expand-file-name "modules/base.el" user-emacs-directory))
(load-file (expand-file-name "modules/key.el" user-emacs-directory))
(load-file (expand-file-name "modules/dev.el" user-emacs-directory))
