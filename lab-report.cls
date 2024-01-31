% camiregu 2024-jan-13

%%% Identification
\ProvidesClass{lab-report}
\NeedsTeXFormat{LaTeX2e}


%%% Class options
% Inherit options of book
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions\relax
\LoadClass{report}


%%% 3rd party packages
% for page formatting
\RequirePackage{geometry}
\RequirePackage{multicol}
% for heading formatting
\RequirePackage{titlesec}
% for images
\usepackage{import}
\usepackage{xifthen}
\usepackage{pdfpages}
\usepackage{transparent}
% for units and tables
\RequirePackage{siunitx}
\RequirePackage{tabularx}
\RequirePackage{caption}
% pgf packages for plots
\RequirePackage{pgfplots}
% ams packages for environments, shortcuts, and fonts
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
% for enumerated lists
\RequirePackage{enumitem}
% for better referencing (consider hyperref and varref)
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{varioref}
\RequirePackage{cleveref}
% for pretty colors
\RequirePackage{tcolorbox}
\tcbuselibrary{most}


%%% Fix chapter heading
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries} % format
{} % label
{20pt}{\Huge \thechapter. } % before


%%% Commands for lab information
\newcommand{\experiment}[1]{\def\Experiment{#1}}
\newcommand{\course}[4]{\def\@coursecode{#1} \def\@coursetitle{#2} \def\@coursesection{#3} \def\@coursetimeframe{#4}}
\newcommand{\student}[2]{\def\@studentname{#1} \def\@studentnumber{#2}}
\newcommand{\institution}[1]{\def\@institution{#1}}
\renewcommand{\date}[1]{\def\@date{#1}}


%%% Formatting commands
%% Create title page
\renewcommand{\maketitle}{
    \begin{center}
        \textbf{\Huge{\Experiment}}\\[1.5\baselineskip]
        \vspace{11mm}
        \textbf{\LARGE{\@coursecode: \@coursetitle}}\\[1.5\baselineskip]
        \textbf{\LARGE{Lab Section \@coursesection}}\\[1.5\baselineskip]
        \textbf{\LARGE{\@coursetimeframe}}\\[1.5\baselineskip]
        \vspace{26mm}
        \textbf{\LARGE{\@studentname}}\\[1.5\baselineskip]
        \textbf{\LARGE{\@studentnumber}}\\[1.5\baselineskip]
        \textbf{\LARGE{\@institution}}\\[1.5\baselineskip]
        \Large{\today}
    \end{center}
    \newpage
}

% Define typographic struts, as suggested by Claudio Beccari in an article in TeX and TUG News, Vol. 2, 1993.
\newcommand\Tstrut{\rule{0pt}{2.6ex}}         % = `top' strut
\newcommand\Bstrut{\rule[-1.4ex]{0pt}{0pt}}   % = `bottom' strut

%%% Commands for Lab Report elements
% Usage: \lrequation{<label>}{<symbol>}{<varnum>}{<eqn>}{<varsymbols>}
\newcommand{\lrequation}[5]{%
    % Usage: \#1eqn{<var1>}{<var2>}{<var3>}...
    \expandafter\newcommand\csname #1eqn\endcsname[#3]{#4}

    \begin{equation} \label{eqn:#1}
        #2 = \csname #1eqn\endcsname#5
    \end{equation}

    % Usage: \lrsample#1[<symbol>]{<finalanswer>}{{<val1>}{<val2>}{<val3>}...}
    \expandafter\newcommand\csname lrsample#1\endcsname%
    [3][#2]%
    {%
        \begin{align*}
            ##1 &= \csname #1eqn\endcsname#5 \\
            &= \csname #1eqn\endcsname##3 \\
            &= ##2
        \end{align*}
    }
}

% Usage: \lrfigure[placement]{<label>}{<caption>}
\newcommand{\lrfigure}[3][!htbp]
{
    \begin{figure}[#1]
        \centering
        \def\svgwidth{\columnwidth}
        \import{\Experiment/Images/}{#2.pdf_tex}
        \caption{#3}
        \label{fig:#2}
    \end{figure}
}
 
% Usage: \begin{lrtable}[<placement>]{<label>}{<caption>}{<numcolumns>}{<titles>}{<data>}
\newcommand{\lrtable}[6][!htbp]
{
\begin{table}[#1]
\centering
\begin{tabular}{|| *{#4}{c} ||}
    \hline %
    \Tstrut#5\Bstrut\\ %
    \hline\hline %
    \Tstrut#6\Bstrut\\ %
    \hline %
\end{tabular}
\caption{#3}
\label{tab:#2}
\end{table}
}

\newenvironment{lrapparatus}
{\begin{multicols}{2} \begin{itemize}}
{\end{itemize} \end{multicols}}