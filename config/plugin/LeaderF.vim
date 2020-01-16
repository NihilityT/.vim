let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.cache')
let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'one'
" let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_MruMaxFiles = 2048
let g:Lf_RecurseSubmodules = 1

if (exists('*popup_create') && has('patch-8.1.2000')) || has('nvim-0.4')
	let g:Lf_WindowPosition = 'popup'
	let g:Lf_PopupColorscheme = 'default'
endif

let g:Lf_ShortcutF = '<Leader>sf'
let g:Lf_ShortcutB = '<Leader>sb'
nnoremap <silent> <Leader>sB :<C-U>LeaderfBufferAll<CR>
nnoremap <silent> <Leader>sm :<C-U>LeaderfMru<CR>
nnoremap <silent> <Leader>sd :<C-U>LeaderfFunction<CR>
nnoremap <silent> <Leader>sD :<C-U>LeaderfFunctionAll<CR>
nnoremap <silent> <Leader>st :<C-U>LeaderfTag<CR>
nnoremap <silent> <Leader>sT :<C-U>LeaderfTagAll<CR>
nnoremap <silent> <Leader>sl :<C-U>LeaderfLine<CR>
nnoremap <silent> <Leader>sL :<C-U>LeaderfLineAll<CR>
nnoremap <silent> <Leader>s: :<C-U>LeaderfHistoryCmd<CR>
nnoremap <silent> <Leader>s/ :<C-U>LeaderfHistorySearch<CR>
