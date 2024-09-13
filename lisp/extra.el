(use-package macrursors :defer t
  :vc (:url "https://github.com/corytertel/macrursors" :branch "main")
  :bind
  (("C-;" . macrursors-mark-all-lines-or-instances))
  :config
  (dolist (mode '(company-mode))
    (add-hook 'macrursors-pre-finish-hook mode)
    (add-hook 'macrursors-post-finish-hook mode)))

(defun selected-region-or-symbol-at-point ()
  "Return the selected region, otherwise return the symbol at point."
  (let (search-term)
    (setq search-term
          (seq-some #'thing-at-point '(region symbol)))
    (if (use-region-p) (deactivate-mark))    
    search-term))
