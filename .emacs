(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" default))
 '(initial-scratch-message ";; Go crazy")
 '(package-selected-packages
   '(corfu jupyter markdown-mode vterm-toggle vterm ripgrep nix-mode flycheck-golangci-lint flycheck vertico eglot-booster elm-mode emacsql-sqlite evil gruvbox-theme org-roam rainbow-mode web-mode zig-mode))
 '(package-vc-selected-packages
   '((eglot-booster :vc-backend Git :url "https://github.com/jdtsmith/eglot-booster"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:background "#1d2021"))))
 '(line-number-current-line ((t (:background "#3c3836"))))
 '(mode-line ((t (:background "#3a3a3a"))))

 '(mode-line-inactive ((t (:background "#303030")))))

(load-file "~/.emacs.d/typst.el")
(load-file "~/.emacs.d/script-runner.el")

;; Including melpa support
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Machine specific variables
(setq sawyer/org-roam-directory "~/sync/org") 
(setq sawyer/org-agenda-files '("~/sync/org/todos.org"))
(setq sawyer/repos-directory "~/sync/repos")

;; Aesthetics
(setq default-frame-alist '((font . "JetBrainsMono-10")))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(toggle-truncate-lines)
(global-hl-line-mode)
(setq tab-width 8)
(setq inhibit-startup-screen t)

(setq display-line-numbers-type 'relative)

(global-display-line-numbers-mode)

(set-window-fringes nil 0 0)
(setq left-fringe-width 0)
(setq right-fringe-width 0)
(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; Auto Mode Alist
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

;; Hooks
(add-hook 'prog-mode-hook (lambda () (electric-pair-local-mode)))

;; Hide backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Package config
(use-package evil
    :ensure t
    :init
    (setq evil-want-C-u-scroll t)
    (setq evil-want-minibuffer t)

    :config
    (evil-set-leader 'normal (kbd "<SPC>"))

    (evil-define-key nil 'global
      (kbd "<leader> b")  'switch-to-buffer
      (kbd "<leader> e")  'find-file
      (kbd "<leader> df") 'describe-function
      (kbd "<leader> dv") 'describe-variable
      (kbd "<leader> dm") 'describe-mode
      (kbd "<leader> dk") 'describe-key
      (kbd "<leader> dp") 'describe-package
      (kbd "<leader> h")  'evil-window-left
      (kbd "<leader> j")  'evil-window-down
      (kbd "<leader> k")  'evil-window-up
      (kbd "<leader> l")  'evil-window-right
      (kbd "<leader> q")  'evil-quit
      (kbd "<leader> w")  'kill-buffer-and-window
      (kbd "<leader> .")  'evil-window-split
      (kbd "<leader> /")  'evil-window-vsplit
      (kbd "<leader> ;")  'delete-other-windows
      (kbd "<leader> c")  'compile
      (kbd "<leader> ,")  'toggle-truncate-lines
      (kbd "<leader> <tab>") 'indent-region

      (kbd "<leader> s")  (lambda () (interactive) (cd sawyer/repos-directory) (shell)))

    (evil-define-key '(normal insert) xref--xref-buffer-mode-map
      (kbd "RET") 'xref-goto-xref)

    (evil-define-key '(normal insert) shell-mode-map
      (kbd "C-k") 'comint-previous-input
      (kbd "C-j") 'comint-next-input)

    (evil-define-key 'normal lisp-interaction-mode-map
      (kbd "C-SPC") 'eval-region
      (kbd "C-b") 'eval-buffer)

    (evil-define-key 'normal emacs-lisp-mode-map
      (kbd "C-SPC") 'eval-region
      (kbd "C-b") 'eval-buffer)

    (evil-mode 1))

(use-package dired
  :after evil
  :init
  (add-hook 'dired-mode-hook 'evil-normalize-keymaps)
  :config
  (define-key dired-mode-map (kbd "SPC") nil)
  (evil-define-key '(normal) dired-mode-map
    (kbd "<leader> e") 'find-file))

(use-package web-mode
  :config
  (add-hook 'web-mode-hook (lambda () (setq tab-width 2))))

(use-package corfu
  :config
  (setq corfu-auto t)
  (setq corfu-cycle t)
  (global-corfu-mode 1))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard))

(use-package vertico
  :config
  (vertico-mode 1))

(use-package eglot
  :after evil
  :config
  (evil-define-key '(normal visual) 'eglot--managed-mode
    (kbd "K") 'eldoc-print-current-symbol-info
    (kbd "<leader> SPC") 'eglot-code-actions
    (kbd "<leader> sr") 'xref-find-references
    )
  (evil-define-key nil 'global
    (kbd "<leader> g") 'eglot)
  (add-to-list 'eglot-ignored-server-capabilities
	       '(:hoverProvider :inlayHintProvider :documentHighlightProvider :codeLensProvider))
  (add-to-list 'eglot-stay-out-of 'flymake)
  (add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1)))
  (add-hook 'eglot-managed-mode-hook (lambda () (flycheck-mode 1)))
  (evil-define-key '(normal visual) eglot-mode-map
    (kbd "<leader> f") 'eglot-format-buffer)
  (add-to-list 'eglot-server-programs
			   '(go-ts-mode . ("/home/sawyer/go/bin/gopls")))
  (add-to-list 'eglot-server-programs
			   '(web-mode . ("typescript-language-server" "--stdio"))))

(use-package org-roam
  :after org
  :init
  (setq org-roam-directory sawyer/org-roam-directory)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (evil-define-key nil 'global
    (kbd "<leader> of") 'org-roam-node-find
    (kbd "<leader> ob") 'org-roam-buffer
    (kbd "C-SPC") 'org-roam-node-insert))

(use-package org
  :after evil
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (julia . t)
     (python . t)
     (jupyter . t))) 
  (setq org-confirm-babel-evaluate nil)
  (setq org-babel-default-header-args:jupyter-python
	'((:async . "yes")))
  (evil-define-key 'normal org-mode-map
    (kbd "TAB") 'org-cycle
    (kbd "C-<tab>") 'org-global-cycle
    (kbd "RET") 'org-open-at-point
    )
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (evil-define-key 'insert org-mode-map
    (kbd "C-<tab>") 'org-global-cycle))

(use-package jupyter
  :after org
  :config
  (evil-define-key 'normal org-mode-map
    (kbd "C-c RET") 'jupyter-org-insert-src-block
    (kbd "C-c k") 'jupyter-org-kill-block-and-results
    )
  )

(use-package org-agenda
  :after org
  :init
  (setq org-agenda-files sawyer/org-agenda-files)
  :config
  (evil-define-key '(normal visual) org-agenda-mode-map
    (kbd "RET") 'org-agenda-todo)
  (evil-define-key '(normal visual) 'global
    (kbd "<leader> a") 'org-agenda)
  (define-key org-agenda-mode-map (kbd "j") nil)
  (define-key org-agenda-mode-map (kbd "k") nil)
  (evil-set-initial-state 'org-agenda-mode 'normal))

(use-package eglot-booster
  :after eglot
  :config
  (eglot-booster-mode))

(use-package project
  :after evil
  :config
  (evil-define-key nil 'global
    (kbd "<leader> pp") 'project-switch-project
    (kbd "<leader> pf") 'project-find-file
    (kbd "<leader> ps") 'project-shell
    (kbd "<leader> pr") 'project-run-script
    (kbd "<leader> pb") 'project-run-build-script
    (kbd "<leader> pc") 'project-compile
    (kbd "<leader> pg") 'project-find-regexp
    (kbd "<leader> pk") 'project-kill-buffers))
