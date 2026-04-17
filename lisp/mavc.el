
(use-package vc :defer t
  :config
  (defun vc-dir-current-should-skip-p ()
    "判断当前行是否需要跳过：跳过文件夹 + 跳过未修改(up-to-date)文件"
    (when vc-ewoc
      (let* ((node (ewoc-locate vc-ewoc))
             (data (ewoc-data node)))
        (when data
          (or (vc-dir-fileinfo->directory data)
              (eq (vc-dir-fileinfo->state data) 'up-to-date))))))
  (defun vc-dir-next-and-diff ()
    "移动到下一个文件并显示 diff，跳过文件夹。如果在最后一个文件则跳转到第一个文件。"
    (interactive)
    (let ((start-node (and vc-ewoc (ewoc-locate vc-ewoc)))
          (wrapped nil))
      (catch 'done
        (while t
          (let ((prev-node (and vc-ewoc (ewoc-locate vc-ewoc))))
            (vc-dir-next-line 1)
            (let ((cur-node (and vc-ewoc (ewoc-locate vc-ewoc))))
              ;; 到达底部无法继续向后时，回环到顶部
              (when (and (eq cur-node prev-node) (not wrapped))
                (setq wrapped t)
                (goto-char (point-min))
                (vc-dir-next-line 1)
                (setq cur-node (and vc-ewoc (ewoc-locate vc-ewoc))))
              ;; 已遍历一圈回到起始节点
              (when (eq cur-node start-node)
                (message "No edited files found")
                (throw 'done nil))
              (unless (vc-dir-current-should-skip-p)
                (throw 'done nil))
              ;; 回环后仍无法移动
              (when (eq cur-node prev-node)
                (message "No edited files found")
                (throw 'done nil)))))))
    (save-selected-window
      (vc-diff)))
  (defun vc-dir-prev-and-diff ()
    "移动到上一个文件并显示 diff，跳过文件夹。如果在第一个文件则跳转到最后一个文件。"
    (interactive)
    (let ((start-node (and vc-ewoc (ewoc-locate vc-ewoc)))
          (wrapped nil))
      (catch 'done
        (while t
          (let ((prev-node (and vc-ewoc (ewoc-locate vc-ewoc))))
            (vc-dir-previous-line 1)
            (let ((cur-node (and vc-ewoc (ewoc-locate vc-ewoc))))
              ;; 到达顶部无法继续向前时，回环到底部
              (when (and (eq cur-node prev-node) (not wrapped))
                (setq wrapped t)
                (goto-char (point-max))
                (vc-dir-previous-line 1)
                (setq cur-node (and vc-ewoc (ewoc-locate vc-ewoc))))
              ;; 已遍历一圈回到起始节点
              (when (eq cur-node start-node)
                (message "No edited files found")
                (throw 'done nil))
              (unless (vc-dir-current-should-skip-p)
                (throw 'done nil))
              ;; 回环后仍无法移动
              (when (eq cur-node prev-node)
                (message "No edited files found")
                (throw 'done nil)))))))
    (save-selected-window
      (vc-diff)))
  (defun vc-dir-quick-commit-all ()
    "标记所有已跟踪且修改过的文件并进入提交界面"
    (interactive)
    (vc-dir-unmark-all-files 1)
    (dolist (state '(edited added removed))
      (vc-dir-mark-state-files state))
    (let ((files (vc-dir-marked-files)))
      (if files
          (vc-next-action nil)
        (message "No files to commit"))))
  (add-hook 'vc-dir-mode-hook #'vc-dir-hide-up-to-date)
  (with-eval-after-load 'vc-dir
    (define-key vc-dir-mode-map "e" 'vc-ediff)
    (define-key vc-dir-mode-map "d" 'vc-diff)
    (define-key vc-dir-mode-map "k" 'vc-revert)
    (define-key vc-dir-mode-map "c" 'vc-dir-quick-commit-all)
    (define-key vc-dir-mode-map (kbd "<tab>") 'vc-dir-next-and-diff)
    (define-key vc-dir-mode-map (kbd "<backtab>") 'vc-dir-prev-and-diff)
    (define-key vc-dir-mode-map "F" 'vc-pull)))
