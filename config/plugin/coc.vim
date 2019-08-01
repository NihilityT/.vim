nnoremap <silent> <Leader>cc :EditConfig coc.vim<CR>


function! AddCocExtension(extension)
	if exists('*coc#add_extension')
		call coc#add_extension(a:extension)
	else
		let g:coc_global_extensions = get(g:, 'coc_global_extensions', [])
		call add(g:coc_global_extensions, a:extension)
	endif
endfunction

call SetupCommandAlias('C', 'CocConfig')
call SetupCommandAlias('CL', 'CocList')

augroup coc-custom
	autocmd!
augroup END

let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'

call AddCocExtension('coc-marketplace')

call AddCocExtension('coc-tsserver')
call AddCocExtension('coc-eslint')

call AddCocExtension('coc-json')
call AddCocExtension('coc-html')
call AddCocExtension('coc-css')
call AddCocExtension('coc-wxml')

call AddCocExtension('coc-vimlsp')
call AddCocExtension('coc-yaml')

call AddCocExtension('coc-snippets')
call AddCocExtension('coc-git')
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)

call AddCocExtension('coc-highlight')
autocmd coc-custom CursorHold * silent call CocActionAsync('highlight')

call AddCocExtension('coc-python')
call AddCocExtension('coc-lists')
call AddCocExtension('coc-svg')
call AddCocExtension('coc-vimtex')
call AddCocExtension('coc-dictionary')
call AddCocExtension('coc-tag')
call AddCocExtension('coc-word')
call AddCocExtension('coc-syntax')

call AddCocExtension('coc-pairs')
"call AddCocExtension('coc-prettier')

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ?
	\   "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
	\"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup coc-custom
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Using CocList
" Resume latest coc list
nnoremap <silent> <space>clr  :<C-u>CocListResume<CR>
" Show all diagnostics
nnoremap <silent> <space>cld  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>cle  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>clc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>clo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>cls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>cn  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>cp  :<C-u>CocPrev<CR>
