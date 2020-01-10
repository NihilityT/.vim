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

noremap  <C-h> <Left>
noremap  <C-j> <Down>
noremap  <C-k> <Up>
noremap  <C-l> <Right>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <C-a> <Home>
inoremap <C-A> <C-a>
inoremap <C-e> <End>
inoremap <C-E> <C-e>

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

noremap <silent> <Leader>W  :w!!<CR>
noremap <silent> <Leader>w  :w<CR>

noremap <silent> <Leader>nh  :noh<CR>

nnoremap <silent> <Leader>=  :call     util#format()<CR>

nnoremap          <Leader>:  "oY:<C-r>=substitute(@o, '\v^\s+\|[[:blank:]\r\n]+$', '', 'g')<CR>
vnoremap          <Leader>:  "oy:<C-r>=substitute(@o, '\v^\s+\|[[:blank:]\r\n]+$', '', 'g')<CR>
" todo
noremap  <silent> <Leader>ga s<C-R>= nr2char('<C-R>"') ?
	\                                nr2char('<C-R>"') :
	\                                char2nr('<C-R>"')<CR><Esc>

noremap <expr> <Leader>, getline('.') =~ '\s$' ? '$ge<Right>C;<Esc>' : 'A;<Esc>'
noremap <expr> <Leader>; getline('.') =~ '\s$' ? '$ge<Right>C;<Esc>' : 'A;<Esc>'

nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

nnoremap g[ `[v`]
nnoremap <Leader>< <C-W><
nnoremap <Leader>> <C-W>>
nnoremap <Leader>- <C-W>-
nnoremap <Leader>+ <C-W>+

noremap <leader>l :<C-u>let &conceallevel = &conceallevel ? 0 : 1<CR>

nnoremap <F5>   :call util#compile()<CR>
nnoremap <C-F5> :call util#force_compile()<CR>

nnoremap <F6>   :call util#run()<CR>
nnoremap <C-F6> :call util#input_run()<CR>

nnoremap <F7>   :call util#compile_run()<CR>
nnoremap <C-F7> :call util#compile_input_run()<CR>
