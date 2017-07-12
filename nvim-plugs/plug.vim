call plug#begin('~/.local/share/nvim/plugged')
    Plug 'pseewald/vim-anyfold'

    " IDE like shit
    Plug 'scrooloose/nerdtree'
    Plug 'majutsushi/tagbar'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'mhinz/vim-startify'
    Plug 'sjl/gundo.vim'
    Plug 'vasconcelloslf/vim-interestingwords'

    " Motion stuff
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'terryma/vim-expand-region'

    " Format (I need a new formatter)
    Plug 'foosoft/vim-argwrap'
    Plug 'andrewradev/sideways.vim'
    Plug 'godlygeek/tabular'
    Plug 'scrooloose/nerdcommenter'
    Plug 'farfanoide/inflector.vim'

    " Autocompelete
    Plug 'jiangmiao/auto-pairs'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --omnisharp-completer' }

    " Pretty stuff
    Plug 'Valloric/vim-operator-highlight'
    Plug 'vim-scripts/TagHighlight'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-bufferline'
    Plug 'arithran/vim-delete-hidden-buffers'

    " Source control
    Plug 'junegunn/gv.vim'
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
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

"vim airline and options
    " Lengthy process to setup airline...but hey, I'm picky
    let g:airline_powerline_fonts = 1
    let g:airline_theme='bubblegum'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_close_button = 0
    " let g:airline_section_y = fnamemodify(getcwd(), ':t')
    let g:airline_section_y = getcwd()
    " win doesn't know how to render these correctly...because it sucks
    if(has("unix"))
        let g:airline_left_sep = '█▓▒░'
        let g:airline_right_sep = '░▒▓█'
    else
        let g:airline_left_sep = ''
        let g:airline_right_sep = ''
    endif
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

    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'
    let g:interestingWordsRandomiseColors = 1
    let g:interestingWordsGUIColors = [ '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF' ]
    nnoremap <silent> <leader>/ :call InterestingWords('n')<cr>
    nnoremap <silent> <leader>? :call UncolorAllWords()<cr>
    let anyfold_activate=1
    set foldlevel=0

    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    " Enable per-command history.
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = '~/.local/share/fzf-history'
