call plug#begin('~/.local/share/nvim/plugged')
    " IDE like shit
    Plug 'majutsushi/tagbar'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Motion stuff
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'thinca/vim-visualstar'

    " Format (I need a new formatter)
    Plug 'foosoft/vim-argwrap'
    Plug 'godlygeek/tabular'
    Plug 'scrooloose/nerdcommenter'
    Plug 'cyansprite/vim-fold-cycle'
    Plug 'sbdchd/neoformat'

    " Autocompelete
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'cyansprite/CmdlineComplete'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --omnisharp-completer' }

    " Pretty stuff
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-bufferline'

    " Source control
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
call plug#end()

" mappings
    " fzf
        noremap <c-s> :Ag 
        noremap <c-p> :Files<cr>
    " Tagbar, nerd tree
        noremap <m-]> :Tagbar<cr>
        noremap <m-\> :NERDTreeToggle<CR>
    " Ultisnips activation and movement
        let g:UltiSnipsJumpForwardTrigger="<c-f>"
        let g:UltiSnipsExpandTrigger="<c-g>"
        let g:UltiSnipsJumpBackwardTrigger="<c-b>"
        let g:UltiSnipsEditSplit="vertical"

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
    let g:bufferline_rotate = 1 "weep
    let g:bufferline_fixed_index =  0 "always first



    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings  = 1

    nnoremap <silent> <leader>A :ArgWrap<CR>

    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'

    " Won't close when max fold is opened
    " Won't open when max fold is closed
    let g:fold_cycle_toggle_max_open  = 0
    let g:fold_cycle_toggle_max_close = 0

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

    " autocmd VimEnter * nested :call tagbar#autoopen(1)
