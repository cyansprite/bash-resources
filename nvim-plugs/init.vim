" TODO
" Research formatprg
" Research include and define
" Research g ops
" Of [ ops like [I
" Of ] ops
" map ]f and [f because gf is the same and I never use it anyways...
" map arrow keys ??
" function for cpp  ->  ::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$

" Plug, colo {{{

if has("unix")
    so ~/.config/nvim/plug.vim
else
    so ~\AppData\Local\nvim\plug.vim
endif
set guicursor=n-c-v:block,i-ci:ver30,r-cr:hor20,o:hor100
colo restraint
if $TERMDARK
    set bg=dark
endif

"}}}
"Begin Vim set {{{
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
    set title title                " rxvt and tmux make this usable
    set titlestring=%<%F\ \ %y     " title, and titlestring
    set undofile                   " keep undo history ina file

    " Set: Those that use =
    let &showbreak = '↳ '          " Change show break thing (rare occasion)
    set cinkeys-=0#                " don't force # indentation, ever write python?
    set cmdheight=1                " Pair up
    set complete=.,w,b,u,U         " Complete all buffers,window, current
    set completeopt=menu           " I'm not a fan of auto documentation.
    set diffopt+=context:3         " diff context lines
    set foldcolumn=1               " foldcolumn... yes
    set foldmethod=marker          " fold stuff :)
    set foldopen+=jump,search      " open folds when I search/jump to things
    set icm="nosplit"              " inc command split in preview, hasn't worked
    set matchtime=0                " Show matching time
    set matchpairs+=<:>            " More matches
    set mouse=                     " Shame... but terminal functionality isn't always present.
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
    set fillchars=vert:\|,stlnc:_,stl:\ ,fold:.,diff:-
    " Changes listchars to more suitable chars
    set listchars=tab:>\ ,trail:·,extends:<,precedes:>,conceal:¦
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
    " Refresh my script bitch!
    nnoremap <F5> :w \| so %<cr>
    nnoremap <c-p> g;
    nnoremap <c-n> g,

    " TODO: make a set or something?
    nnoremap <leader>ea :e <c-r>%<c-w>
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

    " You know, fuck those arrow keys
    cnoremap <C-j> <down>
    cnoremap <C-k> <up>

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
" Begin Vim abbrev {{{
" I have a bad habit here...
    ca W w
    ca Echo echo
    ca Q q
    ca Set set
    ca Let let

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

    setl statusline+=%#diffRemoved#%r
    setl statusline+=%#Folded#\ %{ScopeStart()}%=
    setl statusline+=%<%-1.(%{ScopeEnd()}%<%=\ %4*%)

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
    setl statusline+=\ \ \ \ %*
    setl statusline+=:\ %LG,%p%%
endfunc

func! CurArg()
    let l:rtn = ''
    if argc() == 0 || argv(argidx()) !=# @%
        return @%
    endif
    let l:curarg = argv(argidx())
    let l:rtn .= '[' . l:curarg . ']'
    return l:rtn
endfun

func! Mode(mode)
    if !has_key(s:, "statusmodes")
        let s:statusmodes = {
                    \ "n"  : "            ",
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
    let track='+'

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
    exec "%s/\\s\\+$//ge"
endfu
command! -nargs=0 Kws call KillWhitespace()
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
"
" New Plugin: highlighty stuff... info soon... {{{1
let g:highlightactive=get(g:, 'highlightactive', 1)
" if !hlexists('InnerScope')
    hi InnerScope ctermbg=14 ctermfg=none cterm=bold guibg=#eeeeee
" endif
" if !hlexists('OuterScope')
    hi OuterScope ctermbg=6 ctermfg=none cterm=none guibg=#dddddd
" endif
" if !hlexists('LinkScope')
    hi LinkScope ctermbg=4 ctermfg=none cterm=none
" endif
" if !hlexists('SearchC')
" endif
" if !hlexists('UnderLine')
    hi Underline ctermfg=none ctermbg=none guibg=none guifg=none gui=underline cterm=underline
" endif

" Mapping to alter custom highlighting. {{{1
nnoremap <silent><c-space> :silent let g:highlightactive=!g:highlightactive<bar>
    \silent call AutoHighlightCurrentWord()<bar>
    \silent call ScopeIndentHighlight()<bar>
    \silent call HighlightCurrentSearchWord()<cr>

func! s:skipthis() "{{{1
    if has_key(g:,'curhighword')
        return len(g:curhighword) < g:smallest ||
        \ (match(g:curhighword, "\\A") != -1 && match(g:curhighword, "_") == -1)
    else
        return 1
    endif
endfunc

func! BlinkLineAndColumn() "{{{1
    " right now I just don't care
    " let oldc = &cursorcolumn
    " let oldl = &cursorline
    let s:distl = &scroll
    let s:distc = winwidth('.') * 9 / 10
    if &bg=="light"
        let s:colors = [254,253,252,253,254]
    else
        let s:colors = [235,237,239,237,235]
    endif

    if !has_key(s:, 'lastfile')
        let s:lastfile = expand('%')
    endif

    if !has_key(s:, 'lastline')
        let s:lastline = line('.')
    endif

    if !has_key(s:, 'lastcol')
        let s:lastcol = col('.')
    endif

    if s:lastfile != expand('%') || 
                \ abs(line('.') - s:lastline) > s:distl ||
                \ abs(col('.') - s:lastcol)   > s:distc
        if foldclosed('.') == -1
            " let s:lastcolor = (s:lastcolor) % 15 + 1
            " TODO:Figure out a color-thing that works well...
            for col in s:colors
                exec 'highlight CursorLine ctermbg=' . col
                exec 'highlight CursorColumn ctermbg=' . col
                redraw
            endfor
            highlight CursorLine ctermbg=none ctermfg=none guibg=none guifg=none cterm=none gui=none
            highlight CursorColumn ctermbg=none ctermfg=none guibg=none guifg=none cterm=none gui=none
        endif

    endif
    " echom s:lastcolor
    let s:lastfile = expand('%')
    let s:lastline = line('.')
    let s:lastcol = col('.')
endfunc

func! HighlightCurrentSearchWord() "{{{1
    try | call matchdelete(888) | catch *
    endtry
    try | call matchdelete(889) | catch *
    endtry

    if !g:highlightactive
        return
    endif

    " nbc Gets the first index.
    " nec Gets the last index (last - first + 1 == len).
    " n   Gets the next instance.
    try
        let sp = searchpos(@/, "nbc", line('.'))
        let sp2 = searchpos(@/, "nec", line('.'))
        let sp3 = searchpos(@/, "n", line('.'))
        let len = sp2[1] - sp[1] + 1

        if &hlsearch && sp != [0,0] && sp2 != [0,0] && (sp2[1] < sp3[1] || sp3 == [0,0])
            call matchaddpos('SearchC', [[line('.'), sp[1], l:len], ] , 888, 888)
        else
        endif
    catch E871
        echohl ErrorMsg
        echom "Invalid Search Pattern"
        echohl NONE
        return
    endtry
endfunc

func! AutoHighlightCurrentWord() "{{{1
    try | call matchdelete(999) | catch *
    endtry

    if g:highlightactive
        let g:curhighword = expand("<cword>")
        let g:smallest = 2

        if s:skipthis()
            return
        endif

        if !(g:curhighword == @/ && &hlsearch)
            try
                call matchadd('OuterScope', IgnoreCase().'\<'.g:curhighword.'\>', -999999, 999)
            catch E874
            endtry
        endif
    endif
endfun

func! NextCurrentWord(back)
  norm! m`
  call search('\c' . IgnoreCase().'\<'.g:curhighword.'\>', a:back)
endfunc
nnoremap <silent>m :call NextCurrentWord('')<cr>zv
nnoremap <silent>M :call NextCurrentWord('b')<cr>zv


func! IgnoreCase() "{{{1
    return &ignorecase ? '\c' : '\C'
endfunc

func! ScopeIndentHighlight() "{{{1
    try | call matchdelete(101010) | catch *
    endtry
    try | call matchdelete(666) | catc *
    endtry
    try | call matchdelete(667) | catch *
    endtry
    try | call matchdelete(668) | catch *
    endtry
    try | call matchdelete(111) | catch *
    endtry
    try | call matchdelete(112) | catch *
    endtry
    try | call matchdelete(222) | catch *
    endtry
    try | call matchdelete(333) | catch *
    endtry
    try | call matchdelete(223) | catch *
    endtry
    try | call matchdelete(334) | catch *
    endtry
    try | call matchdelete(444) | catch *
    endtry

    if &filetype == 'help' || &filetype == 'qf' || !g:highlightactive || mode() != 'n'
        return
    endif

    let l:start = line('0')
    let l:end = line('$')
    let indent = indent('.')

    if l:indent < &shiftwidth
        let l:indent = &shiftwidth
    endif

    let o_indent = l:indent
    let passby = 1
    let lastline = ''
    for x in reverse(range(l:start,line('.')))
        if indent(x) < l:indent && !empty(getline(x))
            let l:start = x
            let indent = indent(x) + 1
            break
        else
            let lastline = x
        endif
    endfor

    for x in range(line('.'), l:end)
        if indent(x) < l:indent && !empty(getline(x))
            let l:end = x
            break
        endif
    endfor

    if len(getline(l:end - 1)) == 0
        let l:end -= 1
    endif

    call matchadd('OuterScope',"\\%".1."c\\%>".l:start.'l\%<'.l:end.'l',-50,666)

    if l:indent == l:o_indent
        let l:indent = l:indent - &shiftwidth + 1
    endif

    if !l:passby
        let o_indent += &shiftwidth
        let l:indent += &shiftwidth
    else
    endif

    let g:scope_startline = getline(l:start)
    let l:indentmorestart = 0

    if l:start != l:end
        let g:scope_endline = getline(l:end)
    else
        let g:scope_endline = ''
    endif

    if match(g:scope_endline,'\s\{2,}end\|}') == -1
        let l:end -= 1
    endif

    " use \{2,} not \+ because what if you have else { or else if {
    " If curly on new line get above for scope startline and column
    if match(g:scope_startline,'\s\{2,}{') != -1
        let l:indentmorestart = 1
        let g:scope_startline = getline(l:start - l:indentmorestart)
    endif

    let l:if = -1

    " If else then get if as well
    if match(g:scope_startline, '\s\+else\|elif') != -1
        let l:if = search('^\s\{'.(l:o_indent-&shiftwidth).'}if', 'bn')
    endif

    " If case then get switch as well
    if match(g:scope_startline, '\s\{2,}case') != -1
        let l:if = search('^\s\{'.(l:o_indent-&shiftwidth).'}switch', 'bn')
    endif

    " If catch then go with try
    if match(g:scope_startline, '\s\{2,}catch') != -1
        let l:if = search('^\s\{'.(l:o_indent-&shiftwidth).'}try', 'bn')
    endif

    if l:if != -1
        call matchaddpos('LinkScope' , [[l:if     , 1    , l:indent - l:passby - 1] ,] , -50, 111)
        call matchaddpos('LinkScope' , [[l:if     , l:indent - l:passby, 1 ],] , -50, 112)
    endif

    let l:indentmoreend = 0
    if match(g:scope_endline,'\s\{2,}}') != -1
        let l:indentmoreend = 1
    endif

    if l:indent != 1
        call matchaddpos('InnerScope', [[l:start  , l:indent - 1    , 1] ,] , -50, 222)
        call matchaddpos('InnerScope', [[l:end    , l:indent - 1    , 1] ,] , -50, 333)
        " call matchaddpos('HoldScope1', [[l:start + 1  , l:indent - 1    , 1] ,] , -50, 223)
        " if l:start + 1 != l:end - 1
            " call matchaddpos('HoldScope1', [[l:end - 1    , l:indent - 1    , 1] ,] , -50, 334)
            " call matchaddpos('HoldScope', [[l:end - 1    , 2    , l:indent - 3  + l:indentmoreend  ] ,] , -50, 668)
        " endif
        " call matchaddpos('HoldScope', [[l:start + 1  , 2    , l:indent - 3  + l:indentmorestart] ,] , -50, 667)
    endif

    let s:scope_start = l:start
    let s:scope_end   = l:end
    " try | call matchdelete(010101) | catch *
    " endtry
    " call matchaddpos('HoldScope1', [[line('.'), 80, 50] ,] , -50, 010101)
endfun

func! SearchOnlyThisScope() "{{{1
    return '\%>'.(s:scope_start).'l\%<'.(s:scope_end + 1).'l'
endfun
nnoremap <Plug>(ScopeSearch) /<c-r>=SearchOnlyThisScope()<cr>
nnoremap <Plug>(ScopeSearchReplace) :%s/<c-r>=SearchOnlyThisScope()<cr>
nnoremap <Plug>(ScopeSearchStar) /\<<c-r>=SearchOnlyThisScope()<cr><c-r><c-w>\><cr>
nnoremap <Plug>(ScopeSearchStarAppend) /<c-r><c-/>\\|\<<c-r>=SearchOnlyThisScope()<cr><c-r><c-w>\><cr>
nnoremap <Plug>(ScopeSearchStarReplace) :%s/\<<c-r>=SearchOnlyThisScope()<cr><c-r><c-w>\>/
nmap <leader>* <Plug>(ScopeSearchStar)N
nmap <leader># <Plug>(ScopeSearchStarAppend)N
nmap <leader>/ <Plug>(ScopeSearch)
nmap <F7> <Plug>(ScopeSearchStarReplace)
nmap <F6> <Plug>(ScopeSearchReplace)

augroup scope "{{{1
    autocmd!
    autocmd CursorMoved * call ScopeIndentHighlight() | call AutoHighlightCurrentWord() | call HighlightCurrentSearchWord() | call BlinkLineAndColumn()
    autocmd CursorHold  * call ScopeIndentHighlight() | call AutoHighlightCurrentWord() | call HighlightCurrentSearchWord()
    autocmd InsertEnter * call ScopeIndentHighlight() | call AutoHighlightCurrentWord() | call HighlightCurrentSearchWord()
augroup END

" }}}1
" Special chars {{{
" *\·•:,…!
" #․.‥—–-«»‹›¢¤ƒ£¥≡+−×÷=≠><≥≤±≈~¬∅∞∫∆∏∑√∂µ%‰∴∕∙▁▂▃▄▅▆▇█▀▔
" ▏▎▍▌▋▊▉▐▕▖▗▘▙▚▛▜▝▞▟░▒▓━│┃┄┅┆┇┈┉┊┋┌┍┎┏┐┑┒┓└┕┖┗┘┙┚┛├┝┞┟┠┡┢┣┤┥┦┧┨┩┪┫┬┭┮┯┰┱┲┳┴┵┶┷┸
" ┹┺┻┼┽┾┿╀╁╂╃╄╅╆╇╈╉╊╋╌╍╎╏═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬╭╮╯╰╱╲╳╴╵╶╷╸╹╺╻╼╽╾╿♥@¶§©®
"" ™°|¦†ℓ‡^̣´˘ˇ¸ˆ¨˙`˝¯˛˚˜
