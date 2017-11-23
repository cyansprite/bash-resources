" Plugins: (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'thinca/vim-visualstar'
    Plug 'tpope/vim-commentary'
    Plug 'zcodes/vim-surround'

    " Format: Wrap it and align it.
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " Syntax: The default is mediocre
    Plug 'cyansprite/vim-csharp'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    " Plug 'Valloric/vim-operator-highlight'

    " Completion: Deoplete is amazing
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'
    Plug 'Shougo/neoinclude.vim'
    Plug 'zchee/deoplete-jedi'
    Plug 'Shougo/neco-syntax'
    Plug 'Shougo/neco-vim'

    Plug 'cyansprite/deoplete-omnisharp' , {'do': './install.sh'}
    Plug 'Shougo/echodoc.vim'
    Plug 'wellle/tmux-complete.vim'

    " Git:
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " Navigation:
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

    " Interface: My Stuff to look pretty.
    Plug 'cyansprite/logicalBuffers'
    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

    " Grep: the context grep sucks; but quickfix is nice and match is nice...
    " TODO FIX side issues I have.
    " TODO FIX match issues ( turns off in hlsearch is off? I think... idr )
    Plug 'cyansprite/vim-grepper'

    " Color: My personal theme featuring Espurr
    Plug 'cyansprite/Restraint.vim'
call plug#end()

" {{{ Completion
    let g:tmuxcomplete#trigger = ''
    let g:deoplete#enable_at_startup = 1
    let g:echodoc#enable_at_startup = 1
    let g:deoplete#enable_camel_case = 1
    inoremap <silent><expr> <c-space> deoplete#mappings#manual_complete()
    let g:deoplete#delimiters = ['/',',',';','.',':']
    let g:deoplete#auto_refresh_delay = 100
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}

" Various Mappings With No Options: {{{1
    nnoremap <silent> <leader>A :ArgWrap<cr>
    nmap <leader>] :TagbarToggle<cr>
    nmap <leader>u :UndotreeToggle<cr>
    let g:undotree_WindowLayout = 2

" Options: {{{1
let g:gitgutter_override_sign_column_highlight = 0
" LeaderF
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    let g:Lf_ShortcutF = '<Leader>ff'
    let g:Lf_ShortcutB = '<Leader>fb'
    nnoremap <silent><Leader>f: :LeaderfHistoryCmd<cr>
    nnoremap <silent><Leader>f/ :LeaderfHistorySearch<cr>
    nnoremap <silent><Leader>fl :LeaderfLine<cr>
    nnoremap <silent><Leader>fo :LeaderfMru<cr>
    nnoremap <silent><Leader>f] :LeaderfTag<cr>
    nnoremap <silent><Leader>fh :LeaderfHelp<cr>
    nnoremap <silent><Leader>fm :LeaderfFunction<cr>
    nnoremap <silent><Leader>f :LeaderfSelf<cr>

" Cpp highlight {{{2
let g:cpp_class_scope_highlight     = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight      = 1
let g:cpp_concepts_highlight        = 1

"Grepper {{{2
    let g:grepper           = {}
    let g:grepper.tools     = ['git', 'ag', 'grep']
    let g:grepper.open      = 0
    let g:grepper.jump      = 1
    let g:grepper.next_tool = '<leader>g'
    let g:grepper.highlight = 1
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
" test-zone
