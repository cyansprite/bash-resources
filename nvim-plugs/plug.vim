" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'wellle/targets.vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-signify'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Do this after pull
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"wrap it up
call plug#end()

"Plugin options
"Gen tags
"let g:gen_tags#gtags_auto_gen = 1
"let g:gen_tags#ctags_auto_gen = 1
"let g:gen_tags#verbose = 1

" Keys that do stuff
"Ctrl+\ c    Find functions calling this function
"Ctrl+\ d    Find functions called by this function
"Ctrl+\ e    Find this egrep pattern
"Ctrl+\ f    Find this file
"Ctrl+\ g    Find this definition
"Ctrl+\ i    Find files #including this file
"Ctrl+\ s    Find this C symbol
"Ctrl+\ t    Find this text string
"map <leader>g <c-\>

"fzf
map <c-s> :Ag 
map <c-p> :Files<cr>

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"vim airline
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_twilight'
let g:airline#extensions#tabline#enabled = 1

  let g:airline_left_sep = ''
  let g:airline_right_sep = ''

"easy motion
nmap s <Plug>(easymotion-overwin-f2)

let g:startify_change_to_vcs_root = 1
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif

map <C-n> :NERDTreeToggle<CR>

let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

map <c-[> :Tags<cr>
map <m-[> :BTags<cr>
