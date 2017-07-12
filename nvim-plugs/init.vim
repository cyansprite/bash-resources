"Plug, colo
    if(has("unix"))
        set termguicolors
        so ~/.config/nvim/plug.vim
    else
        so ~\AppData\Local\nvim\plug.vim
    endif
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175
    colo chill

"Begin Vim set
    "Those that use macros
    set sol nosol            " Moving to the start of the line every jump is stupid
    set cursorline           " set cursorline to highlight the current line I'm no
    set showmode noshowmode  " don't show mode in cmd line, I hate when it clears an echo
    set expandtab            " Expands tab to spaces
    set splitbelow           " when split, split below the window instead of above
    set splitright           " when vsplit, splt to the right instead of left
    set showcmd              " Show cmd while typing
    set ignorecase smartcase " in the name
    set smartcase            " makes things a bit better
    set smartindent          " indent things well
    set smarttab             " tab plays nicer
    set nowrap               " I really hate wrap
    set nowrapscan           " I don't like my searches to continue forever
    set list                 " list my chars╳│

    "Those that use =
    set fillchars=vert:\|,stlnc:-,stl:\ ,fold:-,diff: " set fill chars to things that make me happy
    set listchars=tab:→\ ,trail:·,extends:<,precedes:> " Changes listchars to more suitable chars
    set viewoptions=cursor                             " What to save with mkview
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
    cmap <c-x> <c-r>x
    cmap <c-d> <c-r>d
    cmap <c-s> <c-r>s
    cmap <c-q> <c-r>+
    cmap <c-.> <c-r>.
    cmap <c-j> <down>
    cmap <c-k> <up>
    cmap <c-h> <left>
    cmap <c-l> <right>

    "Buffer movement
    map <m-n> :bn<cr>
    map <m-N> :bp<cr>
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
    inoremap <silent><c-y> <esc>"ygpa
    inoremap <silent><c-x> <esc>"xgpa
    inoremap <silent><C-q> <esc>"+gpa
    inoremap <silent><C-s> <esc>"cgpa
    inoremap <silent><C-d> <esc>"dgpa
    inoremap <silent><C-.> <esc>".gpa
    inoremap <silent><C-*> <esc>"*gpa
    nnoremap <silent>x "xx
    nnoremap <silent>X "xX
    nnoremap <silent>c "cc
    nnoremap <silent>C "cC
    nnoremap <silent>d "dd
    nnoremap <silent>D "dD

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

    hi holdSearch guifg=none guibg=#4a5f58 gui=none
    set updatetime=300
    func! HighlightOnHold()
        try
            exec printf("2match holdSearch \/%s\/", expand("<cword>"))
        catch /.*/
            echo "Ignoring match error :: " v:exception
        endtry
    endfun

    func! KillWhitespace()
        exec "%s/\\s\\+$//g"
    endf
    command! -nargs=0 Kws call KillWhitespace()

    " TODO Make this a command so it can accept a filter
    noremap <Leader>T :noautocmd vimgrep /TODO/j **/*.cs<CR>:cw<CR>.

    augroup init
        autocmd!
        autocmd CursorHold * call HighlightOnHold()
        autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
        autocmd WinEnter * cal EnterWin()
        autocmd BufWinLeave * cal LeaveBufWin()
        autocmd BufWinEnter * cal EnterBufWin()
        autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
