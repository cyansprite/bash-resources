call plug#begin('~/.local/share/nvim/plugged')
    Plug 'wellle/targets.vim'
    Plug 'terryma/vim-expand-region'
    Plug 'godlygeek/tabular'
    Plug 'sjl/gundo.vim'
    Plug 'chrisbra/colorizer'
    Plug 'sbdchd/neoformat'
    Plug 'vasconcelloslf/vim-interestingwords'
    Plug 'pseewald/vim-anyfold'
    Plug 'vim-airline/vim-airline'
    Plug 'michaeljsmith/vim-indent-object'
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
    Plug 'arithran/vim-delete-hidden-buffers'
    Plug 'romainl/vim-qf'
    Plug 'foosoft/vim-argwrap'
    Plug 'farfanoide/inflector.vim'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    Plug 'scrooloose/nerdcommenter'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'jiangmiao/auto-pairs'
call plug#end()

" mappings
    " fzf
        noremap <c-s> :Ag 
        noremap <c-p> :Files<cr>
    " Tagbar, nerd tree
        noremap <m-]> :Tagbar<cr>
        noremap <m-\> :NERDTreeToggle<CR>
    " Startify edit, vsp, or split
        nnoremap <leader>se :Startify<cr>
        nnoremap <leader>sv :vsp \| Startify<cr>
        nnoremap <leader>ss :sp \| Startify<cr>
    " Sideways movement
        nnoremap <m-h> :SidewaysLeft<cr>
        nnoremap <m-l> :SidewaysRight<cr>
    " Ultisnips activation and movement
        let g:UltiSnipsJumpForwardTrigger="<c-b>"
        let g:UltiSnipsJumpBackwardTrigger="<c-z>"
        let g:UltiSnipsEditSplit="vertical"
    " Auto pairs pair movement
        let g:AutoPairsShortcutJump='<c-n>'

"vim airline
    " Lengthy process to setup airline...but hey, I'm picky
    let g:airline_powerline_fonts = 1
    let g:airline_theme='base16_twilight'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 0
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

    let g:startify_change_to_vcs_root = 1
    let g:startify_bookmarks = [
            \ { 'p': '~/.config/nvim/plug.vim' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'c': '~/.config/nvim/colors/chill.vim' },
            \ ]

    let g:ycm_complete_in_comments = 1

    let g:clever_f_fix_key_direction = 1
    let g:clever_f_across_no_line=1

    let g:inflector_mapping = 'gi'


    nnoremap <silent> <leader>a :ArgWrap<CR>

    let g:qf_auto_resize = 1
    nmap <leader>qq <Plug>(qf_qf_toggle)
    nmap <leader>ll <Plug>(qf_loc_toggle)

    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'
    let g:interestingWordsRandomiseColors = 1
    let g:interestingWordsGUIColors = [ '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF' ]

    au bufread * ColorHighlight!
