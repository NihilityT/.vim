function! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() =~# ''\v^:*\s*\V'.a:from.''')'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAlias('w!!', 'w !sudo tee > /dev/null %')


inoreabbrev thsi this
inoreabbrev slient silent
inoreabbrev Licence License
inoreabbrev accross across
inoreabbrev cosnt const
