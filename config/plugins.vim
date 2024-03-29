source $vim/config/addplugin.vim

function! ApplyPlugins()
    for [repo, options] in items(g:plugins_config)
        call dein#add(repo, options)
    endfor
endfunction

function! AddPluginNoMerge(repo, ...)
    call AddPlugin(a:repo, extend({'merged': 0}, get(a:, 1, {})))
endfunction

" call AddPlugin('yianwillis/vimcdoc')
" 
" colorscheme {{{
call AddPlugin('altercation/vim-colors-solarized')
call AddPlugin('tomasr/molokai')
call AddPlugin('joshdick/onedark.vim')
call AddPlugin('poiuto/gruvbox9')
call AddPlugin('itchyny/landscape.vim')
call AddPlugin('rakr/vim-one')
" }}}

call AddPlugin('itchyny/lightline.vim')
call AddPlugin('mengelbrecht/lightline-bufferline', {
    \   'depends': 'lightline.vim'
    \})

call AddPluginNoMerge('neoclide/coc.nvim', {
    \   'if': executable('node'),
    \   'rev': 'release',
    \})
 "\'build': 'yarn install --frozen-lockfile',
" call AddPlugin('jackguo380/vim-lsp-cxx-highlight')
" 
" call AddPlugin('junegunn/vim-easy-align')
" 
" call AddPlugin('easymotion/vim-easymotion')

" file tree {{{
call AddPlugin('scrooloose/nerdtree', {
    \   'on_cmd': 'NERDTreeToggle',
    \})
call AddPlugin('Xuyuanp/nerdtree-git-plugin', {
    \   'depends': 'nerdtree',
    \   'on_source': 'nerdtree',
    \})
" }}}


" https://github.com/haasosaurus/nerd-fonts/tree/regen-mono-font-fix/patched-fonts/Hack/Regular/complete
call AddPlugin('ryanoasis/vim-devicons', {
    \   'depends': ['nerdtree', 'nerdtree-git-plugin'],
    \   'on_source': ['nerdtree', 'nerdtree-git-plugin'],
    \})
" call AddPlugin('tiagofumo/vim-nerdtree-syntax-highlight', {
"     \   'depends': ['vim-devicons', 'nerdtree'],
"     \   'on_source': ['vim-devicons', 'nerdtree'],
"     \})
" 
" call AddPlugin('airblade/vim-rooter', {
"     \
"     \})
" 
" call AddPlugin('Yggdroot/LeaderF', {
"     \   'if': has('python') || has('python3'),
"     \   'build': expand('./install'.(g:system.isWindows ? '.bat': '.sh')),
"     \})
" 
" call AddPlugin('skywind3000/asyncrun.vim')
" 
" call AddPlugin('tpope/vim-repeat')
" 
 call AddPlugin('tpope/vim-surround')
" 
" call AddPlugin('octol/vim-cpp-enhanced-highlight')
" call AddPlugin('LucHermitte/lh-vim-lib')
" call AddPlugin('luchermitte/vimfold4c', {
"     \   'depends': 'lh-vim-lib',
"     \})
" 
" call AddPlugin('neoclide/jsonc.vim')
" call AddPlugin('chemzqm/wxapp.vim', {
"     \   'on_ft': ['wxml', 'wxss', 'wxs'],
"     \})
" call AddPlugin('honza/vim-snippets')
" 
" call AddPlugin('scrooloose/nerdcommenter')
" 
" git {{{
call AddPlugin('tpope/vim-fugitive')
call AddPlugin('airblade/vim-gitgutter', { 'lazy': 1, 'on_event': 'VimEnter' })
" call AddPlugin('junegunn/gv.vim')
" }}}
" 
" text object {{{
call AddPlugin('kana/vim-textobj-user')
call AddPlugin('kana/vim-textobj-indent')
call AddPlugin('kana/vim-textobj-syntax')
call AddPlugin('kana/vim-textobj-function') " , {'for':['c', 'cpp', 'vim', 'java']}
call AddPlugin('sgur/vim-textobj-parameter')
" }}}

" call AddPlugin('nathanaelkane/vim-indent-guides')

" highlight {{{
call AddPluginNoMerge('sheerun/vim-polyglot')
" }}}
" 
call AddPlugin('NihilityT/UnderCursor')
" " call AddPlugin('luochen1990/rainbow')
" 
" 
" "call AddPlugin('terryma/vim-multiple-cursors')
" 
" "call AddPlugin('MarcWeber/vim-addon-mw-utils')
" "call AddPlugin('tomtom/tlib_vim')
" "call AddPlugin('garbas/vim-snipmate')
" 
" "call AddPlugin('iamcco/markdown-preview.nvim', {
" "\'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
" "\'build': 'cd app & yarn install',
" "\})
" call AddPlugin('jiangmiao/auto-pairs')
" call AddPlugin('andymass/vim-matchup')
" " packadd! matchit
" 
" " call AddPlugin('alvan/vim-closetag')
" " call AddPlugin('NihilityT/Pairs')
" 
" " other
" " https://github.com/universal-ctags/ctags
" if executable('ctags') == 1
"     call AddPlugin('ludovicchabant/vim-gutentags')
" endif
" " call AddPlugin('w0rp/ale')
" " call AddPlugin('jeffkreeftmeijer/vim-numbertoggle')
" "call AddPlugin('pangloss/vim-javascript')
" 
" dein {{{
" git@github.com:Shougo/dein.vim.git

function! ExistPluginManager()
    return !empty(glob('$dein_dir/.git'))
endfunction

function! ThrowIfGitNotExist()
    if !executable('git')
        throw "git don't exist, can't install plugin manager"
    endif
endfunction

function! InstallPluginManager()
    "let s:init_dein = 1
    call ThrowIfGitNotExist()
    exec '!git clone --depth=1 https://github.com/Shougo/dein.vim.git '.$dein_dir
endfunction

function! InstallPluginManagerIfNotExist()
    if ExistPluginManager()
        return
    endif
    call InstallPluginManager()
endfunction

call InstallPluginManagerIfNotExist()
if !ExistPluginManager()
    finish
endif

if &compatible
    set nocompatible
endif
set runtimepath+=$dein_dir

if dein#load_state($bundle)
    call dein#begin($bundle)

    call dein#add($dein_dir)
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call ApplyPlugins()

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#tap('lightline.vim')
    let g:dein#install_progress_type = 'none'
endif

let s:bundle_gitkeep_path = expand('$bundle/.gitkeep')
let s:bundle_gitkeep_modify_time_sec = getftime(s:bundle_gitkeep_path)
let s:current_time_sec = strftime('%Y%m%d')
let s:seven_days_sec = 7 * 24 * 60 * 60
if s:current_time_sec > s:bundle_gitkeep_modify_time_sec + s:seven_days_sec
    if dein#check_install()
        call dein#install()
    else
        call dein#update()
    endif
    call writefile([], s:bundle_gitkeep_path)
endif

" dein }}}

command! -nargs=* PUpdate call dein#update(<args>)
command! -nargs=* PInstall call dein#install(<args>)
