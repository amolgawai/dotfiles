;; Put your customizations here.

(set-face-attribute 'default nil :family "Source Code Pro" :height 160)
(load-theme 'doom-one t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(doom-modeline-mode 1)
(add-to-list 'initial-frame-alist `(fullscreen . fullheight))
(add-to-list 'default-frame-alist `(fullscreen . fullheight))
(set-frame-height
 (selected-frame)
 (/ (display-pixel-height) (frame-char-height)))
(set-frame-width
 (selected-frame)
 (/ (/ (display-pixel-width) 2) (frame-char-width)))
