language messages zh_CN.utf-8
setg encoding=utf-8
setg fileencodings=utf-8,gbk,ucs-bom,cp936
setg fileformats=unix,dos

" let $NVIM_COC_LOG_LEVEL='debug'

let $vim = fnamemodify(resolve(expand('<sfile>:p')), ':h')

source $vim/base.vim
source $vim/config/mappings.vim
source $vim/config/abbrevs.vim
source $vim/config/commands.vim
source $vim/config/utils.vim

source $vim/config/addplugin.vim
source $vim/config/plugins.vim

source $vim/config/autocmd.vim
source $vim/config/general.vim
