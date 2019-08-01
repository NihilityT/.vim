let g:ale_linters_explicit           = 1
let g:ale_echo_delay                 = 20
let g:ale_lint_delay                 = 500
let g:ale_completion_delay           = 500
let g:ale_echo_msg_format            = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed       = 'normal'
let g:ale_lint_on_insert_leave       = 1
let g:ale_close_preview_on_insert    = 1

let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always         = 1
let g:ale_sign_error                 = '●'
let g:ale_sign_warning               = g:ale_sign_error
"let g:ale_sign_error = 'X'
"let g:ale_sign_warning = '-'

exec 'hi ALEWarning cterm=underline gui=underline'.
	\ substitute(execute('hi SpellCap'), '^.* xxx', ' ', 'g')

let g:ale_c_gcc_options              = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options            = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options         = ''
let g:ale_cpp_cppcheck_options       = ''
let g:ale_linters                    = {
	\   'cpp': ['gcc'],
	\   'c': ['gcc'],
	\   'python': ['pylint'],
	\   'javascript': ['eslint'],
	\}
