(use-package macrursors :defer t
  :vc (:url "https://github.com/corytertel/macrursors" :branch "main")
  :bind
  (("C-;" . macrursors-mark-all-lines-or-instances))
  :config
  (dolist (mode '(company-mode))
    (add-hook 'macrursors-pre-finish-hook mode)
    (add-hook 'macrursors-post-finish-hook mode)))

(defun region-or-symbol-at-point-str ()
  "Returns string of selected region or symbol at point"
  (if (use-region-p)
      (progn
        (deactivate-mark)
	(buffer-substring-no-properties (region-beginning) (region-end)))
    (substring-no-properties (thing-at-point 'symbol))))
