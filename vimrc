execute pathogen#infect()

set nocompatible

set history=1000
set wildmenu wildmode=longest:full,full
set ruler showcmd
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set hlsearch incsearch magic
set noerrorbells visualbell t_vb=
set encoding=utf8
set nobackup nowritebackup noswapfile
set smartcase
set showfulltag
set scrolloff=5 sidescrolloff=5
set hidden
set number
set smartindent autoindent smarttab cindent cinoptions=g0,N-s,E-s
set autoread
set ts=4 sw=4 sts=4
set mouse=a
set timeoutlen=200
set background=dark
set list listchars=tab:<->
set path+=**
set clipboard=unnamed

highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$\| \+\t\s\+\|\t\+\ \s\+/

syntax enable

autocmd FileType c       setlocal makeprg=gcc\ '%'\ -o\ '%:r'\ -std=gnu11\ -Wall
autocmd FileType cpp     setlocal makeprg=g++\ '%'\ -o\ '%:r'\ -std=gnu++1z\ -Wall
autocmd FileType haskell setlocal makeprg=ghc\ --make\ '%'
autocmd Filetype cs      setlocal makeprg=mcs\ '%'\ -r:System.Numerics
autocmd Filetype rust    setlocal makeprg=rustc\ '%'\ -o\ '%:r'
autocmd Filetype ocaml   setlocal makeprg=ocamlopt\ '%'\ -o\ '%:r'

autocmd FileType haskell setlocal shellpipe=2> expandtab
autocmd FileType cabal   setlocal expandtab
autocmd FileType python  setlocal expandtab
autocmd Filetype html    setlocal ts=2 sts=2 sw=2
autocmd Filetype xml     setlocal ts=2 sts=2 sw=2

autocmd BufReadPost * :DetectIndent

autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost make call ExecuteIfNoErrors()

"set errorformat+=%f:%l:%c:\%m
"set errorformat+=%*[\"]%f%*[\"]\\,\ line\ %l:\ %m
"
"set errorformat+=%-Z\ %#
"set errorformat+=%W%f:%l:%c:\ Warning:\ %m
"set errorformat+=%E%f:%l:%c:\ %m
"set errorformat+=%E%>%f:%l:%c:
"set errorformat+=%+C\ \ %#%m
"set errorformat+=%W%>%f:%l:%c:
"set errorformat+=%+C\ \ %#%tarning:\ %m

function! ExecuteIfNoErrors()
	if len(getqflist()) == 0
		call ExecuteFile()
	endif
endfunction

function! ExecuteFile()
	if has('terminal')
		if &filetype == "sh"
			write
			terminal bash "%"
		elseif &filetype == "python"
			write
			terminal python "%"
		elseif &filetype == "javascript"
			write
			terminal node "%"
		elseif &filetype == "c" || &filetype == "cpp" || &filetype == "haskell" || &filetype == "rust" || &filetype == "ocaml"
			terminal "%:p:r"
		elseif &filetype == "cs"
			terminal mono "%:p:r.exe"
		endif
	else " TODO: remove dublicated stuff here
		if &filetype == "sh"
			write
			!bash "%"
		elseif &filetype == "python"
			write
			!python "%"
		elseif &filetype == "javascript"
			write
			!node "%"
		elseif &filetype == "c" || &filetype == "cpp" || &filetype == "haskell" || &filetype == "rust" || &filetype == "ocaml"
			!"%:p:r"
		elseif &filetype == "cs"
			!mono "%:p:r.exe"
		endif
	endif
endfunction

nmap <F8> :w<CR>:make -O2<CR><CR>
nmap <F9> :w<CR>:make<CR><CR>:call ExecuteIfNoErrors()<CR>
nmap <F10> :call ExecuteFile()<CR>
nmap <Tab> mtgg=G't

nmap <C-_> :noh<CR>
nmap <C-D> :terminal ++close<CR>

let mapleader='\'
nmap <Leader>q :q<CR>
nmap <Leader>e :NERDTreeTabsToggle<CR>
nmap <Leader>w :w !sudo tee % > /dev/null<CR><CR>
nmap <Leader>g :GundoToggle<CR>
nmap <Leader>t :GhcModType<CR>

nmap Y y$
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
nmap <C-H> <C-W>h

tmap <ScrollWheelUp> <C-W>N<ScrollWheelUp>

set langmap=чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM

let g:ale_linters = {
\	'haskell': ['stack-ghc', 'hlint']
\}
let g:ale_linters_explicit = 1
let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
set completeopt-=preview

let g:gundo_prefer_python3 = 1

if &term =~? 'xterm'
	set t_ut=
	set t_Co=256
	let g:badwolf_darkgutter = 1
	let g:badwolf_tabline = 2
	colorscheme badwolf
"	let g:solarized_termtrans = 1
"	let g:solarized_termcolors = 256
"	colorscheme solarized
	set cursorline
"else
"	colorscheme evening
endif
