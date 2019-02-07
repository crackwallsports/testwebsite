;;; Version Requirement
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))


;;; Set up package
(require 'package)

(add-to-list 'package-archives
             '("gnu" . " https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)


;;; use-package : used to configure rest of packages
;; Install
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; Load
(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)
(setq use-package-verbose t)


(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)


(require 'diminish) 
(require 'bind-key)


;;; UI
;; Basic config
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;;; OS
(defvar *sys-is* nil)
(if window-system 
  (push :window *sys-is*)
  (push :terminal *sys-is*))
(if (eq system-type 'darwin)
    (progn
      (push :macos *sys-is*)))

(cond 
 ((member :terminal *sys-is*)
  (message "Terminal")
  (menu-bar-mode -1)
  (org-babel-load-file (concat user-emacs-directory "config.org")))
 ((member :macos *sys-is*)
  (message "MacOS")
  (org-babel-load-file (concat user-emacs-directory "config.org")))
 (t
  (message "Other")
  (org-babel-load-file (concat user-emacs-directory "config.org"))))
