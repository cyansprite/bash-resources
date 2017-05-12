" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'vim-utils/vim-man'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'jsfaint/gen_tags.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-fugitive'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Do this after pull
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"wrap it up
call plug#end()


"Plugin options
"Gen tags
let g:gen_tags#gtags_auto_gen = 1
let g:gen_tags#ctags_auto_gen = 1
let g:gen_tags#verbose = 1
" Keys that do stuff
"Ctrl+\ c    Find functions calling this function
"Ctrl+\ d    Find functions called by this function
"Ctrl+\ e    Find this egrep pattern
"Ctrl+\ f    Find this file
"Ctrl+\ g    Find this definition
"Ctrl+\ i    Find files #including this file
"Ctrl+\ s    Find this C symbol
"Ctrl+\ t    Find this text string
map <leader>g <c-\>

"inc search /fzf
map /  <Plug>(incsearch-forward)
map ?  :Ag 
map g/ <Plug>(incsearch-stay)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"vim airline
let g:airline_powerline_fonts = 1
let g:airline_theme='raven'
let g:airline#extensions#tabline#enabled = 1

"easy motion
nmap s <Plug>(easymotion-overwin-f2)
