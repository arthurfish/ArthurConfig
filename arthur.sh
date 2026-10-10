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

alias reload="source $ARTHURSH"
alias config="$EDITOR $ARTHURSH"
function ask(){	
    echo $1 >> ~/ask-history.txt
    aichat $1 | mdlive;
}
function wd() { 
    echo $1 >> ~/word-list.txt;
    prompt="请解释单词$1的意思。如果这是抽象的单词，请说出它的比较具体的意思。如果这是1个多义单词，请首先说出它最为重要的意思。简要的说明这个单词的词源。"; 
    aichat $prompt | mdlive;
}
function what() {
    ask "这是什么？$1"
}

function bright() { sudo ddcutil setvcp 10 $1 > /dev/null; }
function contrast() { sudo ddcutil setvcp 12 $1 > /dev/null; }
function bricon() { bright $1; contrast $2; }
alias trans="ask '把这些东西翻译成中文'"
alias agy="agy --dangerously-skip-permissions"
alias vim="nvim"
alias oc="opencode"
function callgraph() { bunx --package @mattelim/typescript-call-graph tcg $1; }
alias agy="agy --dangerously-skip-permissions"
alias asg="agy --add-dir ~/assistant"
