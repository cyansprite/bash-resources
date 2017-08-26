"Plug, colo {{{
    if(has("unix"))
        " set termguicolors
        so ~/.config/nvim/plug.vim
    else
        so ~\AppData\Local\nvim\plug.vim
    endif
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    colo chill
    " change if you have a light bg for terminal. (don't use a space between =)
    set bg=dark
    "}}}

"Begin Vim set {{{
    "Those that use macros
    set sol nosol                                      " Moving to the start of the line every jump is stupid
    set cursorline                                     " set cursorline to highlight the current line I'm on
    " set showmode noshowmode                            " don't show mode in cmd line, I hate when it clears an echo
    set expandtab                                      " Expands tab to spaces
    set splitbelow                                     " when split, split below the window instead of above
    set splitright                                     " when vsplit, splt to the right instead of left
    set showcmd                                        " Show cmd while typing in bottom right corner
    set ignorecase smartcase                           " in the name
    set smartcase                                      " makes things a bit better
    set smartindent                                    " indent things well
    set smarttab                                       " tab plays nicer
    set nowrap                                         " I really hate wrap
    set nowrapscan                                     " I don't like my searches to continue forever
    set list                                           " list my chars╳│
    set undofile                                       " keep undo history ina file
    set foldmethod=marker                              " fold stuff :)
    set foldopen+=jump                                 " open folds when I jump to things as well but not all...
    set colorcolumn=80,130                             " color columns
    set textwidth=80                                   " text width
    set icm="split"

   " Those that use =
    set fillchars=vert:\|,stlnc:-,stl:\ ,fold:-,diff: " set fill chars to things that make me happy
    set listchars=tab:→\ ,trail:·,extends:<,precedes:> " Changes listchars to more suitable chars
    set viewoptions=cursor                             " What to save with mkview
    set foldcolumn=0                                   " foldcolumn... yes
    set mouse=a                                        " I sometimes jump around with this
    set shiftwidth=4                                   " Use indents of 4 spaces
    set cindent                                        " Match c type files
    set tabstop=4                                      " An indentation every four columns
    set softtabstop=4                                  " Let backspace delete indent
    let &showbreak = '↳ '                              " Change show break thing (rare occasion I use wrap)
    set showmatch                                      " Show matching brackets/parentthesis
    set matchtime=1                                    " Show matching time
    set visualbell                                     " Please don't make noises
    " set report=0                                       " Always report changed lines
    set complete=.,w,b,u,U,i,d,]                       " Complete more...
    if &modifiable | set number | endif                " If it's modifable, turn on numbers
    set wildmode=longest,full                          " Let's make it nice tab completion
    set undolevels=99999                               " A lot of undo history :P
"End Vim set }}}

"Begin Vim map {{{
    " map K and <c-z> to something useful...
    "I don't use space so...here it is
    map <space> <leader>
    map <cr> ggzz
    " Does anyone actually use single quote?
    map ' `

    "Cycle error list like a boss
    map <f4> :cp<cr>
    map <f5> :cn<cr>

    "movement while in insert mode, xmode and command mode
    imap <c-j> <down>
    imap <c-k> <up>
    imap <c-h> <left>
    imap <c-l> <right>
    xmap <c-j> <down>
    xmap <c-k> <up>
    xmap <c-h> <left>
    xmap <c-l> <right>
    cmap <c-v> <c-r>"
    cmap <m-w> \s\+$

    "Buffer movement
    map <m-h> :hid<cr>
    map <m-w> :bw<cr><cr>

    "[Pre/App]end to the word under the cursor
    map <m-a> ea
    map <m-i> bi

    "Paste from clipboard
    map <m-p> "+p
    map <m-P> "+P

    "pasting
    inoremap <silent><c-v> <esc>gpa
    inoremap <CR> <C-]><C-G>u<CR>

    "I uh... don't use ESC
    inoremap  
    vnoremap  
    nnoremap  

    "Search and replace word under cursor
    nnoremap <F6> :%s/<C-r><C-w>/
    nnoremap <F7> :%s/\<<C-r><C-w>\>/

    "c-hjkl for window movement
    nnoremap <silent> <c-k> :wincmd k<CR>
    nnoremap <silent> <c-j> :wincmd j<CR>
    nnoremap <silent> <c-h> :wincmd h<CR>
    nnoremap <silent> <c-l> :wincmd l<CR>

    "I like playing with colors (Gives me hi-lo ids)
    map <leader>1 :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"End Vim Map }}}

"Aucmd {{{
    let g:doGoldRatioActive=0
    let g:GoldRatio=1.6
    let g:doAutoNumInActive=0
    let g:killInactiveCursor=1
    let g:doAutoWrap=0
    let g:dynamicStatusLine=0

    function! EnterWin()
        let curWinIndex = winnr()
        let windowCount = winnr('$')
        let ratio = &columns/g:GoldRatio

        exec printf("set scroll=%d",float2nr(winheight(winnr()) * 0.3))

        for i in range(1,winnr('$'))
            if( i != curWinIndex )
                wincmd w
                if(g:doGoldRatioActive && (&modifiable || (&lines-winheight(curWinIndex) != 3)))
                    let minRatio = float2nr(ratio/windowCount)

                    cal setwinvar(i,"&winminwidth",minRatio)
                    cal setwinvar(i,"&winwidth",minRatio)
                endif
                if(g:doAutoNumInActive)
                    setlocal number nonumber
                    setlocal relativenumber norelativenumber
                endif
                if(g:killInactiveCursor)
                    set cursorline nocursorline
                endif
            endif
        endfor

        wincmd w
        if(&modifiable && &buftype != 'terminal')
            if(g:doGoldRatioActive)
                exec printf("vertical resize %d", float2nr(ratio))
            endif
            if(g:killInactiveCursor)
                set cursorline
            endif
            if(g:doAutoNumInActive)
                setlocal number
            endif
            if(g:doAutoWrap)
                setlocal wrap nowrap
            endif
        endif
    endfunction

    func! LeaveBufWin()
        if &modifiable && filereadable(expand("%"))
            mkview
        endif
    endfun

    func! EnterBufWin()
        if &modifiable && filereadable(&viewdir .'/~=+.config=+nvim=+'.expand('%:t').'=')
            loadview
        endif
    endfun

    func! GitGrep(...)
        let save = &grepprg
        set grepprg=git\ grep\ -n\ $*
        let s = 'grep'
        for i in a:000
            let s = s . ' ' . i
        endfor
        exe s
        let &grepprg = save
    endfun
    command! -nargs=? G call GitGrep(<f-args>)
    command! -nargs=0 W write

    " hi holdSearch guifg=none guibg=#4a5f58 gui=none
    " set updatetime=500
    " func! HighlightOnHold()
    "     try
    "         "echo expand("<cword>")
    "         exec printf("2match holdSearch \/\\<%s\\>\/", expand("<cword>"))
    "     catch /.*/
    "     endtry
    " endfun

    func! KillWhitespace()
        exec "%s/\\s\\+$//g"
    endf
    command! -nargs=0 Kws call KillWhitespace()

    let g:term_buf = 0
    function! Term_toggle()
        if g:term_buf == bufnr("")
            setlocal bufhidden=hide
            hide
        else
            exec printf("botright %dnew", winheight(winnr()) * 10 / 30)
            try
                exec "buffer ".g:term_buf
            catch
                term
                let g:term_buf = bufnr("")
            endtry
            startinsert!
        endif
    endfunction

    function! GetNextBuffer()
        let l:curbuf = bufnr("")
        let l:newbuf = 0
        let l:firstbuf = 0
        for buf in getbufinfo({'buflisted': 1})
            if !empty(buf.windows) || l:curbuf == buf.bufnr || buf.hidden
                continue
            endif

            if l:firstbuf == 0
                let l:firstbuf = buf.bufnr
            endif

            if l:curbuf > buf.bufnr
                let l:newbuf = buf.bufnr
                continue
            else
                exec "buffer". buf.bufnr
                return
            endif
        endfor
        if l:firstbuf != 0
            exec "buffer". firstbuf
        endif
    endfunction

    function! GetPrevBuffer()
        let l:curbuf = bufnr("")
        let l:newbuf = 0
        let l:firstbuf = 0
        for buf in reverse(getbufinfo({'buflisted': 1}))
            if !empty(buf.windows) || l:curbuf == buf.bufnr || buf.hidden
                continue
            endif

            if l:firstbuf == 0
                let l:firstbuf = buf.bufnr
            endif

            if l:curbuf < buf.bufnr
                let l:newbuf = buf.bufnr
                continue
            else
                exec "buffer". buf.bufnr
                return
            endif
        endfor
        if l:firstbuf != 0
            exec "buffer". firstbuf
        endif
    endfunction

    noremap <silent> <m-t> :silent call Term_toggle()<cr>
    tnoremap <silent> <m-t> <C-\><C-n>:silent call Term_toggle()<cr>
    nmap <silent> <m-n> :call GetNextBuffer()<cr>
    nmap <silent> <m-N> :call GetPrevBuffer()<cr>

    augroup init
        autocmd!
        " autocmd CursorHold * call HighlightOnHold()
        autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
        autocmd WinEnter * cal EnterWin()
        autocmd BufWinLeave * cal LeaveBufWin()
        autocmd BufWinEnter * cal EnterBufWin()
        autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"}}}

function! SuperSexyFoldText() "{{{
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = printf("%s", lines_count)
    let foldchar = " "
    let foldtextstart = strpart('' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = ' ( ' . repeat(" ", 5 - len(lines_count_text)) . lines_count_text . repeat(" ", 2) . "lines" . '   )  '
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return '....' . repeat('.', winwidth('.') / 4) . " " . line . repeat(foldchar, winwidth('.') / 3 - len(line)) . foldtextend . repeat(".", winwidth('.'))
endfunction
set foldtext=SuperSexyFoldText()
" }}}
