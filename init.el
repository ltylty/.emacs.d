(require 'package)

;; (setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                          ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(package-initialize)

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-maris-dark :no-confirm))

(set-face-attribute 'default nil :font "Maple Mono SC NF")

(load-file (expand-file-name "modules/base.el" user-emacs-directory))
(load-file (expand-file-name "modules/key.el" user-emacs-directory))
(load-file (expand-file-name "modules/dev.el" user-emacs-directory))
