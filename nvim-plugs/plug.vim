" Plugins: (Plug.vim) {{{
call plug#begin('~/.local/share/nvim/plugged')
    " WIP: Need major updates before releasing.
    Plug 'cyansprite/nvim-gml'
    Plug 'cyansprite/nvim-unmatched'

    " Stuff:
    Plug 'cyansprite/vim-highlightedyank'
    " Plug 'cyansprite/Sir-Nvim' " TODO Remove probably
    Plug 'Shougo/context_filetype.vim'

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'

    Plug 'thinca/vim-visualstar'

    Plug 'tyru/caw.vim' " Comments

    Plug 'AndrewRadev/dsf.vim' " delete surrounding function with dsf
    Plug 'AndrewRadev/deleft.vim' " delete surrounding blocks with dh

    " Syntax:
    Plug 'cyansprite/vim-csharp'
    Plug 'udalov/kotlin-vim'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    Plug 'cyansprite/vim-operator-highlight'
    Plug 'amadeus/vim-xml'
    Plug 'tbastos/vim-lua'
    Plug 'PProvost/vim-ps1'
    Plug 'mfukar/robotframework-vim'

    " Format:
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " LSP:
    " Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'

    if has('unix')
        Plug '~/.fzf'
    elseif has('win32')
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    endif

    " Git:
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive', { 'on' : ['Gdiff', 'Gblame'] } " add more if I ever use

    " Interface:
    Plug 'cyansprite/vim-sayonara'
    Plug 'cyansprite/logicalBuffers'

    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'junegunn/fzf.vim'

    Plug 'Lenovsky/nuake'
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'cyansprite/vim-grepper', { 'on' : 'Grepper' }
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'mhinz/vim-tree', { 'on': 'Tree' }
    Plug 'junegunn/gv.vim', { 'on': 'GV' }

    Plug 'liuchengxu/vista.vim'

    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'ryanoasis/vim-devicons'

    Plug 'AndrewRadev/inline_edit.vim'

    " Color:
    Plug 'cyansprite/Restraint.vim'
call plug#end() " }}}

" {{{ Completion
    autocmd BufEnter * lua require'completion'.on_attach()
    let g:completion_confirm_key = "\<C-y>"
    let g:completion_matching_smart_case = 1
    let g:completion_enable_auto_hover = 1

" }}}
"
" Various Mappings With No Options: {{{
    nnoremap <silent> <leader>A :ArgWrap<cr>
    nmap <leader>u :UndotreeToggle<cr>
    nnoremap <F4> :Nuake<CR>
    inoremap <F4> <C-\><C-n>:Nuake<CR>
    tnoremap <F4> <C-\><C-n>:Nuake<CR>
" }}}

" Options: {{{
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                   = '•'
let g:gitgutter_sign_modified                = '•'
let g:gitgutter_sign_removed                 = '•'
let g:gitgutter_sign_removed_first_line      = '•'
let g:gitgutter_sign_modified_removed        = '•'
let g:gitgutter_sign_allow_clobber           = '•'
let g:gitgutter_sign_removed_above_and_below = '•'
let g:gitgutter_sign_priority                = '•'
let g:gitgutter_highlight_linenrs = 1
let g:highlightactive = 1
let g:autoHighCurrent = 0
let g:undotree_WindowLayout = 2
let g:vista_default_executive = 'nvim_lsp'

" TODO fix preview it's trying to preview files because exedee
nmap <leader>fv :Vista finder<cr>
" TODO Needs more work I may make my own
nmap <leader>i :InlineEdit context_filetype#get()['filetype']<cr>
" }}}

" FZF {{{
if has('unix')
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
" }}}

"Grepper {{{
    let g:grepper           = {}
    let g:grepper.tools     = ['git', 'ag', 'grep']
    let g:grepper.open      = 0
    let g:grepper.jump      = 1
    let g:grepper.highlight = 1
    nnoremap <leader>ag :Grepper -tool ag<cr>
"}}}

" Extract {{{
let g:extract_maxCount = 15
"}}}

"LSP  TODO move to plugin? {{{

let g:plug_last_hover_pos=[0, 0]

function! Hover(timer)
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))') && g:plug_allow
        try
            let [bufnum, lnum, col, off, curswant] = getcurpos()
            if g:plug_last_hover_pos[0] == lnum && g:plug_last_hover_pos[1] == col
                return
            endif
            let g:plug_last_hover_pos = [lnum, col]
            if luaeval('vim.lsp.diagnostic.show_line_diagnostics()') == v:null
                lua vim.lsp.buf.hover()
            endif
        catch /.*/
            echo v:exception
        endtry
    endif
endfunc

function! Moved(timer)
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients())') && g:plug_allow
        "let myei=&ei
        "set eventignore=all
        try
            lua vim.lsp.buf.clear_references()
            lua vim.lsp.buf.document_highlight()
        catch /.*/
            " Be silent for this will happen a lot
            " echo v:exception
        endtry
        "let &eventignore=myei
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
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients())') && g:plug_allow
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
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients())') && g:plug_allow
        try
            let g:plug_allow = v:false
            lua vim.lsp.buf.code_action()
        catch /.*/
            echo v:exception
        endtry
    endif
endfunc

let g:plug_timers={}
let g:plug_timer_wait=100
let g:plug_allow = v:true

" Let's not spam it
function! Timed(method)
    if has_key(g:plug_timers, a:method) && g:plug_timers[a:method]
        call timer_stop(g:plug_timers[a:method])
        unlet g:plug_timers[a:method]
    endif

    let g:plug_timers[a:method] = timer_start(g:plug_timer_wait, a:method)
endfunc

nnoremap <silent> <c-]> <cmd>call Tag()<CR>
nnoremap <silent> K     <cmd>call Timed('Hover')<CR>
nnoremap <silent> ga    <cmd>call CodeAction()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" Make it all go away when I'm trying to focus
" nnoremap <silent> <space>k <cmd>lua vim.lsp.buf.clear_references()<CR>

augroup lsp
    " It's a feature but it fucking annoys me so go away
    " autocmd! CursorHold * silent! call Timed('Hover')
    " autocmd! CursorHoldI * silent! call Timed('Hover')
    autocmd! CursorMoved * silent! call Timed('Moved')
    autocmd! CursorMovedI * silent! call Timed('Moved')
augroup END

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=• texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint text=• texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint

" lua << EOF
    " require'lspconfig'.vimls.setup{}
    " require'lspconfig'.pyls_ms.setup{}
    " require'lspconfig'.tsserver.setup{}
    " require'lspconfig'.bashls.setup{}
    " require'lspconfig'.jsonls.setup{}
    " require'colorizer'.setup()
" EOF

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

    try
        LspInstall jsonls
    catch /.*/
        echom v:exception
    endtry
endfunc

set omnifunc=v:lua.vim.lsp.omnifunc
" }}}

" {{{ Treesitter
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"     ensure_installed = "maintained",
"         indent = {
"             enable = false
"         },
"
"         highlight = {
"             enable = true,
"             disable = {},
"             ["Keyword"] = "Keyword",
"         },
"
"         incremental_selection = {
"             enable = true,
"             keymaps = {
"                 init_selection = "gnn",
"                 node_incremental = "gni",
"                 scope_incremental = "gns",
"                 node_decremental = "gnc",
"             },
"         }
"     }
" EOF
" }}}

" {{{ Preview Folds: TODO Move to plugin
let g:fold_win_id = -1
let g:fold_old_lnum = -1
func! PreviewFold(lnum)
    let r = foldtextresult(a:lnum)

    if r == '' && foldclosed(a:lnum) || g:fold_old_lnum == a:lnum
        return v:false
    end

    call CloseFoldPreview()

    let bufname = "Fold " . string(a:lnum) . " ~ " . string(v:foldend)
    let buf = nvim_create_buf(v:false, v:true)
    let lines = getline(a:lnum, v:foldend)

    call nvim_buf_set_name(buf, bufname)
    call nvim_buf_set_option(buf, 'filetype',  &filetype)
    call nvim_buf_set_option(buf, 'buftype',   'nofile')
    call nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    call nvim_buf_set_option(buf, 'buflisted', v:false)
    call nvim_buf_set_option(buf, 'swapfile',  v:false)
    call nvim_buf_set_lines(buf, 0, len(lines), v:false, lines)
    call nvim_buf_set_option(buf, 'modifiable',  v:false)

    let height = min([20, len(lines)])

    let g:fold_win_id = nvim_open_win(buf, v:false, {
                \ 'relative': 'cursor',
                \ 'row': 1,
                \ 'col': 0,
                \ 'width': &tw,
                \ 'height': height,
                \ 'style': 'minimal'
                \ })

    call nvim_win_set_option(g:fold_win_id, 'foldenable',  v:false)
    call nvim_win_set_cursor(g:fold_win_id, [height, 0])
    nmap <c-u> <cmd>silent! call nvim_win_set_cursor(g:fold_win_id, [nvim_win_get_cursor(g:fold_win_id)[0] - nvim_win_get_height(g:fold_win_id) / 2, 0])<cr>
    nmap <c-d> <cmd>silent! call nvim_win_set_cursor(g:fold_win_id, [nvim_win_get_cursor(g:fold_win_id)[0] + nvim_win_get_height(g:fold_win_id) / 2, 0])<cr>

    autocmd CursorMoved <buffer> ++once call CloseFoldPreview()
    let g:fold_old_lnum = a:lnum
endfunc

func! CloseFoldPreview()
    silent! unmap <c-u>
    silent! unmap <c-d>

    if g:fold_win_id != -1
        execute win_id2win(g:fold_win_id).'wincmd c'
        let g:fold_win_id = -1
        let g:fold_old_lnum = -1
    endif
endfunc
nnoremap L     <cmd>call PreviewFold('.')<CR>
" autocmd CursorHold * call PreviewFold('.')
autocmd CmdlineEnter * call CloseFoldPreview()
"}}}

" {{{ Preview File Under Cursor
" Test: ~/Documents/bash-resources/nvim-plugs/init.vim : 100
let g:file_pop_win_id = -1
func! PreviewFile()
    call CloseFilePreview()

    let max_height = 20
    let filetype = ''
    let bufnr = bufnr()

    try
        keepj norm! gF
    catch /^Vim\%((\a\+)\)\=:E447/
        echohl ErrorMsg | echom v:exception | echohl None
        return
    endtry

    let filebuf = bufnr()
    execute 'keepj buf ' . bufnr

    let g:file_pop_win_id = nvim_open_win(filebuf, v:false, {
                \ 'relative': 'cursor',
                \ 'row': 1,
                \ 'col': 0,
                \ 'width': &tw,
                \ 'height': max_height,
                \ 'style': 'minimal'
                \ })

    call nvim_win_set_option(g:file_pop_win_id, 'foldenable',  v:false)

    nmap <c-u> <cmd>silent! call nvim_win_set_cursor(g:file_pop_win_id, [nvim_win_get_cursor(g:file_pop_win_id)[0] - nvim_win_get_height(g:file_pop_win_id), 0])<cr>
    nmap <c-d> <cmd>silent! call nvim_win_set_cursor(g:file_pop_win_id, [nvim_win_get_cursor(g:file_pop_win_id)[0] + nvim_win_get_height(g:file_pop_win_id), 0])<cr>
    autocmd CursorMoved <buffer> ++once call CloseFilePreview()
endfunc

func! CloseFilePreview()
    silent! unmap <c-u>
    silent! unmap <c-d>

    if g:file_pop_win_id != -1
        execute win_id2win(g:file_pop_win_id).'wincmd c'
        let g:file_pop_win_id = -1
    endif
endfunc

nnoremap gf <cmd>call PreviewFile()<CR>
"}}}
