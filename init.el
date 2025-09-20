;; MY DEFINED CONFIG

;; EMACS GENERAL CONFIG ----------------------------------------

;; LOAD A THEME FOR EMACS
;; OMITTED -> Easier using Customize from toolbar

;; Don't show the splash screen at start-up
(setq inhibit-startup-message t) 

;; TO NOT SAVE AUTO-SAVE FILES ALL AROUND
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

    (setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))

;; Syntax highlighting
;; Other
(show-paren-mode t)               ;show matching parenthesis.

;;ACTIVATE NUMBERED LINES GLOBALLY
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; always use y or p for yes or no
 (defalias 'yes-or-no-p 'y-or-n-p)

;;Text mode is happier than Fundamental mode ;-)
(setq default-major-mode 'text-mode)

;;Enable Rainbow delimiters mode for desired major modes
;;Not automatic-starting maybe wrong mode name?
;;(add-hook 'geiser-repl-mode-hook #'rainbow-delimiters-mode)


;;BUFFER MENU ----------------------------------------

;; To just open the buffer menu in the current window (burying whatever buffer you were in before):
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; To have it instead open the buffer menu and switch to it in one action, rebind the key as follows:
;;    (global-set-key (kbd "C-x C-b") 'buffer-menu-other-window)


;;WINDOW SET-UP
;; Quickly switch windows, sobstitute C-x o to S-arrows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; ORG MODE ----------------------------------------

;; ADD AUTOFILL ON ORG MODE AUTO
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; Personalied TODO status sequence, added 2 TODO equivalent and 1 DONE equivalent
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "PAUSED" "|" "DONE" "CANCELED")))

;; Use this variable to decide how to show headings on file opening
;; default nofols show all, nofold all closed. Can decide show<n>levels (<n> = 2..5)
(setq org-log-done 'time)

;; Make default that org mode doesn't open everything when opening files
(setq org-startup-folded 'fold)

;; Add a note when an item is marked as DONE
;;(setq org-log-done 'note) ;; temporarily disabled, a little annoying when in a hurry

;; Add this keys combinations to make quicker using org Agenda 
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)


;; REMEMBER RECENT FILES ----------------------------------------

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; LISP CONFIG ----------------------------------------
;; If there are no archived package contents, refresh them

;; Slime not saving FASL fils in same directory when compiling
(make-directory "/tmp/slime-fasls/" t) ;;to make sure dir exist because deleted on shutdown
(setq slime-compile-file-options '(:fasl-directory "/tmp/slime-fasls/"))


;; Setting a lisp for SLIME in Emacs
; commented out (setq inferior-lisp-program "/opt/sbcl/bin/sbcl")

;; Configure SBCL as the Lisp program for SLIME.
;;(add-to-list 'exec-path "/usr/local/bin")
;;(setq inferior-lisp-program "sbcl")

;; SLIME setting
;;(load (expand-file-name "~/.quicklisp/slime-helper.el"))
;;(setq inferior-lisp-program "sbcl")
(load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")


;; PACKAGE SETTING  ----------------------------------------

;; FOLOWING LINES COPIED FROM ANOTHER GH From here -->

;; Enables basic packaging support
;; Adds the Melpa archive to the list of available repositories
 
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;; myPackages contains a list of package names

(defvar myPackages

  '(
    ;; material-theme                  ;; Theme
    ;; elpy                            ;; Emacs Lisp Python Environment


;;    pdf-tools    ;; Libraray for PDF support NEED OTHERS PACKAGE
;;    pdf-view-pagemark  ;;shows the page index in the PDF
      magit ;; to control git workflow
;;    elfeed  ;; feed RSS/Atom reader Stil prefer newsboat
;;      jedi    ;; Python autocompletion 
      eglot    ;;The Emacs Client for LSP servers

    )
  )


;; Scans the list in myPackages
;; If the package listed is not already installed, install it

(mapc #'(lambda (package)

          (unless (package-installed-p package)

            (package-install package)))

      myPackages)


;; --> To Here

;; ERC SETTING

;; OMITTED

;; EGLOT-JAVA INITIALIZATION

(add-hook 'java-mode-hook 'eglot-java-mode)
(with-eval-after-load 'eglot-java
  (define-key eglot-java-mode-map (kbd "C-c l n") #'eglot-java-file-new)
  (define-key eglot-java-mode-map (kbd "C-c l x") #'eglot-java-run-main)
  (define-key eglot-java-mode-map (kbd "C-c l t") #'eglot-java-run-test)
  (define-key eglot-java-mode-map (kbd "C-c l N") #'eglot-java-project-new)
  (define-key eglot-java-mode-map (kbd "C-c l T") #'eglot-java-project-build-task)
  (define-key eglot-java-mode-map (kbd "C-c l R") #'eglot-java-project-build-refresh))


;;JEDI Python Config  ----------------------------------------

;; (add-hook 'python-mode-hook 'jedi:setup)

;;ELGOT Python Config  ----------------------------------------

;; (use-package lsp-pyright
;;   :ensure t
;;   :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
;;   :hook (python-mode . (lambda ()
;;                           (require 'lsp-pyright)
;;                           (lsp))))  ; or lsp-deferred



;;ELFEED CONFIG  ----------------------------------------
; Elfeed subscription list

(setq elfeed-feeds
      '(("https://planet.emacslife.com/atom.xml" emacs)
	("https://xkcd.com/rss.xml" comic humor)
	("https://feeds.feedburner.com/mrmoneymustache" money blog)
	("http://feeds.feedburner.com/becomingminimalistcom" minimalism improvement)
	("https://news.ycombinator.com/rss" tech hackernews)
	("https://hackernoon.com//feed" tech)
	("https://planet.lisp.org/rss20.xml" lisp)
	("https://josvisser.substack.com/feed" tech substack)))


;; Load elfeed-org
;;(require 'elfeed-org)

;; Initialize elfeed-org
;; This hooks up elfeed-org to read the configuration when elfeed
;; is started with =M-x elfeed=
;;(elfeed-org)

;; Optionally specify a number of files containing elfeed
;; configuration. If not set then the location below is used.
;; Note: The customize interface is also supported.
;;(setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org"))


;; TEMPO-MODE  ----------------------------------------

;; OMITTED, STILL EXPERIMENTING WITH IT


;; END OF USER DEFINED VARIABLE

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(misterioso))
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu
	      move-to-prompt netsplit networks noncommands readonly
	      ring services stamp track))
 '(geiser-guile-binary "guile3.0")
 '(org-log-into-drawer t)
 '(package-selected-packages
   '(company eglot-java elfeed geiser geiser-chicken geiser-guile
	     geiser-racket jedi magit ox-rst paredit pdf-tools
	     pdf-view-pagemark py-autopep8 pyvenv racket-mode
	     rainbow-delimiters slime-company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
