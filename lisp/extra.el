(use-package macrursors :defer t
  :vc (:url "https://github.com/corytertel/macrursors" :branch "main" :rev :newest)
  :bind
  (("C-;" . macrursors-mark-all-lines-or-instances)))

(use-package color-rg :after project
  :vc (:url "https://github.com/manateelazycat/color-rg" :branch "main" :rev :newest)
  :custom
  (color-rg-command-prefix "powershell"))

(defun insert-image-from-clipboard ()
  "Insert an image from the clipboard into the current org buffer."
  (interactive)
  (let* ((image-file (concat (format-time-string "%Y%m%d%H%M%S") ".png")))
    ;; Save the clipboard image 
    (if (eq system-type 'windows-nt)
	(shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Clipboard]::GetImage().Save('" image-file "', [System.Drawing.Imaging.ImageFormat]::Png)\""))
      (error "Unsupported OS"))
    (when (eq major-mode 'org-mode)
      (insert (concat "[[file:" image-file "]]"))
      (org-display-inline-images))
    (when (eq major-mode 'markdown-mode)
      (insert (concat "![]" "(" image-file ")"))
      (markdown-display-inline-images))))
