" Plugins: (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'thinca/vim-visualstar'
    Plug 'tpope/vim-commentary'

    " Format: Wrap it and align it.
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " Syntax: The default is mediocre
    Plug 'cyansprite/vim-csharp'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    Plug 'Valloric/vim-operator-highlight'

    " Searching for a completion engine that works well...
    "     Plug 'Valloric/YouCompleteMe'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'Shougo/neoinclude.vim'
    Plug 'Shougo/neco-syntax'
    Plug 'tweekmonster/deoplete-clang2'
    Plug 'dimixar/deoplete-omnisharp'
    Plug 'Shougo/echodoc.vim'

    " Git:
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " IDElike: I am looking into stuff like this, don't know if I will use.
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

    " Navigation:
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

    " Interface: My Stuff to look pretty.
    Plug 'cyansprite/logicalBuffers'

    " Grep: the context grep sucks; but quickfix is nice, look into others.
    Plug 'mhinz/vim-grepper'

    " Color: My personal theme featuring Espurr
    Plug 'cyansprite/Restraint.vim'

call plug#end()

" {{{ Completion
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_camel_case = 1
    inoremap <silent><expr> <c-space> deoplete#mappings#manual_complete()
    let g:deoplete#delimiters = ['/',',',';','.',':']
    let g:deoplete#auto_refresh_delay = 100
    let g:ulti_expand_or_jump_res = 0 "default value, just set once
    let g:UltiSnipsExpandTrigger               = "<tab>"
    let g:UltiSnipsListSnippets                = "<s-tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-n>"
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<c-p>"
" }}}

" Various Mappings With No Options: {{{1
    nnoremap <silent> <leader>A :ArgWrap<CR>
    nmap <leader>] :TagbarToggle<CR>

" Options: {{{1
" LeaderF
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    let g:Lf_ShortcutF = '<Leader>ff'
    let g:Lf_ShortcutB = '<Leader>fb'
    nnoremap <silent><Leader>f: :LeaderfHistoryCmd<cr>
    nnoremap <silent><Leader>f/ :LeaderfLine<cr>
    nnoremap <silent><Leader>fo :LeaderfMru<cr>
    nnoremap <silent><Leader>f] :LeaderfTag<cr>
    nnoremap <silent><Leader>fh :LeaderfHelp<cr>
    nnoremap <silent><Leader>f :LeaderfSelf<cr>

" Cpp highlight {{{2
let g:cpp_class_scope_highlight     = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight      = 1
let g:cpp_concepts_highlight        = 1

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
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
" Preview.
let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" Don't you fuckin popup unless I say
" let g:ycm_auto_trigger = 0
" I don't actually use these... but I will be damned before I use tab/s-tab
let g:ycm_key_list_select_completion   = []
let g:ycm_key_list_previous_completion = []

"Grepper {{{2
    let g:grepper           = {}
    let g:grepper.tools     = ['git', 'ag', 'grep']
    let g:grepper.open      = 0
    let g:grepper.jump      = 1
    let g:grepper.next_tool = '<leader>g'
    nnoremap <leader>gg :Grepper -tool git<cr>
    nnoremap <leader>ga :Grepper -tool ag<cr>

" Extract {{{2
let g:extract_maxCount = 20

" Autocmd: {{{1
autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')
" Highlight: {{{1
    hi link StartifyPath     StorageClass
    hi link StorageClass     Keyword
    hi link cppSTLnamespace  Label
    hi link cCustomMemVar    Member
    hi link cCustomClass     Class
    hi link cRepeat          Repeat

    let g:ophigh_highlight_link_group = 'Operator'
    let g:ophigh_filetypes_to_ignore = {'jinja': 1, 'help': 1, 'notes': 1,
                \ 'markdown': 1, 'less': 1, 'sh': 1, 'html': 1, 'diff': 1,
                \ 'bash': 1, 'qf': 1, 'css': 1, 'vim': 1, 'txt': 1
    \}
"}}}1
" Remember {{{
    " Leaving here although I'm not currently interested...
    " Plug 'AndrewRadev/bufferize.vim'
    " Plug 'junegunn/vim-after-object'
    " Plug 'AndrewRadev/linediff.vim'

    " like the idea hate the plugin
    " call g:quickmenu#append('# Resource Files', '')
    " call quickmenu#append("init.vim", 'e ~/.config/nvim/init.vim', "")
    " call quickmenu#append("plug.vim", 'e ~/.config/nvim/plug.vim', "")

    " call g:quickmenu#append('# Plugin Files', '')
    " call quickmenu#append("restraint.vim", 'e ~/.local/share/nvim/plugged/Restraint.vim/colors/restraint.vim', "")
    " call quickmenu#append("logicalBuffers.vim", 'e ~/.local/share/nvim/plugged/logicalBuffers/plugin/logicalBuffers.vim', "")
    " call quickmenu#append("extract.vim", 'e ~/.local/share/nvim/plugged/extract/plugin/extract.vim', "")
"}}}

" test-zone
