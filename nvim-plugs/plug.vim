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
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

"fzf, tagbar, and nerdtree
    map <c-s> :Ag 
    map <c-p> :Files<cr>
    map <m-]> :Tagbar<cr>
    map <C-n> :NERDTreeToggle<CR>

"vim airline
    let g:airline_powerline_fonts = 1
    let g:airline_theme='base16_twilight'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline_section_y = fnamemodify(getcwd(), ':t')
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:bufferline_echo = 0
    let g:bufferline_show_bufnr = 0

"easy motion
    nmap s <Plug>(easymotion-overwin-f2)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    let g:EasyMotion_smartcase = 1

"various things
    let g:startify_change_to_vcs_root = 1
    let g:ycm_complete_in_comments = 1
