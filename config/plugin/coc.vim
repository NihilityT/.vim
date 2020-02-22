function! CocAddExtension(extension)
    if a:0 == 0 | return | endif
    if exists('*coc#add_extension')
        call call(coc#add_extension, a:000)
    else
        let g:coc_global_extensions = get(g:, 'coc_global_extensions', [])
        call extend(g:coc_global_extensions, a:000)
    endif
endfunction

call SetupCommandAlias('C', 'CocConfig')
call SetupCommandAlias('CL', 'CocList')

augroup coc-custom
	autocmd!
augroup END

let g:coc_status_error_sign   = '•'
let g:coc_status_warning_sign = '•'

call CocAddExtension('coc-marketplace')

call CocAddExtension('coc-tsserver')
call CocAddExtension('coc-eslint')

call CocAddExtension('coc-json')
call CocAddExtension('coc-html')
call CocAddExtension('coc-css')
call CocAddExtension('coc-wxml')

call CocAddExtension('coc-vimlsp')
call CocAddExtension('coc-yaml')

call CocAddExtension('coc-snippets')
"call CocAddExtension('coc-git')
"nmap [c <Plug>(coc-git-prevchunk)
"nmap ]c <Plug>(coc-git-nextchunk)

call CocAddExtension('coc-highlight')
" autocmd coc-custom CursorHold * silent call CocActionAsync('highlight')

let s:python = {}
function! s:python.install_lsp(...)
    let C = get(a:, 1)
    let job = job_start('pip install python-language-server', {
        \ 'exit_cb': { job, v -> v == 0 && !empty('C') ? call(C, []) : 0 }
        \})
endfunction
function! s:python.add_to_coc(...)
    let C = get(a:, 1)
    call CocAddExtension('coc-python')
    if !empty(C)
        call call(C, [])
    endif
endfunction
function! s:python.add(...)
    if executable('pip')
        let job = job_start('pip show python-language-server -qq', {
            \ 'exit_cb': { job, v ->
            \               v == 0 ? 
            \                   s:python.add_to_coc() :
            \                   s:python.install_lsp(s:python.add_to_coc)
            \ }
            \})
    endif
endfunction
call s:python.add()

let s:ruby = {}
function! s:ruby.install_lsp(...)
    let C = get(a:, 1)
    let job = job_start('gem install solargraph', {
        \ 'exit_cb': { job, v -> v == 0 && !empty('C') ? call(C, []) : 0 }
        \})
endfunction
function! s:ruby.add_to_coc(...)
    let C = get(a:, 1)
    call CocAddExtension('coc-solargraph')
    if !empty(C)
        call call(C, [])
    endif
endfunction
function! s:ruby.add(...)
    if executable('gem')
        let job = job_start('gem list -i --silent solargraph', {
            \ 'exit_cb': { job, v ->
            \               v == 0 ? 
            \                   call(s:python.add_to_coc, []) :
            \                   call(s:python.install_lsp,
            \                        [s:python.add_to_coc])
            \ }
            \})
    endif
endfunction
call s:ruby.add()

call CocAddExtension('coc-lists')
call CocAddExtension('coc-svg')
call CocAddExtension('coc-vimtex')
call CocAddExtension('coc-dictionary')
call CocAddExtension('coc-tag')
call CocAddExtension('coc-word')
call CocAddExtension('coc-syntax')

"call CocAddExtension('coc-pairs')
"call CocAddExtension('coc-prettier')

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <S-TAB> <Plug>(coc-range-select)
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

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[p` and `]p` to navigate diagnostics
nmap <silent> [p <Plug>(coc-diagnostic-prev)
nmap <silent> ]p <Plug>(coc-diagnostic-next)

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
	"autocmd CursorHoldI call CocActionAsync('showSignatureHelp')
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

function! CocConfig(section, value)
    if exists('*coc#config')
        call coc#config(a:section, a:value)
    else
        let g:coc_user_config = get(g:, 'coc_user_config', {})
        let g:coc_user_config[a:section] = a:value
    endif
endfunction

"call CocConfig('json.schemas', [
    "\ {
    "\   "name": "compile commands",
    "\   "fileMatch": ["compile_commands.json"],
    "\   "url": fnamemodify($vim, ':gs,\,/,').'/compile_commands.schema.json',
    "\ },
    "\])

call CocConfig('languageserver.ccls.initializationOptions.cache.directory',
    \          expand("~/.cache/ccls"))
