"plugin pathogen stuf
execute pathogen#infect()
syntax on
filetype plugin indent on

"Rainbow Para
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"Airline stuff"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='vice'
"Undo tree toggle! and assuming persistant undo!
nnoremap <F5> :UndotreeToggle<cr>
if has("persistent_undo")
	    set undodir=~/.undodir/
	        set undofile
endif

"vim stuff
let g:loaded_matchparen=1
set relativenumber
set number
set wildmode=longest,list
set wrap nowrap
set hlsearch
inoremap  
set cursorline
set cuc
set mouse=a
"map enter to insert cr and exit insert below, and shift enter for above
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
"map ctrl + D to clipboard
map <C-D> "+
inoremap <C-Z> <Esc>ui

"gvim stuff...
set guioptions-=T
set laststatus=2

hi clear
if exists("syntax_on")
  syntax reset
endif

set t_Co=256

"Cursor and Visual
hi Cursor         ctermfg = NONE ctermbg = NONE cterm = inverse
hi visual         ctermfg = NONE ctermbg = NONE cterm = standout
hi cursorline     ctermfg = NONE ctermbg = 234  cterm = bold
hi cursorcolumn   ctermfg = NONE ctermbg = 234  cterm = bold
hi MatchParen     ctermfg = NONE ctermbg = NONE cterm = underline

"LineNumber
hi CursorLineNr   ctermfg = 118  ctermbg = 0    cterm = NONE
hi LineNr         ctermfg = 33   ctermbg = 0    cterm = NONE
hi VertSplit      ctermfg = 241  ctermbg = 241  cterm = NONE
hi ModeMsg        ctermfg = NONE ctermbg = NONE cterm = standout

"tab line!
hi TabLine        ctermfg = NONE ctermbg = NONE cterm = NONE
hi TabLineSel     ctermfg = NONE ctermbg = NONE cterm = NONE
hi TabLineFill    ctermfg = NONE ctermbg = NONE cterm = NONE

"Status line!
hi StatusLine     ctermfg = 231  ctermbg = 241  cterm = bold
hi StatusLineNC   ctermfg = 231  ctermbg = 241  cterm = NONE
hi WildMenu       ctermfg = 231  ctermbg = 241  cterm = NONE

"hint popup-menu!
hi Pmenu          ctermfg = NONE ctermbg = NONE cterm = NONE
hi PmenuSel       ctermfg = NONE ctermbg = 59   cterm = NONE

"searching!
hi IncSearch      ctermfg = NONE ctermbg = NONE cterm = NONE
hi Search         ctermfg = NONE ctermbg = NONE cterm = underline

"dir
hi Directory      ctermfg = 141  ctermbg = NONE cterm = NONE
hi Folded         ctermfg = 242  ctermbg = 235  cterm = NONE

"types
hi SignColumn     ctermfg = NONE ctermbg = 237  cterm = NONE
hi Normal         ctermfg = 231  ctermbg = 235  cterm = NONE
hi Boolean        ctermfg = 196  ctermbg = NONE cterm = NONE
hi Character      ctermfg = 66   ctermbg = NONE cterm = NONE
hi Comment        ctermfg = 11   ctermbg = 0    cterm = NONE
hi Conditional    ctermfg = 141  ctermbg = NONE cterm = NONE
hi Constant       ctermfg = 202  ctermbg = 232  cterm = underline
hi Define         ctermfg = 197  ctermbg = NONE cterm = NONE
hi DiffAdd        ctermfg = 231  ctermbg = 64   cterm = bold
hi DiffDelete     ctermfg = 88   ctermbg = NONE cterm = NONE
hi DiffChange     ctermfg = NONE ctermbg = NONE cterm = NONE
hi DiffText       ctermfg = 231  ctermbg = 24   cterm = bold
hi ErrorMsg       ctermfg = 246  ctermbg = 160  cterm = NONE
hi WarningMsg     ctermfg = 246  ctermbg = 227  cterm = NONE
hi Float          ctermfg = 76   ctermbg = NONE cterm = NONE
hi Number         ctermfg = 148  ctermbg = NONE cterm = NONE
hi Function       ctermfg = 79   ctermbg = NONE cterm = NONE
hi Identifier     ctermfg = 230  ctermbg = NONE cterm = NONE
hi Keyword        ctermfg = 45   ctermbg = NONE cterm = NONE
hi Label          ctermfg = 186  ctermbg = NONE cterm = NONE
hi NonText        ctermfg = 59   ctermbg = 236  cterm = NONE
hi Operator       ctermfg = 231  ctermbg = NONE cterm = NONE
hi PreProc        ctermfg = 14   ctermbg = NONE cterm = NONE
hi Special        ctermfg = 231  ctermbg = NONE cterm = NONE
hi SpecialKey     ctermfg = 59   ctermbg = 237  cterm = NONE
hi Statement      ctermfg = 219  ctermbg = NONE cterm = NONE
hi StorageClass   ctermfg = 81   ctermbg = NONE cterm = NONE
hi String         ctermfg = 71   ctermbg = NONE cterm = NONE
hi Tag            ctermfg = 9    ctermbg = NONE cterm = NONE
hi Title          ctermfg = 231  ctermbg = NONE cterm = bold
hi Todo           ctermfg = NONE ctermbg = NONE cterm = inverse
hi Type           ctermfg = 159  ctermbg = NONE cterm = NONE
hi Macro          ctermfg = NONE ctermbg = NONE cterm = NONE
hi Underlined     ctermfg = NONE ctermbg = NONE cterm = underline
"End of colors
