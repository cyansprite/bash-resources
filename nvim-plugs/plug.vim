" Plugins: (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')

    Plug 'cyansprite/gitch'
    Plug 'google/vim-searchindex'
    Plug 'junegunn/rainbow_parentheses.vim'

    Plug 'https://github.com/udalov/kotlin-vim'

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'cyansprite/Sir-Nvim'
    Plug 'thinca/vim-visualstar'
    Plug 'vim-scripts/cmdlinecomplete'
    Plug 'kana/vim-repeat'
    Plug 'tyru/caw.vim'

    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

    " Format: Wrap it and align it.
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " Syntax: The default is mediocre, and that's being nice
    Plug 'cyansprite/vim-csharp'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    Plug 'cyansprite/vim-operator-highlight'
    Plug 'leafgarland/typescript-vim'
    Plug 'larsbs/vim-xmll'

    " Completion:
    " Plug 'ncm2/ncm2'
    " Plug 'roxma/nvim-yarp'
    " Plug 'ncm2/ncm2-tmux'
    " Plug 'ncm2/ncm2-path'
    " Plug 'ncm2/ncm2-match-highlight'
    " Plug 'ncm2/ncm2-bufword'
    Plug 'Shougo/deoplete.nvim'

    if has('unix')
        Plug 'wellle/tmux-complete.vim'
    endif

    " Git: git...GIT
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " Interface:
    Plug 'cyansprite/logicalBuffers'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'mhinz/neovim-remote'

    Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

    Plug 'cyansprite/vim-grepper'
    Plug '/users/brcoffman/.local/share/nvim/plugged/LeaderF-gitModified'

    " Color: My personal theme
    Plug 'cyansprite/Restraint.vim'
    Plug 'cyansprite/omnisharp.nvim'

call plug#end()

let g:rainbow#pairs = [['(', ')'],['{','}']]
let g:nvim_typescript#diagnostics_enable = 0

" Activation based on file type
augroup rainbows
  autocmd!
  autocmd FileType * RainbowParentheses
augroup END

let g:ncm2#match_highlight = 'bold'

" {{{1 Completion
    " let g:tmuxcomplete#trigger = ''
    let g:deoplete#enable_at_startup = 1
    let g:echodoc#enable_at_startup = 1
    let g:deoplete#enable_camel_case = 1
    inoremap <silent><expr> <c-space> deoplete#mappings#manual_complete()
    let g:deoplete#delimiters = ['/',',',';','.',':']
    let g:deoplete#auto_refresh_delay = 100
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
" Various Mappings With No Options: {{{1
    nnoremap <silent> <leader>A :ArgWrap<cr>
    nmap <leader>u :UndotreeToggle<cr>
    let g:undotree_WindowLayout = 2
" Options: {{{1
let g:gitgutter_override_sign_column_highlight = 0

" FZF {{{2
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
    let g:grepper.next_tool = '<leader>g'
    let g:grepper.highlight = 1
    nnoremap <leader>gg :Grepper -tool git<cr>
    nnoremap <leader>ga :Grepper -tool ag<cr>

" Extract {{{2
let g:extract_maxCount = 20


" Highlight: {{{1
    hi link StartifyPath     StorageClass
    hi link StorageClass     Keyword
    hi link cppSTLnamespace  Label
    hi link cCustomMemVar    Member
    hi link cCustomClass     Class
    hi link cRepeat          Repeat
"}}}1
