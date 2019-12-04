function! ApplyPlugins()
	for [repo, options] in items(g:plugins_config)
		call dein#add(repo, options)
	endfor
endfunction

function! AddPluginNM(repo, ...)
	call AddPlugin(a:repo, extend({'merged': 0}, get(a:, 1, {})))
endfunction

call AddPlugin('yianwillis/vimcdoc')

call AddPlugin('altercation/vim-colors-solarized')
call AddPlugin('tomasr/molokai')
call AddPlugin('joshdick/onedark.vim')
call AddPlugin('mengelbrecht/lightline-bufferline')
call AddPlugin('taigacute/gruvbox9')
call AddPlugin('itchyny/landscape.vim')

call AddPlugin('itchyny/lightline.vim')
call AddPlugin('mengelbrecht/lightline-bufferline')

call AddPluginNM('neoclide/coc.nvim', {
	\'rev': 'release',
	\})
	"\'build': 'yarn install --frozen-lockfile',

call AddPlugin('junegunn/vim-easy-align')

call AddPlugin('easymotion/vim-easymotion')
call AddPlugin('scrooloose/nerdtree', {
	\'on_cmd': 'NERDTreeToggle',
	\})

call AddPlugin('Yggdroot/LeaderF', {
	\'build': expand('./install'.(g:system.isWindows ? '.bat': '.sh')),
	\})

call AddPlugin('skywind3000/asyncrun.vim')

call AddPlugin('tpope/vim-repeat')

call AddPlugin('tpope/vim-surround')

call AddPlugin('octol/vim-cpp-enhanced-highlight')
call AddPlugin('LucHermitte/lh-vim-lib')
call AddPlugin('luchermitte/vimfold4c')

call AddPlugin('neoclide/jsonc.vim')
call AddPlugin('chemzqm/wxapp.vim', {
	\'on_ft': ['wxml', 'wxss', 'wxs'],
	\})
call AddPlugin('honza/vim-snippets')

call AddPlugin('scrooloose/nerdcommenter')
call AddPlugin('tpope/vim-fugitive')
call AddPlugin('airblade/vim-gitgutter')

call AddPlugin('kana/vim-textobj-user')
call AddPlugin('kana/vim-textobj-indent')
call AddPlugin('kana/vim-textobj-syntax')
call AddPlugin('kana/vim-textobj-function') " , {'for':['c', 'cpp', 'vim', 'java']}
call AddPlugin('sgur/vim-textobj-parameter')

" call AddPlugin('luochen1990/rainbow')


"call AddPlugin('terryma/vim-multiple-cursors')

"call AddPlugin('MarcWeber/vim-addon-mw-utils')
"call AddPlugin('tomtom/tlib_vim')
"call AddPlugin('garbas/vim-snipmate')

"call AddPlugin('iamcco/markdown-preview.nvim', {
"\'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
"\'build': 'cd app & yarn install',
"\})
"call AddPlugin('jiangmiao/auto-pairs')
" call AddPlugin('alvan/vim-closetag')
" call AddPlugin('NihilityT/Pairs')

" other
if executable('ctags') == 1
	""call AddPlugin('ludovicchabant/vim-gutentags')
endif
" call AddPlugin('w0rp/ale')
" call AddPlugin('jeffkreeftmeijer/vim-numbertoggle')
"call AddPlugin('pangloss/vim-javascript')


if &compatible
	set nocompatible
endif

set runtimepath^=$dein_dir

" dein {{{
" git@github.com:Shougo/dein.vim.git
if empty(glob('$dein_dir/.git'))
	exec '!git clone --depth=1 https://github.com/Shougo/dein.vim.git '.$dein_dir
endif
if empty(glob('$dein_dir/.git'))
    finish
endif

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
syntax on
" dein }}}

