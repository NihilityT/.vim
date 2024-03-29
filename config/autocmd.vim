augroup vimrc
	au!
	au BufWritePost $vimrc,$vim/*.vim,$vim/*vimrc source <afile>
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

augroup JSON
	au!
	autocmd FileType json,jsonc let &l:sw=4 | let &l:sts=4 | setl et
augroup END

augroup PowerShell
	au!
	autocmd FileType ps1 set bomb
	autocmd BufWritePre *.ps1 set bomb
augroup END
