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
