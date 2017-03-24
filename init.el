;; Package list
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initialize all the ELPA packages
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")
(load "prelude-packages.el")

;; Show parenthesis mode
(show-paren-mode 1)

;; ido-mode for file/buffer suggestions
(require 'ido-yes-or-no)
(ido-mode 1)
(ido-yes-or-no-mode)

;; IDO for M-x
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
;(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)

;; paredit
(require 'paredit)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;; ElDoc
(require 'eldoc)
(eldoc-add-command
     'paredit-backward-delete
     'paredit-close-round)

;; Enable company-mode for programming related modes
(add-hook 'prog-mode-hook 'global-company-mode)
(setq company-idle-delay 0.1)
(setq company-selection-wrap-around t)
(setq company-minimum-prefix-length 2)

;; Remap TAB to complete-or-indent
(defun complete-or-indent ()
    (interactive)
    (if (company-manual-begin)
        (company-complete-common)
      (indent-according-to-mode)))
;(global-set-key [tab] 'complete-or-indent)
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-selection)
     (define-key company-active-map [tab] 'company-complete-selection)))

;; Quickhelp popup for company-mode
(company-quickhelp-mode 1)

;; Eldoc-mode for clojure: shows argument list of function call
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

;; some key bindings
(global-set-key [f5] 'desktop-save)
(global-set-key [f6] 'desktop-read)
(global-set-key [f7] 'paredit-mode)
(global-set-key [f8] 'other-window)
(global-set-key [f9] 'cider-jack-in)
(global-set-key [C-tab] 'indent-relative)

;; Highlight current line
(global-hl-line-mode t)

;; Line numbers
(global-linum-mode t)

;; Custom variables
(custom-set-variables
 '(auto-save-default t)
 '(backup-inhibited t)
 '(column-number-mode t)
 '(cursor-type (quote bar) t)
 '(delete-selection-mode t)
 '(global-company-mode nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(speedbar-show-unknown-files t)
 '(scroll-bar-mode nil)
 ;'(visible-bell t)
 '(ring-bell-function 'ignore)
)

(if window-system
    (tool-bar-mode -1))

;; Set bigger fonts
;(set-default-font 'default nil "Courier-New-13")
(when (member "Source Code Pro" (font-family-list))
  (set-face-attribute 'default nil :font "Source Code Pro-13"))

;; color theme
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-night t)

;; use cmd as meta
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000) ;; sometimes scrolling jumps anyway, this helps

;; Open file at same position as last time
(require 'saveplace)
(setq-default save-place t)

;; Markdown Mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Ensure environment variables inside Emacs look the same as in the user's shell
;; This sets $MANPATH, $PATH and exec-path from your shell, but only on OS X
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Settings for Python
(require 'company-jedi)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-to-list 'company-backends 'company-jedi)
(add-hook 'python-mode-hook 'rainbow-delimiters-mode)
(add-hook 'python-mode-hook 'electric-pair-mode)

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))
(defun my-run-python ()
  (save-selected-window
    (switch-to-buffer-other-window (process-buffer (python-shell-get-or-create-process (python-shell-parse-command))))))
(add-hook 'python-mode-hook 'my-run-python)

; Disable undo for inferior python buffer
(add-hook 'inferior-python-mode-hook 'buffer-disable-undo)

;; makes up and down arrow keys behave in interaction buffer as in shell
(add-hook 'inferior-python-mode-hook
          (lambda ()
            (define-key inferior-python-mode-map [up] 'comint-previous-input)
            (define-key inferior-python-mode-map [down] 'comint-next-input)))

(add-hook 'inferior-python-mode-hook
          (lambda () (setq comint-prompt-read-only t)))
