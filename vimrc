execute pathogen#infect()

set history=1000
set wildmenu wildmode=longest:full,full
set ruler showcmd
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set hlsearch incsearch magic
set noerrorbells visualbell t_vb=
set background=dark
set encoding=utf8
set nobackup nowritebackup noswapfile
set smartcase
set showfulltag
set scrolloff=5 sidescrolloff=5
set hidden
set number
set smartindent autoindent smarttab cindent
set autoread
set ts=4 sw=4 sts=4
set mouse=a
set timeoutlen=200

syntax enable

if filereadable("Makefile")
	setlocal makeprg=make
else
	autocmd FileType c          setlocal makeprg=gcc\ '%'\ -o\ '%:r'\ -std=gnu11\ -Wall
	autocmd FileType cpp        setlocal makeprg=g++\ '%'\ -o\ '%:r'\ -std=gnu++1z\ -Wall
	autocmd FileType haskell    setlocal makeprg=ghc\ --make\ '%'
	autocmd Filetype cs         setlocal makeprg=mcs\ '%'\ -r:System.Numerics
	autocmd Filetype rust		setlocal makeprg=rustc\ '%'\ -o\ '%:r'

	autocmd FileType sh         setlocal makeprg=true
	autocmd FileType python     setlocal makeprg=true
	autocmd FileType javascript setlocal makeprg=true

	autocmd Filetype markdown   setlocal makeprg=pandoc\ '%'\ -o\ '%:r.html'
endif

autocmd FileType haskell    setlocal shellpipe=2> expandtab
autocmd FileType cabal      setlocal expandtab
autocmd Filetype html       setlocal ts=2 sts=2 sw=2
autocmd Filetype xml        setlocal ts=2 sts=2 sw=2

"autocmd BufReadPost * :DetectIndent

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
	if &filetype == "sh"
		write
		!bash '%'
	elseif &filetype == "python"
		write
		!python '%'
	elseif &filetype == "javascript"
		write
		!node '%'
	elseif &filetype == "c" || &filetype == "cpp" || &filetype == "haskell" || &filetype == "rust"
		!'%:p:r'
	elseif &filetype == "cs"
		!mono '%:p:r.exe'
	endif
endfunction

nmap <F8> :w<CR>:make -O2<CR><CR>
nmap <F9> :w<CR>:make<CR><CR>:call ExecuteIfNoErrors()<CR>
nmap <F10> :call ExecuteFile()<CR>
"nmap <C-D> :ConqueTermSplit zsh<CR>
nmap <Tab> mtgg=G't

nmap  :noh<CR>

let mapleader='\'
nmap <Leader>q :q<CR>
nmap <Leader>e :NERDTreeTabsToggle<CR>
nmap <Leader>w :w !sudo tee % > /dev/null<CR><CR>
nmap <Leader>p :make program<CR><CR>

nmap Y y$
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
nmap <C-H> <C-W>h

set langmap=чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM

let g:ycm_global_ycm_extra_conf = '/etc/vim/ycm_extra_conf.py'
set completeopt-=preview

"let g:syntastic_c_compiler_options = '-std=gnu11'
"let g:syntastic_cpp_compiler_options = '-std=gnu++1z'
"
""set conceallevel=2
""set concealcursor=vin
"let g:clang_snippets=1
"let g:clang_conceal_snippets=1
"let g:clang_snippets_engine='clang_complete'
"let g:clang_user_options = '-std=gnu++1z'
"
"let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'

if &term =~? 'xterm'
	set t_ut=
	set t_Co=256
	let g:badwolf_darkgutter = 1
	let g:badwolf_tabline = 2
	colorscheme badwolf
"	let g:solarized_termtrans = 1
"	colorscheme solarized
	set cursorline
"else
"	colorscheme evening
endif
