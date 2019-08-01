let g:system              = {}
let g:system['isWindows'] = has('win16') || has('win32') || has('win64')
let g:system['isLinux']   = has('unix') && !has('macunix') && !has('win32unix')
let g:system['isOSX']     = has('macunix')

let $vim               = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let $vimrc             = expand('$vim/vimrc')

let $config            = expand('$vim/config')
let $plugin_config_dir = expand('$config/plugin')

let $bundle            = expand('$vim/bundle')
let $dein_dir          = expand('$bundle/repos/github.com/Shougo/dein.vim')
let $plug_dir          = expand('$bundle/vim-plug')
