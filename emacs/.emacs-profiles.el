;;; .emacs-profiles.el --- profiles tobe used with chemacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Amol Gawai

;; Author: Amol Gawai(("default" . ((user-emacs-directory . "~/.emacs.d"))) <amol@doesnot.exist>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; chemacs provides ability to use different Emacs "distros".  It is done through having
;; differnet "profiles" which are provided in this file
;;

;;; Code:
;; FIXME:- change the doom-emacs directory to ~/code/emacs-distros/doom-emacs

(("default" . ((user-emacs-directory . "~/.emacs.d")))
 ("super-emacs" . ((user-emacs-directory . "~/code/emacs-distros/super-emacs/.emacs.d")))
 ("elegant-emacs" . ((user-emacs-directory . "~/code/emacs-distros/elegantemacs")))
 ("doom" .((user-emacs-directory . "~/code/emacs-distros/doom-emacs"))))

(provide '.emacs-profiles)
;;; .emacs-profiles.el ends here
