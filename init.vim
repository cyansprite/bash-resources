"Plug, colo, and cursor shape.
    so ~\AppData\Local\nvim\plug.vim
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175
    colo chill
"    let g:python3_host_prog='C:\Users\brand\AppData\Local\Programs\Python\Python36\py.exe'
"    let g:python_host_prog='C:\Python27\python.exe'

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
    set nowrapscan
    set list                " list my chars╳│

    "Those that use =
    set fillchars=vert:\|,stlnc:-,stl:\ ,fold:-,diff: " set fill chars to things that make me happy
    set listchars=tab:→\ ,trail:·,extends:┇,precedes:┇ " Changes listchars to more suitable chars
    set viewoptions=cursor,folds                       " What to save with mkview
    set foldcolumn=0                                   " foldcolumn... noty
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

    " TODO Make this a command so it can accept a filter
    noremap <Leader>T :noautocmd vimgrep /TODO/j **/*.cs<CR>:cw<CR>.

    "Cycle error list like a boss
    map <f4> :cp<cr>
    map <f5> :cn<cr>

    "movement while in insert mode
    imap <c-j> <down>
    imap <c-k> <up>
    imap <c-h> <left>
    imap <c-l> <right>
    xmap <c-j> <down>
    xmap <c-k> <up>
    xmap <c-h> <left>
    xmap <c-l> <right>
    cmap <c-v> <c-r>"
    cmap <c-x> <c-r>x
    cmap <c-d> <c-r>d
    cmap <c-s> <c-r>s
    cmap <c-q> <c-r>+
    cmap <c-.> <c-r>.
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
    inoremap <silent><c-x> <esc>"xgpa
    inoremap <silent><C-q> <esc>"+gpa
    inoremap <silent><C-s> <esc>"cgpa
    inoremap <silent><C-d> <esc>"dgpa
    inoremap <silent><C-.> <esc>".gpa

    "I uh... don't use ESC
    inoremap  
    vnoremap  
    nnoremap x "xx
    nnoremap X "xX
    nnoremap c "cc
    nnoremap C "cC
    nnoremap d "dd
    nnoremap D "dD

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
        if &modifiable && filereadable("%")
            mkview
        endif
    endfun

    func! EnterBufWin()
        if &modifiable && filereadable(&viewdir .'/~=+.config=+nvim=+'.expand('%:t').'=')
            silent loadview
        endif
    endfun

    func! HighlightOnHold()
        try
            exec printf("match holdSearch \/%s\/", expand("<cword>"))
        catch /.*/
            echo "Ignoring match error :: " v:exception
        endtry
    endfun

    hi holdSearch guifg=none guibg=#4a5f58 gui=none
    set updatetime=300
    au! CursorHold * call HighlightOnHold()

    set hlsearch

    augroup init
        autocmd!
        autocmd WinEnter * cal EnterWin()
        autocmd BufWinLeave * cal LeaveBufWin()
        autocmd BufWinEnter * cal EnterBufWin()
    augroup END
"End    Aucmd   -------------------------
