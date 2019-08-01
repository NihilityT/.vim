let g:airline#extensions#tabline#enabled=1

augroup PowerlineFonts
	au!
	autocmd VimEnter *
		\ if !get(g:, 'airline_powerline_fonts', 0) && getfontname() =~? 'powerline'
		\|	let g:airline_powerline_fonts = getfontname() =~? 'powerline'
		\|	let g:airline_left_sep      = "\ue0b0"
		\|	let g:airline_left_alt_sep  = "\ue0b1"
		\|	let g:airline_right_sep     = "\ue0b2"
		\|	let g:airline_right_alt_sep = "\ue0b3"
		\|	call extend(g:airline_symbols, {
		\	  'readonly': "\ue0a2",
		\	  'whitespace': "\u2632",
		\	  'linenr': "\u2630 ",
		\	  'maxlinenr': " \ue0a1",
		\	  'branch': "\ue0a0",
		\	  'notexists': "\u0246",
		\	  'crypt': nr2char(0x1F512),
		\	})
		\|endif
augroup END


let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree']
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_tab_count = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 2

let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_idx_mode = 1
