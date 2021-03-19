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

(global-linum-mode t)               ;; Enable line numbers globally
(global-hl-line-mode t)             ;; Highlight current line
(show-paren-mode t)

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
 '(auto-save-default t)
 '(backup-inhibited t t)
 '(column-number-mode t)
 '(cursor-type 'bar)
 '(delete-selection-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(elpy smex rainbow-delimiters paredit material-theme markdown-mode magit ido-yes-or-no color-theme-sanityinc-tomorrow better-defaults amx))
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil))

 (if window-system
     (tool-bar-mode -1))

 ;; Set bigger fonts
(when (member "Source Code Pro" (font-family-list))
  (set-face-attribute 'default nil
                      :family "Source Code Pro"
                      :weight 'normal
                      :width 'normal))
(set-face-attribute 'default nil
                    :height 130)
   
;; color theme
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-night t)

;; use cmd as meta
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;; Open file at same position as last time
(require 'saveplace)
(setq-default save-place t)

;; Markdown Mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Settings for Python
(elpy-enable)

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
