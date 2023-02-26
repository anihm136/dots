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

(setq doom-theme 'doom-monokai-pro)

;; Utility variables

{%@@ if profile == "localhost" @@%}
(defconst ani/org-directory "~/storage/shared/Documents/org/"
  "The default directory for org files.")
{%@@ else @@%}
(defconst ani/org-directory "~/Documents/org/"
  "The default directory for org files.")
{%@@ endif @@%}

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

;; Deferred loading
{%@@ if profile != "localhost" and profile != "work" @@%}
(defun ox-markup-filter-attach (text backend info)
  (if (and (equal backend 'latex) (string-match-p "\.attach" text))
      (progn
        (setq text (replace-regexp-in-string "\\\\" "" text))
        (string-match "\{file:\\/\\/\\(.+?\\)\}\{\\(.+\\)\}" text)
        (format "\\textattachfile{%s}{%s}" (match-string 1 text) (match-string 2 text))
        )
    text))
{%@@ endif @@%}

(use-package! org
  :defer t
  :config
  (setq
   org-fold-catch-invisible-edits 'show-and-error
   org-startup-folded 'content
{%@@ if profile != "localhost" and profile != "work" @@%}
   ;; Embed attached files when converting from org to pdf
   org-export-filter-link-functions '(ox-markup-filter-attach)
{%@@ endif @@%}
   ;; Display
   org-ellipsis " ▾ "
   org-list-demote-modify-bullet '(("+" . "*") ("-" . "+") ("*" . "-") ("1." . "a."))
   ;; Refile
   org-refile-use-outline-path 'file
   org-refile-allow-creating-parent-nodes 'confirm
   org-outline-path-complete-in-steps nil
   ;; TODO state changes
   org-log-done 'time
   org-log-into-drawer t
   ;; Repeating TODO settings
   org-log-repeat 'nil
   org-todo-repeat-to-state t
   ;; Clock
   org-clock-mode-line-total 'current
   ;; Org-attach settings
   org-attach-id-dir ".attach/"
   org-attach-dir-relative t
   ;; TODO states
   org-todo-keywords '((sequence "TODO(t)" "WAITING(w@)" "RECURRING(r)" "|" "DONE(d)" "CANCELLED(c)")
                       (sequence "PROJECT(p)" "|"))
   ;; Capture templates
   org-capture-templates
   `(("i" "Inbox" entry
      (file ,(concat ani/org-directory "GTD/" "inbox.org"))
      "* TODO %i%?")
     ("l" "Org protocol" entry
      (file ,(concat ani/org-directory "GTD/" "inbox.org"))
      "* TODO [[%:link][%:description]]\n %i" :immediate-finish t)
     ("k" "Clipboard link" entry
      (file ,(concat ani/org-directory "GTD/" "inbox.org"))
      "* TODO %(org-cliplink-capture)\n" :immediate-finish t)))

  (defun ani/org-handle-recurring-todos (org-todo-orig &optional arg)
    (let ((org-old-state (substring-no-properties (org-get-todo-state)))
          (org-repeat (org-get-repeat)))
      (funcall org-todo-orig arg)
      (when (and (equal org-old-state "RECURRING")
                 (not org-repeat)
                 (org-entry-is-done-p))
        (let ((current-prefix-arg '(4)))
          (call-interactively 'org-schedule)
          (funcall org-todo-orig "RECURRING")))))
  (advice-add 'org-todo :around #'ani/org-handle-recurring-todos)

  (defun ani/org-handle-waiting-todos ()
    (when (and (equal org-state "WAITING"))
      (let ((current-prefix-arg '(4)))
        (call-interactively 'org-schedule))))
  (add-hook! 'org-after-todo-state-change-hook #'ani/org-handle-waiting-todos)

  (defun ani/org-process-inbox-item ()
    "Process a single item in the inbox."
    (interactive)
    (org-with-wide-buffer
     (call-interactively #'org-todo)
     (org-set-tags-command)
     (org-priority)
     (org-refile)))

  (defun ani/org-process-inbox ()
    "Process all items in the inbox."
    (interactive)
    (find-file (concat ani/org-directory "GTD/" "inbox.org"))
    (org-map-entries #'ani/org-process-inbox-item nil `(,(concat ani/org-directory "GTD/" "inbox.org"))))

  (org-clock-persistence-insinuate)
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'proselint 'org-mode))
  (add-hook! 'org-capture-after-finalize-hook (org-element-cache-reset t))
  (defadvice! ani/org--restart-mode-h-careful-restart (fn &rest args)
    :around #'+org--restart-mode-h
    (let ((old-org-capture-current-plist (and (bound-and-true-p org-capture-mode)
                                              (bound-and-true-p org-capture-current-plist))))
      (apply fn args)
      (when old-org-capture-current-plist
        (setq-local org-capture-current-plist old-org-capture-current-plist)
        (org-capture-mode +1)))))

(add-hook! org-mode #'org-fragtog-mode #'org-appear-mode #'+org-pretty-mode)

(map! :map org-mode-map
      :i "C-c b" (lambda () (interactive) (org-emphasize ?*))
      :i "C-c i" (lambda () (interactive) (org-emphasize ?/))
      :i "C-c m" (lambda () (interactive) (progn (insert "\\(\\)") (backward-char 2))))

(use-package! org-agenda
  :defer t
  :init
  (setq
   org-agenda-files `(,(concat ani/org-directory "GTD/"))
   org-refile-targets `((,(concat ani/org-directory "GTD/" "projects.org") :maxlevel . 3)
                        (,(concat ani/org-directory "GTD/" "tasks.org") :level . 0)
                        (,(concat ani/org-directory "GTD/" "reading.org") :level . 0)
                        (,(concat ani/org-directory "GTD/" "learning.org") :level . 0)
                        (,(concat ani/org-directory "GTD/" "someday.org") :level . 0))
   org-agenda-skip-deadline-if-done t
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-prewarning-if-scheduled t
   org-agenda-custom-commands (let
                                  ((gtd/inbox-head  "Refile:")
                                   (gtd/next-action-head "Next actions:")
                                   (gtd/waiting-head  "Waiting on:")
                                   (gtd/recurring-head  "Recurring tasks:")
                                   (gtd/someday-head  "Review someday tasks:")
                                   (gtd/stuck-projects-head  "Review stuck projects:"))
                                `(("g" . "GTD")
                                  ("gg" "GTD overview"
                                   ((alltodo ""
                                             ((org-agenda-overriding-header ,gtd/inbox-head) (org-agenda-files '(,(concat ani/org-directory "GTD/" "inbox.org")))))
                                    (todo "TODO"
                                          ((org-agenda-overriding-header ,gtd/next-action-head)
                                           (org-agenda-files '(,(concat ani/org-directory "GTD/" "tasks.org") ,(concat ani/org-directory "GTD/" "projects.org")))
                                           (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))
                                    (todo "WAITING"
                                          ((org-agenda-overriding-header ,gtd/waiting-head)))
                                    (todo "RECURRING"
                                          ((org-agenda-overriding-header ,gtd/recurring-head)
                                           (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))))
                                  ("gt" "Today"
                                   ((agenda ""
                                            ((org-agenda-span 1)
                                             (org-agenda-start-on-weekday nil)
                                             (org-agenda-start-day "+0d")))))
                                  ("gs" "Things to do someday"
                                   ((org-ql-search-block '(todo)
                                                         ((org-ql-block-header ,gtd/someday-head) (org-agenda-files '(,(concat ani/org-directory "GTD/" "someday.org")))))))
                                  ("l" "Things to learn"
                                   ((todo "TODO"
                                          ((org-agenda-files '(,(concat ani/org-directory "GTD/" "learning.org")))))))
                                  ("gp" "Stuck projects"
                                   ((org-ql-search-block '(and (todo "PROJECT")
                                                               (not (children (todo "TODO" "PROJECT" "RECURRING"))))
                                                         ((org-ql-block-header ,gtd/stuck-projects-head))))))))
  :config
  (map! :map org-agenda-mode-map
        :localleader :prefix "d" :desc "Schedule item for today" :n "t" (lambda () (interactive) (org-agenda-schedule nil "+0d"))))


(add-hook! 'auto-save-hook 'org-save-all-org-buffers)

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

(defadvice ani/org-archive-subtree (around fix-hierarchy activate)
  (let* ((fix-archive-p (and (not current-prefix-arg)
                             (not (use-region-p))))
         (afile (car (org-archive--compute-location org-archive-location)))
         (buffer (or (find-buffer-visiting afile) (find-file-noselect afile))))
    ad-do-it
    (when fix-archive-p
      (with-current-buffer buffer
        (goto-char (point-max))
        (while (org-up-heading-safe))
        (let* ((olpath (org-entry-get (point) "ARCHIVE_OLPATH"))
               (path (and olpath (split-string olpath "/")))
               (level 1)
               tree-text)
          (when olpath
            (org-mark-subtree)
            (setq tree-text (buffer-substring (region-beginning) (region-end)))
            (let (this-command) (org-cut-subtree))
            (goto-char (point-min))
            (save-restriction
              (widen)
              (-each path
                (lambda (heading)
                  (if (re-search-forward
                       (rx-to-string
                        `(: bol (repeat ,level "*") (1+ " ") ,heading)) nil t)
                      (org-narrow-to-subtree)
                    (goto-char (point-max))
                    (unless (looking-at "^")
                      (insert "\n"))
                    (insert (make-string level ?*)
                            " "
                            heading
                            "\n"))
                  (cl-incf level)))
              (widen)
              (org-end-of-subtree t t)
              (org-paste-subtree level tree-text))))))))

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
  :commands (org-diagrams-insert-at-point-and-edit org-diagrams-edit-at-point org-diagrams-init)
  :config (progn
            (setq
             org-diagrams-editor "drawio"
             org-diagrams-on-update "drawio -x -f png -o ${OUT} ${IN}")
            (org-diagrams-init)))

(use-package! company
  :defer t
  :config
  (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                            company-preview-if-just-one-frontend
                            company-echo-metadata-frontend)))

{%@@ if profile != "localhost" and profile != "work" @@%}
(use-package! org-protocol
  :defer t
  :config
  (setq org-protocol-default-template-key "l"))

(use-package! magit
  :defer t
  :config
  (setq magit-repository-directories '(("~/code/vcs/" . 2) ("~/code/os_contrib/" . 2))
        global-git-commit-mode t))

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

(use-package! engrave-faces-latex
  :after ox-latex)

(load! "+org-latex")

(load! "+engrave-faces")
{%@@ endif @@%}

(add-hook! 'prog-mode-hook (lambda ()(modify-syntax-entry ?_ "w")))

(add-hook! 'after-init-hook 'ani/my-init-func)

;; Utility functions and keymaps

(defun ani/evil-unimpaired-paste-above ()
  "Linewise paste above."
  (interactive)
  (let ((register (if evil-this-register
                      evil-this-register
                    ?\")))
    (when (not (member 'evil-yank-line-handler (get-text-property 0 'yank-handler (evil-get-register register))))
      (evil-insert-newline-above))
    (evil-paste-before 1 register)))

(defun ani/evil-unimpaired-paste-below ()
  "Linewise paste below."
  (interactive)
  (let ((register (if evil-this-register
                      evil-this-register
                    ?\")))
    (when (not (member 'evil-yank-line-handler (get-text-property 0 'yank-handler (evil-get-register register))))
      (evil-insert-newline-below))
    (evil-paste-after 1 register)))

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE|CANCELLED"
   'agenda))

(defun ani/my-init-func ()
  "Function to run on init."
  (global-subword-mode t)
  (global-auto-revert-mode t)
  (setq-default uniquify-buffer-name-style 'forward
                window-combination-resize t
                org-clock-persist t
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
{%@@ if profile == "work" @@%}
	magic-mode-alist (assq-delete-all 'ess-SAS-log-mode-p magic-mode-alist)
        magic-mode-alist (assq-delete-all 'ess-SAS-listing-mode-p magic-mode-alist)
{%@@ endif @@%}
        alert-default-style 'libnotify)
  (map! :nv "C-a" 'evil-numbers/inc-at-pt
        :nv "C-S-x" 'evil-numbers/dec-at-pt
        :v "g C-a" 'evil-numbers/inc-at-pt-incremental
        :v "g C-S-x" 'evil-numbers/dec-at-pt-incremental
        :nv "M-j" 'drag-stuff-down
        :nv "M-k" 'drag-stuff-up
        :v "o" "$"
        :n "]p" 'ani/evil-unimpaired-paste-below
        :n "[p" 'ani/evil-unimpaired-paste-above
        :desc "Paste in insert mode"
        :i "C-v" "C-r +"))
