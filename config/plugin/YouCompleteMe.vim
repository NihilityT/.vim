let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
set completeopt=menu,menuone,noselect
let g:ycm_global_ycm_extra_conf = expand('$HOME/.ycm_extra_conf.py')

let g:ycm_semantic_triggers =  {
	\      'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
	\      'cs,lua,javascript,typescript': ['re!\w{2}'],
	\}

let g:ycm_filetype_whitelist = {
	\      "c":1,
	\      "cpp":1,
	\      "objc":1,
	\      "javascript":1,
	\      "typescript":1,
	\      "sh":1,
	\      "zsh":1,
	\      "zimbu":1,
	\}
