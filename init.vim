"plugin pathogen stuf
execute pathogen#infect()
:
"Rainbow Para
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"Airline stuff"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
"Undo tree toggle! and assuming persistant undo!
nnoremap <F5> :UndotreeToggle<cr>

"vim stuff
set cinoptions+=g0,(0
set si
set sts=4
set sw=4
set et

" change cursor to i-beam in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

set listchars=tab:>-
set list
set relativenumber
set number
set wrap nowrap
set hlsearch
inoremap  
set cursorline
set laststatus=2

"map enter to insert cr and exit insert below, and shift enter for above
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
"map ctrl + D to clipboard
map <C-D> "+
inoremap <C-Z> <Esc>ui

hi clear
if exists("syntax_on")
  syntax reset
endif

set t_Co=256
colorscheme sin
