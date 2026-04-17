;;; -*- lexical-binding: t; -*-
(use-package vc :defer t
  :custom
  (vc-handled-backends '(Git))
  (vc-auto-revert-mode t)
  (vc-dir-hide-up-to-date-on-revert t)
  :config
  (add-hook 'vc-dir-mode-hook #'vc-dir-hide-up-to-date)

  (defun vc-dir-current-should-skip-p ()
    "判断当前行是否需要跳过"
    (when vc-ewoc
      (let* ((node (ewoc-locate vc-ewoc))
             (data (ewoc-data node)))
        (when data
          (or (vc-dir-fileinfo->directory data)
              (eq (vc-dir-fileinfo->state data) 'up-to-date))))))

  (defun vc-dir-move-and-diff (move-fn wrap-pos)
    "移动到下一个文件并显示 diff"
    (let ((start-node (and vc-ewoc (ewoc-locate vc-ewoc)))
          (wrapped nil))
      (catch 'done
        (while t
          (let ((prev-node (and vc-ewoc (ewoc-locate vc-ewoc))))
            (funcall move-fn 1)
            (let ((cur-node (and vc-ewoc (ewoc-locate vc-ewoc))))
              ;; 到达边界无法继续时，回环到另一端
              (when (and (eq cur-node prev-node) (not wrapped))
                (setq wrapped t)
                (goto-char wrap-pos)
                (funcall move-fn 1)
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

  (defun vc-dir-next-and-diff ()
    "向后移动"
    (interactive)
    (vc-dir-move-and-diff #'vc-dir-next-line (point-min)))

  (defun vc-dir-prev-and-diff ()
    "向前移动"
    (interactive)
    (vc-dir-move-and-diff #'vc-dir-previous-line (point-max)))

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

  (with-eval-after-load 'vc-dir
    (define-key vc-dir-mode-map "e" 'vc-ediff)
    (define-key vc-dir-mode-map "d" 'vc-diff)
    (define-key vc-dir-mode-map "k" 'vc-revert)
    (define-key vc-dir-mode-map "c" 'vc-dir-quick-commit-all)
    (define-key vc-dir-mode-map (kbd "<tab>") 'vc-dir-next-and-diff)
    (define-key vc-dir-mode-map (kbd "<backtab>") 'vc-dir-prev-and-diff)
    (define-key vc-dir-mode-map "F" 'vc-pull)))
