" TODO
" Research formatprg
" Research include and define
" Research g ops
" Of [ ops like [I
" Of ] ops
" map ]f and [f because gf is the same and I never use it anyways...
" map arrow keys ??
" function for cpp  ->  ::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$

nnoremap <F9> :!python src/main.py<cr>

" Plug, colo {{{

if has("unix")
    so ~/.config/nvim/plug.vim
    command! -nargs=0 INIT :e ~/.config/nvim/init.vim
    command! -nargs=0 PLUG :e ~/.config/nvim/plug.vim
else
    so ~\AppData\Local\nvim\plug.vim
    command! -nargs=0 INIT :e c:/Users/bcoffman/AppData/Local/nvim/init.vim
    command! -nargs=0 PLUG :e c:/Users/bcoffman/AppData/Local/nvim/plug.vim
endif

set guicursor=n-c-v:block,i-ci:ver30,r-cr:hor20,o:hor100

try
    " set termguicolors
    colo restraint
    command! -nargs=0 COLO :e ~/.local/share/nvim/plugged/Restraint.vim/colors/restraint.vim
catch E185
    colo desert
endtry

func! Colors()
    hi cursorcolumn guifg=none guibg=none ctermfg=none ctermbg=none cterm=none
    hi cursorline   guifg=none guibg=none ctermfg=none ctermbg=none cterm=none
endfunc

if !hlexists("StatusLineAdd")
    hi StatusLineAdd ctermfg=10 ctermbg=none cterm=bold
endif

if hostname() == 'DESKTOP-D9I4I5S'
    let g:python3_host_prog='V:\Python3\python.exe'
    let g:python_host_prog='V:\Python2\python.exe'
    set bg=light
elseif hostname() == 'mojajojo'
    let g:python3_host_prog='/usr/bin/python3'
    let g:python_host_prog='/usr/bin/python2'
    set bg=dark
elseif hostname() == 'captainJojo'
    set bg=light
elseif hostname() == 'cinder'
    set bg=dark
else
endif

"}}}
"Begin Vim set {{{
    " Set: Those that use macros
    set cursorline                 " set cursorline, just make sure highlight is none
    set cursorcolumn               " set no cursor column
    set expandtab                  " Expands tab to spaces
    set linebreak                  " don't cut words on wrap if i DO wrap
    set list                       " list my chars: ╳│¦|┆×•·
    set nowrap                     " I really hate wrap
    set nowrapscan                 " I don't like my searches to continue forever
    set shiftround                 " indent it by multiples of shiftwidth please
    set showcmd                    " Show cmd while typing in bottom right corner
    set noshowmatch                " Plugin does this Show matching brackets/parentthesis
    set noshowmode                 " I just put it in statusbar, don't clear echo
    set ignorecase smartcase       " ignore case if just using lower
    set smartcase                  " makes things a bit better
    set smartindent                " indent things well
    set smarttab                   " tab plays nicer
    set nosol                      " Don't be stupid and move to start of line
    set splitbelow                 " ...split below... what did you think?
    set splitright                 " Oh this one will be different!...cept not.
    set undofile                   " keep undo history ina file

    " Set: Those that use =
    let &showbreak = '↳ '          " Change show break thing (rare occasion)
    set cinkeys-=0#                " don't force # indentation, ever write python?

    set cmdheight=1                " Pair up
    set complete=.,w,b,u,U         " Complete all buffers,window, current
    set completeopt=menu           " I'm not a fan of auto documentation.
    set diffopt+=context:3         " diff context lines
    set foldcolumn=2               " foldcolumn... yes
    set foldmethod=marker          " fold stuff :)
    set foldopen+=jump,search      " open folds when I search/jump to things
    set icm="nosplit"              " inc command split in preview, hasn't worked
    set matchtime=0                " Show matching time
    set matchpairs+=<:>            " More matches
    set mouse=                     " I like terminal func
    set shiftwidth=4               " Use indents of 4 spaces
    set shortmess+=c               " Insert completions is annoying as hellllll
    set sidescrolloff=10           " 10 columns off?, scroll
    set scrolloff=0                " I want to touch the top...
    set softtabstop=4              " Let backspace delete indent
    set tabstop=4                  " An indentation every four columns
    set textwidth=80               " text width
    set timeoutlen=999             " Best type maps fast
    set ttimeoutlen=25             " I don't care much for waiting
    set undolevels=99999           " A lot of undo history :P
    set updatecount=33             " update swp every 33 chars.
    set updatetime=1000            " Do updates every second
    set viewoptions=folds,cursor   " What to save with mkview
    set wildmode=full              " Let's make it nice tab completion

    " Set: Those that are complex, or just look stupid
    " These are annoying to have on
    set belloff=error,ex,insertmode,showmatch
    " set fill chars to things that make me happy—
    set fillchars=vert:\|,stlnc:_,stl:\ ,fold:.,diff:┉
    " Changes listchars to more suitable chars
    set listchars=tab:→\ ,trail:·,extends:<,precedes:>,conceal:¦
    " If it's modifable, turn on numbers
    if &modifiable | set number | endif
    set synmaxcol=300
    " Ignore this crap :) Need more..?
    set wildignore=*.jar,*.class,*/Sdk*,*.ttf,*.png,*.tzo,*.tar,*.pdf,
                  \*.gif,*.gz,*.jpg,*.jpeg,**/bin/*,*.iml,*.store,*/build*
    set wildignore+=*.bak,*.swp,*.swo | "vim
    set wildignore+=*.a,*.o,*.so,*.pyc,*.class | "cpp/python/java
    set wildignore+=*/.git*,*.tar,*.zip | "srctl, compress

    " I finally set it up >.> happy?
    set formatoptions=
    set formatoptions+=l " Don't auto break lines unless I say
    set formatoptions+=r " Continue comments in insert mode
    set formatoptions+=q " continue comments with gq
    set formatoptions+=n " Recognize numbered lists
    set formatoptions+=2 " Use indent from 2nd line of a paragraph
    set formatoptions+=j " Destroy comment leader join when valid
    " set formatoptions-=c " Auto-wrap comments using textwidth
    " set formatoptions-=t " auto wrap based on textwidth
    " set formatoptions-=a " auto-paragraphing, fuck that.
    " set formatoptions-=v " vi auto wrapping, no.
    " set formatoptions-=b " I just don't like auto
    " set formatoptions-=1 " I don't fuckin care how long it is
    " set formatoptions-=o " do not continue comment using o or O
"End Vim set }}}
"Begin Vim map {{{
    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    " Refresh my script bitch!
    nnoremap <F5> :w \| so %<cr>
    " On windows it's f15 because you have to hold down shift because windows thinks f5 is fuckin E for some fucked up reason
    nnoremap <F15> :w \| so %<cr>
    nnoremap <c-p> g;
    nnoremap <c-n> g,


    " Current file ea will remove extenion so like header, ec will keep
    " directory but remove file entirely. NOTE, if you file has no extension
    " still use ea.
    nnoremap <leader>ea :e <c-r>%<c-w>
    nnoremap <leader>ec :e <c-r>%<c-w><c-w><c-w>
    nnoremap <leader>ve :vsp <c-r>%<c-w>
    nnoremap <leader>vc :vsp <c-r>%<c-w><c-w><c-w>
    nnoremap <leader>se :sp <c-r>%<c-w>
    nnoremap <leader>sc :sp <c-r>%<c-w><c-w><c-w>

    nnoremap <leader>cc :cfile  \| copen \| cc<left><left><left><left><left><left><left><left><left><left><left><left><left>

    " Does anyone actually use single quote?
    map ' `

    " Hls ease
    nnoremap <silent><space>h hl:silent set hlsearch!<cr>
    nnoremap n :set hlsearch<cr>nzv
    nnoremap N :set hlsearch<cr>Nzv
    nnoremap / :set hlsearch<cr>/
    " don't move... please :)
    nnoremap * :set hlsearch \| let @/='\<<c-r><c-w>\>'<cr>
    " add to the existing search if it doesn't already match
    nnoremap <silent># :set hlsearch \| if match('\<'.@/.'\>', '\<<c-r><c-w>\>') == -1 \| let @/='<c-r><c-/>\\|\<<c-r><c-w>\>' \| endif<cr>

    " pasting in cmode, maybe get extract up in here.
    cmap <c-v> <c-r>"
    " pasting in cmode, but escape for searching
    cmap <m-v>/ <c-r>=substitute(escape('', '/'), "\\s", "", "g")<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
    " pasting in cmode, but escape for /
    cmap <m-v>\ <c-r>=substitute(escape('', '\\'), "\\s", "", "g")<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

    " c-list ( Quickfix ) why no qn qp ? probably has something to do with quit.
    nnoremap <m-c> :cn<cr>
    nnoremap <m-C> :cp<cr>

    " I don't know why this isn't default
    nnoremap Y y$

    " Opp of j
    nnoremap g<cr> i<cr><esc>

    "[Pre/App]end to the word under the cursor
    map <m-a> ea
    map <m-i> bi

    " I uh... don't use ESC
    inoremap  
    vnoremap  
    nnoremap ? /\c

    " I like playing with colors (Gives me hi-trans-lo ids)
    map <leader>1 :call HiLoBro()<cr>

    func! HiLoBro()
        let hi = synIDattr(synID(line("."),col("."),1),"name")
        let trans = synIDattr(synID(line("."),col("."),0),"name")
        let lo = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
        echo 'hi<' . hi . '> trans<' . trans . '> lo<' . lo . '>'
        exec 'hi ' . lo
    endfunc

" End Vim Map }}}
" Status Line , mode [arg]|file [+][-][RO] > TODO < l,c : maxG,% [ pos ] {{{
function! StatusLine()
    " Left Filename/CurArg
    setl statusline=%#ModeMsg#\ %{Mode(mode())}\ %*
    setl statusline+=%#StatusLine#\ %{CurArg()}\ %*

    if &modifiable
        setl statusline+=%#diffAdded#%m
    else
        setl statusline+=%#diffRemoved#%m
    endif

    setl statusline+=%#diffRemoved#%r%#CursorLineNr#%=

    " Right: linenr,column    PositionBar()
    setl statusline+=%-10.(%#CursorLineNr#\ %l,%c\ :\ %LG,%p%%\ %)
    setl statusline+=%-22.(%#LineNr#\ [\ %{PositionBarLeft()}
                          \%#CursorLineNr#%{PositionBar()}
                          \%#LineNr#%{PositionBarRight()}%)\ ]\ %*
endfunction

function! ScopeStart()
    if has_key(g:, 'scope_startline')
        return strpart(substitute(g:scope_startline, '^\s\+\|\s\+$', "", "g"),
                    \ 0, winwidth('.')/2)
    else
        return ''
    endif
endfunc

function! ScopeEnd()
    if has_key(g:, 'scope_endline')
        return strpart(substitute(g:scope_endline, '^\s\+\|\s\+$', '', "g"),
                    \ 0, winwidth('.')/4)
    else
        return ''
    endif
endfunc

" Status Line Not current, file [+][-][RO]_______>____<____l,c : maxG,%
function! StatusLineNC()
    setl statusline =%<%#Statuslinenc#%{CurArg()}
    if &modifiable
        setl statusline+=%1*%m
    else
        setl statusline+=%2*%m
    endif
    setl statusline+=%2*%r
    setl statusline+=%#StatusLineNC#
    setl statusline+=%*%=
    setl statusline+=%(%l,%c%)
    setl statusline+=\ \ \ \ %*
    setl statusline+=:\ %LG,%p%%
endfunc

func! CurArg()
    let f = @%

    if len(@%) == 0
        return 'None'
    endif

    " Breadcrumb that shit
    let pa = split(@%, '/\|\\')
    if len(pa) > 0
        for i in range(0, len(pa) - 2)
            let pa[i] = strcharpart(pa[i], 0,1)
        endfor
        return join(pa, '/')
    endif

    return f
endfun

func! Mode(mode)
    if !has_key(s:, "statusmodes")
        let s:statusmodes = {
                    \ "n"  : "-- xxxxxx --",
                    \ "no" : "-- OPERATOR --",
                    \ "i"  : "-- INSERT --",
                    \ "v"  : "-- VISUAL --",
                    \ "V"  : "-- VISUAL LINE --",
                    \ "" : "-- VISUAL BLOCK --",
                    \ "R"  : "-- REPLACE --",
                    \ "Rv" : "-- V REPLACE --",
                    \ "t"  : "-- TERMINAL --",
                    \ "s"  : "-- SELECT --",
                    \ "S"  : "-- SELECT LINE --",
                    \ "" : "-- SELECT BLOCK--",
                    \ "c"  : "-- COMMAND --",
                    \ "cv" : "-- VEX --",
                    \ "ce" : "-- EX --",
                    \ "r"  : "-- PROMPT --",
                    \ "rm" : "-- MORE --",
                    \ "r?" : "-- CONFIRM --",
                    \ "!"  : "-- SHELL --",
       \}
    endif

    let paste = ""
    if &paste
        let paste = " PASTE "
    endif

    if !&modifiable
        return '- '. toupper(&filetype) . ' -'
    else
        return s:statusmodes[a:mode] . l:paste
    endif
endfunc

func! PositionBarRight()
     return repeat(s:scrolltrack, float2nr(round(s:scrollrratio)))
endfunc

func! PositionBar()
     return s:scrollpos
endfunc

func! PositionBarLeft()
    let cnt=line("$") * 1.0
    let current=line('.') * 1.0
    let desiredlength=20.0
    let length=20.0
    " If we don't have 20 lines don't display 20 dots...
    if l:cnt < l:length
        let l:length = l:cnt
    endif
    let track='·'

    let ratio=(l:current/l:cnt)*l:length
    let rratio=l:length-l:ratio

    " If we are greater than the length, something is wrong, and if we can never reach the end, something
    " is also wrong.
    if (l:ratio >= 0.5 && l:cnt < l:desiredlength * 2) || round(l:ratio) + round(l:rratio) > l:length
        let l:ratio -= 1
    endif

    if l:current == 1
        let pos = '|=='
    elseif l:current != l:cnt
        let pos = '=|='
    else
        let pos='==|'
    endif

    let s:scrollrratio = l:rratio
    let s:scrollpos = l:pos
    let s:scrolltrack = l:track

    return repeat(l:track, float2nr(round(l:ratio)))
endfunc  "}}}
" Enter/LeaveWin {{{
function! LeaveWin()
    call StatusLineNC()
endfunc

function! EnterWin()
    call StatusLine()
    try
        let curWinIndex = winnr()
        let windowCount = winnr('$')

        exec printf("set scroll=%d",float2nr(winheight(winnr()) * 0.4))

        for i in range(1,winnr('$'))
            if( i != curWinIndex )
                wincmd w
                " setl relativenumber norelativenumber
                setl nocursorline
                setl nocursorcolumn
                setl colorcolumn=0
            endif
        endfor

        wincmd w

        setl cursorline
        setl cursorcolumn
        setl colorcolumn=80,130
    catch /.*/
    endtry
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
    let fold = strcharpart(&fillchars, stridx(&fillchars, 'fold') + 5, 1)
    let foldlevel = match(getline(v:foldstart),'{{' . '{\d')
    let foldlevelend = matchend(getline(v:foldstart),'{{' . '{\d')
    if l:foldlevel == -1
        let l:foldlevel = '|'
    else
        let l:foldlevel = strpart(getline(v:foldstart), l:foldlevel + 3, l:foldlevelend)
    endif
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let oldline = l:line
    let line = strpart(l:line, 0, winwidth('.') / 2 - 3)
    if len(l:line) < len(l:oldline)
        let l:line .= "···"
    endif
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = printf("%s", lines_count)
    let spacechar = " "
    let foldtextstart = strpart('' . repeat(spacechar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = ' ( #' . repeat(" ", 4 - len(lines_count_text)) . lines_count_text . " ) "
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return l:foldlevel . repeat(l:fold, winwidth('.') / 4) . l:foldlevel . " " . line . repeat(spacechar, winwidth('.') / 2 - len(line)) . foldtextend . l:foldlevel
endfunction
set foldtext=SuperSexyFoldText()
" }}}
func! KillWhitespace() " {{{ -- fuck ws
    retab
    exec "%s/\\s\\+$//ge"
endfu
command! -nargs=0 Kws silent! call KillWhitespace()
" }}}
" Autocommands {{{
augroup init
    autocmd!
    " me
    autocmd BufWinLeave * cal LeaveBufWin() | call LeaveWin()
    autocmd BufWinEnter * cal EnterBufWin() | call EnterWin()
    autocmd WinEnter * cal EnterWin()
    autocmd WinLeave * cal LeaveWin()

    " Filetypes
    autocmd FileType c,cpp,java,cs set commentstring=//\ %s
    autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END
"}}}
try " CurlNewGuiDataFunc {{{
    func! CurlNewGuiDataFunc(ip)
        let ip =  strpart(a:ip, 0,2) . '.'
        let ip .= strpart(a:ip, 2,3) . '.'
        let ip .= strpart(a:ip, 5,2) . '.'
        let ip .= strpart(a:ip, 7)
        exec "!wget http://".(l:ip)."/cgi-bin/guidebugdata -O guidebugdata"
    endfunc
catch /.*/
endtry
command! -nargs=1 CurlNewGuiData call CurlNewGuiDataFunc(<args>)
" }}}
" {{{ fun GetAllClosedFolds
func! GetAllClosedFolds()
    let ll = 0
    for l in range(line('w0'), line('w$'))
        if l > ll && foldclosed(l) != -1
            echom l
            let ll=foldclosedend(l)
        endif
    endfor
endfunc
" }}}

" }}}1
" Special chars {{{
" *\·•:,…!
" #․.‥—–-«»‹›¢¤ƒ£¥≡+−×÷=≠><≥≤±≈~¬∅∞∫∆∏∑√∂µ%‰∴∕∙▁▂▃▄▅▆▇█▀▔
" ▏▎▍▌▋▊▉▐▕▖▗▘▙▚▛▜▝▞▟░▒▓━│┃┄┅┆┇┈┉┊┋┌┍┎┏┐┑┒┓└┕┖┗┘┙┚┛├┝┞┟┠┡┢┣┤┥┦┧┨┩┪┫┬┭┮┯┰┱┲┳┴┵┶┷┸
" ┹┺┻┼┽┾┿╀╁╂╃╄╅╆╇╈╉╊╋╌╍╎╏═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬╭╮╯╰╱╲╳╴╵╶╷╸╹╺╻╼╽╾╿♥@¶§©®
"" ™°|¦†ℓ‡^̣´˘ˇ¸ˆ¨˙`˝¯˛˚˜
" Don't delete this...

func! HexToRgbPercent(hex)
    let dex = 0
    if a:hex[0] == '#'
        let l:dex = 1
    endif

    let r = string(str2float('0x'.a:hex[dex].a:hex[dex+1])) | let dex += 2
    let g = string(str2float('0x'.a:hex[dex].a:hex[dex+1])) | let dex += 2
    let b = string(str2float('0x'.a:hex[dex].a:hex[dex+1]))

    let pr = r / 255.0
    let pg = g / 255.0
    let pb = b / 255.0

    " call setreg('r', l:r, 'c')
    " call setreg('g', l:g, 'c')
    " call setreg('b', l:b, 'c')

    " if exists("g:extract_loaded")
    "     call extract#YankHappened({'regname': 'r', 'regcontents': [l:r], 'regtype' : 'v'})
    "     call extract#YankHappened({'regname': 'g', 'regcontents': [l:g], 'regtype' : 'v'})
    "     call extract#YankHappened({'regname': 'b', 'regcontents': [l:b], 'regtype' : 'v'})
    " endif

    return '' .
                \ 'B '. l:b . l:pb . '   ' .
                \ 'G '. l:g . l:pg . '   ' .
                \ 'R '. l:r . l:pr . '   ' .
                \ ''
endfunc
