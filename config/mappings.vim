let mapleader = ' '

" config
nnoremap <silent> <Leader>cr :source   $vimrc<CR>
nnoremap <silent> <Leader>ce :edit     $vimrc<CR>
" copy
noremap  <silent> <Leader>v "+
nnoremap <silent> <Leader>vY :%y +<CR>
vnoremap <silent> <Leader>vY :y  +<CR>
noremap  <silent> <Leader>p "0p
noremap  <silent> <Leader>P "0P
noremap  <silent> <Leader>gp "0g
noremap  <silent> <Leader>gP "0gP

noremap <silent> <Leader>bd  :<C-u>bd<CR>
noremap <silent> <Leader>bn  :<C-u>bn<CR>
noremap <silent> <Leader>bp  :<C-u>bp<CR>
noremap <silent> <Leader>bl  :<C-u>ls<CR>
noremap <silent> <Leader>bb  :<C-u>ls<CR>:b
noremap <silent> <Leader>bs  :<C-u>sp<CR>
noremap <silent> <Leader>bv  :<C-u>vs<CR>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <C-a> <Home>
inoremap <A-a> <C-a>
inoremap <C-e> <End>
inoremap <A-e> <C-e>

cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-_> <C-k>
cnoremap <C-l> <Right>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-f> <C-d>

noremap  <A-h> <C-w>h
noremap  <A-j> <C-w>j
noremap  <A-k> <C-w>k
noremap  <A-l> <C-w>l
noremap  <A-c> <C-w>c
noremap  <A-o> <C-w>o
noremap  <A-]> <C-w>]

noremap 0 ^
noremap ^ 0

noremap <silent> <Leader>W  :w!!<CR>
noremap <silent> <Leader>w  :w<CR>

noremap n /<cr>
noremap N ?<cr>

function s:text_browsing()
    if exists('#text-browsing#CursorMoved')
        noremap j jzz
        noremap k kzz
        noremap <c-o> <c-o>zz
        noremap <c-i> <c-i>zz
        " noremap <expr> n 'Nn'[v:searchforward].'zz'
        " noremap <expr> N 'nN'[v:searchforward].'zz'
        noremap n /<cr>zz
        noremap N ?<cr>zz
    endif
endfunction

" call s:text_browsing()

nnoremap [e :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e :<c-u>execute 'move +'. v:count1<cr>

nnoremap [<space> :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space> :<c-u>put =repeat(nr2char(10), v:count1)<cr>

nnoremap <silent> <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

xnoremap < <gv
xnoremap > >gv

nnoremap <silent> <Leader>=  :call     util#format()<CR>

nnoremap          <Leader>:  "oY:<C-r>=substitute(@o, '\v^\s+\|\_s+$', '', 'g')<CR>
vnoremap          <Leader>:  "oy:<C-r>=substitute(@o, '\v^\s+\|\_s+$', '', 'g')<CR>

nnoremap <leader>m :<c-u><c-r><c-r>='let @'.v:register.' = '.string(getreg(v:register))<cr><c-f><left>

function! IsCharCode(str)
    let charcode_ptns = [
        \   '\v^\d+$',
        \   '\v^\\[0-8]{3}$',
        \   '\v^\\[1-8][0-8]{1,2}$',
        \   '\v\c^\\x[0-9a-f]{1,2}$',
        \   '\v\c^\\x[1-9a-f]$',
        \   '\v^\\u\c[0-9a-f]{1,4}$',
        \   '\v^\\U\c[0-9a-f]{1,8}$',
        \]
    for ptn in charcode_ptns
        if a:str =~# ptn
            return 1
        endif
    endfor
    return 0
endfunction

function! CharCodeUnderCursor()
    let line = getline('.')
    let col = col('.')
    let match = matchstrpos(line, '\v'.
        \                   '%<'.(col + 1).'c'.
        \                   '\c(\\[ux]?)?[0-9a-f]*[0-9a-f]+'.
        \                   '%>'.col.'c'
        \)
    return IsCharCode(match[0]) ? match : []
endfunction

function! CharCode2Char(charcode)
    let start_with_oct = '^\\\d'
    let start_with_hex = '^\\[xu]'
    if a:charcode =~# start_with_oct
        let dec = str2nr(a:charcode[1:], 8)
    elseif a:charcode =~# start_with_hex
        let dec = str2nr(a:charcode[2:], 16)
    else
        let dec = str2nr(a:charcode, 10)
    endif
    return nr2char(dec)
endfunction

function! EscapeChar(char)
    let map = {
        \ "\b": '\b',
        \ "\e": '\e',
        \ "\f": '\f',
        \ "\n": '\n',
        \ "\r": '\r',
        \ "\t": '\t',
        \ "\\": '\',
        \ "\"": '"',
        \}
    return get(map, a:char, a:char)
endfunction

function! LiteralChar(char)
    let map = {
        \ "\b": 'BS',
        \ "\e": 'Esc',
        \ "\f": 'FF',
        \ "\n": 'NL',
        \ "\r": 'CR',
        \ "\t": 'Tab',
        \}
    return get(map, a:char, a:char)
endfunction

function! EscapeString(string)
  return substitute(a:string,
      \ "[\b\e\f\n\r\t\\\"]", '\=EscapeChar(submatch(0))', 'g')
endfunction

function! EchoCharUnderCursor()
    let charcode_strpos = CharCodeUnderCursor()
    if empty(charcode_strpos)
        return trim(execute('ascii'))
    else
        let char = CharCode2Char(charcode_strpos[0])
        let dec = char2nr(char)
        return printf('<%s>  %d,  Hex %x,  Octal %o', LiteralChar(char), dec, dec, dec)
    endif
endfunction

nnoremap <silent> ga :<C-u>echo EchoCharUnderCursor()<Esc>
nnoremap <silent> <expr> <leader>ga
    \ (empty(CharCodeUnderCursor()) ? 's' : 'ciw').
    \ '<c-r>=IsCharCode(@") ? EscapeChar(CharCode2Char(@")) : char2nr(@")<cr><esc>'
vnoremap <silent> ga
    \ s<c-r>=IsCharCode(@") ? EscapeChar(CharCode2Char(@")) : char2nr(@")<cr><esc>

noremap <expr> <Leader>, getline('.') =~ '\s$' ? '$ge<Right>C;<Esc>' : 'A;<Esc>'
noremap <expr> <Leader>; getline('.') =~ '\s$' ? '$ge<Right>C;<Esc>' : 'A;<Esc>'

nnoremap g[ `[v`]
nnoremap <Leader>< <C-W><
nnoremap <Leader>> <C-W>>
nnoremap <Leader>- <C-W>-
nnoremap <Leader>+ <C-W>+

noremap <silent> <leader>l :<C-u>let &conceallevel = &conceallevel ? 0 : 1<CR>:set conceallevel?<CR>

nnoremap <F5>   :call util#compile()<CR>
nnoremap <C-F5> :call util#force_compile()<CR>

nnoremap <F6>   :call util#run()<CR>
nnoremap <C-F6> :call util#input_run()<CR>

nnoremap <F7>   :call util#compile_run()<CR>
nnoremap <C-F7> :call util#compile_input_run()<CR>


function! VariableNameUnderCursor()
    let word_under_cursor_pattern = '\v%<'.(col('.') + 1).'c[-_[:alnum:]]+%>'.col('.').'c'
    return matchstrpos(getline('.'), word_under_cursor_pattern)
endfunction
function! ChangeVariableNameUnderCursor()
    let strpos = VariableNameUnderCursor()
    let begin_col = strpos[1]
    let varname_len = strpos[2] - strpos[1]
    return '0'.begin_col.'lc'.varname_len.'l'
endfunction

function! ToPascal(str)
    return substitute(a:str, '\v%([_-]|^)(.)', '\u\1', 'g')
endfunction
function! ToCamel(str)
    return substitute(ToPascal(a:str), '\v\C^[A-Z]', '\l\0', 'g')
endfunction
function! ToSnake(str)
    return substitute(ToCamel(a:str), '\v\C([a-z])([A-Z])', '\1_\l\2', 'g')
endfunction
function! ToKebab(str)
    return substitute(ToSnake(a:str), '_', '-', 'g')
endfunction

nnoremap <silent> <expr> <leader>tp ChangeVariableNameUnderCursor().
    \ ToPascal(VariableNameUnderCursor()[0]).'<Esc>'
nnoremap <silent> <expr> <leader>tc ChangeVariableNameUnderCursor().
    \ ToCamel(VariableNameUnderCursor()[0]).'<Esc>'
nnoremap <silent> <expr> <leader>ts ChangeVariableNameUnderCursor().
    \ ToSnake(VariableNameUnderCursor()[0]).'<Esc>'
nnoremap <silent> <expr> <leader>tk ChangeVariableNameUnderCursor().
    \ ToKebab(VariableNameUnderCursor()[0]).'<Esc>'

vnoremap <silent> <leader>tp s<C-r>=ToPascal(@")<CR><Esc>
vnoremap <silent> <leader>tc s<C-r>=ToCamel(@")<CR><Esc>
vnoremap <silent> <leader>ts s<C-r>=ToSnake(@")<CR><Esc>
vnoremap <silent> <leader>tk s<C-r>=ToKebab(@")<CR><Esc>
