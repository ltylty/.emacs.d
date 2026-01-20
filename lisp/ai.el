;; -*- lexical-binding: t; -*-
(use-package vterm :ensure t :defer t
  :vc (:url "https://github.com/xhcoding/emacs-libvterm" :branch "main" :rev :newest)
  :config
  (define-key vterm-mode-map (kbd "<prior>") #'vterm--self-insert)
  (define-key vterm-mode-map (kbd "<next>") #'vterm--self-insert)
  (define-key vterm-mode-map (kbd "S-<insert>") #'vterm-yank)
  (define-key vterm-mode-map (kbd "<home>") #'vterm--self-insert)
  (define-key vterm-mode-map (kbd "<end>") #'vterm--self-insert)
  (define-key vterm-mode-map (kbd "C-u") #'vterm--self-insert))

;; Open vterm with command for current project
(defun xx/vterm-with-command (cmd &optional prefix)
  "Open vterm and run CMD for current project.
PREFIX is used for buffer name prefix, defaults to CMD."
  (interactive)
  (let* ((prefix (or prefix cmd))
         (project-root (when (fboundp 'project-current)
                         (let ((proj (project-current)))
                           (when proj (project-root proj)))))
         (buffer-name (if project-root
                          (format "*vterm-%s-%s*" prefix (file-name-nondirectory (directory-file-name project-root)))
                        (format "*vterm-%s*" prefix))))
    (if (get-buffer buffer-name)
        (switch-to-buffer buffer-name)
      (progn
        (vterm buffer-name)
        (vterm-send-string cmd)
        (vterm-send-return)))))

;; AI tools
(defun xx/vterm-opencode () (interactive) (xx/vterm-with-command "opencode"))
(defun xx/vterm-qwen () (interactive) (xx/vterm-with-command "qwen"))
(defun xx/vterm-codebuddy () (interactive) (xx/vterm-with-command "codebuddy"))
(defun xx/vterm-fish () (interactive) (xx/vterm-with-command "fish"))
