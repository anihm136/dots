;;; init.el -*- lexical-binding: t; -*-

(setq fancy-splash-image "{{@@ home @@}}/.config/doom/splash.svg")

(doom! :completion
       company
       (vertico
        +icons)

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       ligatures
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ophints           ; highlight the region an operation acts on
       (popup
        +defaults
        +all)   ; tame sudden yet inevitable temporary windows
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows

       :editor
       (evil
        +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       format            ; automated prettiness
       snippets          ; my elves . They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired
        +icons)             ; making dired pretty [functional]
       (ibuffer
        +icons)                                        ; interactive buffer management
       undo
       vc                ; version-control and Emacs, sitting in a tree

       :term
{%@@ if profile != "localhost" @@%}
       vterm             ; another terminals in Emacs
{%@@ endif @@%}

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (spell
        +aspell)             ; tasing you for misspelling mispelling

       :tools
{%@@ if profile != "localhost" @@%}
       direnv
       pdf               ; pdf enhancements
{%@@ endif @@%}
       magit             ; a git porcelain for Emacs

       :lang
       emacs-lisp        ; drown in parentheses
       latex             ; writing papers in Emacs has never been so fun
       markdown          ; writing docs for people to ignore
       (org
        +pandoc
        +dragndrop
        +pretty
        +roam2)               ; organize your plain life in plain text
       beancount

       :config
       (default
        +bindings
        +smartparens))
