let g:lightline = get(g:, 'lightline', {})
let g:lightline.colorscheme = 'onedark'

function! LightlineExtend(key, value)
    let g:lightline = get(g:, 'lightline', {})
    let g:lightline[a:key] = get(g:lightline, a:key, {})
    call extend(g:lightline[a:key], a:value)
endfunction
call LightlineExtend('active', {
	\   'left': [
	\       [ 'mode', 'paste', 'git-branch', ],
	\       [
	\         'cocstatus', 'currentfunction',
	\         'window-type', 'readonly', 'filename',
	\       ],
	\       [
        \         'plugin-progress',
	\       ],
	\   ],
	\   'right': [
	\       [ 'git-status', 'winsize', 'percent', 'lineinfo' ],
	\       [ 'fileformat', 'fileencoding', 'filetype' ],
	\       [ 'git-blame', 'asyncrun-code', 'asyncrun-status', ],
	\   ],
	\})
call LightlineExtend('inactive', {
	\   'left': [
	\       [ 'window-type', 'filename' ],
	\   ],
	\   'right': [
	\       [ 'winsize', 'percent', 'lineinfo' ],
	\       [ 'fileformat', 'fileencoding', 'filetype' ],
	\       [ 'git-blame', 'asyncrun-code', 'asyncrun-status', ],
	\   ],
	\})
call LightlineExtend('component', {
	\   'lineinfo': '%l/%L:%2c%-V',
	\})
call LightlineExtend('component_function', {
	\   'cocstatus': 'coc#status',
	\   'currentfunction': 'CocCurrentFunction',
	\   'git-blame': 'LightlineGitBlame',
	\   'git-status': 'LightlineGitStatus',
	\   'git-branch': 'fugitive#head',
	\   'mode': 'LightlineMode',
	\   'asyncrun-status': 'LightlineAsyncRunStatus',
	\   'asyncrun-code': 'LightlineAsyncRunCode',
	\   'winsize': 'LightlineWinSize',
        \   'window-type': 'LightlineWindowType',
        \   'plugin-progress': 'LightlinePluginProgress',
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
	let st = GitGutterGetHunkSummary()
        let status = ['+:'.st[0], '~:'.st[1], '-:'.st[2]]
	return winwidth(0) >= 85 ? join(status, ' ') : ''
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

function! LightlineWindowType() abort
    return &previewwindow ? 'P' : "" " empty(getloclist(winnr())) ? 'L' : ''
endfunction

function! LightlinePluginProgress() abort
    let success = match(dein#get_progress(), 'You may have') >= 0
    return success ? '' : dein#get_progress() 
endfunction

augroup lightline-custom
	au!
	autocmd Syntax,ColorScheme * silent! call lightline#enable()
	autocmd BufWritePost lightline*.vim silent! call lightline#enable()
augroup END
