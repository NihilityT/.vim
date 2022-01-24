function! TryApplyColorSchemes(colorschemes)
    set background=dark
    for scheme in a:colorschemes
        try
            exec 'colorscheme' scheme
            return scheme
        catch
        endtry
    endfor
endfunction

let g:default_colorschemes = ['one', 'onedark', 'molokai', 'desert']

function! ApplyDefaultColorScheme()
    set background=dark
    call TryApplyColorSchemes(g:default_colorschemes)
endfunction

if !exists('s:first_load_general')
	let s:first_load_general = 1

        call ApplyDefaultColorScheme()

	" let g:airline_theme = 'ayu_mirage'
	" if exists(':AirlineTheme')
	" AirlineTheme ayu_mirage
	" endif

	" colorscheme molokai
	" colorscheme onedark
	" colorscheme one

	" colorscheme gruvbox9
	"let g:airline_theme = 'onedark'
	"AirlineTheme onedark
	"endif
endif

function s:matchdelete(group)
    call map(filter(getmatches(), 'v:val.group == '''.a:group.''''), 'matchdelete(v:val.id)')
endfunction

function s:matchadd(group, pattern)
    call s:matchdelete(a:group)
    call matchadd(a:group, a:pattern)
endfunction

highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
augroup ExtraWhitespace
	au!
	autocmd BufWinEnter * call s:matchadd('ExtraWhitespace', '\s\+$')
	autocmd BufWinLeave * call s:matchdelete('ExtraWhitespace')
	autocmd InsertEnter * call s:matchadd('ExtraWhitespace', '\s\+\%#\@<!$')
	autocmd InsertLeave * call s:matchadd('ExtraWhitespace', '\s\+$')
augroup END
