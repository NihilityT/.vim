set lines=40
set columns=120

set guioptions-=m " Hide menu bar.
set guioptions-=T " Hide toolbar
set guioptions-=L " Hide left-hand scrollbar
set guioptions-=r " Hide right-hand scrollbar
set guioptions-=b " Hide bottom scrollbar
set guioptions-=e " Hide tab
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

function! s:escape_font(font, option_lst)
    let font_name = a:font
    if empty(a:option_lst)
        return font_name
    else
        if g:system.isWindows
            return font_name.':'.join(a:option_lst, ':')
        else
            let height = matchstr(a:option_lst, '^h')
            if empty(height)
                return font_name
            else
                if g:system.isOSX
                    return font_name.height
                else
                    return font_name.' '.height[1:]
                endif
            endif
        endif
    endif
endfunction

let s:font_list = []
call add(s:font_list, s:escape_font('Hack NF', ['h11']))
call add(s:font_list, s:escape_font('Hack Nerd Font Mono', ['h11']))
call add(s:font_list, s:escape_font('Hack Nerd Font', ['h11']))
call add(s:font_list, s:escape_font('Hack', ['h11']))
call add(s:font_list, s:escape_font('DejaVuSansMono NF', ['h11']))
call add(s:font_list, s:escape_font('DejaVu Sans Mono for Powerline', ['h11']))
call add(s:font_list, s:escape_font('Monaco', ['h12']))
call add(s:font_list, s:escape_font('Consolas', ['h12']))

let &guifont = join(s:font_list, ',')
