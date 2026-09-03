;; -*- lexical-binding: t; -*-
(setq gc-cons-threshold (* 128 1024 1024))
(setq read-process-output-max (* 1024 1024))

;; PERF: Many elisp file API calls consult `file-name-handler-alist'.
;; Setting it to nil speeds up startup significantly.
;; Reduce file-name operations on `load-path'. No dynamic modules are
;; loaded this early, so we skip .so/.dll search. Also skip .gz to
;; avoid decompression checks.
;; We restore them after startup.
(let ((default-file-name-handler-alist file-name-handler-alist)
      (default-load-suffixes load-suffixes)
      (default-load-file-rep-suffixes load-file-rep-suffixes))
  (setq file-name-handler-alist nil
        load-suffixes '(".elc" ".el")
        load-file-rep-suffixes '(""))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq load-suffixes default-load-suffixes
                    load-file-rep-suffixes default-load-file-rep-suffixes
                    file-name-handler-alist default-file-name-handler-alist))
            101))

(when (eq system-type 'windows-nt)
  (setq w32-get-true-file-attributes nil   ; decrease file IO workload
        w32-use-native-image-API t         ; use native w32 API
        w32-pipe-read-delay 0              ; faster IPC
        w32-pipe-buffer-size 65536))       ; read more at a time (64K, was 4K)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(prefer-coding-system 'utf-8)
(setq inhibit-startup-message t)
(setq inhibit-compacting-font-caches t)
(setq initial-major-mode 'fundamental-mode)
(setq-default frame-title-format '("  %f" (:eval (if (buffer-modified-p) "  ✍️"))))
(load-theme 'modus-vivendi-tinted t)
(setq default-frame-alist '((fullscreen . maximized)))
