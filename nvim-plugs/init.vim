call elemental#assimilate()
"The 4 most important lines
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
set termguicolors
colorscheme cyansprite
map <space> <leader>
map <leader>ee :ElemOpenList<cr>

"''
"''

"Begin Vim set   -------------------------
auto BufEnter * let &titlestring = "NVIM   %f%h%m%r%y   "
"set clipboard+=unnamed
set sol nosol
set viewoptions=cursor,folds
set foldcolumn=0
set mouse=a
set title titlestring=%P
set cursorline "set cursorline to highlight the current line I'm no
set showmode noshowmode "don't show mode in cmd line, I hate when it clears an echo
set shiftwidth=4               " Use indents of 4 spaces
set tabstop=4                  " An indentation every four columns
set softtabstop=4              " Let backspace delete indent
set expandtab                  " Expands tab to spaces
set splitbelow "when split, split below the window instead of above
set splitright "when vsplit, splt to the right instead of left
set showcmd                    "Show cmd while typing
set ignorecase "in the name
set smartcase  "makes things a bit better
set smartindent "indent things well
set smarttab	"tab plays nicer
set list        "list my chars╳
set fillchars=vert:│,stlnc:-,stl:\ ,fold:*,diff: "set fill chars to things that make me happy
set listchars=tab:→\ ,trail:·,extends:┇,precedes:┇  "Changes listchars to more suitable chars
let &showbreak = '↳ '          "Change show break thing
set showmatch      " Show matching brackets/parentthesis
set matchtime=1    " Show matching time
set report=0       " Always report changed lines
if &modifiable | set number | endif "If it's modifable, turn on numbers
"End   Vim set   -------------------------

nmap <cr> gg
vmap <cr> gg

"[Pre/App]end to the word under the cursor
"And in visual mode, slow movement
map <m-a> ea
map <m-i> bi
map <m-p> ep
map <m-P> bP

map <silent><pageup> <c-u>
map <silent><pagedown> <c-d>
inoremap <silent><c-v> <esc>gpa

"Smooth scroll

"Map some clipboard function
vnoremap  "+y
vnoremap <c-v> "+P
vnoremap <c-x> "+d

"Search and replace word under cursor
nnoremap <F6> :%s/<C-r><C-w>/

"Map home and end to ^$ respect'
nnoremap <End> $
nnoremap <Home> ^
vnoremap <End> $
vnoremap <Home> ^

"s-lrud for window movement
nnoremap <silent> <s-up> :wincmd k<CR>
nnoremap <silent> <s-down> :wincmd j<CR>
nnoremap <silent> <s-left> :wincmd h<CR>
nnoremap <silent> <s-right> :wincmd l<CR>
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>
tnoremap <silent> <s-up> <C-\><C-n>:wincmd k<CR>
tnoremap <silent> <s-down> <C-\><C-n>:wincmd j<CR>
tnoremap <silent> <s-left> <C-\><C-n>:wincmd h<CR>
tnoremap <silent> <s-right> <C-\><C-n>:wincmd l<CR>

"Copy full path of filename to black hole
nnoremap <M-Y> :let @" = expand("%:p")<cr>

"I like playing with colors (Gives me hi-lo ids)
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"End   Mappings   -------------------------

"Aucmd time       -------------------------
let g:doGoldRatioActive=1
let g:GoldRatio=1.6
let g:doAutoNumInActive=1
let g:killInactiveCursor=1
let g:doAutoWrap=1
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
    execute "mksession! " . $HOME . "/.config/nvim/lastSession.vim"
    if &modifiable
        mkview
    endif
endfun

func! EnterBufWin()
    if argc() == 0 && filereadable($HOME . "/.config/nvim/lastSession.vim") 
        execute "source " . $HOME . "/.config/nvim/lastSession.vim"
    endif

    if &modifiable && filereadable(&viewdir .'/~=+.config=+nvim=+'.expand('%:t').'=')
        silent loadview
    endif
endfun


augroup init
    autocmd!
    autocmd WinEnter * cal EnterWin()
    autocmd BufWinLeave * cal LeaveBufWin()
    autocmd BufWinEnter * cal EnterBufWin()
augroup END
"End    Aucmd   -------------------------

"Symbols
" AÁĂÂÄÀĀĄÅÃÆBCĆČÇĈDÐĎĐEÉĚÊËĖÈĒĘFGĜHĤIĲÍÎÏÌĪĮJĴKLĹĽĿŁMNŃŇÑOÓÔÖÒŐŌØÕŒPÞQRŔŘSŚŠŞŜTŦŤUÚŬÛÜÙŰŪŲŮVWẂŴẄẀXYÝŶŸỲZŹŽŻŢa
" áăâäàāąåãæbcćčçĉdðďđeéěêëėèēęfgĝhĥiıíîïìĳīįjȷĵklĺľŀłmnńňñoóôöòőōøõœpþqrŕřsśšşŝßtŧťuúŭûüùűūţųůvwẃŵẅẁxyýŷÿỳzźžż
" ªºАБВГЃДЕЁЖЗИЙКЌЛМНОПРСТУФХЧЦШЩЬЪЫЅЭІЇЈЮЯӀӢӮабвгѓдеёжзийкќлмнопрстуфхчцшщьъыѕэіјюяһӣӯΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ
" αβγδεζηθικλμνξοπρστυφχψω0123456789⁄⅟½↉⅓⅔¼¾⅕⅖⅗⅘⅙⅚⅐⅛⅜⅝⅞⅑⅒*\·•:,…!‼¡#․.?¿"';/‥_{}[]()—–-«»‹›„“”‘‛’
" €¢¤$ƒ£¥≡+−×÷=≠><≥≤±≈~¬∅∞∫∆∏∑√∂µ%‰∴∕∙▁▂▃▄▅▆▇█▀▔▏▎▍▌▋▊▉▐▕▖▗▘▙▚▛▜▝▞▟░▒▓━│┃┄┅┆┇┈┉┊┋┌┍┎┏┐┑┒┓└┕┖┗┘┙┚┛
"├┝┞┟┠┡┢┣┤┥┦┧┨┩┪┫┬┭┮┯┰┱┲┳┴┵┶┷┸┹┺┻┼┽┾┿╀╁╂╃╄╅╆╇╈╉╊╋╌╍╎╏═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬╭╮╯╰╱╲╳╴╵╶╷╸╹╺╻╼╽╾╿
"♥@&¶§©®™°|¦†ℓ‡^̣´˘ˇ¸ˆ¨˙`˝¯˛˚˜ 
"
