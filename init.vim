" TODO
" Research formatprg
" Research include and define
" Research g ops
" Of [ ops like [I
" Of ] ops
" map ]f and [f because gf is the same and I never use it anyways...
" map arrow keys ??
" function for cpp  ->  ::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$

" Plug, colo

let g:netrw_liststyle = 3

if has("unix")
    so ~/.config/nvim/plug.vim
    command! -nargs=0 INIT :e ~/.config/nvim/init.vim
    command! -nargs=0 PLUG :e ~/.config/nvim/plug.vim
else
    so ~\AppData\Local\nvim\plug.vim
    command! -nargs=0 INIT :e c:/Users/bcoffman/AppData/Local/nvim/init.vim
    command! -nargs=0 PLUG :e c:/Users/bcoffman/AppData/Local/nvim/plug.vim
endif

let g:clipboard = {
        \   'name': 'xsel - bin',
        \   'copy': {
        \      '+': $HOME.'/bin/xsel -i -b',
        \      '*': $HOME.'/bin/xsel -i -p',
        \    },
        \   'paste': {
        \      '+': $HOME.'/bin/xsel -b',
        \      '*': $HOME.'/bin/xsel -p',
        \   },
        \   'cache_enabled': 0,
\ }

" doesn't work on windows... says it does but I'm pretty sure that's only for
" the nvim-qt shit and fuck that...
" set guicursor=n-c-v:block,i-ci:ver30,r-cr:hor20,o:hor100
set guicursor=

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
    if !hlexists("StatusLineAdd")
        hi StatusLineAdd ctermfg=10 ctermbg=none cterm=bold
    endif
endfunc

call Colors()

" I typically want dark, but I CAN use light if I want/need
if hostname() == "mojajojo" || hostname() == "captainJojo"
    set bg=dark
else
    set bg=dark
endif


"Begin Vim set
    " Set: Those that use macros
    set cursorline                 " set cursorline, just make sure highlight is none
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
    set foldcolumn=0               " foldcolumn... no
    set foldmethod=marker          " fold stuff :)
    set foldopen+=jump,search      " open folds when I search/jump to things
    set matchtime=0                " Show matching time
    set matchpairs+=<:>            " More matches
    set mouse=                     " I like terminal func
    set shiftwidth=4               " Use indents of 4 spaces
    set shortmess+=c
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
    " set formatoptions-=c " Auto-wrap comments using textwidth
    " set formatoptions-=t " auto wrap based on textwidth
    " set formatoptions-=a " auto-paragraphing, fuck that.
    " set formatoptions-=v " vi auto wrapping, no.
    " set formatoptions-=b " I just don't like auto
    " set formatoptions-=1 " I don't fuckin care how long it is
    " set formatoptions-=o " do not continue comment using o or O
"End Vim set
"Begin Vim map
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
    nnoremap <c-p> g;zO
    nnoremap <c-n> g,zO

    " If i'm asking the name just copy it to the black hole register while we are at it...
    nnoremap <c-g> :let @" = expand('%')<cr><c-g>

    " TODO: make a set or something?
    nnoremap <leader>ea :e <c-r>%<c-w>
    nnoremap <leader>cc :cfile  \| copen \| cc<left><left><left><left><left><left><left><left><left><left><left><left><left>

    " Does anyone actually use single quote?
    map ' `

    " Hls ease
    nnoremap <silent><space>h hl:silent set hlsearch!<cr>
    nnoremap <silent> n :set hlsearch<cr>nzv
    nnoremap <silent> N :set hlsearch<cr>Nzv
    nnoremap <silent> / :set hlsearch<cr>/
    " don't move... please :)
    let starlist = []
    let stardex = -1
    nnoremap <silent> * :set hlsearch \| let @/='\<<c-r><c-w>\>' \| call filter(starlist, 'v:val !~ "<c-r><c-w>"') \| call add(g:starlist, @/) <cr>
    " add to the existing search if it doesn't already match
    nnoremap <silent># :set hlsearch \| if match('\<'.@/.'\>', '\<<c-r><c-w>\>') == -1 \| let @/='<c-r><c-/>\\|\<<c-r><c-w>\>' \| add(starlist, @/) \| endif<cr>
    nnoremap <> :if !empty(g:starlist) \| let @/ = g:starlist[g:stardex] \| let g:stardex = (g:stardex - 1) % len(g:starlist) \| endif<cr>
    nnoremap <> :if !empty(g:starlist) \| let @/ = g:starlist[g:stardex] \| let g:stardex = (g:stardex + 1) % len(g:starlist) \| endif<cr>

    " pasting in cmode, maybe get extract up in here.
    cmap <silent> <c-v> <c-r>"
    " put word boundaries around current word why c-s? dunno... why not
    cnoremap <silent> <c-r><c-s> \<<c-r><c-w>\>

    " c-list ( Quickfix ) why no qn qp ? probably has something to do with quit.
    nnoremap <silent> <m-c> :cn<cr>
    nnoremap <silent> <m-C> :cp<cr>

    " I don't know why this isn't default
    nnoremap <silent> Y y$

    " Opp of j
    nnoremap <silent> g<cr> i<cr><esc>

    "[Pre/App]end to the word under the cursor
    map <m-a> ea
    map <m-i> bi

    " I uh... don't use ESC
    inoremap  
    vnoremap  

    " I like playing with colors (Gives me hi-trans-lo ids)
    map <leader>1 :call HiLoBro()<cr>

    func! HiLoBro()
        let hi = synIDattr(synID(line("."),col("."),1),"name")
        let trans = synIDattr(synID(line("."),col("."),0),"name")
        let lo = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
        echo 'hi<' . hi . '> trans<' . trans . '> lo<' . lo . '>'
        exec 'hi ' . lo
    endfunc

" End Vim Map
" Begin Vim abbrev
" I have a bad habit here...
"    ca W w
"    ca Echo echo
"    ca Q q
"    ca Set set
"    ca Let let
"    ca wb w \| bw

" End Vim Map
" Status Line , mode [arg]|file [+][-][RO] > TODO < l,c : maxG,% [ pos ]
function! StatusLine()

    " Left Filename/CurArg
    setl statusline=%#Statusline#\ %{Mode(mode())}\ %*
    setl statusline+=%#StatusLine#\ %{CurArg()}\ %*
    setl statusline+=%#DiffAdded#%m
    setl statusline+=%#diffRemoved#%r%#StatusLine#%=
    setl statusline+=%#Identifier#%{ScopeStart()}%=
    setl statusline+=%#Identifier#%{ScopeEnd()}%=

    " Right: linenr,column    PositionBar()
    setl statusline+=%-10.(%#LineNr#\ %l,%c\ :\ %LG,%p%%\ %)
    setl statusline+=%-22.(%#LineNr#\ [\ %{PositionBarLeft()}
                          \%#CursorLineNr#%{PositionBar()}
                          \%#LineNr#%{PositionBarRight()}%)\ ]\ %*
endfunction

function! ScopeStart()
    if has_key(g:, 'scope_startline')
        return strpart(substitute(g:scope_startline, '^\s\+\|\s\+$', "", "g"),
                    \ 0, winwidth('.')/8)
    else
        return ''
    endif
endfunc

function! ScopeEnd()
    if has_key(g:, 'scope_endline')
        return strpart(substitute(g:scope_endline, '^\s\+\|\s\+$', '', "g"),
                    \ 0, winwidth('.')/8)
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
                    \ "n"  : "---××××××---",
                    \ "no" : "-- OPERTR --",
                    \ "i"  : "-- INSERT --",
                    \ "v"  : "-- VISUAL --",
                    \ "V"  : "-- VSLINE --",
                    \ "" : "-- VSBLCK --",
                    \ "R"  : "-- RPLACE --",
                    \ "Rv" : "-- VRPLCE --",
                    \ "t"  : "-- TRMINL --",
                    \ "s"  : "-- SELECT --",
                    \ "S"  : "-- SLCLNE --",
                    \ "" : "-- SLCBLK--",
                    \ "c"  : "-- CMMAND --",
                    \ "cv" : "-- VEXXXX --",
                    \ "ce" : "-- EXXXXX --",
                    \ "r"  : "-- PROMPT --",
                    \ "rm" : "-- MOREEE --",
                    \ "r?" : "-- CONFRM --",
                    \ "!"  : "-- SHELLL --",
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
endfunc
" Enter/LeaveWin
function! LeaveWin()
    call StatusLineNC()
endfunc

function! EnterWin()
    call StatusLine()
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
endfunction
"
" }}}
function! SuperSexyFoldText()
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
"
func! KillWhitespace() "  -- fuck ws
    retab
    exec "%s/\\s\\+$//ge"
endfu
command! -nargs=0 Kws silent! call KillWhitespace()
"
" Autocommands
augroup init
    autocmd!
    " me
    autocmd WinEnter * cal EnterWin()
    autocmd WinLeave * cal LeaveWin()
    autocmd BufWinEnter * cal EnterWin()
    autocmd BufWinLeave * cal LeaveWin()

    " Filetypes
    autocmd FileType c,cpp,java,cs set commentstring=//\ %s
    autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END

"
" Special chars
" *\·•:,…!
" #․.‥—–-«»‹›¢¤ƒ£¥≡+−×÷=≠><≥≤±≈~¬∅∞∫∆∏∑√∂µ%‰∴∕∙▁▂▃▄▅▆▇█▀▔
" ▏▎▍▌▋▊▉▐▕▖▗▘▙▚▛▜▝▞▟░▒▓━│┃┄┅┆┇┈┉┊┋┌┍┎┏┐┑┒┓└┕┖┗┘┙┚┛├┝┞┟┠┡┢┣┤┥┦┧┨┩┪┫┬┭┮┯┰┱┲┳┴┵┶┷┸
" ┹┺┻┼┽┾┿╀╁╂╃╄╅╆╇╈╉╊╋╌╍╎╏═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬╭╮╯╰╱╲╳╴╵╶╷╸╹╺╻╼╽╾╿♥@¶§©®
"" ™°|¦†ℓ‡^̣´˘ˇ¸ˆ¨˙`˝¯˛˚˜

try
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

call StatusLine()
autocmd FileType qss set filetype=css
