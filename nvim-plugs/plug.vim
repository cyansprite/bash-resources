" Plugins: (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'cyansprite/Sir-Nvim'
    Plug 'thinca/vim-visualstar'
    Plug 'vim-scripts/cmdlinecomplete'
    " Plug 'kana/vim-repeat'
    " Plug 'tyru/caw.vim'

    " Syntax: The default is mediocre, and that's being nice
    Plug 'cyansprite/vim-csharp'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    Plug 'cyansprite/vim-operator-highlight'
    Plug 'leafgarland/typescript-vim'
    Plug 'larsbs/vim-xmll'

    " Format: Wrap it and align it.
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " Completion: Deoplete is amazing
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neoinclude.vim'
    Plug 'zchee/deoplete-jedi'
    Plug 'Shougo/neco-syntax'
    Plug 'Shougo/neco-vim'
    if hostname() == "mojajojo"
        " Plug 'wokalski/autocomplete-flow'
        Plug 'ternjs/tern_for_vim', { 'do': 'node ~/bin/npm install && node ~/bin/npm install -g tern' }
        Plug 'carlitux/deoplete-ternjs'
    end

    if has('unix')
    else
        Plug 'cyansprite/omnisharp.nvim'
    endif
    Plug 'Shougo/echodoc.vim'

    if has('unix')
        Plug 'wellle/tmux-complete.vim'
    endif

    " Git: git...GIT
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " Interface:
    Plug 'cyansprite/logicalBuffers'
    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
    Plug '~/.fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'cyansprite/vim-grepper'
    " Plug 'mhinz/neovim-remote'

    " Color: My personal theme featuring Espurr
    Plug 'cyansprite/Restraint.vim'
call plug#end()

" {{{ Completion
    " let g:tmuxcomplete#trigger = ''
    let g:deoplete#enable_at_startup = 1
    let g:echodoc#enable_at_startup = 1
    let g:deoplete#enable_camel_case = 1
    inoremap <silent><expr> <c-space> deoplete#mappings#manual_complete()
    let g:deoplete#delimiters = ['/',',',';','.',':']
    let g:deoplete#auto_refresh_delay = 100
    let g:tern#command = ["/users/brcoffman/bin/node-v12.12.0-linux-x64/bin/node",  "/users/brcoffman/lib/node_modules/tern/bin/tern"]
    let g:deoplete#sources#ternjs#tern_bin  = "/users/brcoffman/lib/node_modules/tern/bin/tern"
    let g:deoplete#sources#ternjs#node_bin  = "/users/brcoffman/bin/node-v12.12.0-linux-x64/bin/node"
" }}}
" Various Mappings With No Options: {{{1
    nnoremap <silent> <leader>A :ArgWrap<cr>
    nmap <leader>] :TagbarToggle<cr>
    nmap <leader>u :UndotreeToggle<cr>
    let g:undotree_WindowLayout = 2

" Options: {{{1
let g:gitgutter_override_sign_column_highlight = 0
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <leader>ff :Files<cr>
nmap <leader>fl :BLines<cr>
nmap <leader>fa :Ag<space>
nmap <leader>fo :History<cr>
nmap <leader>fh :Helptags<cr>
nmap <leader>f] :BTags<cr>

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
"}}}1
