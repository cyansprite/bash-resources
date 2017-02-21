"plugin pathogen stuf
execute pathogen#infect()
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
"Rainbow Para
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"ctags
set tags=./tags;
let g:easytags_dynamic_files = 2
let g:easytags_events = ['BufWritePost']
let g:easytags_auto_update = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Airline stuff"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
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
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>jnoremap <F2> :OmniSharpRename<cr>

hi clear
if exists("syntax_on")
  syntax reset
endif

set t_Co=256
colorscheme snow

"let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
