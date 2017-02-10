"plugin pathogen stuf
execute pathogen#infect()
syntax on
filetype plugin indent on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
"no fuckin clue why it makes me set it..maybe it inherits somehow and 
"colorscheme Monokai
colorscheme seoul256-light

"vim stuff
let g:loaded_matchparen=1
set relativenumber 
set number
set wildmode=longest,list
set wrap nowrap
set hlsearch
map O3~ <End>
inoremap  
set cursorline
set cuc
highlight Cursorline cterm=underline
set fo=tcrwa textwidth=80


"gvim stuff...
set guioptions-=m
set guioptions-=T
set guioptions-=l
