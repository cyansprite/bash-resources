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
    " Set: Those that use macros
    set backup | set writebackup " back it up, the file, I mean.
    set nocursorline             " set cursorline to highlight NOTHING
    set expandtab                " Expands tab to spaces
    set ignorecase smartcase     " in the name
    set linebreak                " don't cut words on wrap if i DO wrap
    set list                     " list my chars╳│
    set nowrap                   " I really hate wrap
    set nowrapscan               " I don't like my searches to continue forever
    set shiftround               " indent it by multiples of shiftwidth please:)
    set showcmd                  " Show cmd while typing in bottom right corner
    set smartcase                " makes things a bit better
    set smartindent              " indent things well
    set smarttab                 " tab plays nicer
    set sol nosol                " Don't be stupid and move to start of line
    set splitbelow               " ...split below... what did you think?
    set splitright               " Oh this one will be different!...cept not.
    set undofile                 " keep undo history ina file

   " Set: Those that use =
    let &showbreak = '↳ '        " Change show break thing (rare occasion)
    set cinkeys-=0#              " don't force # indentation, ever write python?
    set colorcolumn=80,130       " color columns
    set foldcolumn=0             " foldcolumn... yes
    set foldmethod=marker        " fold stuff :)
    set foldopen+=jump           " open folds when I jump to things as well
    set icm="split"              " inc command split in preview, hasn't worked
    set matchtime=1              " Show matching time
    set matchpairs+=<:>          " More matches
    set mouse=                   " I prefer having terminal fucntionality.
    set shiftwidth=4             " Use indents of 4 spaces
    set showmatch                " Show matching brackets/parentthesis
    set sidescrolloff=5          " 5 columns off?, scroll
    set scrolloff=0              " I want to touch the top...
    set softtabstop=4            " Let backspace delete indent
    set tabstop=4                " An indentation every four columns
    set textwidth=80             " text width
    set timeoutlen=250           " Best type maps fast
    set ttimeoutlen=25           " I don't care much for waiting
    set undolevels=99999         " A lot of undo history :P
    set updatecount=33           " update swp every 33 chars.
    set viewoptions=cursor       " What to save with mkview
    set visualbell               " Please don't make noises
    set wildmode=longest,full    " Let's make it nice tab completion

    " Set: Those that are complex, or just look stupid
    " Backup dirrrrrrrrrrr
    set backupdir-=.
    " set fill chars to things that make me happy
    set fillchars=vert:\|,stlnc:-,stl:\ ,fold:-,diff:
    " Changes listchars to more suitable chars
    set listchars=tab:→\ ,trail:·,extends:<,precedes:>
    " If it's modifable, turn on numbers
    if &modifiable | set number | set relativenumber | endif
    " If it goes past tw, don't highlight it
    exe 'set synmaxcol=' . &tw
    " Ignore this crap :)
    set wildignore=*.jar,*.class,*/Sdk*,*.ttf,*.png,*.tzo,*.tar,*.pdf,
                \*.gif,*.gz,*.jpg,*.jpeg,**/bin/*,*.iml,*.store,*/build* | "rand
    set wildignore+=*.bak,*.swp,*.swo | "vim
    set wildignore+=*.a,*.o,*.so,*.pyc,*.class | "cpp/python/java
    set wildignore+=*/.git*,*.tar,*.zip | "srctl, compress
"End Vim set }}}

"Begin Vim map {{{
    "I don't use space so...here it is
    map <space> <leader>
    " Does anyone actually use single quote?
    map ' `

    "Cycle error list like a boss
    map <f4> :cp<cr>
    map <f5> :cn<cr>

    " pasting in cmode
    cmap <c-v> <c-r>"

    " I don't know why this isn't default
    nnoremap Y y$

    "[Pre/App]end to the word under the cursor
    map <m-a> ea
    map <m-i> bi

    " undo break for each <cr>
    inoremap <CR> <C-]><C-G>u<CR>

    "I uh... don't use ESC
    inoremap  
    vnoremap  

    " neat things I found from mhinz
    nmap <expr> n  'Nn'[v:searchforward]
    nmap <expr> N  'nN'[v:searchforward]
    nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

    " Search and replace word under cursor
    " Why f6 and f7? I'm not sure...
    nnoremap <F6> :%s/<C-r><C-w>/
    nnoremap <F7> :%s/\<<C-r><C-w>\>/

    "I like playing with colors (Gives me hi-lo ids)
    map <leader>1 :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"End Vim Map }}}

"Aucmd {{{

    " Do I really need this??... {{{
    " let g:doGoldRatioActive=0
    " let g:GoldRatio=1.6
    " let g:doAutoNumInActive=0
    " let g:killInactiveCursor=1
    " let g:doAutoWrap=0
    " let g:dynamicStatusLine=0

    " function! EnterWin()
    "    let curWinIndex = winnr()
    "    let windowCount = winnr('$')
    "    let ratio = &columns/g:GoldRatio

    "    exec printf("set scroll=%d",float2nr(winheight(winnr()) * 0.3))

    "    for i in range(1,winnr('$'))
    "        if( i != curWinIndex )
    "            wincmd w
    "            if(g:doGoldRatioActive && (&modifiable || (&lines-winheight(curWinIndex) != 3)))
    "                let minRatio = float2nr(ratio/windowCount)

    "                cal setwinvar(i,"&winminwidth",minRatio)
    "                cal setwinvar(i,"&winwidth",minRatio)
    "            endif
    "            if(g:doAutoNumInActive)
    "                setlocal number nonumber
    "                setlocal relativenumber norelativenumber
    "            endif
    "            if(g:killInactiveCursor)
    "                set cursorline nocursorline
    "            endif
    "        endif
    "    endfor

    "    wincmd w
    "    if(&modifiable && &buftype != 'terminal')
    "        if(g:doGoldRatioActive)
    "            exec printf("vertical resize %d", float2nr(ratio))
    "        endif
    "        if(g:killInactiveCursor)
    "            set cursorline
    "        endif
    "        if(g:doAutoNumInActive)
    "            setlocal number
    "        endif
    "        if(g:doAutoWrap)
    "            setlocal wrap nowrap
    "        endif
    "    endif
    "endfunction
    " }}}

    " Auto viewing... {{{
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
    " }}}

    " I fuckin hate when I accidentally type :W<cr> {{{
    command! -nargs=0 W write
    " }}}

    " Fix this and possibly make a plugin... {{{
    " hi holdSearch guifg=none guibg=#4a5f58 gui=none
    " set updatetime=500
    " func! HighlightOnHold()
    "     try
    "         "echo expand("<cword>")
    "         exec printf("2match holdSearch \/\\<%s\\>\/", expand("<cword>"))
    "     catch /.*/
    "     endtry
    " endfun
    " }}}

    func! KillWhitespace() " {{{ fuck ws
        exec "%s/\\s\\+$//g"
    endf
    command! -nargs=0 Kws call KillWhitespace()
    " }}}

    " Buffer Swappping; Export to a plugin, some people might enjoy this? {{{
    " Get buff that isn't already displayed in a window and isn't unlisted
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

    nmap <silent> <m-n> :call GetNextBuffer()<cr>
    nmap <silent> <m-N> :call GetPrevBuffer()<cr>
    " }}}
    augroup init
        autocmd!
        " autocmd CursorHold * call HighlightOnHold()
        autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
        " autocmd WinEnter * cal EnterWin()
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
