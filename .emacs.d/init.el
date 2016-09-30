; Mhh, let's see where this goes. (I hope I don't grow a beard.)
(load "~/.emacs.d/better-defaults")

(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)
(setq inhibit-startup-message t)

(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "backups"))))

(setq ido-auto-merge-delay-time 9999)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(add-hook 'before-save-hook #'gofmt-before-save)

(add-to-list 'auto-mode-alist '("\\.edn\\'" . clojure-mode))

(add-hook 'clojure-mode-hook 'paredit-mode)

(defun simple-writing-mode (&optional enable)
  "Change the current buffer to allow for simple writing of long texts"
  (interactive)
  (if (or enable (null (get this-command 'is-enabled)))
      (progn
        (setq-local word-wrap t)
        (visual-fill-column-mode 1)
        (set-fringe-style '(0 . nil))
        (put this-command 'is-enabled t)
        (message "Simple writing mode enabled"))
    (progn
      (setq-local word-wrap nil)
      (visual-fill-column-mode 0)
      (set-fringe-style nil)
      (put this-command 'is-enabled nil)
      (message "Simple writing mode disabled"))))

(defun read-lines (path)
  (with-temp-buffer
    (insert-file-contents path)
    (split-string (buffer-string) "\n" t)))

(require 'ido-vertical-mode)
(defun find-recent-notes ()
  "Find recently edited notes."
  (interactive)
  (let ((vertical-mode-enabled ido-vertical-mode))
    (turn-on-ido-vertical)
    (let* ((recent (read-lines "~/.recent.txt"))
           (file (ido-completing-read "Choose note: " recent)))
      (when file
        (find-file file)))
    (if (null vertical-mode-enabled)
        (turn-off-ido-vertical))
    (simple-writing-mode t)))

(global-set-key (kbd "C-x C-n") 'find-recent-notes)

(custom-set-variables
 '(global-auto-revert-mode t)
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent)))
 '(scheme-program-name "petite"))
