"plugin pathogen stuf
""""
execute pathogen#infect()
"Rainbow Para
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound

"Airline stuff"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

let g:easytags_dynamic_files = 2
let b:easytags_auto_highlight = 0

"vim stuff
set shiftwidth=4   " Use indents of 4 spaces
set tabstop=4      " An indentation every four columns
set softtabstop=4  " Let backspace delete indent
set et
set wildmode=list:longest:full
set splitbelow
set splitright
set showcmd        "Show cmd while typing
let &showbreak = '↳ ' "Change show break thing
set cpo=n          "Show break in line numbers with wrap on
set showmode nosmd
set ignorecase
set smartcase
set smartindent
set smarttab
set scrolloff=10    " Minumum lines to keep above and below cursor
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶
set list
set relativenumber
set number
set wrap nowrap
set hidden         " Allow buffer switching without saving
inoremap  
set cursorline
set showmatch      " Show matching brackets/parentthesis
set matchtime=5    " Show matching time
set report=0       " Always report changed lines
set linespace=0    " No extra spaces between rows
set t_ut=          "On those rare occasions I use tmux

" change cursor to i-beam in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1


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
"Map c-left and right to switch between buffers
map <C-left> :bp<cr>
map <C-right> :bn<cr>
"Map <C-E> to close current buffer
map <C-E> :bd<cr>
nmap <C-W><left> :windo left<CR>

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F5> :w<CR>

set t_Co=256
colorscheme snow

let g:UltiSnipsExpandTrigger="<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-v>"
