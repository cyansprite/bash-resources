" open entry in a new horizontal window
nnoremap <silent> <buffer> s <C-w><CR>

" open entry in a new tab.
nnoremap <silent> <buffer> t <C-w><CR><C-w>T

" open entry and come back
nnoremap <silent> <buffer> o <CR><C-w>p

" open entry and close the location/quickfix window.
nnoremap <silent> <buffer> O <CR>:lclose \| cclose<CR>
set buflisted nobuflisted
