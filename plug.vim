"set termguicolors

call plug#begin('~/.local/share/nvim/plugged')
    Plug 'wellle/targets.vim'
    Plug 'terryma/vim-expand-region'
    Plug 'godlygeek/tabular'
    Plug 'sjl/gundo.vim'
    Plug 'vasconcelloslf/vim-interestingwords'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mhinz/vim-startify'
    Plug 'scrooloose/nerdtree'
    Plug 'bling/vim-bufferline'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-signify'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'andrewradev/sideways.vim'
    Plug 'rhysd/clever-f.vim'
    Plug 'arithran/vim-delete-hidden-buffers'
    Plug 'romainl/vim-qf'
    Plug 'foosoft/vim-argwrap'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    Plug 'valloric/vim-operator-highlight'
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-scripts/TagHighlight'
    Plug 'farfanoide/inflector.vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'sbdchd/neoformat'

    Plug 'chrisbra/colorizer'
    "Plug 'yggdroot/indentline'
    "Plug 'pseewald/vim-anyfold'
    "Plug 'guns/xterm-color-table.vim'
    "Plug 'flazz/vim-colorschemes'
    "Plug 'tpope/vim-fugitive'
    "Plug 'zefei/vim-colortuner'
    "Plug 'roxma/nvim-completion-manager'
    "Plug 'roxma/clang_complete'
    "Plug 'michaeljsmith/vim-indent-object'
    "Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

"fzf, tagbar, and nerdtree
    map <c-s> :Ag
    map <c-p> :Files<cr>
    map <m-]> :Tagbar<cr>
    map <m-\> :NERDTreeToggle<CR>

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
    let g:qf_auto_resize = 1

    let g:startify_bookmarks = [
            \ { 'p': '~/AppData/Local/nvim/plug.vim' },
            \ { 'i': '~/AppData/Local/nvim/init.vim' },
            \ { 'c': '~/AppData/Local/nvim/colors/chill.vim' },
            \ ]

    nnoremap <leader>se :Startify<cr>
    nnoremap <leader>sv :vsp \| Startify<cr>
    nnoremap <leader>ss :sp \| Startify<cr>
    nmap <leader>qq <Plug>(qf_qf_toggle)
    nmap <leader>ll <Plug>(qf_loc_toggle)
    let g:UltiSnipsExpandTrigger="<c-d>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"
    "inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    "inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    "let g:clang_library_path="/usr/lib/llvm-4.0/lib"
    let g:AutoPairsShortcutJump='<c-n>'
    let g:clever_f_across_no_line=1
    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'
    let g:interestingWordsRandomiseColors = 1
    let g:interestingWordsGUIColors = [ '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF' ]
    let g:ophigh_color_gui = "#ffffff"
