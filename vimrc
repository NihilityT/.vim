language messages zh_CN.utf-8
let $NVIM_COC_LOG_LEVEL='debug'

let $vim = fnamemodify(resolve(expand('<sfile>:p')), ':h')
set runtimepath^=$vim

source $vim/base.vim
source $config/mappings.vim
source $config/abbrevs.vim
source $config/commands.vim
source $config/utils.vim

source $config/addplugin.vim

source $config/plugins.vim

source $config/general.vim
