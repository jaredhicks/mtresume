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

\RequirePackage{tabularx}

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
\RequirePackage[margin=1.1in,nohead,nofoot]{geometry}

% improvements to various subtle things
\RequirePackage{microtype}

% hyperlinks AND document properties
\AtEndPreamble{
  \RequirePackage{hyperref}

  \AtBeginDocument{
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
\setstretch{1.0}
}


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
 \vspace{1em}%
 \begin{center}%
  \textbf{\Large\@name\\}%
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
        \setlength\itemsep{0.4ex}       % items are separated by \parsep + \itemsep
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

\newcommand{\eduspace}{\vspace{0.7em}}

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
\eduspace
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
\eduspace
}

%1st argument: Award name (may include institution)
%2nd argument: Year(s) of award
%Content: [optional--leave blank if none] description
\newenvironment{award}[2]{%
\par\noindent\textbf{#1} (#2)
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


