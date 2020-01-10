let mapleader = ' '

" config
nnoremap <silent> <Leader>cr :source   $vimrc<CR>
nnoremap <silent> <Leader>ce :edit     $vimrc<CR>
noremap  <silent> <Leader>DD :%d
" copy
noremap  <silent> <Leader>v "+
nnoremap <silent> <Leader>vY :%y +<CR>
vnoremap <silent> <Leader>vY :y  +<CR>
noremap  <silent> <Leader>" "0

noremap <silent> <Leader>bd  :bd<CR>
noremap <silent> <Leader>bn  :bn<CR>
noremap <silent> <Leader>bp  :bp<CR>
noremap <silent> <Leader>bl  :ls<CR>
noremap <silent> <Leader>bb  :ls<CR>:b
noremap <silent> <Leader>bs  :sp<CR>
noremap <silent> <Leader>bv  :vs<CR>

map     <silent> <Leader>bW  :w!!<CR>
noremap <silent> <Leader>bw  :w<CR>

noremap <silent> <Leader>nh  :noh<CR>

nnoremap <silent> <Leader>=  :call     util#format()<CR>
nnoremap          <Leader>o  "oyy:<C-r>=substitute(@o, '\v^\s+\|\s+$', '', 'g')<CR>
vnoremap          <Leader>o  "oy:<C-r>=substitute(@o, '\v^\s+\|\s+$', '', 'g')<CR>
noremap  <silent> <Leader>ga s<C-R>= nr2char('<C-R>"') ?
	\                                nr2char('<C-R>"') :
	\                                char2nr('<C-R>"')<CR><Esc>
nnorema <silent> <Leader>, :<C-u>keeppatterns s/\v\s*$/,<CR>
nnorema <silent> <Leader>; :<C-u>keeppatterns s/\v\s*$/;<CR>

nnoremap g[ `[v`]
nnoremap <Leader>< <C-W><
nnoremap <Leader>> <C-W>>
nnoremap <Leader>- <C-W>-
nnoremap <Leader>+ <C-W>+

map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

nnoremap <F5> :call util#compile()<CR>
nnoremap <C-F5> :call util#force_compile()<CR>

nnoremap <F6> :call util#run()<CR>
nnoremap <C-F6> :call util#input_run()<CR>

nnoremap <F7> :call util#compile_run()<CR>
nnoremap <C-F7> :call util#compile_input_run()<CR>
