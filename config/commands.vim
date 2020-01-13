function! UpdateConfig()
    if !executable('git')
        return 0
    else
        if exists('*job_start')
            let job = job_start('git -C "'.expand('$vim').'" pull --rebase', {
                \   "in_io": "null",
                \   "out_io": "null",
                \   "err_io": "null",
                \   'exit_cb': { job, status ->
                \       !status ?
                \           execute('source $vimrc | echom ''update config succeed.''') :
                \           execute('echom ''update config failed.''')
                \   },
                \})
            return job_status(job) != 'fail'
        else
            system('git -C "'.expand('$vim').'" pull --rebase')
            if v:shell_error
                source $vimrc
                echom 'update config succeed.' 
                return 1
            else
                echom 'update config failed.'
                return 0
            endif
        endif
    endif
endfunction

command UpdateConfig call UpdateConfig()
