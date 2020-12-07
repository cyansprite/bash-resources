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
    Plug 'tbastos/vim-lua'

    Plug 'cyansprite/vim-ps1'

    Plug 'cyansprite/vim-ps1', {
      \ 'branch': 'feature/named-switches'
      \ }

    " Format: Wrap it and align it.
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " Completion: Deoplete is amazing
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'joereynolds/vim-minisnip'
    Plug 'artur-shaik/vim-javacomplete2'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neoinclude.vim'
    Plug 'Shougo/echodoc.vim'
    " TODO see if deoplete source for nvim .50 lsp

    " TODO Checkout language server for this
    " Plug 'zchee/deoplete-jedi'
    " TODO see if I want to modify these as a toggle
    " Plug 'Shougo/neco-vim'
    " Plug 'Shougo/neco-syntax'
    " Plug 'joereynolds/deoplete-minisnip'
    Plug 'neovim/nvim-lspconfig'

    if has('unix')
        Plug 'wellle/tmux-complete.vim'
        Plug '~/.fzf'
    elseif has('win32')
        Plug 'cyansprite/omnisharp.nvim'
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    endif

    " Git: git...GIT
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " Interface:
    Plug 'cyansprite/logicalBuffers'
    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'junegunn/fzf.vim'

    " TODO update
    Plug 'cyansprite/vim-grepper'
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

    let lend = ''
    if has('win32')
        let lend = '.cmd'
    endif

" Options: {{{1
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                   = '•'
let g:gitgutter_sign_modified                = '•'
let g:gitgutter_sign_removed                 = '•'
let g:gitgutter_sign_removed_first_line      = '•'
let g:gitgutter_sign_modified_removed        = '•'
let g:gitgutter_sign_allow_clobber           = '•'
let g:gitgutter_sign_removed_above_and_below = '•'
let g:gitgutter_sign_priority                = '•'

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

"Grepper {{{2
    let g:grepper           = {}
    let g:grepper.tools     = ['git', 'ag', 'grep']
    let g:grepper.open      = 0
    let g:grepper.jump      = 1
    let g:grepper.highlight = 1
    nnoremap <leader>ag :Grepper -tool ag<cr>

" Extract {{{2
let g:extract_maxCount = 15

"LSP  {{{1

function! Hover()
    try
        lua vim.lsp.buf.hover()
        lua vim.lsp.buf.document_highlight()
    catch /.*/
    endtry
endfunc

function! Moved()
    try
        lua vim.lsp.buf.clear_references()
        lua vim.lsp.buf.document_highlight()
    catch /.*/
    endtry
endfunc

func! Tag()
    try
        lua vim.lsp.buf.definition()
    catch /.*/
        norm! 
    endtry
endfunc

nnoremap <silent> <c-]> <cmd>call Tag()<CR>
nnoremap <silent> K     <cmd>call Hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

autocmd! CursorHold * silent! call Hover()
autocmd! CursorHoldI * silent! call Hover()
autocmd! CursorMoved * silent! call Moved()

lua require'lspconfig'.sumneko_lua.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.pyls_ms.setup{}
set omnifunc=v:lua.vim.lsp.omnifunc

hi link LspDiagnosticsError ErrorMsg
hi link LspDiagnosticsErrorSign ErrorMsg
hi link LspDiagnosticsErrorFloating ErrorMsg

hi link LspDiagnosticsWarning WarningMsg
hi link LspDiagnosticsWarningSign WarningMsg
hi link LspDiagnosticsWarningFloating WarningMsg

hi link LspDiagnosticsInformation MoreMsg
hi link LspDiagnosticsInformationSign MoreMsg
hi link LspDiagnosticsInformationFloating MoreMsg

hi link LspDiagnosticsHint Question
hi link LspDiagnosticsHintSign Question
hi link LspDiagnosticsHintFloating Question

hi link LspReferenceText CursorLineNr
hi link LspReferenceRead CursorLineNr
hi link LspReferenceWrite CursorLineNr
