;; -*- lexical-binding: t; -*-
(add-hook 'prog-mode-hook 'electric-pair-mode) ;括号配对
(add-hook 'prog-mode-hook 'hs-minor-mode) ;代码折叠

(use-package ediff :defer t
  :hook
  (ediff-quit . winner-undo)
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain
	ediff-split-window-function 'split-window-horizontally))

(use-package project :defer t
  :custom
  (project-switch-commands 'project-dired))

(use-package treesit :defer t
  :config
  (setq major-mode-remap-alist
	'((python-mode . python-ts-mode)
	  (json-mode . json-ts-mode)
	  (markdown-mode . markdown-ts-mode)
          (java-mode . java-ts-mode))))

(use-package magit :ensure t :defer t
  :config
  (setq magit-ediff-dwim-show-on-hunks t))

(use-package diff-hl :ensure t :after project
  :custom (diff-hl-draw-borders nil)
  :config
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (with-eval-after-load 'magit
      (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
      (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)))

(use-package markdown-mode :ensure t :defer t)

(use-package json-mode :ensure t :defer t)

(use-package nerd-icons-dired :ensure t :defer t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package highlight-thing :ensure t :after project
  :hook (prog-mode . highlight-thing-mode)
  :custom-face
  (highlight-thing ((t (:inherit isearch))))
  :config
  (setq highlight-thing-exclude-thing-under-point t))

(use-package citre :ensure t :after project
  :init
  (require 'citre-config)
  :config
  (setq-default citre-enable-imenu-integration nil)
  (setq-default citre-enable-capf-integration nil)
  (setq
   citre-default-create-tags-file-location 'global-cache
   citre-gtags-args '("--compact")
   citre-edit-ctags-options-manually nil
   citre-auto-enable-citre-mode-modes '(sql-mode)))

(use-package color-rg :after project
  :vc (:url "https://github.com/manateelazycat/color-rg" :branch "main" :rev :newest)
  :custom
  (color-rg-mac-load-path-from-shell nil)
  (color-rg-search-ignore-rules nil)
  (color-rg-search-no-ignore-file nil))

(use-package fanyi :ensure t :defer t)

(use-package sqlformat :ensure t :after sql
  :config
  (define-key sql-mode-map (kbd "C-c C-f") 'sqlformat))

(use-package highlight-parentheses :ensure t :after project
  :hook (prog-mode . highlight-parentheses-mode)
  :custom
  (highlight-parentheses-colors '("red" "green" "yellow" "purple" "orange")))

(use-package copilot :ensure t :after project
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))
  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))
  (add-to-list 'copilot-indentation-alist '(special-mode 2)))

(use-package aidermacs :ensure t :defer t
  :custom
  (aidermacs-default-model "openrouter/deepseek/deepseek-r1-0528:free")
  (aidermacs-weak-model "openrouter/qwen/qwen3-235b-a22b:free")
  (aidermacs-use-architect-mode t))

(use-package lsp-java :ensure t :defer t
  :hook (java-ts-mode . lsp)
  :config
  (setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx2G" "-Xms100m" "-javaagent:c:/Users/Administrator/AppData/Roaming/.emacs.d/lombok.jar"))
  (setq lsp-java-configuration-runtimes '[(:name "JavaSE-1.8"
						 :path "C:/Program Files/Java/jdk1.8.0_201/"
						 :default t)]))

(use-package treemacs :ensure t :defer t
  :config
  (setq treemacs-follow-after-init t)
  (setq treemacs-is-never-other-window t)
  (setq treemacs-collapse-dirs 10)
  (treemacs-git-mode 'deferred)
  (treemacs-git-commit-diff-mode t)
  (treemacs-project-follow-mode t)
  (treemacs-follow-mode t))

(use-package treemacs-evil :ensure t :after (treemacs evil))
(use-package treemacs-magit :ensure t :after (treemacs magit))
