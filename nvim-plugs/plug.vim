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
    Plug 'justinmk/vim-sneak'

    Plug 'thinca/vim-visualstar'

    Plug 'tyru/caw.vim' " Comments

    Plug 'AndrewRadev/dsf.vim' " delete surrounding function with dsf
    Plug 'AndrewRadev/deleft.vim' " delete surrounding blocks with dh

    " Syntax:
    Plug 'MTDL9/vim-log-highlighting'
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

    " LSP and completion:
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'nvim-lua/plenary.nvim'
    " Plug 'jose-elias-alvarez/null-ls.nvim'
    " Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
    " Plug 'mfussenegger/nvim-jdtls'
    " Use release branch (recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'antoinemadec/coc-fzf'
    Plug 'wellle/tmux-complete.vim'

    if has('unix')
        Plug '~/.fzf'
    elseif has('win32')
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    endif

    " Git:
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive', { 'on' : ['Gdiff', 'Gblame'] } " add more if I ever use

    " Interface:
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

    Plug 'justinmk/vim-matchparenalways'

    Plug 'liuchengxu/vim-which-key'

    " Optional
    Plug 'rcarriga/nvim-notify'

    " Color:
    Plug 'cyansprite/Restraint.vim'
call plug#end() " }}}

" {{{ Completion
    " Set internal encoding of vim, not needed on neovim, since coc.nvim using some
    " unicode characters in the file autoload/float.vim
    set encoding=utf-8

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noselect

    " suppress the annoying 'match x of y', 'The only match' and 'Pattern not
    " found' messages
    set shortmess+=c

    " select
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    if has("nvim-0.5.0") || has("patch-8.1.1564")
        " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
    else
        set signcolumn=yes
    endif

    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    nmap <silent> gd <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
        else
            execute '!' . &keywordprg . " " . expand('<cword>')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>nn <Plug>(coc-rename)
    xmap <leader>F  <Plug>(coc-format-selected)

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Run the Code Lens action on the current line.
    nmap <leader>cl  <Plug>(coc-codelens-action)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <leader>s <Plug>(coc-range-select)
    xmap <silent> <leader>s <Plug>(coc-range-select)
    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:Imports` command for organize imports of the current buffer.
    command! -nargs=0 Imports   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

    " Mappings for CoCList
    " allow to scroll in the preview
    set mouse=a

    " mappings
    nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
    nnoremap <silent> <space>g       :<C-u>CocFzfList diagnostics<CR>
    nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
    nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
    nnoremap <silent> <space>e       :<C-u>CocFzfList extensions<CR>
    nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
    nnoremap <silent> <space>o       :<C-u>CocFzfList outline<CR>
    nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
    nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>

" }}}

" Various Mappings With No Options: {{{
    map zs <Plug>Sneak_s
    map zS <Plug>Sneak_S
    nnoremap <silent> <space> :WhichKey '<Space>'<CR>
    nnoremap <silent> <leader> :WhichKey '\'<CR>
    nnoremap <silent> <leader>A :ArgWrap<cr>
    nmap <leader>u :UndotreeToggle<cr>
    nnoremap <F4> :Nuake<CR>
    inoremap <F4> <C-\><C-n>:Nuake<CR>
    tnoremap <F4> <C-\><C-n>:Nuake<CR>
    nmap <space>c <Plug>(caw:prefix)
    xmap <space>c <Plug>(caw:prefix)
" }}}

" Options: {{{
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_signs=0
let g:gitgutter_sign_added                   = ''
let g:gitgutter_sign_modified                = ''
let g:gitgutter_sign_removed                 = ''
let g:gitgutter_sign_removed_first_line      = ''
let g:gitgutter_sign_modified_removed        = ''
let g:gitgutter_sign_allow_clobber           = ''
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_priority                = ''
let g:gitgutter_highlight_linenrs = 1
let g:highlightactive = 1
let g:autoHighCurrent = 0
let g:undotree_WindowLayout = 2
let g:vista_default_executive = 'nvim_lsp'

nmap <leader>d :GitGutterPreviewHunk<cr>
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

" Lua {{{
" lua << EOF
"     require'nvim-treesitter.configs'.setup {
"         -- One of "all", "maintained" (parsers with maintainers), or a list of languages
"         ensure_installed = "maintained",
"
"         -- Install languages synchronously (only applied to `ensure_installed`)
"         sync_install = false,
"
"         -- List of parsers to ignore installing
"         ignore_install = {},
"
"         highlight = {
"             -- `false` will disable the whole extension
"             enable = true,
"
"             -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
"             -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
"             -- the name of the parser)
"             -- list of language that will be disabled
"             disable = {},
"
"             -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
"             -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
"             -- Using this option may slow down your editor, and you may see some duplicate highlights.
"             -- Instead of true it can also be a list of languages
"             additional_vim_regex_highlighting = true,
"         },
"         incremental_selection = {
"             enable = true,
"             keymaps = {
"                 init_selection = "gnn",
"                 node_incremental = "grn",
"                 scope_incremental = "grc",
"                 node_decremental = "grm",
"             },
"         },
"     }
" require'nvim-treesitter.configs'.setup {
" }
" EOF
" End Lua}}}

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
