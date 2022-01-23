;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Anirudh H M"
      user-mail-address "anihm136@gmail.com")

{%@@ if profile == "sorcery" @@%}
(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "Overpass" :weight 'normal :size 16))
{%@@ elif profile == "apex" @@%}
(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 36)
      doom-variable-pitch-font (font-spec :family "Overpass" :weight 'normal :size 36))
{%@@ endif @@%}

(setq display-line-numbers-type 'relative)

(setq org-directory nil)

;; Utility variables

(defconst ani/org-directory "~/Documents/org/"
  "The default directory for org files.")

(defvar dark-themes '(doom-one doom-gruvbox doom-solarized-dark doom-spacegrey doom-monokai-pro doom-tomorrow-night)
  "Set of dark themes to choose from.")

(defvar light-themes '(doom-gruvbox-light doom-solarized-light doom-flatwhite)
  "Set of light themes to choose from.")

;; Eager loading
(setq-default tab-width 2
              standard-indent 2
              load-prefer-newer t
              org-download-image-dir "./images"
              org-download-heading-lvl 'nil
              ispell-dictionary "en-custom"
              ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir))

(custom-set-faces! '(font-lock-comment-face :slant italic))

(use-package! evil-escape
  :config
  (setq evil-escape-key-sequence "fd"
        evil-escape-delay 0.3))

(use-package! aggressive-indent
  :config
  (aggressive-indent-global-mode))

(use-package! doom-modeline
  :config
  (setq doom-modeline-indent-info t
        doom-modeline-unicode-fallback t
        doom-modeline-buffer-file-name-style 'truncate-upto-root))

(load! "lisp/llvm-mode")

;; Deferred loading
(defun ox-markup-filter-attach (text backend info)
  (if (and (equal backend 'latex) (string-match-p "\.attach" text))
      (progn
        (setq text (replace-regexp-in-string "\\\\" "" text))
        (string-match "\{file:\\/\\/\\(.+?\\)\}\{\\(.+\\)\}" text)
        (format "\\textattachfile{%s}{%s}" (match-string 1 text) (match-string 2 text))
        )
    text))

(use-package! org
  :defer t
  :config
  (setq org-export-filter-link-functions '(ox-markup-filter-attach)
        org-ellipsis " ▾ "
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm
        org-catch-invisible-edits 'smart
        org-list-demote-modify-bullet '(("+" . "*") ("-" . "+") ("*" . "-") ("1." . "a."))
        org-startup-folded 'content
        org-log-done 'time
        org-log-into-drawer t
        org-log-state-notes-insert-after-drawers nil
        org-attach-id-dir ".attach/"
        org-attach-dir-relative t
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "RECURRING(a)" "|" "DONE(d)" "CANCELLED(c)")
                            (sequence "REFILE(f)" "READ(r)" "PROJECT(p)" "|"))
        org-capture-templates
        `(("i" "Inbox" entry
           (file ,(concat ani/org-directory "GTD/" "inbox.org"))
           "* REFILE %i%?")
          ("l" "Org protocol" entry
           (file ,(concat ani/org-directory "GTD/" "inbox.org"))
           "* READ [[%:link][%:description]]\n %i"
           :immediate-finish t)
          ("k" "Clipboard link" entry
           (file ,(concat ani/org-directory "GTD/" "inbox.org"))
           "* READ %(org-cliplink-capture)\n" :immediate-finish t)))
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'proselint 'org-mode)))

(add-hook! 'org-mode-hook 'org-fragtog-mode)
(add-hook! 'org-mode-hook 'org-appear-mode)
(add-hook! 'org-mode-hook '+org-pretty-mode)

(use-package! org-diagrams
  :commands (org-diagrams-insert-at-point-and-edit org-diagrams-edit-at-point org-diagrams-init)
  :config (progn
            (setq
             org-diagrams-editor "drawio"
             org-diagrams-on-update "drawio -x -f png -o ${OUT} ${IN}")
            (org-diagrams-init)))

(map! :map org-mode-map
      :i "C-c b" (lambda () (interactive) (org-emphasize ?*))
      :i "C-c i" (lambda () (interactive) (org-emphasize ?/))
      :i "C-c m" (lambda () (interactive) (progn (insert "\\(\\)") (backward-char 2))))

(use-package! org-agenda
  :defer t
  :init
  (defalias '+org--restart-mode-h #'ignore)
  (setq
   org-agenda-files '("~/Documents/org/GTD")
   org-refile-targets `((,(concat ani/org-directory "GTD/" "projects.org") :maxlevel . 3)
                        (,(concat ani/org-directory "GTD/" "tasks.org") :maxlevel . 2)
                        (,(concat ani/org-directory "GTD/" "reading.org") :level . 1)
                        (,(concat ani/org-directory "GTD/" "someday.org") :level . 1))
   gtd/next-action-head "Next actions:"
   gtd/project-todos-head "Projects:"
   gtd/task-todos-head "Tasks:"
   gtd/waiting-head  "Waiting on:"
   gtd/inbox-head  "Dump:"
   gtd/recurring-head  "Recurring tasks:"
   org-agenda-custom-commands
   `(("g" "GTD view"
      ((agenda "" ((org-agenda-span 1) (org-agenda-start-on-weekday nil)))
       (todo "" ((org-agenda-files '(,(concat ani/org-directory "GTD/" "inbox.org"))) (org-agenda-overriding-header gtd/inbox-head)))
       (org-ql-search-block '(todo "NEXT")
                            ((org-ql-block-header gtd/next-action-head)))
       (org-ql-search-block '(or (todo "REFILE")
                                 (and (todo "PROJECT")
                                      (not (children (todo "PROJECT")))))
                            ((org-ql-block-header gtd/project-todos-head) (org-agenda-files '(,(concat ani/org-directory "GTD/" "projects.org")))))
       (org-ql-search-block '(todo "REFILE" "TODO")
                            ((org-ql-block-header gtd/task-todos-head) (org-agenda-files '(,(concat ani/org-directory "GTD/" "tasks.org")))))
       (org-ql-search-block '(todo "RECURRING")
                            ((org-ql-block-header gtd/recurring-head)))
       (org-ql-search-block '(todo "WAITING")
                            ((org-ql-block-header gtd/waiting-head)))))
     ("r" "Reading list"
      ((org-ql-search-block '(todo "READ")
                            ((org-agenda-files '(,(concat ani/org-directory "GTD/" "reading.org")))))))
     ("p" "Stuck projects"
      ((org-ql-search-block '(and (todo "PROJECT")
                                  (not (children (todo "PROJECT" "NEXT"))))))))))

(add-hook! 'auto-save-hook 'org-save-all-org-buffers)

(use-package! org-protocol
  :defer t
  :config
  (setq org-protocol-default-template-key "l"))

(use-package! org-roam
  :defer t
  :custom-face
  (org-roam-link ((t (:inherit org-link :foreground "#009600"))))
  :config
  (setq org-roam-directory (concat ani/org-directory "notes/")
        org-roam-db-location (concat org-roam-directory "org-roam.db")
        org-roam-completion-fuzzy-match t
        org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head "${slug}.org" "#+title: ${title}\n")
           :unnarrowed t))
        org-roam-buffer-width 0.25))

(use-package! magit
  :defer t
  :config
  (setq magit-repository-directories '(("~/vcs/" . 2) ("~/os_contrib/" . 2))
        global-git-commit-mode t))

(use-package! company
  :defer t
  :config
  (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                            company-preview-if-just-one-frontend
                            company-echo-metadata-frontend)))

(use-package! aas
  :hook (LaTeX-mode . ass-activate-for-major-mode)
  :hook (org-mode . ass-activate-for-major-mode))

(use-package! laas
  :hook (LaTeX-mode . laas-mode)
  :config ; do whatever here
  (aas-set-snippets 'laas-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
                    "supp" "\\supp"
                    "On" "O(n)"
                    "O1" "O(1)"
                    "Olog" "O(\\log n)"
                    "Olon" "O(n \\log n)"))

(use-package! org-download
  :config
  (setq
   org-download-method 'directory
   org-download-timestamp "%Y%m%d-%H%M%S_"
   org-download-link-format "[[file:%s]]\n"
   org-download-link-format-function
   (lambda (filename)
     (format (concat (unless (image-type-from-file-name filename)
                       (concat (+org-attach-icon-for filename)
                               " "))
                     org-download-link-format)
             (org-link-escape (file-relative-name filename))))
   org-image-actual-width 400))

(use-package! engrave-faces-latex
  :after ox-latex)

(load! "+org-latex")

(load! "+engrave-faces")

(add-hook! 'prog-mode-hook (lambda ()(modify-syntax-entry ?_ "w")))

(add-hook! 'after-init-hook '+ani/my-init-func)

;; Utility functions and keymaps

(defun forward-to-argsep ()
  (interactive)
  (while (progn (comment-forward most-positive-fixnum)
                (looking-at "[^,)]"))
    (condition-case ex (forward-sexp)
      ('scan-error (if (looking-at "[<>]")
                       (forward-char)
                     (throw ex nil)))))
  (point))

(defun backward-to-argsep ()
  (interactive)
  (let ((pt (point)) cur)
    (up-list -1)
    (while (looking-at "<")
      (up-list -1))
    (forward-char)
    (while (progn (setq cur (point))
                  (> pt (forward-to-argsep)))
      (forward-char))
    (goto-char cur)))

(defun transpose-args-direction (is_forward)
  (interactive)
  (let* ((pt-original (point))
         (pt (progn (when (not is_forward)
                      (goto-char (- (backward-to-argsep) 1))
                      (unless (looking-at ",")
                        (goto-char pt-original)
                        (user-error "Argument separator not found")))
                    (point)))
         (b (backward-to-argsep))
         (sep (progn (goto-char pt)
                     (forward-to-argsep)))
         (e (progn (unless (looking-at ",")
                     (goto-char pt-original)
                     (user-error "Argument separator not found"))
                   (forward-char)
                   (forward-to-argsep)))
         (ws-first (buffer-substring-no-properties
                    (goto-char b)
                    (progn (skip-chars-forward "[[:space:]\n]")
                           (point))))
         (first (buffer-substring-no-properties (point) sep))
         (ws-second (buffer-substring-no-properties
                     (goto-char (1+ sep))
                     (progn (skip-chars-forward "[[:space:]\n]")
                            (point))))
         (second (buffer-substring-no-properties (point) e)))
    (delete-region b e)
    (insert ws-first second "," ws-second first)

    (if is_forward
        (goto-char (+ (- (point) (length first))
                      (- pt b (length ws-first))))
      (goto-char (+ b (length ws-first)
                    (- pt-original (+ pt 1 (length ws-second))))))))

(defun +ani/evil-unimpaired-paste-above ()
  "Linewise paste above."
  (interactive)
  (let ((register (if evil-this-register
                      evil-this-register
                    ?\")))
    (when (not (member 'evil-yank-line-handler (get-text-property 0 'yank-handler (evil-get-register register))))
      (evil-insert-newline-above))
    (evil-paste-before 1 register)))

(defun +ani/evil-unimpaired-paste-below ()
  "Linewise paste below."
  (interactive)
  (let ((register (if evil-this-register
                      evil-this-register
                    ?\")))
    (when (not (member 'evil-yank-line-handler (get-text-property 0 'yank-handler (evil-get-register register))))
      (evil-insert-newline-below))
    (evil-paste-after 1 register)))

(defun +ani/my-init-func ()
  "Function to run on init."
  (global-subword-mode t)
  (+ani/set-random-theme)
  (setq-default uniquify-buffer-name-style 'forward
                window-combination-resize t
                x-stretch-cursor t)
  (setq lsp-signature-doc-lines 1
        company-idle-delay nil
        inhibit-compacting-font-caches t
        evil-want-fine-undo t
        evil-vsplit-window-right t
        evil-split-window-below t
        +evil-want-o/O-to-continue-comments nil
        evil-respect-visual-line-mode nil
        doom-fallback-buffer-name "► Doom"
        +doom-dashboard-name "► Doom"
        alert-default-style 'libnotify)
  (map! :nv "C-a" 'evil-numbers/inc-at-pt
        :nv "C-S-x" 'evil-numbers/dec-at-pt
        :v "g C-a" 'evil-numbers/inc-at-pt-incremental
        :v "g C-S-x" 'evil-numbers/dec-at-pt-incremental
        :nv "M-j" 'drag-stuff-down
        :nv "M-k" 'drag-stuff-up
        :v "o" "$"
        :desc "Transpose function argument to the right"
        :n "g>" '(lambda () (interactive) (transpose-args-direction t))
        :desc "Transpose function argument to the left"
        :n "g<" '(lambda () (interactive) (transpose-args-direction nil))
        :n "]p" '+ani/evil-unimpaired-paste-below
        :n "[p" '+ani/evil-unimpaired-paste-above
        :desc "Paste in insert mode"
        :i "C-v" "C-r +"
        :desc "Set random theme"
        :n "<f12>" '+ani/set-random-theme
        :n "S-<f12>" (λ! () (+ani/set-random-theme 't))))


(defun +ani/set-random-theme (&optional light)
  "Set the theme to a random dark theme.
If LIGHT is non-nil, use a random light theme instead."
  (interactive)
  (random t)
  (let ((themes (if light light-themes dark-themes)))
    (load-theme (nth (random (length themes)) themes) t))
  (princ (cdr custom-enabled-themes)))
