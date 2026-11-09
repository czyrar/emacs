;; -*- lexical-binding: t; -*-

;;; ========== MY CUSTOM VARIABLES ==========
;; Set once here and it will affect the needed places
(defvar fontname "IosevkaNerdFontMono")
(defvar fontsize 14)
(defvar lsps '("fortitude" "ty"))

;;; ========== PACKAGE MANAGER ==========
(setq package-enable-at-startup nil)
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
(setq straight-check-for-modifications '(watch-files find-when-checking))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;; ========== GENERAL CONFIG ==========
(use-package emacs
  :init
  (set-frame-font (concat fontname " " (number-to-string fontsize)))
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  :config
  (savehist-mode)
  (show-paren-mode t)
  (column-number-mode t)
  (global-display-line-numbers-mode t)
  (put 'upcase-region 'disabled nil)
  :custom
  (show-trailing-whitespace t)
  (display-line-numbers-type 'relative)
  (indent-tabs-mode nil)
  (initial-buffer-choice t))

;; Theme
(use-package gruber-darker-ayu-theme
  :config
  (load-theme 'gruber-darker-ayu t))

;; Vertical IDO
(use-package vertico
  :config
  (vertico-mode)
  (context-menu-mode t))

;; Completion style
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; Annotations in M-x
(use-package marginalia
  :config
  (marginalia-mode))

;; Git
(use-package magit)

;; Better selection
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-'"         . mc/skip-to-next-like-this)
         ("C-\""        . mc/skipt-to-previous-like-this)))

(use-package phi-search
  :bind (("C-s" . phi-search)
         ("C-r" . phi-search-backward)))

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

(defun duplicate-line ()
  (interactive)
  (beginning-of-line)
  (kill-line)
  (yank)
  (end-of-line)
  (newline)
  (yank))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "M-p") 'duplicate-line)

;;; ========== FOR PROGRAMMING LANGUAGES ==========

;; Tree-sitter
(use-package tree-sitter-langs)

(use-package tree-sitter
  :requires (tree-sitter-langs))

;; LSP
(use-package mason
  :config
  (mason-setup
   (dolist (pkg lsps)
     (unless (mason-installed-p pkg)
      (ignore-errors (mason-install pkg))))))

(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
	      ("C-c l r" . eglot-rename)
	      ("C-c l h" . eldoc)
	      ("C-c l f" . eglot-format)
	      ("C-c l F" . eglot-format-buffer)
	      ("C-c l d" . xref-find-definitions-at-mouse)
	      ("C-c l R" . eglot-reconnect))
  :config
  (add-to-list 'eglot-server-programs '((f90-mode f90-ts-mode) . ("fortitude" "server"))))

;; Autocompletion
(use-package corfu
  :hook (prog-mode . corfu-mode))

;; Fortran
(use-package f90-ts-mode
  :mode "\\.f90\\'"
  :custom
  (f90-auto-keyword-case 'downcase-word)
  (f90-beginning-ampersand nil)
  (f90-continuation-indent 4)
  (f90-do-indent 2)
  (f90-if-indent 2)
  (f90-smart-end 'no-blink)
  (f90-ts-indent-block 2)
  (f90-ts-indent-contain 2)
  (f90-ts-indent-continued 4)
  (f90-ts-indent-declaration 3)
  (f90-ts-indent-delete-trailing-whitespace t)
  (f90-ts-leading-ampersand nil)
  (f90-ts-leading-ampersand-style '(indent . 2))
  (f90-ts-smart-end 'no-blink)
  (f90-type-indent 2))

;; Python
(use-package micromamba
  :commands micromamba-activate)

(use-package ein
  :commands ein:run)

;; Emacs Lisp
(use-package paredit
  :hook (emacs-lisp-mode-hook . paredit-mode))
