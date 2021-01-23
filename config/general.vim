set updatetime=100
set t_Co=256

set history=2000
set pumheight=10
set signcolumn=yes
set wildmode=list:longest,full
set wildmenu
set whichwrap=b,s,<,>,[,]
set mousehide
set mousemodel=popup
set mouse=a

setg encoding=utf-8
setg fileencodings=ucs-bom,utf-8,gb18030,latin1
setg fileformats=unix,dos

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

if !exists('g:source_type')
    let g:source_type = ['c', 'cpp', 'python', 'java', 'javascript', 'ruby', 'vim']
endif

"set colorcolumn=81
highlight link guideline DiffDelete
augroup g-guidline
    au!
    au BufWinEnter,FileType *
        \ silent! call matchdelete(get(w:, 'guideline_id', -1)) |
        \ if index(g:source_type, &filetype) >= 0 |
        \   let w:guideline_id = matchadd('guideline', '\%81v.', 999,
        \                                 get(w:, 'guideline_id', -1)) |
        \ endif
augroup end

set backspace=indent,eol,start
set showtabline=2
set laststatus=2
set display+=lastline
set hidden

set foldenable
set foldmethod=indent
" set foldcolumn=2
set foldlevelstart=99
set magic
set showmatch
set nobomb

set formatoptions+=j
set formatoptions+=o

set diffopt=vertical
set showbreak=↪

set textwidth=0
set ruler
set number
set relativenumber
augroup number-toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set title
set wildignorecase
if empty(glob('%:p*'))
    set nowildignorecase
endif

set guicursor=a:block-blinkon0
aug general-vim
    au!
    au syntax,colorscheme * hi Cursor term=bold cterm=bold gui=bold
aug end
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
set backupdir^=.vim/backups,$vim/backups,$home/.vim/backups
set backupext=.~
set undofile
set undodir^=.vim/undo,$vim/undo,$home/.vim/undo
set swapfile
set directory^=.vim/swaps,$vim/swaps,$home/.vim/swaps
setg tags+=.tags,tags
setg tags+=./\.?*/.tags;,./\.?*/tags;
setg tags+=./*/.tags;,./*/tags;
setg tags+=~/.cache/.tags,~/.cache/tags

let g:vim_indent_cont = 4

function! TryApplyColorSchemes(colorschemes)
    set background=dark
    for scheme in a:colorschemes
        try
            exec 'colorscheme' scheme
            return scheme
        catch
        endtry
    endfor
endfunction

let g:default_colorschemes = ['one', 'onedark', 'molokai', 'desert']

function! ApplyDefaultColorScheme()
    set background=dark
    call TryApplyColorSchemes(g:default_colorschemes)
endfunction

if !exists('s:first_load_general')
	let s:first_load_general = 1

        call ApplyDefaultColorScheme()

	" let g:airline_theme = 'ayu_mirage'
	" if exists(':AirlineTheme')
	" AirlineTheme ayu_mirage
	" endif

	" colorscheme molokai
	" colorscheme onedark
	" colorscheme one

	" colorscheme gruvbox9
	"let g:airline_theme = 'onedark'
	"AirlineTheme onedark
	"endif
endif

