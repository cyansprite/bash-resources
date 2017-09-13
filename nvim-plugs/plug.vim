" plugins (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')
    " Motion stuff
    Plug 'wellle/targets.vim'
    Plug 'bronson/vim-visual-star-search'
    Plug 'chaoren/vim-wordmotion'
    Plug 'cyansprite/extract'
    Plug 'cyansprite/automatch'

    " Format
    Plug 'foosoft/vim-argwrap'
    Plug 'godlygeek/tabular'
    Plug 'scrooloose/nerdcommenter'

    " Syntax
    Plug 'cyansprite/vim-csharp'
    Plug 'octol/vim-cpp-enhanced-highlight'

    " Autocompelete
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'Valloric/YouCompleteMe'
    Plug 'cyansprite/CmdlineComplete'

    " Source control
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'justinmk/vim-dirvish'

    " Nice Stuff
    Plug 'cyansprite/vim-search-pulse'
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/goyo.vim'
    Plug 'romainl/vim-qf'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'mhinz/vim-grepper'
    Plug 'mhinz/vim-startify'
    Plug 'majutsushi/tagbar'
    Plug 'cyansprite/a.vim'
    Plug 'AndrewRadev/linediff.vim'
    Plug 'ericpruitt/tmux.vim'


call plug#end()

" mappings {{{1
    " Ultisnips activation and movement
    let g:UltiSnipsJumpForwardTrigger="<c-f>"
    let g:UltiSnipsExpandTrigger="<c-e>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"

    nnoremap <silent> <leader>A :ArgWrap<CR>

    let g:targets_nlNL = 'nN  '

    let g:wordmotion_mappings = {
                \ 'w' : 'W',
                \ 'b' : 'B',
                \ 'e' : 'E',
                \ 'iw' : 'iW',
                \ '<C-R><C-W>' : '<C-R><M-w>'
                \ }

    nmap <leader><leader>] :TagbarToggle<CR>

" options {{{1
" Cpp highlight {{{2
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1

"Ycm {{{2
" I'm not sure if I've ever used this...
let g:ycm_always_populate_location_list = 1
" Please, for the love of all that is vim, do not fuckin highlight my stuff.
let g:ycm_enable_diagnostic_highlighting = 0
" I might change these one day to something prettier, but who the fuck knows.
let g:ycm_warning_symbol = '>>'
let g:ycm_error_symbol = 'XX'
" Don't limit strings and comments
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings  = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" Preview.
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" Don't you fuckin popup unless I say
let g:ycm_auto_trigger = 0
" I don't actually use these... but I will be damned before I use tab/s-tab
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" Nerd Commenter {{{2
" Just make it pretty please
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
"Grepper {{{2
nnoremap <leader>gg :Grepper -tool git<cr>
nnoremap <leader>ga :Grepper -tool ag<cr>
nnoremap <leader>gs :Grepper -tool ag -side<cr>
nnoremap <leader>*  :Grepper -tool ag -cword -noprompt<cr>

let g:grepper           = {}
let g:grepper.tools     = ['git', 'ag', 'grep']
" }}}2
" autocmds {{{1
" autocmd FileType dirvish Goyo
autocmd FileType GrepperSide
  \  silent normal! gg
  \  silent execute 'keeppatterns v#'.b:grepper_side.'#>'
  \| silent normal! ggn
