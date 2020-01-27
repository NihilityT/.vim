nmap <Leader>tt :NERDTreeToggle<CR>
nmap <Leader>tT :NERDTreeToggleVCS<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree() abort
    if &modifiable && !&diff &&
        \ exists('g:NERDTree') && g:NERDTree.IsOpen()
        \ && filereadable(expand('%:p'))
        NERDTreeFind
        wincmd p
    endif
endfunction

" Highlight currently open buffer in NERDTree
augroup NERDTree-custom
    autocmd!
    autocmd BufEnter * call SyncTree()
augroup end
