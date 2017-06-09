" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-bufferline'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Do this after pull
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"wrap it up
call plug#end()

"Plugin options

"fzf
map <c-s> :Ag 
map <c-p> :Files<cr>
map <m-[> :BTags<cr>

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"vim airline
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_twilight'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_section_y = fnamemodify(getcwd(), ':t')
let g:airline_left_sep = ''
let g:airline_right_sep = ''

"easy motion
nmap s <Plug>(easymotion-overwin-f2)

let g:startify_change_to_vcs_root = 1

map <C-n> :NERDTreeToggle<CR>

let g:ycm_complete_in_comments = 1
