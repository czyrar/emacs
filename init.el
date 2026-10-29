;; -*- lexical-binding: t; -*-

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

(straight-use-package 'use-package)

;; Base config
(use-package emacs
  :init
  (set-frame-font "IosevkaNerdFontMono 14")
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (ido-mode 1)
  (ido-everywhere 1)
  (show-paren-mode 1)
  (column-number-mode 1)
  (global-display-line-numbers-mode 1))

(use-package ido-completing-read+
  :straight t
  :config
  (ido-ubiquitous-mode 1))

(use-package amx
  :straight t
  :config
  (amx-mode 1))

;; Git
(use-package magit
  :straight t)

;; Better selection
(use-package expand-region
  :straight t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; Multiple cursors
(use-package multiple-cursors
  :straight t
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->")         'mc/mark-next-like-this)
  (global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
  (global-set-key (kbd "C-'")         'mc/skip-to-next-like-this)
  (global-set-key (kbd "C-\"")        'mc/skip-to-previous-like-this))

(use-package phi-search
  :straight t
  :config
  (global-set-key (kbd "C-s") 'phi-search)
  (global-set-key (kbd "C-r") 'phi-search-backward)
  (require 'phi-replace)
  (global-set-key (kbd "M-%") 'phi-replace-query))

;;; ========== FOR PROGRAMMING LANGUAGES ==========

;; Tree-sitter
(use-package treesit
  :config
  (add-to-list 'treesit-language-source-alist '(fortran "https://github.com/stadelmanma/tree-sitter-fortran")))

;; LSP
(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '((f90-mode f90-ts-mode) . ("fortitude" "server"))))

;; Fortran
(use-package f90-ts-mode
  :straight t
  :mode "\\.f90\\'")

;; Python
(use-package python-ts-mode
  :mode "\\.py\\'")

(use-package micromamba
  :straight t)

(use-package ein
  :straight t
  :defer t)

;; Lisp
(use-package paredit
  :straight t
  :hook (emacs-lisp-mode-hook . paredit-mode))

;; Move lines up or down
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; ========== HOOKS ==========

;; Delete trailing whitespaces
(defun delete-trailing-whitespace-at-save ()
  (interactive)
  (setopt show-trailing-whitespace t)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

;; ========== OPTIONS SELECTED BY customize ==========

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("346abfbbf2d6327d5e5ae13bd1d2ee7f7c340c8a21b85948c479264a4f6c89cf"
     default))
 '(f90-auto-keyword-case 'downcase-word)
 '(f90-beginning-ampersand nil)
 '(f90-continuation-indent 4)
 '(f90-do-indent 2)
 '(f90-if-indent 2)
 '(f90-smart-end 'no-blink)
 '(f90-ts-indent-block 2)
 '(f90-ts-indent-contain 2)
 '(f90-ts-indent-continued 4)
 '(f90-ts-indent-declaration 3)
 '(f90-ts-indent-delete-trailing-whitespace t)
 '(f90-ts-leading-ampersand nil)
 '(f90-ts-leading-ampersand-style '(indent . 2))
 '(f90-ts-smart-end 'no-blink)
 '(f90-type-indent 2)
 '(indent-tabs-mode nil)
 '(initial-buffer-choice t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

;; ========== THEMES ==========

(use-package gruber-darker-ayu-theme
  :straight t
  :config
  (load-theme 'gruber-darker-ayu))
