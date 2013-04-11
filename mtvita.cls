% A class file for formatting CV content similar to  the Manager Tools
% reccommended resume format.
% Author: Jared A. Hicks (jared.a.hicks@gmail.com)

%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{mtvita}[2011/5/15 Formats CV content similar to a Manager Tools resume.]

%-------------------------------------------------------------------------------
%                class options
%
% Note: Our resume class is built on top of the KOMA extended article class
%-------------------------------------------------------------------------------

% available font sizes
\DeclareOption{9pt}{\PassOptionsToClass{9pt}{scrartcl}}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{scrartcl}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{scrartcl}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{scrartcl}}

% available font:lmodern
\newif\if@lmodern\@lmoderntrue
\DeclareOption{lmodern}{\@lmoderntrue}

% available font:times
\newif\if@times\@timesfalse
\DeclareOption{times}{\@timestrue}

% available font:palatino
\newif\if@palatino\@palatinofalse
\DeclareOption{palatino}{\@palatinotrue}

% available paper sizes
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{scrartcl}}
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{scrartcl}}

% pass along draft/final
\DeclareOption{draft}{\PassOptionsToClass{draft}{scrartcl}}
\DeclareOption{final}{\PassOptionsToClass{final}{scrartcl}}

% execute default options
\ExecuteOptions{letterpaper,10pt}

% Load KOMA article 
\ProcessOptions\relax
\LoadClass{scrartcl}[2011/5/15]

%-------------------------------------------------------------------------------
%                support packages
%-------------------------------------------------------------------------------

% for class programming utilities
\RequirePackage{etoolbox}[2011/5/15]

% for if...then...else constructs and \isempty
\RequirePackage{xifthen}[2011/5/15]

%latex vs pdflatex vs xelatex vs luatex complation
% see http://en.wikibooks.org/wiki/LaTeX/Tips_and_Tricks#Generic_header
\RequirePackage{ifpdf}

\RequirePackage{tabularx}


%-------------------------------------------------------------------------------
%                style packages
%
% setting up the typesetting...
%-------------------------------------------------------------------------------


% scalable Computer Modern fonts
%\usepackage{type1cm}
\usepackage{ae,aecompl}

% Latin modern Sans (enhanced version on Computer Modern)
\if@lmodern
\RequirePackage{lmodern}
\RequirePackage{textcomp}   % for using any of the TS1-encoding symbols with lmodern
\fi

% Times New Roman font as default roman
\if@times
\RequirePackage{mathptmx}\fi

% palatino font as default roman. (sans?)
\if@palatino
\RequirePackage[osf]{mathpazo}
\renewcommand{\sfdefault}{helvet}
\fi

% font encoding
\RequirePackage[T1]{fontenc}

\RequirePackage[american]{babel}

% page geometry
\RequirePackage[nofoot]{geometry}
\geometry{
    margin=1.1in,
    headheight=3ex,
    headsep=2ex
}

% header and footer
\RequirePackage{fancyhdr}
\pagestyle{fancyplain}
\lhead{\sf \MyName: \MyTitle}
\rhead{\sf\thepage}
\fancyfoot{}


% improvements to various subtle things
\RequirePackage{microtype}

% hyperlinks AND document properties
\AtEndPreamble{
  \RequirePackage{hyperref}

  \AtBeginDocument{
% Don't want links displayed in color (for easier printing) or underlined (for printing).
% But put them in boxes so that they are visible in readers as links
    \hypersetup{
      breaklinks,
      colorlinks    = false,
      baseurl       = http://,
      pdfborder     = 0 0 0.5,
      pdfpagemode   = UseNone, % do not show thumbnails or bookmarks on opening
%      pdfstartview  = FitH,
      pdfstartpage  = 1,
      pdfcreator    = \LaTeX{} with `mtvita' package,
      pdfproducer   = \LaTeX{},
      bookmarksopen = true,
      pdftitle = {\@name}'s Curriculum Vit\ae{},
      pdfauthor = {\@name},
      pdfsubject    = {\@name},
      pdfkeywords   = \@name{} resume curriculum vit\ae{}}
      }

  \pagenumbering{arabic}% has to be issued after loading hyperref

  \title{\@name}
}

\RequirePackage{setspace}

%===================================================================

\AtBeginDocument{
\frenchspacing  % Disable the additional space at the end of a sentance
\setlength{\headwidth}{1.0\textwidth}   % make sure we have the correct textwidth
\if@palatino
\setstretch{1.05}
\else
\setstretch{1.0}
\fi
}


%-------------------------------------------------------------------------------
%                class definition
%-------------------------------------------------------------------------------

%========= Defining the DSL =============

\newcommand*{\name}[1]{\def\@name{#1}}
\newcommand*{\docname}[1]{\def\@doc{#1}}
\newcommand*{\address}[3]{\def\@addressstreet{#1}\def\@addresscity{#2}\def\@addresszip{#3}}
\newcommand*{\phone}[1]{\def\@phone{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}

\newcommand*{\MyName}{\@name}
\newcommand*{\MyTitle}{\@doc}

\renewcommand{\@maketitle}{     % want to change the meaning of \@maketitle
 \vspace{1em}%
 \begin{center}%
  \textbf{\Large\@name\\}%
 \vspace{0.3em}%
  \begin{tabular}{c|c|c|c|c}
  \@addressstreet & \@addresscity & \@addresszip & \@phone & \href{mailto:\@email}{\@email}%
  \end{tabular}
 \end{center}%
 \vspace{0em}%
 }

\newcommand*{\compress}{\@minipagetrue}

\newcommand*{\accompspacing}{
        \setlength\leftmargin{1em}      % line up left edge of env to left edge of item label
        \setlength\topsep{0ex}          %
        \setlength\parskip{0.5ex}
        \setlength\listparindent{1em}   % if for some reason we have a paragraph break, indent
        \setlength\parsep{0in}          %             but put no vertical space btw paragraphs
        \setlength\itemsep{0.6ex}       % items are separated by \parsep + \itemsep
}

\newenvironment{accomplishments}{%
    \begin{spacing}{0.2}                % compress vertical spacing WITHIN LIST
	\begin{list}{\textbullet}{%
    \accompspacing
        }
}{
	\end{list}
\end{spacing}
}

%% Compressed more!
\newenvironment{accomplishments*}{%
    \begin{spacing}{0.2}                % compress vertical spacing WITHIN LIST
	\begin{list}{\textbullet}{%
        \compress                      % Removes whitespace before environment
    \accompspacing
        }
}{
	\end{list}
\end{spacing}
}


\newcommand{\accomplishment}{\item}

%========= Setting up sectioning  =============
\usepackage{titlesec}  %explicit allows removing of the titles

%% Margin section titles
%\titleformat{\section}[leftmargin]{\normalfont\vspace{6pt}\sffamily\bfseries\filcenter}{\sectiontitle}{.5em}{}
%\titlespacing{\section}{4pc}{1.5ex plus .1ex minus .2ex}{1pc}

%% A Ruled title
\titleformat{\section}{\large\scshape\raggedright}{}{0em}{}[\titlerule]
\titlespacing{\section}{0em}{2em}{2em}

%========= User Environments  =============

%1st argument: Dates
%2nd argument: Title
%3rd argument: Company and location
%4th argument: Responsibilities
\newenvironment{job}[4]{%
\vspace{0.0em}
\noindent\textbf{\underline{{#1: #2\ifthenelse{\isempty{#3}}{}{, #3}}}}---#4%
\noindent\begin{accomplishments}{}
}{
\end{accomplishments}
\vspace{2.0em}
}

%1st argument: Dates
%2nd argument: Title
%3rd argument: Company and location
%4th argument: Responsibilities
\newenvironment{job*}[4]{%
\vspace{0.0em}
\noindent\textbf{\underline{{#1: #2\ifthenelse{\isempty{#3}}{}{, #3}}}}---#4%
\vspace{2.0em}
}

\newcommand{\eduspace}{0.7em}
\newcommand{\degreeindent}{\\&}

%%  Degree environment (compressed)
%0th argument: Degree name (e.g. MA)
%1st argument: Degree field (e.g. Business Administration)
%2nd argument: Year of degree
%3rd argument: Conferring institution name
%4th argument: Conferring institution location
\newenvironment{degree*}[5]{%
\par\noindent\tabularx{\linewidth}{@{}>{\raggedright}p{2em}X}
#1 &\textbf{#4}, #2, #3
}{
\vspace{\eduspace}
}

%%  Degree environment (multi-line)
%0th argument: Degree name (e.g. MA)
%1st argument: Degree field (e.g. Business Administration)
%2nd argument: Year of degree
%3rd argument: Conferring institution name
%4th argument: Conferring institution location
\newenvironment{degree}[5]{%
\par\noindent\tabularx{\linewidth}{@{}>{\raggedright}p{2em}X}
#1 &\textbf{#4}\\
&#2, #3
}{
\endtabularx
\vspace{\eduspace}
}

\newcommand{\refspace}{1.3em}
%%  Reference environment (multi-line)
\newenvironment{reference}[1]{%
\par\noindent\ignorespaces\textbf{#1}\\
}{
\vspace{\refspace}
}

%1st argument: Award name (may include institution)
%2nd argument: Year(s) of award
%Content: [optional--leave blank if none] description
\newenvironment{award}[2]{%
\par\noindent{#1} (#2)
%\ifthenelse{\isempty{#3}}{\null}{\\\noindent#3}%
}{
\vspace{2.1ex}
}

%% Lecture
%1st argument: Title
%2nd argument: Forum
%3rd argument: Location
%4th argument: Date
\newcommand{\lecture}[4]{\par\noindent``{#1},''\par\noindent#2, #3, #4\vspace{2.5ex}}

% Bibliography formatting

\RequirePackage[sorting=ynt,bibstyle=authoryear-comp,labelyear=false,defernumbers=true,maxnames=20,firstinits=true, uniquename=init,dashed=false]{biblatex}

\DeclareFieldFormat{url}{\url{#1}}
\DeclareFieldFormat[article]{pages}{#1}
\DeclareFieldFormat[inproceedings]{pages}{\lowercase{pp.}#1}
\DeclareFieldFormat[incollection]{pages}{\lowercase{pp.}#1}
\DeclareFieldFormat[article]{volume}{\textbf{#1}}
\DeclareFieldFormat[article]{number}{(#1)}
\DeclareFieldFormat[article]{title}{\MakeCapital{#1}}
\DeclareFieldFormat[inproceedings]{title}{#1}
\DeclareFieldFormat{shorthandwidth}{#1}

% Don't use "In:" in bibliography. Omit urls from journal articles.
\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/editor}%
  \setunit{\labelnamepunct}\newblock
  \MakeSentenceCase{\usebibmacro{title}}%
  \newunit
  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{byeditor+others}%
  \newunit\newblock
  \printfield{version}%
  \newunit\newblock
%  \usebibmacro{in:}%
  \usebibmacro{journal+issuetitle}%
  \newunit\newblock
  \printfield{note}%
  \setunit{\bibpagespunct}%
  \printfield{pages}
  \newunit\newblock
  \usebibmacro{eprint}
  \newunit\newblock
  \printfield{addendum}%
  \newunit\newblock
  \usebibmacro{pageref}%
  \usebibmacro{finentry}}

% Remove dot between volume and number in journal articles.
\renewbibmacro*{journal+issuetitle}{%
  \usebibmacro{journal}%
  \setunit*{\addspace}%
  \iffieldundef{series}
    {}
    {\newunit
     \printfield{series}%
     \setunit{\addspace}}%
  \printfield{volume}%
%  \setunit*{\adddot}%
  \printfield{number}%
  \setunit{\addcomma\space}%
  \printfield{eid}%
  \setunit{\addspace}%
  \usebibmacro{issue+date}%
  \newunit\newblock
  \usebibmacro{issue}%
  \newunit}


% Bibliography categories
\def\makebibcategory#1#2{\DeclareBibliographyCategory{#1}\defbibheading{#1}{\subsection*{#2}}}
\makebibcategory{books}{Books}
\makebibcategory{papers}{Refereed research papers}
\makebibcategory{chapters}{Book chapters}
\makebibcategory{conferences}{Papers in conference proceedings}
\makebibcategory{techreports}{Unpublished working papers}
\makebibcategory{bookreviews}{Book reviews}
\makebibcategory{editorials}{Editorials}
\makebibcategory{phd}{PhD thesis}
\makebibcategory{subpapers}{Submitted papers}
\makebibcategory{curpapers}{Current projects}

\setlength{\bibitemsep}{2.65pt}
\setlength{\bibhang}{.8cm}
%\renewcommand{\bibfont}{\small}

\renewcommand*{\bibitem}{\addtocounter{papers}{1}\item \mbox{}\hskip-0.85cm\hbox to 0.85cm{\hfill\arabic{papers}.~~}}
\defbibenvironment{bibliography}
{\list{}
  {\setlength{\leftmargin}{\bibhang}%
   \setlength{\itemsep}{\bibitemsep}%
   \setlength{\parsep}{\bibparsep}}}
{\endlist}
{\bibitem}

\newenvironment{publications}{\section{Publications}\label{papersstart}\vspace*{0.2cm}\small
\titlespacing{\section}{0pt}{1.5ex}{1ex}\itemsep=0.00cm
}{\label{papersend}\addtocounter{sumpapers}{-1}\refstepcounter{sumpapers}\label{sumpapers}}

\def\printbib#1{\printbibliography[category=#1,heading=#1]\lastref{sumpapers}}

% Counters for keeping track of papers
\newcounter{papers}\setcounter{papers}{0}
\newcounter{sumpapers}\setcounter{sumpapers}{0}
\def\lastref#1{\addtocounter{#1}{\value{papers}}\setcounter{papers}{0}}

% Add all papers in the bib file.
\nocite{*}


