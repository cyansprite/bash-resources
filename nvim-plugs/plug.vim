call plug#begin('~/.local/share/nvim/plugged')
    Plug 'wellle/targets.vim'
    Plug 'terryma/vim-expand-region'
    Plug 'junegunn/vim-easy-align'
    Plug 'vim-airline/vim-airline'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'chrisbra/nrrwrgn'
    Plug 'guns/xterm-color-table.vim'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-startify'
    Plug 'scrooloose/nerdtree'
    Plug 'bling/vim-bufferline'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-signify'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'andrewradev/sideways.vim'
    Plug 'vim-scripts/TagHighlight'
    Plug 'rhysd/clever-f.vim'
    Plug 'thaerkh/vim-workspace'
    Plug 'romainl/vim-qlist'
    Plug 'arithran/vim-delete-hidden-buffers'
    Plug 'wahidrahim/resize-font'
    Plug 'romgrk/replace.vim'
    Plug 'romainl/vim-qf'
    Plug 'andrewvos/vim-git-navigator'
    Plug 'foosoft/vim-argwrap'
    Plug 'farfanoide/inflector.vim'
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
    "let g:airline#extensions#tabline#tab_min_count = 2
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline_section_y = fnamemodify(getcwd(), ':t')
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline#extensions#tagbar#flags = 'f'
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#show_message = 0
    let g:airline#extensions#tabline#tab_nr_type = 2
    let g:airline#extensions#tabline#tabs_label = 't'
    call airline#parts#define_accent('-', 'red')
    silent! call airline#extensions#whitespace#disable()

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
    let g:clever_f_fix_key_direction = 1

    " This is like calling R with g:replace_register=='|'
    nmap R <Plug>ReplaceOperator
    vmap R <Plug>ReplaceOperator
    nmap X <Plug>ExchangeOperator
    let g:inflector_mapping = 'gi'


    nnoremap <m-h> :SidewaysLeft<cr>
    nnoremap <m-l> :SidewaysRight<cr>

    nnoremap <silent> <leader>a :ArgWrap<CR>
    let g:qf_auto_resize = 0
