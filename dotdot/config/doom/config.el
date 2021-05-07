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

(setq org-directory "~/Documents/org/GTD/")

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
              org-download-image-dir "./images"
              org-download-heading-lvl 'nil
              ispell-dictionary "en-custom"
              ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir)
              )

(custom-set-faces! '(font-lock-comment-face :slant italic))

(use-package! org-super-agenda
  :defer t
  :config
  (setq org-super-agenda-groups `((:discard
                                   (
                                    :file-path "ideas.org"
                                    ))
                                  (:name "Today"
                                   :scheduled today)
                                  (:name "Upcoming"
                                   :deadline future
                                   :scheduled (before ,(ts-format "%F %T" (ts-inc 'day 7 (ts-now)))))
                                  (:discard (:scheduled t))
                                  (:name "Refile"
                                   :category "refile")
                                  (:name "Waiting"
                                   :todo "WAIT"
                                   :todo "HOLD"
                                   :todo "[?]"
                                   :order 9)
                                  (:name "Started/Next"
                                   :todo "STRT"
                                   :todo "[-]")
                                  (:name "Overdue"
                                   :deadline past)
                                  (:name "Caldav Todos"
                                   :file-path "caldav-inbox.org")
                                  (:name "Projects"
                                   :file-path "projects.org")
                                  (:name "Tasks"
                                   :todo "[ ]")
                                  )))

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
  (setq org-default-notes-file (concat org-directory "inbox.org")
        org-export-filter-link-functions '(ox-markup-filter-attach)
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
        org-export-preserve-breaks t
        org-attach-id-dir ".attach/"
        org-attach-dir-relative t
        org-capture-templates
        '(("t" "Todo" entry (file org-default-notes-file)
           "* TODO %?\n")
          ("a" "Task" entry (file org-default-notes-file)
           "* [ ] %?\n")
          ("l" "org-protocol-capture" entry (file "~/Documents/org/reading.org")
           "* [[%:link][%:description]]\n %i"
           :immediate-finish t)
          ("k" "Cliplink capture task" entry (file "~/Documents/org/reading.org")
           "* %(org-cliplink-capture)\n" :immediate-finish t))
        )
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'proselint 'org-mode))
  (+org-pretty-mode)
  )
(add-hook! 'org-mode-hook 'org-diagrams-init)
(add-hook! 'org-mode-hook 'org-fragtog-mode)
(add-hook! 'org-mode-hook 'org-appear-mode)
(map! :map org-mode-map
      :i "C-c b" (lambda () (interactive) (org-emphasize ?*))
      :i "C-c i" (lambda () (interactive) (org-emphasize ?/))
      :i "C-c m" (lambda () (interactive) (progn (insert "\\(\\)") (backward-char 2))))

(use-package! org-agenda
  :defer t
  :config
  (org-super-agenda-mode)
  (setq org-agenda-files (append (directory-files-recursively org-directory "\.org$") '("~/Documents/org/calendars/caldav-inbox.org"))
        org-agenda-block-separator nil
        org-agenda-tags-column 100
        org-agenda-compact-blocks t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t)
  (setq org-refile-targets '((nil :maxlevel . 3)
                             (org-agenda-files :maxlevel . 3))))

(use-package! org-projectile
  :after org
  :config
  (progn
    (defun org-projectile-build-heading (heading)
      (when org-projectile-force-linked
        (setq heading (concat "PROJ " (org-projectile-linked-heading heading))))
      (if org-projectile-counts-in-heading (concat heading " [/]")
        heading))
    (setq
     org-projectile-capture-template "* TODO %?"
     org-projectile-projects-file (concat org-directory "projects.org"))
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-character "p"))
    (setq org-link-elisp-confirm-function nil)))

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
        '(("d" "default" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "${slug}"
           :head "#+TITLE: ${title}\n"
           :unnarrowed t))
        org-roam-buffer-width 0.25))

(use-package! projectile
  :defer t
  :init
  (setq projectile-project-search-path '("~/vcs"))
  )

(use-package! magit
  :defer t
  :config
  (setq magit-repository-directories '(("~/vcs/" . 2))
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

(use-package! counsel-gtags
  :init
  (map! :leader :prefix "c" (:prefix ("g" . "gtags")
                             :desc "Goto definition" "d" 'counsel-gtags-find-definition
                             :desc "Find symbol" "s" 'counsel-gtags-dwim
                             :desc "Goto reference" "r" 'counsel-gtags-find-reference))
  :commands (counsel-gtags-dwim counsel-gtags-find-definition counsel-gtags-find-reference))

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

(use-package! org-diagrams
  :after org)

(after! org-archive
  (defun ani/org-archive-done-tasks ()
    (interactive)
    (org-map-entries 'org-archive-subtree "/DONE" 'file)
    (org-map-entries 'org-archive-subtree "/\[X\]" 'file)
    (org-map-entries 'org-archive-subtree "/KILL" 'file))
  (defadvice org-archive-subtree (around my-org-archive-subtree activate)
    (let ((org-archive-location
           (if (save-excursion (org-back-to-heading)
                               (> (org-outline-level) 1))
               (concat (car (split-string org-archive-location "::"))
                       "::* "
                       (car (org-get-outline-path)))
             org-archive-location)))
      ad-do-it))
  )

(use-package org-caldav
  :init
  ;; This is the delayed sync function; it waits until emacs has been idle for
  ;; "secs" seconds before syncing.  The delay is important because the caldav-sync
  ;; can take five or ten seconds, which would be painful if it did that right at save.
  ;; This way it just waits until you've been idle for a while to avoid disturbing
  ;; the user.
  (defvar org-caldav-sync-timer nil
    "Timer that `org-caldav-push-timer' used to reschedule itself, or nil.")
  (defun org-caldav-sync-with-delay (secs)
    (when org-caldav-sync-timer
      (cancel-timer org-caldav-sync-timer))
    (setq org-caldav-sync-timer
          (run-with-idle-timer
           (* 1 secs) nil 'org-caldav-sync)))

  ;; Actual calendar configuration edit this to meet your specific needs
  (setq org-caldav-url "https://caldav.grayideas.org/anirudh")
  (setq org-caldav-calendar-id "b9934bea-291b-6ee9-ac4f-a64f9d829b6e")
  (setq org-caldav-files '("~/Documents/org/GTD/projects.org" "~/Documents/org/GTD/tasks.org"))
  (setq org-caldav-inbox "~/Documents/org/calendars/caldav-inbox.org")
  (setq org-caldav-backup-file nil)
  (setq org-caldav-save-directory "~/.config/emacs/.local/etc/caldav")
  ;; (setq org-caldav-skip-conditions '('nottodo '("TODO" "STRT")))

  :config
  (setq org-icalendar-timezone "Asia/Kolkata")
  (setq org-icalendar-alarm-time 30)
  ;; This makes sure to-do items as a category can show up on the calendar
  ;; (setq org-icalendar-include-todo t)
  ;; This ensures all org "deadlines" show up, and show up as due dates
  (setq org-icalendar-use-deadline '(event-if-todo-not-done todo-due))
  ;; This ensures "scheduled" org items show up, and show up as start times
  (setq org-icalendar-use-scheduled '(todo-start event-if-todo-not-done))
  ;; Add the delayed save hook with a five minute idle timer
  (add-hook 'after-save-hook
            (lambda ()
              (when (eq major-mode 'org-mode)
                (org-caldav-sync-with-delay 300))))
  )

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
  (interactive)
  (let ((register (if evil-this-register
                      evil-this-register
                    ?\")))
    (when (not (member 'evil-yank-line-handler (get-text-property 0 'yank-handler (evil-get-register register))))
      (evil-insert-newline-above))
    (evil-paste-before 1 register)
    ))

(defun +ani/evil-unimpaired-paste-below ()
  (interactive)
  (let ((register (if evil-this-register
                      evil-this-register
                    ?\")))
    (when (not (member 'evil-yank-line-handler (get-text-property 0 'yank-handler (evil-get-register register))))
      (evil-insert-newline-below))
    (evil-paste-after 1 register)
    ))

(defun +ani/my-init-func ()
  "Function to run on init"
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
        :i "C-v" "C-o P"
        :desc "Set random theme"
        :n "<f12>" '+ani/set-random-theme
        :n "S-<f12>" (λ! () (ani/set-random-theme 't))
        ))


(defun +ani/set-random-theme (&optional light)
  "Set the theme to a random dark theme.
If LIGHT is non-nil, use a random light theme instead."
  (interactive)
  (random t)
  (let ((themes (if light light-themes dark-themes)))
    (load-theme (nth (random (length themes)) themes) t))
  (princ (cdr custom-enabled-themes)))
