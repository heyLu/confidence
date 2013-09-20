; Mhh, let's see where this goes. (I hope I don't grow a beard.)
(load "~/.emacs.d/better-defaults")

(require 'package)
(add-to-list 'package-archives
  '("marmalade" .
    "http://marmalade-repo.org/packages/"))

(add-hook 'clojure-mode-hook 'paredit-mode)

(custom-set-variables
 '(initial-buffer-choice (get-buffer "*scratch*")))
