;;; +engrave-faces.el --- Description -*- lexical-binding: t; -*-

(defadvice! org-latex-src-block-engraved (orig-fn src-block contents info)
  "Like `org-latex-src-block', but supporting an engraved backend"
  :around #'org-latex-src-block
  (if (eq 'engraved (plist-get info :latex-listings))
      (org-latex-scr-block--engraved src-block contents info)
    (funcall orig-fn src-block contents info)))

(defadvice! org-latex-inline-src-block-engraved (orig-fn inline-src-block contents info)
  "Like `org-latex-inline-src-block', but supporting an engraved backend"
  :around #'org-latex-inline-src-block
  (if (eq 'engraved (plist-get info :latex-listings))
      (org-latex-inline-scr-block--engraved inline-src-block contents info)
    (funcall orig-fn src-block contents info)))

(defadvice! org-latex-example-block-engraved (orig-fn example-block contents info)
  "Like `org-latex-example-block', but supporting an engraved backend"
  :around #'org-latex-example-block
  (let ((output-block (funcall orig-fn example-block contents info)))
    (if (eq 'engraved (plist-get info :latex-listings))
        (format "\\begin{Code}[alt]\n%s\n\\end{Code}" output-block)
      output-block)))

(setq org-latex-engraved-code-preamble "
\\usepackage{fvextra}
\\fvset{
  commandchars=\\\\\\{\\},
  highlightcolor=white!95!black!80!blue,
  breaklines=true,
  breaksymbol=\\color{white!60!black}\\tiny\\ensuremath{\\hookrightarrow}}
\\renewcommand\\theFancyVerbLine{\\footnotesize\\color{black!40!white}\\arabic{FancyVerbLine}}

\\usepackage[many]{tcolorbox}
\\DeclareTColorBox[]{Code}{}%
{enhanced,
  colback=white!97!black,
  colframe=white!94!black, boxrule=0.5pt,
  fontupper=\\color{EFD}\\footnotesize,
  arc=2.5pt, outer arc=2.5pt,
  boxsep=2pt, left=2pt, right=2pt, top=1pt, bottom=0.5pt,
  breakable}")

(add-to-list 'org-latex-conditional-preambles '("#\\+BEGIN_SRC\\|#\\+begin_src" . org-latex-engraved-code-preamble) t)
(add-to-list 'org-latex-conditional-preambles '("#\\+BEGIN_SRC\\|#\\+begin_src" . engrave-faces-latex-gen-preamble) t)

(defun org-latex-scr-block--engraved (src-block contents info)
  (let* ((lang (org-element-property :language src-block))
         (attributes (org-export-read-attribute :attr_latex src-block))
         (float (plist-get attributes :float))
         (num-start (org-export-get-loc src-block info))
         (retain-labels (org-element-property :retain-labels src-block))
         (caption (org-element-property :caption src-block))
         (caption-above-p (org-latex--caption-above-p src-block info))
         (caption-str (org-latex--caption/label-string src-block info))
         (placement (or (org-unbracket-string "[" "]" (plist-get attributes :placement))
                        (plist-get info :latex-default-figure-position)))
         (float-env
          (cond
           ((string= "multicolumn" float)
            (format "\\begin{listing*}[%s]\n%s%%s\n%s\\end{listing*}"
                    placement
                    (if caption-above-p caption-str "")
                    (if caption-above-p "" caption-str)))
           (caption
            (format "\\begin{listing}[%s]\n%s%%s\n%s\\end{listing}"
                    placement
                    (if caption-above-p caption-str "")
                    (if caption-above-p "" caption-str)))
           ((string= "t" float)
            (concat (format "\\begin{listing}[%s]\n"
                            placement)
                    "%s\n\\end{listing}"))
           (t "%s")))
         (options (plist-get info :latex-minted-options))
         (content-buffer
          (with-temp-buffer
            (insert
             (let* ((code-info (org-export-unravel-code src-block))
                    (max-width
                     (apply 'max
                            (mapcar 'length
                                    (org-split-string (car code-info)
                                                      "\n")))))
               (org-export-format-code
                (car code-info)
                (lambda (loc _num ref)
                  (concat
                   loc
                   (when ref
                     ;; Ensure references are flushed to the right,
                     ;; separated with 6 spaces from the widest line
                     ;; of code.
                     (concat (make-string (+ (- max-width (length loc)) 6)
                                          ?\s)
                             (format "(%s)" ref)))))
                nil (and retain-labels (cdr code-info)))))
            (funcall (org-src-get-lang-mode lang))
            (engrave-faces-latex-buffer)))
         (content
          (with-current-buffer content-buffer
            (buffer-string)))
         (body
          (format
           "\\begin{Code}\n\\begin{Verbatim}[%s]\n%s\\end{Verbatim}\n\\end{Code}"
           ;; Options.
           (concat
            (org-latex--make-option-string
             (if (or (not num-start) (assoc "linenos" options))
                 options
               (append
                `(("linenos")
                  ("firstnumber" ,(number-to-string (1+ num-start))))
                options)))
            (let ((local-options (plist-get attributes :options)))
              (and local-options (concat "," local-options))))
           content)))
    (kill-buffer content-buffer)
    ;; Return value.
    (format float-env body)))

(defun org-latex-inline-scr-block--engraved (inline-src-block _contents info)
  (let ((options (org-latex--make-option-string
                  (plist-get info :latex-minted-options)))
        code-buffer code)
    (setq code-buffer
          (with-temp-buffer
            (insert (org-element-property :value inline-src-block))
            (funcall (org-src-get-lang-mode
                      (org-element-property :language inline-src-block)))
            (engrave-faces-latex-buffer)))
    (setq code (with-current-buffer code-buffer
                 (buffer-string)))
    (kill-buffer code-buffer)
    (format "\\Verb%s{%s}"
            (if (string= options "") ""
              (format "[%s]" options))
            code)))
;;; +engrave-faces.el ends here
