"Plug, colo {{{
if(has("unix"))
    " set termguicolors
    so ~/.config/nvim/plug.vim
else
    so ~\AppData\Local\nvim\plug.vim
endif
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
colo chill
"}}}

"Begin Vim set {{{
    " Set: Those that use macros
    set backup | set writebackup " back it up, the file, I mean.
    set cursorline             " set cursorline to highlight NOTHING
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
    set title title              " rxvt and tmux make this usable
    let &titlestring = expand('%') . " - (" . getcwd() . ')'
    set undofile                 " keep undo history ina file

   " Set: Those that use =
    let &showbreak = '↳ '        " Change show break thing (rare occasion)
    set cinkeys-=0#              " don't force # indentation, ever write python?
    set cmdheight=1              " Pair up
    set colorcolumn=80,130       " color columns
    set foldcolumn=0             " foldcolumn... yes
    set foldmethod=marker        " fold stuff :)
    set foldopen+=jump,search    " open folds when I search/jump to things
    set icm="split"              " inc command split in preview, hasn't worked
    set matchtime=1              " Show matching time
    set matchpairs+=<:>          " More matches
    set mouse=                   " I prefer having terminal functionality.
    set shiftwidth=4             " Use indents of 4 spaces
    set showmatch                " Show matching brackets/parentthesis
    set sidescrolloff=5          " 5 columns off?, scroll
    set scrolloff=0              " I want to touch the top...
    set softtabstop=4            " Let backspace delete indent
    set tabstop=4                " An indentation every four columns
    set textwidth=80             " text width
    set timeoutlen=999           " Best type maps fast
    set ttimeoutlen=25           " I don't care much for waiting
    set undolevels=99999         " A lot of undo history :P
    set updatecount=33           " update swp every 33 chars.
    set viewoptions=cursor       " What to save with mkview
    set belloff=error,ex,insertmode,showmatch " Please visual beep :)
    set wildmode=longest,full    " Let's make it nice tab completion

    " Set: Those that are complex, or just look stupid
    " Backup dirrrrrrrrrrr, and make the fuckin dir please :)
    set backupdir-=.
    exe "call mkdir('" . $HOME . "/.local/share/nvim/backup' , 'p')"
    " set fill chars to things that make me happy
    set fillchars=vert:\|,stlnc:_,stl:\ ,fold:-,diff:┉
    " Changes listchars to more suitable chars
    set listchars=tab:→\ ,trail:·,extends:<,precedes:>
    " If it's modifable, turn on numbers
    if &modifiable | set number | set relativenumber | endif
    " If it goes past tw, don't highlight it
    " exe 'set synmaxcol=' . (&tw + 51)
    " Eh... just do columns
    " exe 'set synmaxcol=' . (&columns)
    set synmaxcol=300
    " Ignore this crap :)
    set wildignore=*.jar,*.class,*/Sdk*,*.ttf,*.png,*.tzo,*.tar,*.pdf,
                \*.gif,*.gz,*.jpg,*.jpeg,**/bin/*,*.iml,*.store,*/build* | "rand
    set wildignore+=*.bak,*.swp,*.swo | "vim
    set wildignore+=*.a,*.o,*.so,*.pyc,*.class | "cpp/python/java
    set wildignore+=*/.git*,*.tar,*.zip | "srctl, compress
"End Vim set }}}

"Begin Vim map {{{
    " Refresh my script bitch!
    nnoremap <F5> :w \| so %<cr>

    " I use this too much for it to not be a mapping
    nnoremap <leader>ee :e **/*
    nnoremap <leader>aa :argadd **/*
    nnoremap <leader>vv :vsp **/*
    nnoremap <leader>ss :sp **/*
    nnoremap <leader>cc :cfile  \| copen \| cc<left><left><left><left><left><left><left><left><left><left><left><left><left>

    " Does anyone actually use single quote?
    map ' `

    " Hls ease
    nnoremap <space> :set hlsearch!<cr>
    nnoremap n :set hlsearch<cr>n
    nnoremap N :set hlsearch<cr>N
    nnoremap / :set hlsearch<cr>/
    nnoremap * :set hlsearch<cr>*

    " I never use #||? should I make it into something else?
    nmap ? :set hlsearch<cr>?
    nmap # :set hlsearch<cr>#

    " pasting in cmode
    cmap <c-v> <c-r>"

    " next/prev arglist
    nnoremap <m-c> :next<cr>
    nnoremap <m-C> :prev<cr>
    " c-list
    nnoremap <m-c> :cn<cr>
    nnoremap <m-C> :cp<cr>

    " resize window m-cap h less, j less, k more, l more
    nnoremap <m-H> <c-w><
    nnoremap <m-L> <c-w>>
    nnoremap <m-J> <c-w>-
    nnoremap <m-K> <c-w>+

    " move hjkl with ctrl
    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k

    " I don't know why this isn't default
    nnoremap Y y$

    "[Pre/App]end to the word under the cursor
    map <m-a> ea
    map <m-i> bi

    " undo break for each <cr>
    inoremap <CR> <C-]><C-G>u<CR>

    " I uh... don't use ESC
    inoremap  
    vnoremap  

    " Search and replace word under cursor
    " Why f6 and f7? I'm not sure...
    nnoremap <F6> :%s/<C-r><C-w>/
    nnoremap <F7> :%s/\<<C-r><C-w>\>/

    " I like playing with colors (Gives me hi-lo ids)
    map <leader>1 :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"End Vim Map }}}

" Status Line {{{
" TODO cache so don't update everytime unless needed
function! StatusLine()
    " Left Filename/CurArg
    setl statusline =%3*%{CurArg()}%*
    " setl statusline=%<

    if &modifiable
        setl statusline+=%1*%m%*
    else
        setl statusline+=%2*%m%*
    endif

    setl statusline+=%2*%r
    setl statusline+=%4*%=

    " Right: linenr,column    TotalLines : Percentage Through
    setl statusline+=%-10.(%#CursorLineNr#%l,%c%)
    setl statusline+=%#LineNr#%p%%\ :\ %L
endfunction

function! StatusLineNC()
    setl statusline =%<%#Statuslinenc#%f
    if &modifiable
        setl statusline+=%1*%m
    else
        setl statusline+=%2*%m
    endif
    setl statusline+=%2*%r
    setl statusline+=%#StatusLineNC#
    setl statusline+=%*%=
    setl statusline+=%(%l,%c%)
    setl statusline+=\ \ \ \ 
    setl statusline+=%L\ :\ %p%%
endfunc

func! CurArg()
    let l:rtn = ''

    if argc() == 0 || argv(argidx()) !=# @%
        return @%
    endif

    let l:curarg = argv(argidx())

    let l:rtn .= '[' . l:curarg . ']'

    return l:rtn
endfun "}}}

" Enter/LeaveWin {{{
function! LeaveWin()
    call StatusLineNC()
endfunc

function! EnterWin()
    call StatusLine()
    let curWinIndex = winnr()
    let windowCount = winnr('$')

    exec printf("set scroll=%d",float2nr(winheight(winnr()) * 0.3))

    for i in range(1,winnr('$'))
        if( i != curWinIndex )
            wincmd w
            setl relativenumber norelativenumber
            setl cursorline nocursorline
            setl colorcolumn=0
        endif
    endfor

    wincmd w

    if(&modifiable && &buftype != 'terminal')
        setl cursorline
        setl relativenumber
        setl colorcolumn=80,130
    endif
endfunction
" }}}

" Auto viewing {{{
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

func! KillWhitespace() " {{{ -- fuck ws
    exec "%s/\\s\\+$//ge"
endf
command! -nargs=0 Kws call KillWhitespace()
" }}}

" Autocommands {{{
augroup init
    autocmd!
    autocmd BufWinLeave * cal LeaveBufWin() | call LeaveWin()
    autocmd BufWinEnter * cal EnterBufWin() | call EnterWin()
    autocmd WinEnter * cal EnterWin()
    autocmd WinLeave * cal LeaveWin()
augroup END
"}}}

" TODO add g= and Opposite of J {{{1
" Fix this and possibly make a plugin... {{{
" hi holdSearch guifg=none guibg=#4a5f58 gui=none
" set updatetime=500
" func! HighlightOnHold()
"     tr
"         "echo expand("<cword>")
"         exec printf("2match holdSearch \/\\<%s\\>\/", expand("<cword>"))
"     catch /.*/
"     endtry
" endfun
" }}}

