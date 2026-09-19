# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"

###

ARTHURSH='~/.arthur.sh'
EDITOR='vim'
alias ass="opencode ~/assistant"
alias emacs="emacs -nw"
alias opencode="opencode --yolo"
alias ins="sudo apt install"
alias start="xdg-open"

alias breload="source $ARTHURSH"
alias bconfig="$EDITOR $ARTHURSH"
function ask(){
	aichat $1 | mdlive
}

function sbright() {
	sudo ddcutil setvcp 10 $1 > /dev/null	
}

function scontrast() {
	sudo ddcutil setvcp 12 $1 > /dev/null	
}
