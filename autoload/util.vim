function! util#cd_root(...)
	let root_wild = get(g:, 'root_wild', ['.git', '.vim', '*.sln'])
	let curdir = get(a:, 1, expand('%:h'))
	let root_file = glob(curdir.'/'.'{'.join(root_wild, ',').'}')
	if root_file !=# ''
		exec 'lcd' curdir
	else
		let parentdir = fnamemodify(curdir, ':h')
		if parentdir ==# curdir
			exec 'lcd' expand('%:h')
		else
			return util#cd_root(parentdir)
		endif
	endif
endfunction

" utils {{{
function! util#exec(funcname, ...)
	if exists('b:'.a:funcname)
		return call(get(b:, a:funcname), a:000)
	elseif exists('g:'.a:funcname)
		return call(get(g:, a:funcname), a:000)
	elseif exists('*'.a:funcname)
		return call(a:funcname, a:000)
	endif
endfunction
" utils}}}

" format {{{
function! util#format()
	let l:view = winsaveview()
	normal gg=G
	call winrestview(l:view)
endfunction

function! util#remove_tail_space()
	let l:view = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:view)
endfunction
" format }}}


" compile {{{
function s:contain(obj, list)
	let splited = split(a:list, '\s*,\s*')
	return index(splited, a:obj) >= 0
endfunction

function! s:compose_by(key, list)
	let composed = ''
	for [keys; values] in a:list
		if s:contain(a:key, keys)
			let composed .= join(values, ' ').' '
		endif
	endfor
	return trim(composed)
endfunction

function! s:get_current_exe_path()
	return expand('%:p:~:.:r:s?^[^/~]?./\0?')
endfunction

function! s:get_current_exe_input_path()
	return fnamemodify(s:get_current_exe_path(), ':s?$?.in?')
endfunction

function! s:exists_input_file()
	return filereadable(s:get_current_exe_input_path())
endfunction

function! s:get_compile_cmd()
	let compile_config = get(b:, 'compile_config', s:get_default_compile_config())
	return s:compose_by(&filetype, compile_config)
endfunction

function! s:src_is_update()
	let l:exe_time = getftime(exepath(s:get_current_exe_path()))
	let l:src_time = getftime(expand('%:p'))

	return l:exe_time < l:src_time
endfunction

function! s:no_filename()
	return expand("%:t") == ''
endfunction


function s:get_default_compile_config()
	return [
		\	['c', 'gcc', '-std=c99'],
		\	['cpp', 'g++', '-std=c++11'],
		\	['c,cpp', '-W -Wall -O2 -D _OFFLINE_ "%" -o "%:r"'],
		\]
endfunction

function! util#exec_by_make(cmd)
	let win_id = win_getid()
	let makeprgbak = &l:makeprg
	let &l:makeprg = a:cmd
	silent make!
	copen
	let &l:makeprg = makeprgbak
	call win_gotoid(win_id)
endfunction

if !exists('g:exec_compile_fn')
	let g:exec_compile_fn = 'util#exec_by_make'
endif

if !exists('g:exec_run_fn')
	let g:exec_run_fn = 'util#exec_by_make'
endif

function util#exec_compile(cmd)
	return util#exec('exec_compile_fn', a:cmd)
endfunction

function util#exec_run(cmd)
	return util#exec('exec_run_fn', a:cmd)
endfunction

function! util#compile()
	up
	if s:src_is_update()
		call util#force_compile()
	endif
endfunction

function! util#force_compile()
	up
	let b:compile_cmd = s:get_compile_cmd()
	return util#exec_compile(b:compile_cmd)
endfunction

function! util#run()
	let b:run_cmd = shellescape(s:get_current_exe_path())

	call util#exec_run(b:run_cmd)
endfunction

function! util#input_run()
	let b:run_cmd = shellescape(s:get_current_exe_path())
	if s:exists_input_file()
		let b:run_cmd .= ' < '.shellescape(s:get_current_exe_input_path())
	endif

	call util#exec_run(b:run_cmd)
endfunction

" compile }}}
