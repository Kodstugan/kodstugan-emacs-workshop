
;; Disable GUI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Remove startup screen
(setq inhibit-startup-message t)

;; Change Yes/No to y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Fix scrolling
(setq scroll-conservatively 100)

;; Stop at subwords when jumping with C/M-<arrow>
(global-subword-mode t)

;; Electric pair mode
;; electric pairs
(setq electirc-pair-pairs '(
			    (?\( . ?\))
			    (?\{ . ?\})
			    (?\[ . ?\])
			    (?\" . ?\")
			    ))
(electric-pair-mode t)

;; Remove bell sound
(setq ring-bell-function 'ignore)

;; Global highlight
;;(when window-system (global-hl-line-mode t))

;; Prettify symbols (optional)
(when window-system (global-prettify-symbols-mode t))

;; Set up bash/terminal/shell shortcut
(defvar my-term-shell "/bin/bash")
;; advice is function to execute before/after/while another
;; in this case we hook into ansi-term and interactively push our
;; shell (my-term-shell) path as arguments, thus always launching bash
(advice-add 'ansi-term :before (lambda (&rest r) (interactive (list my-term-shell))))

;; IDO mode
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

;; Fix buffers
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ibuffer) ;; Replace crappy buffer-list with ibuffer
(setq ibuffer-expret t) ;; I dont make mistakes
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer) ;; Always kill current buffer

;; Fix window switching
(defun split-and-follow-h ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-h)

(defun split-and-follow-v ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-v)

;; Backups
;; (setq make-backup-file nil)
;; (setq auto-save-default nil)

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "file-backups")))))

;; Allow 10 backups, warn if backing up file of size > 1000000
(setq delete-old-versions t
      backup-by-copying   t
      kept-new-versions   20
      kept-old-versions   10
      version-control     t
      large-file-warning-threshold   1000000)

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))





;; Set up MELPA
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Set up use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; Which key
;; - Shows C-x - completions in minibuffer
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; Hungry deletion
(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

;; Kill ring popup
(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

;; Company mode
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config ;; Optionally set delay
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))


;; CUSTOM SETTINGS

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (leuven)))
 '(package-selected-packages
   (quote
    (popup-kill-ring company hungry-delete which-key use-package irony))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#FFFFFF" :foreground "#333333" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "Source Code Pro")))))
