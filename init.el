;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(
      better-defaults                 ;; Set up some better Emacs defaults
      paredit
      ido-completing-read+
      amx
      rainbow-delimiters
      magit
      ido-yes-or-no
      markdown-mode
      color-theme-sanityinc-tomorrow
      elpy
      flycheck
      py-autopep8
      blacken
      jedi
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)
      
;; ===================================
;; Basic Customization
;; ===================================

;(global-linum-mode t)               ;; Enable line numbers globally
(global-hl-line-mode t)
(show-paren-mode t)
(xterm-mouse-mode 1)                ;; mouse support in terminal mode

;; Show line at 80 characters
(setq-default display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; Custom keys
(global-set-key [f5] 'other-window)

;; ido-mode for file/buffer suggestions
(require 'ido-yes-or-no)
(ido-mode 1)
(ido-everywhere 1)
(ido-yes-or-no-mode)

(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

;; ido for M-x
(require 'amx)
(amx-mode 1)

;; rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

 ;; Custom variables
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.

 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#c5c8c6"))
 '(auto-save-default t)
 '(backup-inhibited t t)
 '(beacon-color "#cc6666")
 '(column-number-mode t)
 '(cursor-type 'bar)
 '(custom-safe-themes
   '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))
 '(delete-selection-mode t)
 '(elpy-rpc-python-command "python")
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(elpy smex rainbow-delimiters paredit material-theme markdown-mode magit ido-yes-or-no color-theme-sanityinc-tomorrow better-defaults amx))
 '(python-shell-interpreter "ipython")
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68")))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))

(tool-bar-mode -1)
(menu-bar-mode -1)

;; company-mode for elisp files
(add-hook 'emacs-lisp-mode-hook 'company-mode)

;; linum-mode for elisp
(add-hook 'emacs-lisp-mode-hook 'linum-mode)

;; color theme
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-night t)

;; Open file at same position as last time
(require 'saveplace)
(setq-default save-place t)

;; Markdown Mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setenv "WORKON_HOME" "/home/CODE1/320171775/miniforge3/envs/")
(setq elpy-rpc-virtualenv-path 'current)

;; Settings for Python
(elpy-enable)

;; Set
(define-key elpy-mode-map (kbd "C-c RET") nil)
(define-key elpy-mode-map (kbd "C-c RET") 'elpy-shell-send-statement-and-step)
(define-key elpy-mode-map (kbd "<f6>") 'elpy-doc)

;; Enable linum-mode for elpy
(add-hook 'elpy-mode-hook 'linum-mode)

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
  
;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; User-Defined init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
