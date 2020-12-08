" Plug, colo {{{

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has("unix")
    so ~/.config/nvim/plug.vim
else
    so ~\AppData\Local\nvim\plug.vim
    command! -nargs=0 WT :e ~/Documents/bash-resources/wtsettings.json
    command! -nargs=0 PS :e ~/Documents/bash-resources/profile.ps1
endif

command! -nargs=0 INIT :e ~/Documents/bash-resources/nvim-plugs/init.vim
command! -nargs=0 PLUG :e ~/Documents/bash-resources/nvim-plugs/plug.vim

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

if hostname() == 'MSI'
    if has('win32')
        let g:python3_host_prog='C:\Users\Brand\AppData\Local\Programs\Python\Python39\python.exe'
    endif
    set bg=light
elseif hostname() == 'mojajojo'
    let g:python3_host_prog='/usr/local/bin/python3.7'
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
    set hidden                     " So we can navigate without writing
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
    set complete=.,w,b,u,U         " Complete all buffers, window, current
    set completeopt=menuone,noinsert,noselect
    set diffopt+=context:3         " diff context lines
    set foldcolumn=0               " foldcolumn... no, just, no
    set foldmethod=marker          " fold stuff
    set foldopen=tag,undo,block,hor,insert,percent,jump,search
    set inccommand=split           " pretty fucking useful
    set matchtime=0                " Show matching time
    set matchpairs+=<:>            " More matches
    set mouse=n                    " Term: Lin:shift, Iterm:command, Win:shift
    set scrolloff=0                " I want to touch the top...
    set shiftwidth=4               " Use indents of 4 spaces
    set shortmess+=c               " Insert completions are annoying
    set sidescrolloff=10           " 10 columns off?, scroll
    set signcolumn=number          " always draw it
    set softtabstop=4              " Let backspace delete indent
    set tabstop=4                  " An indentation every four columns
    set textwidth=80               " text width
    set timeoutlen=999             " Best type maps fast
    set ttimeoutlen=25             " I don't care much for waiting
    set undolevels=99999           " A lot of undo history
    set updatecount=33             " update swp every 33 chars.
    set updatetime=1000            " update swp every 1 second while cursorhold
    set viewoptions=folds,cursor   " What to save with mkview
    set wildmode=full              " Let's make it nice tab completion

    " Set: Those that are complex, or just look stupid
    " These are annoying to have on
    set belloff=error,ex,insertmode,showmatch
    " set fill chars to things that make me happy—
    set fillchars=stlnc:_,stl:\ ,fold:═,diff:┉,vert:¦
    " Changes listchars to more suitable chars
    set listchars=tab:→\ ,trail:·,extends:<,precedes:>,conceal:¦
    " If it's modifable, turn on numbers
    if &modifiable | set number | endif
    set synmaxcol=300
    " Ignore this crap ; Need more..?
    set wildignore=*.jar,*.class,*/Sdk*,*.ttf,*.png,*.tzo,*.tar,*.pdf,
                  \*.gif,*.gz,*.jpg,*.jpeg,**/bin/*,*.iml,*.store,*/build*
    set wildignore+=*.bak,*.swp,*.swo | "vim
    set wildignore+=*.a,*.o,*.so,*.pyc,*.class | "cpp/python/java
    set wildignore+=*/.git*,*.tar,*.zip | "srctl, compress

    " I finally set it up
    set formatoptions=   " reset
    set formatoptions+=l " Don't auto break lines unless I say
    set formatoptions+=r " Continue comments in insert mode
    set formatoptions+=q " Continue comments with gq
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
    tnoremap <A-c> <C-\><C-N>

    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-c> <C-\><C-N>

    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    " Refresh my vim script TODO filetypes
    " On windows it's f15 because you have to hold down shift because windows thinks f5 is fuckin E for some fucked up reason
    nnoremap <F5> :w \| so %<cr>
    nnoremap <F15> :w \| so %<cr>

    " Change list
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
    nnoremap ? :set hlsearch<cr>/\c
    " don't move... please
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

    "[Pre/App]end to the word under the cursor TODO make repeatable?
    map <m-a> ea
    map <m-i> bi

    " I uh... don't use ESC
    inoremap  
    vnoremap  

    " omni complete, will probably remove later
    inoremap <c-space> <c-x><c-o>

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
let g:scope_startline = ''
let g:scope_endline = ''

function! StatusLine()
    " Left Filename/CurArg
    setl statusline=%{ModeColor(mode())}%#NormalMode#\ %{Mode(mode())}\ %*
    setl statusline+=%#NormalMode#\ %#ErrorMsg#%{LSP_Error('[[Error]]')}%#WarningMsg#%{LSP_Error('[[Warning]]')}%#MoreMsg#%{LSP_Error('[[Hint]]')}%#NormalMode#\ %{CurArg()}\ %*

    if &modifiable
        setl statusline+=%#diffAdded#%m
    else
        setl statusline+=%#diffRemoved#%m
    endif

    setl statusline+=%#NormalMode#\ %<%{ScopeStart()}\ %#NormalMode#%{ScopePos()}
    setl statusline+=%#NormalMode#\ %{ScopeEnd()}\ %*

    setl statusline+=%#diffRemoved#%r%#NormalMode#%=

    " Right linenr,column    PositionBar()
    setl statusline+=%-8.(%#NormalMode#\ %l,%c%)
    setl statusline+=%-8.(%#NormalMode#%{StatusLineFileType()}\ ┣%{PositionBarLeft()}
                          \%{PositionBar()}
                          \%{PositionBarRight()}%)┫\ %*

    call ModeColor('n')
endfunction

function! LSP_Error(key)
    let x = ''

    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
        let errorCount = luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), ".a:key.")")
        if errorCount > 0
            let x.=" "
            let x.=strcharpart(a:key, 2, 1).":"
            let x.=string(errorCount)
            let x.=" "
        endif
    endif

    return x
endfunc

function! ScopePos()
    return "┃"
endfunc

function! ScopeStart()
    if has_key(g:, 'scope_startline')
        return strpart(substitute(g:scope_startline, '^\s\+\|\s\+$', "", "g"),
                    \ 0, winwidth('.')/3)
    else
        return ''
    endif
endfunc

function! ScopeEnd()
    if has_key(g:, 'scope_endline')
        return strpart(substitute(g:scope_endline, '^\s\+\|\s\+$', '', "g"),
                    \ 0, winwidth('.')/4) . ' '
    else
        return ''
    endif
endfunc

" Status Line Not current, file [+][-][RO]_______>____<____l,c : maxG,%
function! StatusLineNC()
    setl statusline =%<%#Statuslinenc#%{CurArg()}
    setl statusline+=\ %#ErrorMsg#%{LSP_Error('[[Error]]')}%#WarningMsg#%{LSP_Error('[[Warning]]')}%#MoreMsg#%{LSP_Error('[[Hint]]')}

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
    " let pa = split(@%, "/\|\\")
    let pa = split(@%, "/\\|\\")
    if len(pa) > 0
        for i in range(0, len(pa) - 2)
            let pa[i] = strcharpart(pa[i], 0,1)
        endfor
        return join(pa, '/')
    endif

    return f
endfun

if !hlexists("NormalMode")
    hi NormalMode   ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif
if !hlexists("InsertMode")
    hi InsertMode   ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif
if !hlexists("VisualMode")
    hi VisualMode   ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif
if !hlexists("SelectMode")
    hi SelectMode   ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif
if !hlexists("ReplaceMode")
    hi ReplaceMode  ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif
if !hlexists("CommandMode")
    hi CommandMode  ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif
if !hlexists("TerminalMode")
    hi TerminalMode ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif
if !hlexists("OtherMode")
    hi OtherMode    ctermfg=none ctermbg=none guibg=none guifg=none gui=none cterm=none
endif

function! ModeColor(mode)
    if !has_key(s:, "statusmodecolors")
        let s:statusmodecolors = {
                    \ "n"  : "NormalMode",
                    \ "no" : "NormalMode",
                    \ "i"  : "InsertMode",
                    \ "v"  : "VisualMode",
                    \ "V"  : "VisualMode",
                    \ "" : "VisualMode",
                    \ "R"  : "ReplaceMode",
                    \ "Rv" : "ReplaceMode",
                    \ "t"  : "TerminalMode",
                    \ "!"  : "CommandMode",
                    \ "c"  : "CommandMode",
                    \ "cv" : "CommandMode",
                    \ "ce" : "CommandMode",
                    \ "s"  : "SelectMode",
                    \ "S"  : "SelectMode",
                    \ "" : "SelectMode",
                    \ "r"  : "ReplaceMode",
                    \ "rm" : "ReplaceMode",
                    \ "r?" : "ReplaceMode",
       \}
    endif

    let sl = &statusline

    let &statusline=substitute(sl, '%#\(NormalMode\|InsertMode\|VisualMode\|ReplaceMode\|TerminalMode\|CommandMode\|SelectMode\)#', '%#'.s:statusmodecolors[a:mode].'#', 'g')

    return ''
endfun

autocmd CmdlineEnter * if v:event['cmdtype'] == ':' | call ModeColor('c') | redrawstatus! | endif

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

    return s:statusmodes[a:mode] . l:paste
endfunc

func! StatusLineFileType()
    return toupper(&filetype)
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
    let track='━'

    let ratio=(l:current/l:cnt)*l:length
    let rratio=l:length-l:ratio

    " If we are greater than the length, something is wrong, and if we can never reach the end, something
    " is also wrong.
    if (l:ratio >= 0.5 && l:cnt < l:desiredlength * 2) || round(l:ratio) + round(l:rratio) > l:length
        let l:ratio -= 1
    endif

    if l:current == 1
        let pos = '┃━━'
    elseif l:current != l:cnt
        let pos = '━┃━'
    else
        let pos='━━┃'
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
        let ei=&ei
        set eventignore=WinEnter,WinLeave

        let curWinIndex = winnr()
        let windowCount = winnr('$')

        exec printf("set scroll=%d",float2nr(winheight(winnr()) * 0.4))

        for i in range(1,winnr('$'))
            if ( i != curWinIndex )
                wincmd w
                setl nocursorline
                setl nocursorcolumn
                setl colorcolumn=0
                call StatusLineNC()
            endif
        endfor

        wincmd w

        setl cursorline
        setl cursorcolumn
        setl colorcolumn=80,130

        set eventignore=ei
    catch /.*/
    endtry
endfunction
" }}}

" Auto viewing {{{
func! LeaveBufWin()
    if &modifiable && filereadable(expand("%"))
        setlocal foldmethod=marker
        mkview!
    endif
endfun

func! EnterBufWin()
    try
        if &modifiable
            loadview
        endif
    catch /.*/ " E32 : No file name
    endtry
endfun
" }}}

function! SuperSexyFoldText() "{{{
    let fold = strcharpart(&fillchars, stridx(&fillchars, 'fold') + 5, 1)
    let foldlevel = match(getline(v:foldstart),'{{' . '{\d')
    let foldlevelend = matchend(getline(v:foldstart),'{{' . '{\d')
    if l:foldlevel == -1
        let l:foldlevel = '╠'
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
    return l:foldlevel . repeat(l:fold, winwidth('.') / 4) . '╣' . " " . line . repeat(spacechar, winwidth('.') / 2 - len(line)) . foldtextend . l:foldlevel
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
    autocmd WinLeave * cal LeaveBufWin() | call LeaveWin()
    autocmd WinEnter * cal EnterBufWin() | call EnterWin()
    autocmd BufWritePost * cal LeaveBufWin()

    " Filetypes TODO see if these are still even needed
    " autocmd FileType c,cpp,java,cs set commentstring=//\ %s
    " autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END
"}}}

" {{{ fun GetAllClosedFoldsOnScreen
func! GetAllClosedFoldsOnScreen()
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

    return a:hex. ' : ' .
                \ 'B '. (l:b) . " : " .string(l:pb) . '   ' .
                \ 'G '. (l:g) . " : " .string(l:pg) . '   ' .
                \ 'R '. (l:r) . " : " .string(l:pr) . '   ' .
                \ ''
endfunc

" TODO
" Research formatprg
" Research include and define
" Research g ops
" Of [ ops like [I
" Of ] ops
" map ]f and [f because gf is the same and I never use it anyways...
" map arrow keys ??
" function for cpp  ->  ::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$
" True Boundary : (?<=\s)m(?=\s)|^m(?=\s)|(?<=\s)m$|^m$
