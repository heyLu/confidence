; Mhh, let's see where this goes. (I hope I don't grow a beard.)
(load "~/.emacs.d/better-defaults")

(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)

(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "backups"))))

(setq ido-auto-merge-delay-time 9999)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(add-to-list 'auto-mode-alist '("\\.edn\\'" . clojure-mode))

(add-hook 'clojure-mode-hook 'paredit-mode)

(define-derived-mode pixie-mode clojure-mode "Pixie"
  "Major mode for editing Pixie files"
  (setq-local inferior-lisp-program "pixie-vm"))
(add-to-list 'auto-mode-alist '("\\.pxi\\'" . pixie-mode))

(custom-set-variables
 '(global-auto-revert-mode t)
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent)))
 '(initial-buffer-choice (get-buffer "*scratch*"))
 '(scheme-program-name "petite"))
