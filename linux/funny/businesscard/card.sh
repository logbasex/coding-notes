#!/usr/bin/env bash
#ref:https://redd.it/m6erxq
###############################################
# Write a nice business card on the terminal. #
###############################################

# This is a copycat from Bryan Jenks: https://github.com/tallguyjenks/BusinessCard

# ╭═══════════════════════════════════════════════════════╮
# ║                                                       ║
# ║           Michael Tsouchlarakis / michaeltd           ║
# ║                                                       ║
# ║      Work:  tsouchlarakis@gmail.com                   ║
# ║      FOSS:  Gentoo Linux avocado.                     ║
# ║                                                       ║
# ║   Twitter:  https://twitter.com/tsouchlarakismd       ║
# ║       npm:  https://npmjs.com/~michaeltd              ║
# ║    GitHub:  https://github.com/michaeltd              ║
# ║  LinkedIn:  https://linkedin.com/in/michaeltd         ║
# ║       Web:  https://michaeltd.netlify.com/            ║
# ║                                                       ║
# ║      Card:  curl -sL https://tinyurl.com/mtd-card|sh  ║
# ║                                                       ║
# ╰═══════════════════════════════════════════════════════╯

######################################
# Font attributes, colors, bg colors #
######################################
#bg_black="$(tput setab 0)"
#bg_blue="$(tput setab 4)"
#bg_cyan="$(tput setab 6)"
#bg_default="$(tput setab 9)"
#bg_green="$(tput setab 2)"
#bg_magenta="$(tput setab 5)"
#bg_red="$(tput setab 1)"
#bg_white="$(tput setab 7)"
#bg_yellow="$(tput setab 3)"
#black="$(tput setaf 0)"
#blink="$(tput blink)"
#default="$(tput setaf 9)"
#end_underline="$(tput rmul)"
#hidden="$(tput invis)"
#reverse="$(tput rev)"
white="$(tput setaf 7)"
blue="$(tput setaf 4)"
bold="$(tput bold)"
cyan="$(tput setaf 6)"
dim="$(tput dim)"
green="$(tput setaf 2)"
magenta="$(tput setaf 5)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
underline="$(tput smul)"
yellow="$(tput setaf 3)"

cat <<EOF

${cyan}╔═════════════════════════════════════════════════════════╗
${cyan}║${reset}         ${red}__ __      __    _ __   ____  _           __${reset}    ${cyan}║
${cyan}║${reset}        ${red}/ //_/_  __/ /_  (_) /__/ __ \(_)  _____  / /${reset}    ${cyan}║
${cyan}║${reset}       ${red}/ ,< / / / / __ \/ / //_/ /_/ / / |/_/ _ \/ /${reset}     ${cyan}║
${cyan}║${reset}      ${red}/ /| / /_/ / /_/ / / ,< / ____/ />  </  __/ /${reset}      ${cyan}║
${cyan}║${reset}     ${red}/_/ |_\__,_/_.___/_/_/|_/_/   /_/_/|_|\___/_/${reset}       ${cyan}║
${cyan}║${reset}         ${red}-~=# 161 = floss = cypher = nrk #=~-${reset}            ${cyan}║
${cyan}║                                                         ║
${cyan}╠═════════════════════════════════════════════════════════╣
${cyan}║                                                         ║
${cyan}║${reset} ${red}■${reset} ${underline}${bold}KubikPixel:${reset} ${bold}Web & App developer with 3D experiments${reset} ${red}■${reset} ${cyan}║
${cyan}║                                                         ║
${cyan}║${reset}     ${underline}${bold}Email:${reset}  ${green}kubikpixel@dismail.de                       ${cyan}║
${cyan}║${reset}      ${underline}${bold}XMPP:${reset}  ${yellow}kubikpixel@dismail.de                       ${cyan}║
${cyan}║${reset}    ${underline}${bold}Matrix:${reset}  ${cyan}@kubikpixel:tchncs.de                       ${cyan}║
${cyan}║                                                         ║
${cyn}║${reset}       ${underline}${bold}Web:${reset}  ${dim}https://thunix.net/${reset}${yellow}~kubikpixel/             ${cyan}║
${cyan}║${reset}      ${underline}${bold}Blog:${reset}  ${dim}https://paper.wf/${reset}${green}kubikpixel/                ${cyan}║
${cyan}║${reset}    ${underline}${bold}Gemini:${reset}  ${dim}gemini://tilde.pink/${reset}${white}~kubikpixel/            ${cyan}║
${cyan}║                                                         ║
${cyan}║${reset}  ${underline}${bold}Mastodon:${reset}  ${dim}https://chaos.social/${reset}${blue}@kubikpixel            ${cyan}║
${cyan}║${reset}   ${underline}${bold}Twitter:${reset}  ${dim}https://twitter.com/${reset}${white}kubikpixel              ${cyan}║
${cyan}║${reset}    ${underline}${bold}Reddit:${reset}  ${dim}https://www.reddit.com/user/${reset}${red}KubikPixel      ${cyan}║
${cyan}║${reset}  ${underline}${bold}Codeberg:${reset}  ${dim}https://codeberg.org/${reset}${blue}KubikPixel             ${cyan}║
${cyan}║                                                         ║
${cyan}║${reset}      ${underline}${bold}Card:${reset}  ${yellow}curl -sL 0x0.st/Nlpj | sh                   ${cyan}║
${cyan}║                                                         ║
${cyan}╚═════════════════════════════════════════════════════════╝

EOFa
