" Plugins: (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')
    " WIP:
    Plug 'cyansprite/nvim-gml'
    Plug 'cyansprite/nvim-unmatched'

    " Stuff:
    Plug 'cyansprite/vim-highlightedyank'

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'cyansprite/Sir-Nvim'
    Plug 'thinca/vim-visualstar'
    Plug 'vim-scripts/cmdlinecomplete'

    " Syntax:
    Plug 'cyansprite/vim-csharp'
    Plug 'udalov/kotlin-vim'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    Plug 'cyansprite/vim-operator-highlight'
    Plug 'leafgarland/typescript-vim'
    Plug 'amadeus/vim-xml'
    Plug 'tbastos/vim-lua'
    Plug 'PProvost/vim-ps1'

    " Format:
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " LSP:
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'RishabhRD/popfix'
    Plug 'RishabhRD/nvim-lsputils'

    if has('unix')
        Plug '~/.fzf'
    elseif has('win32')
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    endif

    " Git:
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " Interface:
    Plug 'cyansprite/logicalBuffers'
    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'junegunn/fzf.vim'

    " TODO update
    Plug 'cyansprite/vim-grepper'

    " Color:
    Plug 'cyansprite/Restraint.vim'
call plug#end()

" {{{ Completion
    autocmd BufEnter * lua require'completion'.on_attach()
    let g:completion_confirm_key = "\<C-y>"
    let g:completion_matching_smart_case = 1
    let g:completion_enable_auto_hover = 1

" }}}
" Various Mappings With No Options: {{{1
    nnoremap <silent> <leader>A :ArgWrap<cr>
    nmap <leader>u :UndotreeToggle<cr>

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
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
        try
            lua vim.lsp.buf.clear_references()
            lua vim.lsp.buf.hover()
            lua vim.lsp.buf.document_highlight()
        catch /.*/
            echo v:exception
        endtry
    endif
endfunc

function! Moved()
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients())')
        try
            lua vim.lsp.buf.clear_references()
            lua vim.lsp.buf.document_highlight()
        catch /.*/
            echo v:exception
        endtry
    endif
endfunc

func! NormTag()
    try
        if &filetype == "vim"
            " TODO help
        else
            norm! 
        endif
    catch /.*/
        echo v:exception
    endtry
endfu

func! Tag()
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients())')
        try
            let [bufnum, lnum, col, off, curswant] = getcurpos()
            lua vim.lsp.buf.definition()
            let [bufnum1, lnum1, col1, off1, curswant1] = getcurpos()
            if bufnum1 == bufnum && lnum == lnum1 && col == col1 && off == off
                call NormTag()
            endif
        catch /.*/
            echo v:exception
        endtry
    else
        call NormTag()
    endif
endfunc

function! CodeAction()
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients())')
        try
            lua vim.lsp.buf.code_action()
        catch /.*/
            echo v:exception
        endtry
    endif
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
nnoremap <silent> ga    <cmd>call CodeAction()<CR>
" Make it all go away when I'm trying to focus
" nnoremap <silent> <space>k <cmd>lua vim.lsp.buf.clear_references()<CR>

autocmd! CursorHold * silent! call Hover()
autocmd! CursorHoldI * silent! call Hover()
autocmd! CursorMoved * silent! call Moved()
autocmd! CursorMovedI * silent! call Moved()

lua require'lspconfig'.sumneko_lua.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.pyls_ms.setup{}
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.bashls.setup{}

function! InstallAll()
    try
        LspInstall sumneko_lua
    catch /.*/
        echom v:exception
    endtry
    try
        LspInstall vimls
    catch /.*/
        echom v:exception
    endtry
    try
        LspInstall pyls_ms
    catch /.*/
        echom v:exception
    endtry

    try
        LspInstall tsserver
    catch /.*/
        echom v:exception
    endtry

    try
        LspInstall bashls
    catch /.*/
        echom v:exception
    endtry
endfunc

" TODO deoplete
set omnifunc=v:lua.vim.lsp.omnifunc

" lsputils {{{1
lua <<EOF
    vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF
