augroup format_set
	au!
	"au BufWritePre * call Format()
	"au BufWritePre * call util#remove_tail_space()
augroup END

augroup CD_ROOT_DIR
	let g:root_wild = get(g:, 'root_wild', ['.git', '.vim', '*.sln'])
	au!
	"autocmd BufNewFile,BufRead * call util#cd_root()
augroup END

