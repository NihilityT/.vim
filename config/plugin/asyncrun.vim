let g:asyncrun_open = 8
nnoremap <F10> :call asyncrun#quickfix_toggle(10)<cr>
nnoremap <silent> <F9> :AsyncRun g++ -Wall -O2 -std=c++11 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"
"nnoremap <silent> <F5> :AsyncRun -cwd=$(VIM_FILEDIR) -mode=4 "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
call SetupCommandAlias('M', 'Make')

let g:exec_compile_fn = 'ExecByAsyncRun'
let g:exec_run_fn = 'ExecByAsyncRun'

function! ExecByAsyncRun(cmd)
	exec 'AsyncRun' a:cmd
endfunction
