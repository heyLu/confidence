; Mhh, let's see where this goes. (I hope I don't grow a beard.)

(package-initialize)

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

(defun create-note ()
  (interactive)
  (ido-find-file)
  (simple-writing-mode t))

(global-set-key (kbd "C-x C-S-n") 'create-note)

(defun find-diary-entry ()
  (interactive)
  (find-file (format-time-string "~/w/%Y-%m-%d.txt"))
  (simple-writing-mode t))

(global-set-key (kbd "C-x C-d") 'find-diary-entry)

(defun move-line-up ()
  (interactive)
  (beginning-of-line)
  (kill-line)
  (backward-delete-char 1)
  (beginning-of-line)
  (newline)
  (previous-line)
  (yank))

(defun move-line-down ()
  (interactive)
  (beginning-of-line)
  (kill-line)
  (delete-forward-char 1)
  (end-of-line)
  (newline)
  (yank))

(global-set-key (kbd "<M-down>") 'move-line-down)
(global-set-key (kbd "<M-up>") 'move-line-up)

(custom-set-faces
 '(default ((t (:family "Fantasque Sans Mono" :height 124)))))

(custom-set-variables
 '(global-auto-revert-mode t)
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent)))
 '(js-indent-level 2)
 '(org-agenda-files (quote ("~/move.org" "~/calendar.org")))
 '(package-selected-packages
   (quote
    (lua-mode ido-vertical-mode visual-fill-column zencoding-mode zen-mode zeal-at-point yaml-mode writeroom-mode tao-theme rust-mode rainbow-delimiters project-explorer pixie-mode php-mode paredit markdown-mode inf-ruby idris-mode hl-sentence go-mode go-autocomplete git-gutter-fringe+ git-gutter git-commit-mode flymake-go flymake flycheck-rust flycheck-haskell evil ess elm-mode eink-theme editorconfig ediprolog company clojurescript-mode clojure-mode-extra-font-locking cider)))
 '(scheme-program-name "petite"))
