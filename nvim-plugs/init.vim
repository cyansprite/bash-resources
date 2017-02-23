"plugin pathogen stuf
""""
execute pathogen#infect()
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
"Rainbow Para
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadSquare

"Airline stuff"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

let g:easytags_dynamic_files = 2
let b:easytags_auto_highlight = 0

"vim stuff
set sts=4
set sw=4
set et
set wildmode=list:longest:full
set splitbelow
set splitright
let &showbreak = '↳ '

" change cursor to i-beam in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

set listchars=tab:>-
set list
set relativenumber
set number
set wrap nowrap
set hidden
inoremap  
set cursorline

"map enter to insert cr and exit insert below, and shift enter for above
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
"map ctrl + D to clipboard
map <F2> :tabedit <cr>:terminal<cr>
"map Y to copy to clip
map Y "+y
"map Meta p/P to paste from clipboard before and after
map <M-P> "+P
map <M-p> "+p

set t_Co=256
colorscheme snow

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
