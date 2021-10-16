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

