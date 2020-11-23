" Plugins: (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')
    " WIP:
    Plug 'cyansprite/nvim-gml'
    Plug 'cyansprite/nvim-unmatched'

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'cyansprite/Sir-Nvim'
    Plug 'thinca/vim-visualstar'
    Plug 'vim-scripts/cmdlinecomplete'

    " Syntax: The default is mediocre, and that's being nice
    Plug 'cyansprite/vim-csharp'
    Plug 'udalov/kotlin-vim'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    Plug 'cyansprite/vim-operator-highlight'
    Plug 'leafgarland/typescript-vim'
    Plug 'amadeus/vim-xml'

    Plug 'cyansprite/vim-ps1'

    Plug 'cyansprite/vim-ps1', {
      \ 'branch': 'feature/named-switches'
      \ }

    " Format: Wrap it and align it.
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " Completion: Deoplete is amazing
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
    Plug 'joereynolds/vim-minisnip'
    Plug 'artur-shaik/vim-javacomplete2'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neoinclude.vim'
    Plug 'Shougo/neco-vim'
    Plug 'Shougo/echodoc.vim'

    " TODO Checkout language server for this
    Plug 'zchee/deoplete-jedi'

    " TODO see if I want to modify these as a toggle
    " Plug 'Shougo/neco-syntax'
    " Plug 'joereynolds/deoplete-minisnip'

    let languageClientInstallCommand = 'bash install.sh'
    if has('unix')
        Plug 'wellle/tmux-complete.vim'
    elseif has('win32')
        let languageClientInstallCommand = 'powershell -executionpolicy bypass -File install.ps1'
        Plug 'cyansprite/omnisharp.nvim'
    endif

    Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': languageClientInstallCommand,
      \ }

    Plug 'corbob/vim-powershell', {
      \ 'branch': 'dev',
      \ 'do': 'pwsh build.ps1',
      \ }

    " Git: git...GIT
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " Interface:
    Plug 'cyansprite/logicalBuffers'
    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " TODO update
    Plug 'cyansprite/vim-grepper'

    " Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
    " Plug 'mhinz/neovim-remote'

    " Color: My personal theme featuring Espurr
    Plug 'cyansprite/Restraint.vim'
call plug#end()

" {{{ Completion
    " let g:tmuxcomplete#trigger = ''
    let g:deoplete#enable_at_startup = 1
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = "popup"
    let g:deoplete#enable_camel_case = 1
    let g:deoplete#delimiters = ['/',',',';','.',':']

    let g:minisnip_trigger= '<c-space>'

    autocmd FileType java setl omnifunc=javacomplete#Complete

    nmap <leader>jia <Plug>(JavaComplete-Imports-AddSmart)
    nmap <leader>jir <Plug>(JavaComplete-Imports-RemoveUnused)
    let g:JavaComplete_EnableDefaultMappings = 0

" }}}
" Various Mappings With No Options: {{{1
    nnoremap <silent> <leader>A :ArgWrap<cr>
    nmap <leader>u :UndotreeToggle<cr>
    " nmap <leader>] :TagbarToggle<cr>

" Options: {{{1
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added              = '•'
let g:gitgutter_sign_modified           = '•'
let g:gitgutter_sign_removed            = '•'
let g:gitgutter_sign_removed_first_line = '•'
let g:gitgutter_sign_modified_removed   = '•'

let g:highlightactive = 1
let g:autoHighCurrent = 0

let g:undotree_WindowLayout = 2

" FZF {{{2
if has('unix')
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)
endif

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
    nnoremap <leader>ag :Grepper -tool ag<cr>

" Extract {{{2
let g:extract_maxCount = 15

" Autocmd: {{{2
autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')
