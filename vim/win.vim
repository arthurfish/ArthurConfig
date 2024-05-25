syntax on
set ruler
set number
set smartindent
set showcmd
set wrap
set mouse=a
set backspace=eol,start,indent
set tabstop=4
set shiftwidth=4
set smarttab
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=r
set guioptions-=b
set showtabline=0

set updatecount=0

colorscheme newsprint
set guifont=Consolas:h13

map! <F8>	<ESC>:execute "w"	<CR>
map! <F9>	<ESC>:call Comp()	<CR>
map! <F10>	<ESC>:call Run()	<CR>
map! <F11>	<ESC>:call CompRun()	<CR>
map! <F12>	<ESC>:call Debug()	<CR>

nmap <F8>	<ESC>:execute "w"	<CR>
nmap <F9>	<ESC>:call Comp()	<CR>
nmap <F10>	<ESC>:call Run()	<CR>
nmap <F11>	<ESC>:call CompRun()	<CR>
nmap <F12>	<ESC>:call Debug()	<CR>

:function Comp() "±àÒë
:	execute "w"
:	execute "!g++ -g %  -Wall"
:endfunction


:function Run() "ÔËÐÐ
:	execute "!a.exe"
:endfunction

:function CompRun() "±àÒëÔËÐÐ
:	execute "w"
:	call Comp()
:	call Run()
:endfunction

:function OpenHtml() "±àÒëÔËÐÐ
:	execute "w"
:	execute "!firefox ~/web/test.html"
:endfunction

:function Debug() "ÔËÐÐ
:	execute "!gdb a.exe"
:endfunction

