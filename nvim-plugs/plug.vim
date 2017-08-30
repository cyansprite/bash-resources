" plugins (Plug.vim) {{{
call plug#begin('~/.local/share/nvim/plugged')
    " Motion stuff
    Plug 'wellle/targets.vim'
    Plug 'thinca/vim-visualstar'
    Plug 'chaoren/vim-wordmotion'
    Plug 'cyansprite/extract'

    " Format
    Plug 'foosoft/vim-argwrap'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-commentary'

    " Syntax
    Plug 'cyansprite/vim-csharp'
    Plug 'octol/vim-cpp-enhanced-highlight'

    " Autocompelete
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --omnisharp-completer' }
    Plug 'cyansprite/CmdlineComplete'

    " Source control
    Plug 'airblade/vim-gitgutter'
call plug#end()
"}}}

" mappings {{{
    " Ultisnips activation and movement
    let g:UltiSnipsJumpForwardTrigger="<c-f>"
    let g:UltiSnipsExpandTrigger="<c-e>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"


    nnoremap <silent> <leader>A :ArgWrap<CR>

    let g:targets_nlNL = 'nN  '

    let g:wordmotion_mappings = {
                \ 'w' : '<leader>w',
                \ 'b' : '<leader>b',
                \ 'e' : '<leader>e',
                \ 'iw' : 'i<leader>w',
                \ '<C-R><C-W>' : '<C-R><M-w>'
                \ }
"}}}

" options {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1

let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_warning_symbol = '>>'
let g:ycm_error_symbol = 'XX'
let g:ycm_always_populate_location_list = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings  = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_auto_trigger = 0

" }}}
