function! s:get_highlight(group)
    redir => l:hi_content
    sil exe 'hi' a:group
    redir END
    return substitute(trim(l:hi_content), '\v^\S+\s+xxx', '', '')
endfunction

function! s:highlight_gitgutter()
    exe 'hi GitGutterAdd' s:get_highlight('LineNr')
    hi GitGutterAdd ctermfg=LightGreen guifg=LightGreen

    exe 'hi GitGutterChange' s:get_highlight('LineNr')
    hi GitGutterChange ctermfg=Yellow guifg=Yellow

    exe 'hi GitGutterDelete' s:get_highlight('LineNr')
    hi GitGutterDelete ctermfg=LightRed guifg=LightRed

    exe 'hi GitGutterChangeDelete' s:get_highlight('LineNr')
    hi GitGutterChangeDelete ctermfg=Red guifg=Red
endfunction

aug vim-gitgutter
    au!
    au Syntax,ColorScheme * silent! call s:highlight_gitgutter()
aug end
