;;; +org-latex.el --- Description -*- lexical-binding: t; -*-

(defvar org-latex-universal-preamble "
\\usepackage[main,include]{embedall}
\\IfFileExists{./\\jobname.org}{\\embedfile[desc=The original file]{\\jobname.org}}{}
\\usepackage[]{attachfile}
\\attachfilesetup{color=0.1 0.6 0.1}"
  "Preamble to be included in every export.")

(defvar org-latex-conditional-preambles
  `((t . org-latex-universal-preamble)
    ("\\[\\[file:.*\\.svg\\]\\]" . "\\usepackage{svg}"))
  "Snippets which are conditionally included in the preamble of a LaTeX export.

Alist where when the car results in a non-nil value, the cdr is inserted in
the preamble.  The car may be a:
- string, which is used as a regex search in the buffer
- symbol, the value of which used
- function, the result of the function is used

The cdr may be a:
- string, which is inserted without processing
- symbol, the value of which is inserted
- function, the result of which is inserted")

(defadvice! org-latex-header-smart-preamble (orig-fn tpl def-pkg pkg snippets-p &optional extra)
  "Dynamically insert preamble content based on `org-latex-conditional-preambles'."
  :around #'org-splice-latex-header
  (let ((header (funcall orig-fn tpl def-pkg pkg snippets-p extra)))
    (if snippets-p header
      (concat header
              (mapconcat (lambda (term-preamble)
                           (when (pcase (car term-preamble)
                                   ((pred stringp) (save-excursion
                                                     (goto-char (point-min))
                                                     (search-forward-regexp (car term-preamble) nil t)))
                                   ((pred functionp) (funcall (car term-preamble)))
                                   ((pred symbolp) (symbol-value (car term-preamble)))
                                   (_ (user-error "org-latex-conditional-preambles key %s unable to be used" (car term-preamble))))
                             (pcase (cdr term-preamble)
                               ((pred stringp) (cdr term-preamble))
                               ((pred functionp) (funcall (cdr term-preamble)))
                               ((pred symbolp) (symbol-value (cdr term-preamble)))
                               (_ (user-error "org-latex-conditional-preambles value %s unable to be used" (cdr term-preamble))))))
                         org-latex-conditional-preambles
                         "\n")))))

(after! ox-latex
  (setq
   org-latex-default-class "notes"
   org-latex-pdf-process '("latexmk -%latex -shell-escape -interaction=nonstopmode -f -pdf -output-directory=%o %f" "latexmk -c")
   org-latex-listings 'engraved)
  (add-to-list 'org-latex-classes
               '("notes"
                 "\\documentclass{scrartcl}\n\
\\usepackage[T1]{fontenc}\n\
\\usepackage[osf,largesc,helvratio=0.95]{newpxtext}\n\
\\usepackage[scale=0.98]{sourcecodepro}\n\

\\usepackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=2000]{microtype}\n\
\\usepackage{xcolor}\n\
\\usepackage{booktabs}

\\newcommand\\mycomb[2]{{}^{#1}C_{#2}}%
\\newcommand\\myprob[2]{{}^{#1}P_{#2}}%
\\usepackage[letterpaper,hmargin={0.6in,0.5in},vmargin={0.5in,0.5in}]{geometry}
\\usepackage[subtle]{savetrees}

\\usepackage{subcaption}
\\usepackage[hypcap=true]{caption}
\\setkomafont{caption}{\\sffamily\\small}
\\setkomafont{captionlabel}{\\upshape\\bfseries}
\\captionsetup{justification=raggedright,singlelinecheck=true}
\\setcapindent{0pt}

\\setlength{\\parskip}{\\baselineskip}\n\
\\setlength{\\parindent}{0pt}\n\
\\usepackage{enumitem}"

                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (setq org-latex-tables-booktabs t)

  (setq org-latex-hyperref-template "
\\colorlet{greenygreenyblue}{blue!90!green}
\\colorlet{greenyblue}{blue!70!green}
\\colorlet{blueygreen}{blue!40!green}
\\providecolor{link}{named}{greenygreenyblue}
\\providecolor{url}{named}{greenyblue}
\\providecolor{cite}{named}{blueygreen}
\\hypersetup{
  pdfauthor={%a},
  pdftitle={%t},
  pdfkeywords={%k},
  pdfsubject={%d},
  pdfcreator={%c},
  pdflang={%L},
  breaklinks=true,
  colorlinks=true,
  linkcolor=link,
  urlcolor=url,
  citecolor=cite\n}
\\urlstyle{same}\n"))
;;; +org-latex.el ends here
