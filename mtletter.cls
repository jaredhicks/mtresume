% A class file for typesetting professional cover letters
% Author: Jared A. Hicks (jared.a.hicks@gmail.com)

%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{mtletter}[2011/5/15 Typeset professional cover letters.]

%-------------------------------------------------------------------------------
%                class options
%
% Note: Our resume class is built on top of the KOMA extended letter class
%-------------------------------------------------------------------------------
\newcommand{\baseclass}{scrlttr2}

% available font sizes
\DeclareOption{9pt}{\PassOptionsToClass{9pt}{\baseclass}}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{\baseclass}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{\baseclass}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{\baseclass}}

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
\DeclareOption{letterpaper}{\PassOptionsToClass{paper=letter}{\baseclass}}
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{\baseclass}}

% pass along draft/final
\DeclareOption{draft}{\PassOptionsToClass{draft}{\baseclass}}
\DeclareOption{final}{\PassOptionsToClass{final}{\baseclass}}

% execute default options
\ExecuteOptions{letterpaper,10pt,standard}

% Load KOMA article 
\ProcessOptions\relax
\LoadClass{\baseclass}[2011/5/15]

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

% improvements to various subtle things
\RequirePackage{microtype}

% page geometry
\RequirePackage[margin=1.0in,nohead,nofoot]{geometry}

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
      pdfcreator    = \LaTeX{} with `mtletter' package,
      pdfproducer   = \LaTeX{},
      bookmarksopen = true,
      pdftitle = {\@name}'s Cover Letter,
      pdfauthor = {\@name},
      pdfsubject    = {\@name},
      pdfkeywords   = \@name{} resume curriculum vit\ae{}}
      }
  \pagenumbering{arabic}% has to be issued after loading hyperref
}

\RequirePackage{setspace}


%-------------------------------------------------------------------------------
%                class definition
%-------------------------------------------------------------------------------

\newcommand*{\name}[1]{\def\@name{#1}}
\newcommand*{\address}[3]{\def\@addressstreet{#1}\def\@addresscity{#2}\def\@addresszip{#3}}
\newcommand*{\phone}[1]{\def\@phone{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}

\newcommand*{\MyName}{\@name}

%-------------------------------------------------------------------------------
%                document setup
%-------------------------------------------------------------------------------

\AtEndPreamble{
\setkomavar{fromname}{\@name}
\setkomavar{fromaddress}{\@addressstreet\\ \@addresscity \@addresszip}
\setkomavar{fromphone}{\@phone}
\setkomavar{fromemail}{\@email}
}

\AtBeginDocument{
\frenchspacing  % Disable the additional space at the end of a sentance
\setstretch{1.0}

}

