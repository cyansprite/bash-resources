let g:tmpVimDebug = ""
let g:tmpScratch  = ""

echom g:tmpVimDebug
echom g:tmpScratch


com! -nargs=0 -bang -complete=customlist,GitListComplete
           \ SneakVimDebug cal s:OpenMessageTemp()

func! EnterVim()
    let g:tmpVimDebug = tempname()
    let g:tmpScratch  = tempname()
    exe "redir > " . g:tmpVimDebug
    map <leader>v :SneakVimDebug<cr>
endfun

func! s:OpenMessageTemp()
    redir end
    exe "pedit " . g:tmpVimDebug
    exe "redir >> " . g:tmpVimDebug
    wincmd P
    set ma noma
    nnoremap <buffer>x <c-w>z
    nnoremap <buffer>w :w ~/
endfun

func! s:OpenScratchTemp()
    g:tmpScratch
endfun
