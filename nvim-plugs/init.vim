"Plug, colo
    so ~/.config/nvim/plug.vim
    set termguicolors
    colo chill

"Begin Vim set
    "Those that use macros
    set sol nosol           " Moving to the start of the line every jump is stupid
    set cursorline          " set cursorline to highlight the current line I'm no
    set showmode noshowmode " don't show mode in cmd line, I hate when it clears an echo
    set expandtab           " Expands tab to spaces
    set splitbelow          " when split, split below the window instead of above
    set splitright          " when vsplit, splt to the right instead of left
    set showcmd             " Show cmd while typing
    set ignorecase          " in the name
    set smartcase           " makes things a bit better
    set smartindent         " indent things well
    set smarttab            " tab plays nicer
    set nowrap              " I really hate wrap
    set nowrapscan          " I don't like my searches to continue forever
    set list                " list my chars╳│

    "Those that use =
    set fillchars=vert:\|,stlnc:-,stl:\ ,fold:-,diff: " set fill chars to things that make me happy
    set listchars=tab:→\ ,trail:·,extends:┇,precedes:┇ " Changes listchars to more suitable chars
    set viewoptions=cursor,folds                       " What to save with mkview
    set foldcolumn=0                                   " foldcolumn... yes
    set mouse=a                                        " I sometimes jump around with this
    set shiftwidth=4                                   " Use indents of 4 spaces
    set tabstop=4                                      " An indentation every four columns
    set softtabstop=4                                  " Let backspace delete indent
    let &showbreak = '↳ '                              " Change show break thing
    set showmatch                                      " Show matching brackets/parentthesis
    set matchtime=1                                    " Show matching time
    set report=0                                       " Always report changed lines
    set title titlestring=%P                           " titlestring needs to be something for the below to work
    if &modifiable | set number | endif                " If it's modifable, turn on numbers
    auto BufEnter * let &titlestring = "NVIM│%f│%h%m%r%y "
"End Vim set

"Begin Vim map
    "I don't use space so...here it is
    map <space> <leader>

    "Cycle error list like a boss
    map <f3> :cp<cr>
    map <f4> :cn<cr>

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
    cmap <c-j> <down>
    cmap <c-k> <up>
    cmap <c-h> <left>
    cmap <c-l> <right>

    "Temporary quick term and terminal stuff
    map <F12> :10split \| terminal<cr>
    tmap <F12> <C-\><C-n>:hide<cr>
    tmap <c-h> <C-\><C-n><c-w><left>
    tmap <c-j> <C-\><C-n><c-w><down>
    tmap <c-k> <C-\><C-n><c-w><up>
    tmap <c-l> <C-\><C-n><c-w><right>

    "Buffer movement
    map <m-n> :bn<cr>
    map <m-N> :bp<cr>
    map <m-h> :hid<cr>
    map <m-w> :bw<cr><cr>
    map <silent><m-k> 5k
    map <silent><m-j> 5j
    map <silent><m-e> 5<c-e>
    map <silent><m-y> 5<c-y>
    "[Pre/App]end to the word under the cursor
    map <m-a> ea
    map <m-i> bi

    "Paste from clipboard
    map <m-p> "+p
    map <m-P> "+P

    "pasting undoing
    inoremap <silent><c-v> <esc>gpa
    inoremap <silent><c-q> <esc>"gpa

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
    map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"End Vim Map

"Aucmd
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

    func GitGrep(...)
        let save = &grepprg
        set grepprg=git\ grep\ -n\ $*
        let s = 'grep'
        for i in a:000
            let s = s . ' ' . i
        endfor
        exe s
        let &grepprg = save
    endfun
    command -nargs=? G call GitGrep(<f-args>)

    autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

    func KillWhitespace()
        exec "%s/\\s\\+$//g"
    endf
    command -nargs=0 Kws call KillWhitespace()


    augroup init
        autocmd!
        autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
        autocmd WinEnter * cal EnterWin()
        autocmd BufWinLeave * cal LeaveBufWin()
        autocmd BufWinEnter * cal EnterBufWin()
