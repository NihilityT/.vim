augroup vimrc
	au!
	au BufWritePost $vimrc,$vim/*.vim source <afile>
	au BufRead,BufNewFile
		\ *vimrc,*.vim,$vimrc
		\ setf vim | setl foldmethod=marker
	au FileType
		\ vim
		\ setl expandtab softtabstop=4 shiftwidth=4
augroup END

augroup HTML
	au!
	" au BufRead,BufNewFile *.wxml setf xml
	" au BufRead,BufNewFile *.wxss setf css
	au FileType
		\ javascript,typescript,html,css,xml,wxml
		\ setl expandtab softtabstop=4 shiftwidth=4
augroup END

augroup JavaScript
	au!
	" au BufRead,BufNewFile *.wxs setf javascript
	autocmd FileType javascript let &l:cino = ':0,l1,(0,Ws,j1,J1'
augroup END

function s:clear_highlight()
    if exists('s:highlight_word_under_cursor_id')
        silent! call matchdelete(s:highlight_word_under_cursor_id)
    endif
endfunction

function s:highlight_pattern(pattern, ...)
    let l:priority = get(a:, 1, 0)
    let l:hi_group = 'highlight_word_under_cursor'
    exe 'hi default '.l:hi_group.' term=underline cterm=underline gui=underline'
    if exists('s:highlight_word_under_cursor_id')
        call matchadd(l:hi_group, a:pattern, l:priority, s:highlight_word_under_cursor_id)
    else
        let s:highlight_word_under_cursor_id = matchadd(l:hi_group, a:pattern, l:priority)
    endif
endfunction

function! s:highlight_content_under_select()
    if mode() == "v"
        let [l:line_start, l:column_start] = getpos('v')[1:2]
        let [l:line_end, l:column_end] = getpos('.')[1:2]
        if l:line_start > l:line_end ||
            \ l:line_start == l:line_end && l:column_start > l:column_end
            let [l:line_start, l:column_start, l:line_end, l:column_end] =
                \ [l:line_end, l:column_end, l:line_start, l:column_start]
        endif

        call s:clear_highlight()
        let l:lines = getline(line_start, line_end)
        if !empty(lines)
            let l:lines[-1] = lines[-1][:column_end - 1]
            let l:lines[0] = lines[0][column_start - 1:]
            let l:content = trim(join(l:lines, "\n"))
            if !empty(l:content)
                let l:ptn = printf('\V\c%s', escape(l:content, '\'))
                call s:highlight_pattern(l:ptn)
            endif
        endif
    endif
endfunction

function! s:highlight_word_under_cursor()
    let l:cur_line = getline('.')
    let l:cur_col = col('.')
    let l:word = matchstr(l:cur_line, '\v\w*%'.l:cur_col.'c\w+')

    call s:clear_highlight()
    if !empty(l:word)
        let l:ptn = printf('\V\(\w\)\@<!%s\(\w\)\@!', escape(l:word, '\'))
        call s:highlight_pattern(l:ptn)
    endif
endfunction

augroup HighlightWordUnderCursor
    au!
    autocmd CursorHold,CursorHoldI * call s:highlight_word_under_cursor()
    autocmd CursorMoved * call s:highlight_content_under_select()
augroup End
