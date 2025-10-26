;;; init.el --- Updated for Emacs 30

;; UI basics
(setq inhibit-startup-screen t
      initial-scratch-message nil
      make-backup-files nil
      ring-bell-function 'ignore)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-hl-line-mode 1)
(show-paren-mode 1)

;; Set default window size
(setq default-frame-alist
      '((width . 120)     ;; characters
        (height . 50)))   ;; characters

(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'none   ; Right Option for special chars
       ;; mac-command-modifier 'meta       ; Command as Meta
  ))


;; Package sources: GNU + NonGNU + MELPA
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Theme
(use-package color-theme-sanityinc-tomorrow
  :init (load-theme 'sanityinc-tomorrow-night t))

(setq-default display-fill-column-indicator-column 120)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(global-display-line-numbers-mode 1)
(column-number-mode t)

;; Use bar cursor
(setq-default cursor-type 'bar)

;; Modern completion stack
(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult)
(use-package marginalia
  :init (marginalia-mode))

;; Magit (currently disabled)
;; (use-package magit)

;; Rainbow delimiters for coding
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Company auto completion
(use-package company
  :init (global-company-mode 1)
  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 1))

;; Flymake for syntax checking
(add-hook 'prog-mode-hook #'flymake-mode)

;; Markdown support
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))

;; Remember recently opened files
(recentf-mode 1)
(setq recentf-max-saved-items 50)

;; Save minibuffer history between sessions
(savehist-mode 1)

;; Show matching keybindings - very helpful for learning
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 0.5))

;; Better undo/redo
(use-package undo-tree
  :init (global-undo-tree-mode)
  :config (setq undo-tree-auto-save-history nil)) ; avoid cluttering directories

;; Smarter indentation and whitespace
(setq-default indent-tabs-mode nil          ; Use spaces, not tabs
              tab-width 4                    ; Display tabs as 4 spaces
              fill-column 120)               ; Matches your indicator

;; Clean up trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Move through windows with Shift+arrows
(windmove-default-keybindings)

;; Useful keybindings with consult
(global-set-key (kbd "C-x b") 'consult-buffer)      ; Better buffer switching
(global-set-key (kbd "C-c r") 'consult-recent-file) ; Quick recent files
(global-set-key (kbd "C-c g") 'consult-grep)        ; Search in project

;; Better terminal colors
(unless (display-graphic-p)
  (xterm-mouse-mode 1)  ; Enable mouse in terminal
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-down-line))

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
