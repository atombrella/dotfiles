;; load paths
(server-start)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/pymacs")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/magit")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/python-mode")
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/cparen")

;; (load-library "tablegen-mode")

(require 'ibuffer)
(require 'ispell)
(require 'ffap)
(require 'eldoc)
(require 'dired-x)
(require 'iso-transl)
;; (require 'magit)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/package/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; dired stuff
(add-hook 'dired-mode-hook
          '(lambda ()
             (setq dired-omit-files
                   (concat
                    "^\\.svn\\|"
                    "CVS$\\|"
                    "^\\.git\\|"
                    dired-omit-files))
             (dired-omit-mode)))

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

;; put cursor in the place from the last buffer editing position
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")

(set-scroll-bar-mode -1)
(scroll-bar-mode -1)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq selection-coding-system 'utf-8)

(setq large-file-warning-threshold 20000000)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/") t))

(require 'package)

(when (not (equal window-system nil))
  (require 'mwheel)
  (mwheel-install)
  (if (>= (string-to-number emacs-version) 23)
      (set-frame-font "DejaVu Sans Mono 9")
    (set-frame-font "fixed"))
  (set-selection-coding-system 'compound-text-with-extensions)
  (setq default-frame-alist
        '((wait-for-wm . nil)
          (top . 100 ) (left . 50)))
  (unless (featurep 'xemacs)
    (set-background-color "grey80")
    (set-foreground-color "black")
    (set-mouse-color "limegreen")
    (set-cursor-color "dark blue")
    (set-face-background 'fringe "grey85") ;; scrollbar sides
    (set-face-foreground 'font-lock-string-face "cadetblue")
    (set-face-foreground 'font-lock-comment-face "forest green")
    (set-face-foreground 'font-lock-type-face "wheat4")
    (set-frame-height (selected-frame) 60)
    (set-frame-width (selected-frame) 130))
  (setq x-select-enable-clipboard t)
  (set-clipboard-coding-system 'utf-8)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; the in-frame speedbar
(when (require 'sr-speedbar nil 'noerror)
  (setq speedbar-supported-extension-expressions
    '(".org" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?"
       ".tex\\(i\\(nfo\\)?\\)?" ".el"
       ".java" ".p[lm]" ".pm" ".py"  ".s?html"  "Makefile.am" "configure.ac"))
  (setq speedbar-frame-parameters
        '((minibuffer)
          (width . 40)
          (border-width . 0)
          (menu-bar-lines . 0)
          (tool-bar-lines . 0)
          (unsplittable . t)
          (left-fringe . 0)))
  (setq speedbar-hide-button-brackets-flag t)
  (setq speedbar-show-unknown-files t)
  (setq speedbar-smart-directory-expand-flag t)
  (setq speedbar-use-images nil)
  (setq sr-speedbar-auto-refresh nil)
  (setq sr-speedbar-max-width 70)
  (setq sr-speedbar-right-side nil)
  (setq sr-speedbar-width-console 40)

  (when window-system
    (defadvice sr-speedbar-open (after sr-speedbar-open-resize-frame activate)
      (set-frame-width (selected-frame)
                       (+ (frame-width) sr-speedbar-width)))
    (ad-enable-advice 'sr-speedbar-open 'after 'sr-speedbar-open-resize-frame)

    (defadvice sr-speedbar-close (after sr-speedbar-close-resize-frame activate)
      (sr-speedbar-recalculate-width)
      (set-frame-width (selected-frame)
                       (- (frame-width) sr-speedbar-width)))
    (ad-enable-advice 'sr-speedbar-close 'after 'sr-speedbar-close-resize-frame))

  (setq
    sr-speedbar-width-x 20
    sr-speedbar-right-side t))

(setq display-time-string-forms
      '(24-hours ":" minutes))
(display-time)
(auto-save-mode -1)
(temp-buffer-resize-mode t)
(auto-compression-mode t)
(setq transient-mark-mode 1)
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)
(line-number-mode 1)
(column-number-mode 1)
(global-hl-line-mode 1)
(set-face-background 'hl-line "light green")

;; Make space do what tab does when autocompleting,
;; NOT stopping at punctuation:
(define-key minibuffer-local-completion-map (kbd " ")
  'minibuffer-complete)

(setq enable-recursive-minibuffers nil   ;;  allow mb cmds in the mb
      minibuffer-scroll-window nil
      resize-mini-windows nil)

(icomplete-mode t)                       ;; completion in minibuffer
(setq icomplete-prospects-height 1       ;; don't spam my minibuffer
      icomplete-compute-delay 0)         ;; don't wait
(require 'icomplete+ nil 'noerror)       ;; drew adams' extras

(tool-bar-mode -1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq c-basic-offset 4
      tab-width 4
      indent-tabs-mode nil
      inhibit-splash-screen t)         ; hide welcome screen

(desktop-save-mode 1)
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)

(iswitchb-mode 1)
(icomplete-mode 1)
(setq iswitchb-buffer-ignore '("^ " "*Messages*" "*Buffer Completions*"
                               "*scratch*" "*Completions*" "*Compile-Log*"
                               "*Help*" "*desktop*" "^\*.*\*$" "TAGS"))


; php-mode -- start
;; (setq 'irony-supported-major-modes '(php-mode) '(irony-supported-major-modes))
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;; php-mode -- end

;; because I want to able to create __init__.py files
(add-hook 'find-file-hooks 'assume-new-is-modified)
(defun assume-new-is-modified ()
  (when (not (file-exists-p (buffer-file-name)))
    (set-buffer-modified-p t)))

(setq-default calendar-week-start-day 1
              default-fill-column 79 ;; consider changing this to 80
              completion-ignored-extensions
              (quote (".aux" ".svn/" "CVS/" ".o" "~" ".bin" ".lbin"
                      ".so" ".a" ".ln" ".blg" ".bbl" ".elc"
                      ".lof" ".glo" ".idx" ".lot" ".dvi" ".fmt"
                      ".tfm" ".pdf" ".class" ".fas" ".lib" ".mem"
                      ".x86f" ".sparc" ".sparcf" ".fasl" ".ufsl" ".fsl"
                      ".dxl" ".pfsl" ".dfsl" ".lo" ".log" ".la" ".gmo"
                      ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg"
                      ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps"
                      ".vrs" ".pyc" ".pyo" ".thm" ".rel" ".pdf" ".lof"))
              scalable-fonts-allowed t
              show-trailing-whitespace nil
              european-calendar-style t
              next-line-add-newlines nil
              mouse-yank-at-point t
              default-major-mode 'text-mode
              inhibit-startup-message t
              visible-bell nil
              user-full-name "Mads Jensen"
              inhibit-default-init nil
              vc-suppress-confirm nil
              ffap-url-regexp nil
              compilation-window-height 18
              ispell-dictionary "english"
              c-basic-offset 4
              scroll-preserve-screen-position t
              auto-save-default t
              kill-whole-line t
              delete-auto-save-files t
              delete-old-versions t
              initial-scratch-message nil
              version-control 'never
              default-abbrev-mode t
              ispell-program-name "aspell"
              scroll-step 1
              diff-switches "-u"
              tabs-always-indent nil
              sentence-end-double-space t
              ;; sentence-end-without-period nil
              sentence-end "[.?!][]\"')}]*\\($\\|     \\|  \\)[
              ]*"
              ;; paragraph-end ""
              ;; paragraph-start
              ;; paragraph-separate
              indent-tabs-mode nil)

(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;; last pattern "^\*.*\*$"
;; turn off all useless junk
(tool-bar-mode -1)

(add-hook 'html-mode-hook '(lambda ()
                             (auto-fill-mode 1)))

;; parentheses matching
;; mic-paren.el is available at:
;; http://www.docs.uu.se/~mic/emacs.shtml
(require 'mic-paren)
(paren-activate)

(require 'cparen)
(cparen-activate)
(show-paren-mode t)

;; time and date in the mode line
(setq display-time-mail-face 'display-time-mail-face)
(display-time-mode t)

(turn-on-font-lock)
(blink-cursor-mode -1)

;; various stuff
(setq kill-emacs-query-functions
      (cons (lambda () (y-or-n-p "Really kill Emacs? "))
            kill-emacs-query-functions))
(setq initial-major-mode 'lisp-interaction-mode)

(auto-compression-mode t)
(delete-selection-mode 1)
(mouse-avoidance-mode 'exile)

(require 'imenu)
(require 'recentf)

(recentf-mode 1)

(setq hippie-expand-try-functions-list
          '(try-expand-line
            try-expand-dabbrev
            try-expand-line-all-buffers
            try-expand-list
            try-expand-list-all-buffers
            try-expand-dabbrev-visible
            try-expand-dabbrev-all-buffers
            try-expand-dabbrev-from-kill
            try-complete-file-name
            try-complete-file-name-partially
            try-complete-lisp-symbol
            try-complete-lisp-symbol-partially
            try-expand-whole-kill))
(autoload 'comint-dynamic-complete "comint" "Complete for file name" t)
(setq comint-completion-addsuffix '("/" . ""))

; elisp-mode customizations -- start
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
; elisp-mode customizations -- end

; scala mode -- start
(require 'scala-mode)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'load-path "~/.emacs.d/site-lisp/ensime/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
; scala mode -- end

; auctex/reftex settings -- start
(require 'tex-site)
(require 'reftex)
(require 'font-latex)

; source specials
(setq TeX-source-correlate-method 'source-specials)
(TeX-source-correlate-mode t)

; the second argument is for styles
(setq TeX-output-view-style (quote (("^pdf$" "." "evince %o")
                                    ("^ps$" "." "gv %o"))))

(setq TeX-auto-save t
      TeX-parse-self t
      TeX-auto-untabify t)

;; add something for detecting the dictionary automatically

;; c++ and c mode settings -- start
(add-hook 'c++-mode-hook
          '(lambda()
             (irony-mode)
             (company-mode)
             (cwarn-mode)
             (c-toggle-hungry-state)))

(add-hook 'c-mode-hook
          '(lambda()
             (irony-mode)
             (company-mode)
             (cwarn-mode)
             (c-toggle-hungry-state)))
;; c++ and c mode settings -- end

; settings for reftex
(setq reftex-enable-partial-scans t
      reftex-save-parse-info t
      reftex-plug-into-AUCTeX t
      reftex-use-multiple-selection-buffers t
      reftex-label-alist '(AMSTeX))

(setq bibtex-autokey-names 1
      bibtex-autokey-names-stretch 1
      bibtex-autokey-name-separator "-"
      bibtex-autokey-additional-names "-et.al."
      bibtex-autokey-name-case-convert 'identity
      bibtex-autokey-name-year-separator "-"
      bibtex-autokey-titlewords-stretch 0
      bibtex-autokey-titlewords 0
      bibtex-maintain-sorted-entries 'plain
      bibtex-entry-format '(opts-or-alts numerical-fields))

(add-hook 'LaTeX-mode-hook
	  '(lambda()
	     (LaTeX-math-mode t)
             (TeX-global-PDF-mode t)
             (add-to-list 'TeX-view-program-list
                          '("Evince" "evince --page-index=%(outpage) %o"))
             (turn-on-reftex)
	     (ispell-minor-mode t)
             (TeX-PDF-mode t)
             (local-set-key (kbd "<f1>")
                            '(lambda ()
                               (shell-command-to-string "texdoc" (current-word))))
	     (setq ispell-dictionary "english")
	     (setq tex-default-mode 'LaTeX-mode
                   LaTeX-default-width "\\textwidth"
                   font-latex-title-fontify 'color
                   font-latex-slide-title-face 'color
                   TeX-newline-function 'newline-and-indent
                   LaTeX-item-indent 2
                   LaTeX-syntactic-comments nil
                   LaTeX-indent-level 2
                   LaTeX-command "latex -synctex=1"
                   LaTeX-math-menu-unicode t
                   LaTeX-math-abbrev-prefix "*"
                   font-latex-fontify-sectioning 'color
                   font-latex-fontify-script nil
                   TeX-debug-warnings 't
                   TeX-clean-confirm nil
                   TeX-debug-bad-boxes 't
                   default-fill-column 80
                   TeX-master nil
                   LaTeX-default-options "11pt,a4paper"
                   TeX-electric-escape nil)
             (define-key LaTeX-mode-map (kbd "C-x p") 'mark-paragraph)
             (define-key LaTeX-mode-map (kbd "M-s") 'ispell-word)
             (define-key LaTeX-mode-map (kbd "C-<f1>") '(lambda ()
                                                          (interactive)
                                                          (TeX-doc (current-word))))
             (turn-on-auto-fill)
             (paren-toggle-matching-quoted-paren 1)
             (paren-toggle-matching-paired-delimiter 1)))

;; settings for bibtex
(add-hook 'bibtex-mode-hook
	  (lambda ()
	    (ispell-change-dictionary "english")
            (local-set-key (kbd "C-c C-s") 'bibtex-sort-buffer)
            (local-set-key (kbd "C-c C-c") 'bibtex-count-entries)
            (local-set-key (kbd "C-c C-v") 'bibtex-validate)
            (local-set-key (kbd "M-s") 'ispell-word)))
;; auctex/reftex/bibtex settings -- end

;; cmake mode configurations -- start
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode "cmake-mode.el" t)
;; cmake mode configurations -- end


;; text-mode customizations -- start
(add-hook 'text-mode-hook '(lambda ()
                             (define-key text-mode-map (kbd "M-s") 'ispell-word)))
;; text-mode customizations -- end

;; sql-mode customizations -- start
(add-hook 'sql-mode-hook '(lambda ()
                            (sql-highlight-postgres-keywords)
                            (my-sql-mode-hook)))

(defun my-sql-mode-hook ()
  (define-key 'sql-mode-map (kbd "RET") 'newline-and-indent)
  ;; Make # start a new line comment in SQL. This is MySQL-specific
  ;; syntax.
  (modify-syntax-entry ?# "< b" 'sql-mode-syntax-table)
  (set-syntax-table 'sql-mode-syntax-table))
;; sql-mode customizations -- end

;; python-mode settings -- start
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist(cons '("python" . python-mode)
                             interpreter-mode-alist))
;; path to the python interpreter, e.g.: ~rw/python31/bin/python3
(setq py-python-command "python")
(autoload 'python-mode "python-mode" "Python editing mode." t)
;; pymacs settings
(add-hook 'python-mode-hook 'jedi:setup)

(add-hook 'python '(lambda ()
                     (add-to-list jedi:server-args
                                  '("--sys-path" "/usr/lib/python2.7/"
                                    "--sys-path" "/home/mads/pyvirtenv/lib/site-packages"))
                     (setq jedi:setup-keys t)
                     (setq jedi:complete-on-dot t)))

;; python-mode settings -- end

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)

(defun fuck-off-faa ()
  "Some files need trailing whitespace, toggle this as required"
  (interactive)
  (if (member (function delete-trailing-whitespace) 'before-save-hook)
      (remove-hook 'before-save-hook 'delete-trailing-whitespace)
  (remove-hook 'before-save-hook 'delete-trailing-whitespace)))

;; make scripts executable (chmod +x) on save:
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;, various macros for different purposes
(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))

(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))

(defun copy-and-insert-previous-line ()
  "Copies the line above and insert at the current position"
  (interactive)
  (save-excursion
    (forward-line -1)
    (kill-ring-save (point) (line-end-position))
    (forward-line) ;; just moves one line forward
    (yank)))

; automodes -- start
(setq auto-mode-alist (append '((".emacs$" . emacs-lisp-mode)
                                ("\\.((ht)?\\|x)ml$" . xml-mode)
                                ("\\.conf$" . conf-unix-mode)
                                ("\\.css$" . css-mode)
                                ("\\.el\\'" . emacs-lisp-mode)
                                ("\\.el\\.gz\\'" . emacs-lisp-mode)
                                ("\\.jar$" . archive-mode)
                                ("\\.sh$" . shell-script-mode)
                                ("\\.sql$" . sql-mode)
                                ("\\.txt$" . rst-mode)
                                ("\\.tar\\.(bz2\\|gz)$" . tar-mode)
                                ("\\.t(gz\\|bz2)$" . tar-mode)
                                ("\\.xml$" . xml-mode)
                                ("\\.lookml$" . yaml-mode)
                                ("\\.zip$" . archive-mode)) auto-mode-alist))
; automodes -- end

; shortcut key definitions -- start
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-c k") 'kill-whole-line)
(global-set-key (kbd "C-x t") 'compile)
(global-set-key (kbd "M-g")   'goto-line)
(global-set-key (kbd "C-M-g")   'goto-char-in-line)
(global-set-key (kbd "M-p")   'copy-and-insert-previous-line)
(global-set-key (kbd "C-x C-f") 'find-file-at-point)
(global-set-key (kbd "M-C-%") 'replace-string)
(global-set-key (kbd "C-h u") 'describe-unbound-keys)
(global-set-key (kbd "C-l") 'newline-and-indent)
(global-set-key (kbd "M-#") '(lambda ()
                               (interactive)
                               (insert
                                (format-time-string "%a, %d %b %Y %H:%M:%S %z"))
                               (goto-char (point-at-eol))))
(global-set-key (kbd "C-@") '(lambda () (interactive)
                               (insert (format-time-string "%Y-%m-%d"))
                               (end-of-line)))
(global-set-key (kbd "C-c d") 'dictionary)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c M-c") 'comment-region)
(global-set-key (kbd "C-c M-u")   'uncomment-region)
(global-set-key (kbd "C-c l")   'comment-line)
(global-set-key (kbd "C-c u") 'uncomment-line)
(global-set-key [(home)] 'beginning-of-line)
(global-set-key [(end)] 'end-of-line)
(global-set-key [(f4)] '(lambda () (interactive)
                          (desktop-save "~/")
                          (message "desktop successfully saved")))
(global-set-key (kbd "<f9>") '(lambda ()
                                (interactive)
                                (message "Loading local variables")
                                (hack-local-variables)))
; shortcut key definitions -- end
