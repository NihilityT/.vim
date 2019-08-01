set lines=40
set columns=100

set guioptions-=m " Hide menu bar.
set guioptions-=T " Hide toolbar
set guioptions-=L " Hide left-hand scrollbar
set guioptions-=r " Hide right-hand scrollbar
set guioptions-=b " Hide bottom scrollbar
set guioptions-=e " Hide tab
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

if g:system.isWindows
	set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT,Monaco:h12,Consolas:h12
elseif g:system.isOSX
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11,Monaco:h12,Consolas:h12
else
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11,Monaco\ 12,Consolas\ 12
endif
