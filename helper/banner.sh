#!/usr/bin/env bash

VERSION="2.3.0"
AUTHOR="MD Sakibur Rahman (MSR)"
GITHUB="msrofficial"

function banner() {
  echo -e "
\e[92m  ███╗   ███╗███████╗██████╗
\e[92m  ████╗ ████║██╔════╝██╔══██╗
\e[96m  ██╔████╔██║███████╗██████╔╝
\e[96m  ██║╚██╔╝██║╚════██║██╔══██╗
\e[94m  ██║ ╚═╝ ██║███████║██║  ██║
\e[94m  ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝\e[0m
\e[90m  Termux Dotfiles\e[0m

\e[90m  ╔══════════════════════════════════╗\e[0m
\e[90m  ║\e[0m  \e[90mAuthor  :\e[0m  ${AUTHOR}
\e[90m  ║\e[0m  \e[90mGitHub  :\e[0m  \e[94m${GITHUB}\e[0m
\e[90m  ║\e[0m  \e[90mVersion :\e[0m  \e[92mv${VERSION}\e[0m
\e[90m  ╚══════════════════════════════════╝\e[0m
  "
}
