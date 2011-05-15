% A class file for formatting resume content into the Manager Tools
% reccommended format.
% Author: Jared A. Hicks (jared.a.hicks@gmail.com)

%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{mtresume}[2011/5/15 Formats resume content into the Manager Tools reccommended format.]

%-------------------------------------------------------------------------------
%                class options
%
% Note: Our resume class is built on top of the KOMA extended article class
%-------------------------------------------------------------------------------

% available font sizes
\DeclareOption{9pt}{\PassOptionsToClass{9pt}{scrartcl}}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{scrartcl}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{scrartcl}}

% available font:lmodern
\newif\if@lmodern\@lmoderntrue
\DeclareOption{lmodern}{\@lmoderntrue}

% available font:times
\newif\if@times\@timesfalse
\DeclareOption{times}{\@timestrue}

% available font:bookman
\newif\if@bookman\@bookmanfalse
\DeclareOption{bookman}{\@bookmantrue}

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

%-------------------------------------------------------------------------------
%                style packages
%
% setting up the typesetting...
%-------------------------------------------------------------------------------

% font encoding
\RequirePackage[T1]{fontenc}

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
\RequirePackage{times}\fi

% Bookman font as default roman. (Avant Garde as default sans)
\if@bookman
\RequirePackage{bookman}\fi

% page geometry
\RequirePackage[margin=1.0in,nohead,nofoot]{geometry}

% hyperlinks AND document properties
\AtEndPreamble{
    \RequirePackage{hyperref}
  \AtBeginDocument{
    \hypersetup{
      breaklinks,
      baseurl       = http://,
      pdfborder     = 0 0 0,
      pdfpagemode   = UseNone, % do not show thumbnails or bookmarks on opening
%      pdfstartview  = FitH,
      pdfstartpage  = 1,
      pdfcreator    = \LaTeX{} with `mtresume' package,
      pdfproducer   = \LaTeX{},
      bookmarksopen = true,
      pdftitle = {\@name}'s Resume,
      pdfauthor = {\@name},
      pdfsubject    = {\@name},
      pdfkeywords   = \@name{} resume curriculum vit\ae{}}
      }
  \pagenumbering{arabic}% has to be issued after loading hyperref
}

%===================================================================


\frenchspacing  % Disable the additional space at the end of a sentance


%-------------------------------------------------------------------------------
%                class definition
%-------------------------------------------------------------------------------

%========= Defining the DSL =============

\newcommand*{\name}[1]{\def\@name{#1}}
\newcommand*{\address}[3]{\def\@addressstreet{#1}\def\@addresscity{#2}\def\@addresszip{#3}}
\newcommand*{\phone}[1]{\def\@phone{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}

\newcommand*{\MyName}{\@name}

\renewcommand{\@maketitle}{     % want to change the meaning of \@maketitle
 \vspace{1ex}%
 \begin{center}%
  \textbf{\@name\\}%
  \begin{tabular}{c|c|c|c|c}
  \@addressstreet & \@addresscity & \@addresszip & \@phone & \href{mailto:\@email}{\@email}%
  \end{tabular}
 \end{center}%
 }

\usepackage{setspace}
\newenvironment{accomplishments}{%
	\begin{list}{\textbullet}{%
        \setlength\leftmargin{1em}      %line up left edge of env to left edge of item label
        \setlength\topsep{0ex}          %
        \setlength\parskip{0.5ex}
        \setstretch{0.8}
        \setlength\listparindent{1em}   %if for some reason we have a paragraph break, indent
        \setlength\parsep{0in}          %but put no vertical space btw paragraphs
        \setlength\itemsep{0.5ex}         %items are separated by \parsep + \itemsep
        }
}{
	\end{list}
}

\newcommand{\accomplishment}{\item }

%========= Setting up sectioning  =============
\usepackage[explicit]{titlesec}  %explicit allows removing of the titles
%syntax is:
%\titleformat{command}[shape]{format}{label}{sep}{before}{after}
%\titlespacing{command}{left}{beforesep}{aftersep}{right}
\titleformat{\section}[display]{}{}{0em}{}
\titlespacing{\section}{0em}{0em}{0em}

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
\vspace{1.5em}
}

%1st argument: Degree name (e.g. MA Business Administration)
%2nd argument: Year of degree
%3rd argument: Conferring institution name
%4th argument: Conferring institution location
\newenvironment{degree}[4]{%
\par\noindent#1, #3, #2
}{
\vspace{0.0ex}
}

%===================================================================
%===================================================================
% Setting up the doucument

