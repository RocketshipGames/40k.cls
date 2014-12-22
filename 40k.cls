\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{40k}[2014/09/24 Warhammer 40,000 Mission/Campaign Template]


%%----------------------------------------------------------------------
%%-- Notes
%%
%% \pagetitle
%% \missiontitle
%% \missionheading
%% \missionsubheading
%% {story}
%% {squishitemize}
%% \shortlist
%% \BackgroundPic


%%----------------------------------------------------------------------
%%-- Core Packages

\LoadClass[12pt]{article}

\pdfminorversion=4

\RequirePackage{calc}
\RequirePackage{suffix}


\newcommand{\setbackground}{\AddToShipoutPicture{\BackgroundPic{background-skull.pdf}}}
\DeclareOption{nobackground}{\renewcommand{\setbackground}{}}
\ProcessOptions

%%----------------------------------------------------------------------
%%-- Utility Functions

\newcommand\gobblepars{%
    \@ifnextchar\par%
        {\expandafter\gobblepars\@gobble}%
        {}}


%%----------------------------------------------------------------------
%%-- Page Setup

\setlength{\hoffset}{-1in}
\addtolength{\oddsidemargin}{0in}
\addtolength{\evensidemargin}{0in}
\setlength{\leftmargin}{0in}
\setlength{\textwidth}{\paperwidth-1in}

\setlength{\voffset}{-0.5in}
\setlength{\topmargin}{0in}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\textheight}{\paperheight-1in}


%%----------------------------------------------------------------------
%%-- Other Packages

\RequirePackage[table]{xcolor}

%% Change the base font to Helvetica Sans
\RequirePackage[T1]{fontenc}
\RequirePackage[scaled]{helvet}
\renewcommand*{\familydefault}{\sfdefault}

\RequirePackage{tikz}
\usetikzlibrary{shapes}
\usetikzlibrary{decorations}
\usetikzlibrary{calc}
\usetikzlibrary{positioning}

\RequirePackage[obeyspaces]{url}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{amsmath}
\RequirePackage{tabularx}

\RequirePackage{graphicx}

\RequirePackage{latexsym}

\RequirePackage{pdfpages}
\includepdfset{offset=1in -0.5in}

\RequirePackage{pifont}

\RequirePackage{textcomp}

\RequirePackage{stfloats}

\RequirePackage{array}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}


\pagestyle{empty}%


\newenvironment{squishitemize}
{\begin{list}{$\bullet$}{%
    \setlength{\itemsep}{2pt}%
    \setlength{\parsep}{2pt}%
    \setlength{\topsep}{2pt}%
    \setlength{\parskip}{0pt} %
%    \setlength{\labelwidth}{.5in}%
%    \setlength{\labelsep}{0.05in} %
%    \setlength{\leftmargin}{0.2in} %
    \renewcommand{\labelitemi}{--}}}
  {\end{list}}


\newcommand{\shortlist}{
\setlength{\labelwidth}{0pt}
\setlength{\leftmargin}{0pt}
% \setlength{\labelsep}{0pt}
% \renewcommand{\labelitemi}{*}
\setlength{\parskip}{0pt}
\setlength{\parsep}{0pt}
\setlength{\headsep}{0pt}
\setlength{\topskip}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\topsep}{0pt}
\setlength{\partopsep}{0pt}
}

\definecolor{ltgray}{RGB}{245,245,245}


\RequirePackage{datetime}
\yyyymmdddate


%%----------------------------------------------------------------------
%%-- Structure titles

\tikzstyle{blackbox} = [draw=black, fill=black, very thick,
    rectangle, inner sep=15pt, inner ysep=8pt]
\newlength{\ttlwidth}
\setlength{\ttlwidth}{\textwidth-30pt}

\newcommand{\pagetitle}[1]
{%
\noindent\begin{tikzpicture}
\node [blackbox] (box){%
\vbox to 24pt {\vfil\hbox to \ttlwidth {\hfil%
{\scalebox{2}{\color{white}\Large\bf\sc\fontfamily{ptm}\selectfont #1}}
\hfil}\vfil}%
};%
\end{tikzpicture}%
%\vspace*{14pt}
\@afterindentfalse\@afterheading
}

\newcommand{\missiontitledraw}[1]
{\noindent%
\centerline{\scalebox{1.5}{\Large\bf\sc\fontfamily{ptm}\selectfont #1}}
\vspace*{-1pt}
\hrule
\vspace*{3pt}
\hrule
\vspace*{9pt}
\@afterindentfalse\@afterheading
}

\newcommand\missiontitle[1]{\clearpage\missiontitledraw{#1}}
\WithSuffix\newcommand\missiontitle*[1]{\missiontitledraw{#1}}

\newcommand{\missionheading}[1]
{\bigskip\noindent{\Large\bf\sc\fontfamily{ptm}\selectfont #1}%
\@afterindentfalse\@afterheading\par}

\newcommand{\missionsubheading}[1]
{\bigskip\noindent{\bf #1}~~\gobblepars}

%%----------------------------------------------------------------------
%%----------------------------------------------------------------------
%%-- Story call-out

% We need to save the node
% Every append after command might be useful to have this code
\def\savelastnode{\pgfextra\edef\tmpA{\tikzlastnode}\endpgfextra}
\def\restorelastnode{\pgfextra\edef\tikzlastnode{\tmpA}\endpgfextra}
% Define box and box title style
\tikzstyle{borderbox} = [draw=black, fill=ltgray!20, very thick,
    rectangle, inner sep=15pt, inner ysep=12pt]
% rounded corners, 
\tikzstyle{fancytitle} =[fill=black, text=white]
\tikzstyle{club suit} = [append after command={%
    \savelastnode node[fancytitle,yshift=18pt] at (\tikzlastnode.south east)%
    {\includegraphics[width=1.5em]{icon-skull.pdf}}\restorelastnode }]
\tikzstyle{title} = [append after command={%
    \savelastnode node[fancytitle,right=10pt] at (\tikzlastnode.north west)%
    {\sc\fontfamily{ptm}\selectfont #1}\restorelastnode}]

\setlength{\fboxsep}{1pt}
\newcommand{\rescheck}{$\Box$}

\newenvironment{story}[2]{
\noindent\hfil%
\begin{tikzpicture}%
\node [borderbox,club suit,title=#2] (box)\bgroup%
\vbox to #1 \bgroup\hbox to 0.8\linewidth \bgroup%
\begin{minipage}{0.8\linewidth}\it\fontfamily{ptm}\selectfont%
\noindent\ignorespaces%
}{%
\end{minipage}%
\egroup\egroup%
\egroup;%
\end{tikzpicture}%
}

\newenvironment{sidestory}[2]
{
\bigskip
\begin{story}{#1}{#2}
}
{
\end{story}
\smallskip
}


\newenvironment{examples}[1]
{\noindent%
\divider
\vspace*{9pt}
\centerline{\scalebox{1.25}{\Large\bf\sc\fontfamily{ptm}\selectfont #1}}
\@afterindentfalse\@afterheading
}
{
\divider
}

%%----------------------------------------------------------------------
%%----------------------------------------------------------------------
%%-- Formatting

\newenvironment{columns}
{\begin{multicols}{2}
\@afterindentfalse\@afterheading
}
{\end{multicols}
\ignorespacesafterend
}

\newcommand{\divider}{%
\hrule
\vspace*{3pt}
\hrule
}

%%----------------------------------------------------------------------
%%----------------------------------------------------------------------
%%-- Background picture

\RequirePackage{eso-pic}

\newcommand\BackgroundPic[1]{%
\put(72,-36){%
\parbox[b][\paperheight]{\paperwidth}{%
\vfill%
\centering%
\includegraphics[width=\paperwidth,height=\paperheight,%
keepaspectratio]{#1}%
\vfill%
}}}

\setbackground

\newcommand{\squelchbackground}{%
%\let\saveshipout\ESO@HookIBG
\ClearShipoutPicture
}

\newcommand{\restorebackground}{%
%\AddToShipoutPicture{\saveshipout}
\setbackground
}

\endinput
