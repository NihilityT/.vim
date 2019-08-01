set updatetime=100
set t_Co=256

set history=2000
set pumheight=10
set signcolumn=yes
set wildmode=list:longest,full
set whichwrap=b,s,<,>,[,]

set mousehide
set mousemodel=popup
set mouse=a

set fileencodings=utf-8,gbk,ucs-bom,cp936
set fileformats=unix,dos

set autoindent
set smarttab
set smartindent

setg noexpandtab
setg tabstop=8
setg shiftwidth=8
setg softtabstop=8

set cmdheight=2
set shortmess=a

set sessionoptions-=blank
set sessionoptions+=winsize
set sessionoptions+=resize
set sessionoptions+=localoptions
set sessionoptions+=globals

set viewoptions=cursor,folds,options,slash,unix

set ttimeout
set ttimeoutlen=100

set tabpagemax=10
set scrolloff=3

set list
"set listchars=tab:>-,trail:-,nbsp:%
"set listchars=tab:\|\ ,trail:-,nbsp:%
set listchars=tab:┆\ ,trail:·,nbsp:%

set wrap
set showcmd
set noshowmode

"set colorcolumn=81
highlight default link guildline ErrorMsg
call matchadd('guildline', '\%81v', 900) "set column nr

set backspace=indent,eol,start
set showtabline=2
set laststatus=2
set display+=lastline
set hidden

set foldenable
set foldmethod=syntax
set foldcolumn=2
set foldlevelstart=99
set magic
set showmatch
set nobomb

set formatoptions+=j
set formatoptions+=o

set diffopt=vertical
set showbreak=↪

set textwidth=0
set wildmenu
set ruler
set number
set relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set title
set wildignorecase

set guicursor=a:block-blinkon0
set cursorline
set wrapscan
set report=0
"set synmaxcol=300

set hlsearch
set ignorecase
set smartcase
set incsearch

set splitbelow
set splitright

set autoread

set backup
set backupdir^=./.vim/backups,D:/.vim/backups,$vim/backups
set undofile
set undodir^=./.vim/undo,D:/.vim/undo,$vim/undo
set swapfile
set directory^=./.vim/swaps,D:/.vim/swaps,$vim/swaps

let g:vim_indent_cont = 4

if !exists('s:first_load_general')
	let s:first_load_general =  1
	" let g:airline_theme = 'ayu_mirage'
	" if exists(':AirlineTheme')
	" AirlineTheme ayu_mirage
	" endif

	" colorscheme molokai

	set background=dark
	colorscheme gruvbox9
	"let g:airline_theme = 'onedark'
	"AirlineTheme onedark
	"endif
endif

augroup vimrc
	au!
	au BufWritePost $vimrc,$vim/*.vim source <afile>
	au BufRead,BufNewFile
		\ *vimrc,*.vim,$vimrc
		\ setf vim | setl foldmethod=marker
	au FileType
		\ vim
		\ let &l:ts = 4 | let &l:sw = 4 | let &l:sts = 4
augroup END

augroup HTML
	au!
	" au BufRead,BufNewFile *.wxml setf xml
	" au BufRead,BufNewFile *.wxss setf css
	au FileType
		\ javascript,typescript,html,css,xml,wxml
		\ let &l:ts = 4 | let &l:sw = 4 | let &l:sts = 4
augroup END

augroup JavaScript
	au!
	" au BufRead,BufNewFile *.wxs setf javascript
	autocmd FileType javascript let &l:cino = ':0,l1,(0,Ws,j1,J1'
augroup END
