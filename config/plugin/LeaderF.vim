let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git', '.vim']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
"let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''
nnoremap <Leader>sf :LeaderfFile<cr>
nnoremap <Leader>sb :LeaderfBuffer<cr>
nnoremap <Leader>sm :LeaderfMru<cr>
nnoremap <Leader>sd :LeaderfFunction!<cr>
nnoremap <Leader>st :LeaderfTag<cr>

