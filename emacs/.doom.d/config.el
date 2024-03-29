  ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

  ;; Place your private configuration here! Remember, you do not need to run 'doom
  ;; sync' after modifying this file!


  ;; Some functionality uses this to identify you, e.g. GPG configuration, email
  ;; clients, file templates and snippets.
  (setq user-full-name "Amol Gawai"
        user-mail-address "amol.gawai@doesnot.exist"
        confirm-kill-emacs nil)

  ;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
  ;; are the three important ones:
  ;;
  ;; + `doom-font'
  ;; + `doom-variable-pitch-font'
  ;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
  ;;   presentations or streaming.
  ;;
  ;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
  ;; font string. You generally only need these two:
  (setq doom-font (font-spec :family "Source Code Pro" :size 18))

  ;; There are two ways to load a theme. Both assume the theme is installed and
  ;; available. You can either set `doom-theme' or manually load a theme with the
  ;; `load-theme' function. This is the default:
  (setq doom-theme 'doom-one)

  (add-to-list 'initial-frame-alist '(fullscreen . maximized))
  ;; (setq initial-frame-alist '(fullscreen . maximized))

  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  (setq org-directory "~/Notes/")

  ;; This determines the style of line numbers in effect. If set to `nil', line
  ;; numbers are disabled. For relative line numbers, set this to `relative'.
  (setq display-line-numbers-type 'visual)

  (setq deft-directory "~/Notes/")

  ;; (after! centaur-tabs
  ;;   :bind
  ;;   ("C-<prior>" . centaur-tabs-backward)
   ;;  ("C-<next>" . centaur-tabs-forward))
  ;; function list sidebar
  (use-package! imenu-list
    :bind ([f9] . imenu-list-smart-toggle)
    :config
    (setq imenu-list-auto-resize t)            ;; resize automatically
    (setq imenu-list-focus-after-activation t))

  (use-package! org-journal
    :after org
    :custom
    (org-journal-dir (concat (file-name-as-directory org-directory) "journal"))
    (org-journal-file-format "%Y/%m/%Y%m%d")
    (org-journal-date-format "%A, %Y-%m-%d")
    ;; (org-journal-encrypt-journal t)
    ;; (org-journal-enable-encryption nil)
    (org-journal-enable-agenda-integration t))

;; yasnippet
(setq yas-triggers-in-field t)
(use-package! doom-snippets             ; hlissner
  :after yasnippet)
(use-package! yasnippet-snippets        ; AndreaCrotti
  :after yasnippet)

;; blamer.el
;; (use-package! blamer
;;   :bind (("s-i" . blamer-show-commit-info))
;;   :defer 20
;;   :custom
;;   (blamer-idle-time 0.3)
;;   (blamer-min-offset 70)
;;   :custom-face
;;   (blamer-face ((t :foreground "#7a88cf"
;;                     :background nil
;;                     :height 140
;;                     :italic t)))
;;   :config
  ;; (global-blamer-mode 1))

  ;; Here are some additional functions/macros that could help you configure Doom:
  ;;
  ;; - `load!' for loading external *.el files relative to this one
  ;; - `use-package' for configuring packages
  ;; - `after!' for running code after a package has loaded
  ;; - `add-load-path!' for adding directories to the `load-path', relative to
  ;;   this file. Emacs searches the `load-path' when you load packages with
  ;;   `require' or `use-package'.
  ;; - `map!' for binding new keys
  ;;
  ;; To get information about any of these functions/macros, move the cursor over
  ;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
  ;; This will open documentation for it, including demos of how they are used.
  ;;
  ;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
  ;; they are implemented.

(load! "+keybindings")
