call plug#begin('~/.local/share/nvim/plugged')
    " IDE like shit
    Plug 'majutsushi/tagbar'

    " Motion stuff
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'thinca/vim-visualstar'
    Plug 'chaoren/vim-wordmotion'

    " Format
    Plug 'foosoft/vim-argwrap'
    Plug 'godlygeek/tabular'
    Plug 'scrooloose/nerdcommenter'
    Plug 'sbdchd/neoformat'
    Plug 'flazz/vim-colorschemes'

    " Autocompelete
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'cyansprite/CmdlineComplete'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --omnisharp-completer' }

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
        let g:UltiSnipsExpandTrigger="<c-e>"
        let g:UltiSnipsJumpBackwardTrigger="<c-b>"
        let g:UltiSnipsEditSplit="vertical"

    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings  = 1

    nnoremap <silent> <leader>A :ArgWrap<CR>

    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'

    let g:targets_nlNL = 'nlNL'
