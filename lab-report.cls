% camiregu 2024-jan-13

%%% Identification
\ProvidesClass{lab-report}
\NeedsTeXFormat{LaTeX2e}


%%% Class options
% Inherit options of book
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{book}
}
\ProcessOptions\relax
\LoadClass{report}


%%% 3rd party packages
% for page formatting
\RequirePackage{geometry}
% for heading formatting
\RequirePackage{titlesec}
% for images and graphs
\RequirePackage{graphicx}
\RequirePackage{caption}
% \RequirePackage{pgfplots}
% AMS Packages for environments, shortcuts, and fonts
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
% for units
\RequirePackage{siunitx}


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

%%% Commands for Lab Report elements
% Usage: \newequation{<label>}{<symbol>}{<varnum>}{<eqn>}{<varsymbols>}
\newcommand{\newequation}[5]{%
    % Usage: \#1eqn{<var1>}{<var2>}{<var3>}...
    \expandafter\newcommand\csname #1eqn\endcsname[#3]{#4}

    \begin{equation} \label{eqn:#1}
        #2 = \csname #1eqn\endcsname#5
    \end{equation}

    % Usage: \#1sample[<symbol>]{<finalanswer>}{{<val1>}{<val2>}{<val3>}...}
    \expandafter\newcommand\csname #1sample\endcsname%
    [3][#2]%
    {%
        \begin{align*}
            ##1 &= \csname #1eqn\endcsname#5 \\
            &= \csname #1eqn\endcsname##3 \\
            &= ##2
        \end{align*}
    }
}

% Usage:  \lrfigure[<scale>]{<label>}{<caption>}
\newcommand{\lrfigure}[3][1]
{
    \begin{figure}[!htbp] \label{fig:#2}
        \centering
        \includegraphics[scale=#1]{\Experiment/Images/#2.png}
        \caption{#3}
    \end{figure}
}

\newenvironment{lrtable}
{}
{}