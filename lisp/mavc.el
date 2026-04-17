
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
          (first-visited nil))
      (catch 'done
        (while t
          (vc-dir-next-line 1)
          (let ((cur-node (and vc-ewoc (ewoc-locate vc-ewoc))))
            ;; ewoc 节点回环检测：回到起始节点说明已遍历一圈
            (when (eq cur-node start-node)
              (if first-visited
                  (progn (message "No edited files found") (throw 'done nil))
                (setq first-visited t)
                (goto-char (point-min))
                (vc-dir-next-line 1)
                (setq cur-node (and vc-ewoc (ewoc-locate vc-ewoc)))))
            (unless (vc-dir-current-should-skip-p)
              (throw 'done nil))
            ;; 二次回到起始节点（已 wrap 过）
            (when (eq cur-node start-node)
              (message "No edited files found")
              (throw 'done nil))))))
    (save-selected-window
      (vc-diff)))
  (defun vc-dir-prev-and-diff ()
    "移动到上一个文件并显示 diff，跳过文件夹。"
    (interactive)
    (let ((start-node (and vc-ewoc (ewoc-locate vc-ewoc))))
      (catch 'done
        (while t
          (vc-dir-previous-line 1)
          (unless (vc-dir-current-should-skip-p)
            (throw 'done nil))
          (when (eq (ewoc-locate vc-ewoc) start-node)
            (message "No edited files found")
            (throw 'done nil)))))
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
