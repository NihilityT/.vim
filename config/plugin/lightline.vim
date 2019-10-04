let g:lightline = get(g:, 'lightline', {})
let g:lightline.colorscheme = 'onedark'
call extend(g:lightline, {
	\ 'active': {
	\   'left': [
	\     [ 'mode', 'paste', 'git-branch', ],
	\     [
	\       'git-status',
	\       'cocstatus', 'currentfunction',
	\       'readonly', 'filename',
	\     ],
	\     [
	\     ],
	\   ],
	\   'right': [
	\     [ 'winsize', 'percent', 'lineinfo' ],
	\     [ 'fileformat', 'fileencoding', 'filetype' ],
	\     [ 'git-blame', 'asyncrun-code', 'asyncrun-status', ],
	\   ],
	\ },
	\ 'component': {
	\   'lineinfo': '%l/%L:%2c%-V',
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
	\   'currentfunction': 'CocCurrentFunction',
	\   'git-blame': 'LightlineGitBlame',
	\   'git-status': 'LightlineGitStatus',
	\   'git-branch': 'LightlineGitBranch',
	\   'mode': 'LightlineMode',
	\   'asyncrun-status': 'LightlineAsyncRunStatus',
	\   'asyncrun-code': 'LightlineAsyncRunCode',
	\   'winsize': 'LightlineWinSize',
	\ },
	\})

function! LightlineMode()
	let fname = expand('%:t')
	return fname == '__Tagbar__' ? 'Tagbar' :
		\ fname == 'ControlP' ? 'CtrlP' :
		\ fname == '__Gundo__' ? 'Gundo' :
		\ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
		\ fname =~ 'NERD_tree' ? 'NERDTree' :
		\ &ft == 'unite' ? 'Unite' :
		\ &ft == 'vimfiler' ? 'VimFiler' :
		\ &ft == 'vimshell' ? 'VimShell' :
		\ mode(1)
		"\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CocCurrentFunction() abort
	return get(b:, 'coc_current_function', '')
endfunction

function! LightlineGitBranch() abort
	let branch = get(g:, 'coc_git_status', '')
	return winwidth(0) >= 75 ? branch : ''
endfunction

function! LightlineGitStatus() abort
	let status = trim(get(b:, 'coc_git_status', ''))
	return winwidth(0) >= 85 ? status : ''
endfunction

function! LightlineGitBlame() abort
	let blame = get(b:, 'coc_git_blame', '')
	return winwidth(0) >= 100 ? blame : ''
endfunction

function! LightlineAsyncRunStatus() abort
	let status = get(g:, 'asyncrun_status', '')
	return winwidth(0) >= 85 ? status : ''
endfunction

function! LightlineAsyncRunCode() abort
	let code = get(g:, 'asyncrun_code', '')
	return winwidth(0) >= 85 ? code : ''
endfunction

function! LightlineWinSize() abort
	return winwidth(0) >= 100 ? winheight(0).'x'.winwidth(0) : ''
endfunction

augroup lightline-custom
	au!
	autocmd Syntax * call lightline#enable()
augroup END
