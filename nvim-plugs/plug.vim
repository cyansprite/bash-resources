" plugins (Plug.vim) {{{
call plug#begin('~/.local/share/nvim/plugged')
    " IDE like shit
    Plug 'majutsushi/tagbar'

    " Motion stuff
    Plug 'wellle/targets.vim'
    Plug 'thinca/vim-visualstar'
    Plug 'chaoren/vim-wordmotion'
    Plug 'cyansprite/extract'

    " Format
    Plug 'foosoft/vim-argwrap'
    Plug 'godlygeek/tabular'
    Plug 'scrooloose/nerdcommenter'
    Plug 'sbdchd/neoformat'

    " Autocompelete
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'cyansprite/CmdlineComplete'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --omnisharp-completer' }

    " Source control
    Plug 'airblade/vim-gitgutter'
    " Plug 'tpope/vim-fugitive'
call plug#end()
"}}}

" mappings {{{
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

    let g:wordmotion_mappings = {
                \ 'w' : '<M-w>',
                \ 'b' : '<M-b>',
                \ 'e' : '<M-e>',
                \ 'ge' : 'g<M-e>',
                \ 'aw' : 'a<M-w>',
                \ 'iw' : 'i<M-w>',
                \ '<C-R><C-W>' : '<C-R><M-w>'
                \ }

"}}}
