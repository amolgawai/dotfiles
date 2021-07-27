  ;;; $DOOMDIR/my-keybindings.el -*- lexical-binding: t; -*-


(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'none
        ;; set keys for Apple keyboard, for emacs in OS X
        mac-command-modifier 'meta ; make cmd key do Meta
        mac-option-modifier 'super ; make opt key do Super
        mac-control-modifier 'control ; make Control key do Control
        ns-function-modifier 'hyper))  ; make Fn key do Hyper

(map! :map global-map
      "C-M-<left>" #'evil-window-left
      "C-M-<right>" #'evil-window-right
      "C-M-<up>" #'evil-window-up
      "C-M-<down>" #'evil-window-down)
