" Plugins: (Plug.vim) {{{
call plug#begin('~/.local/share/nvim/plugged')
    " WIP: Need major updates before releasing.
    Plug 'cyansprite/nvim-gml'
    Plug 'cyansprite/nvim-unmatched'

    " Win bar thing
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'

    " Flutter
    Plug 'dart-lang/dart-vim-plugin'
    Plug 'thosakwe/vim-flutter'

    " Stuff:
    Plug 'cyansprite/vim-highlightedyank'
    Plug 'Shougo/context_filetype.vim'

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'justinmk/vim-sneak'
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-colorscheme-switcher'

    Plug 'thinca/vim-visualstar'

    Plug 'tyru/caw.vim' " Comments
    Plug 'tpope/vim-surround' " Surrounding things
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'vimwiki/vimwiki'

    Plug 'AndrewRadev/dsf.vim' " delete surrounding function with dsf
    Plug 'AndrewRadev/deleft.vim' " delete surrounding blocks with dh

    " Syntax:
    " Plug 'google/vim-jsonnet'
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
    Plug 'fladson/vim-kitty'
    Plug 'towolf/vim-helm'

    " Format:
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " LSP and completion:
    Plug 'mfussenegger/nvim-lint'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'udalov/kotlin-vim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-git'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'stevearc/conform.nvim'
    Plug 'folke/trouble.nvim'
    Plug 'arnar/vim-matchopen'

    if has('unix')
        Plug '~/.fzf'
    elseif has('win32')
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    endif

    " Git:
    Plug 'akinsho/git-conflict.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive', { 'on' : ['Gdiff', 'Gblame'] } " add more if I ever use

    " Interface:
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
    Plug 'rcarriga/nvim-notify'
    Plug 'cyansprite/nvim-deardiary'
    " Plug 'gelguy/wilder.nvim'
    Plug 'kyazdani42/nvim-tree.lua'
    " Plug 'cyansprite/logicalBuffers'

    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'junegunn/fzf.vim'
    " Plug 'antoinemadec/coc-fzf'

    Plug 'mhinz/vim-grepper', { 'on' : 'Grepper' }
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'

    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'liuchengxu/vim-which-key'

    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " Optional
    Plug 'rcarriga/nvim-notify'

    " Color:
    Plug 'cyansprite/Restraint.vim'
call plug#end() " }}}

" {{{ Completion
    imap <silent><script><expr> <c-k> copilot#Accept("\<CR>")
    hi link MatchOpen Error
    let g:copilot_no_tab_map = v:true

    " call wilder#setup({'modes': [':', '/', '?']})

    " call wilder#set_option('pipeline', [
    "     \   wilder#branch(
    "     \     wilder#cmdline_pipeline({
    "     \       'fuzzy': 1,
    "     \       'set_pcre2_pattern': 1,
    "     \     }),
    "     \     wilder#python_search_pipeline({
    "     \       'pattern': 'fuzzy',
    "     \     }),
    "     \   ),
    "     \ ])

    " let s:highlighters = [
    "         \ wilder#pcre2_highlighter(),
    "         \ wilder#basic_highlighter(),
    "         \ ]

    " call wilder#set_option('renderer', wilder#renderer_mux({
    "     \ ':': wilder#popupmenu_renderer({
    "     \   'highlighter': s:highlighters,
    "     \ }),
    "     \ '/': wilder#wildmenu_renderer({
    "     \   'highlighter': s:highlighters,
    "     \ }),
    "     \ }))

    " let g:coc_disable_transparent_cursor=0

    " function! s:check_back_space() abort
    "   let col = col('.') - 1
    "   return !col || getline('.')[col - 1]  =~# '\s'
    " endfunction

    " inoremap <silent><expr> <TAB>
    "   \ coc#pum#visible() ? coc#_select_confirm() :
    "   \ coc#pum#visible() && coc#expandableOrJumpable() ?
    "   \ coc#pum#visible() && "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    "   \ <SID>check_back_space() ? "\<TAB>" :
    "   \ coc#refresh()

    " " let g:coc_snippet_next = '<tab>'

    " inoremap <silent><expr> <c-space> coc#refresh()

    " " select
    " inoremap <silent><expr> <c-y> coc#pum#visible() ? coc#_select_confirm()
    "                           \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " nmap <silent> [g <Plug>(coc-diagnostic-prev)
    " nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " nmap <silent> <space>i <Plug>(coc-implementation)
    " nmap <silent> <space>d <Plug>(coc-type-definition)
    " nmap <silent> <space>r <Plug>(coc-references)

    " " Use K to show documentation in preview window.
    " nnoremap <silent> KK :call ShowDocumentation()<CR>
    " " fucking moving my cursor smh
    " nnoremap <silent> KD :call Diag()<CR>
    " autocmd! BufWritePost * :call Diag()

    " " fucking coc lol
    " function! FixCursor(x)
    "   norm! jj
    " endfunc

    " function! Diag()
    "   call CocAction('diagnosticRefresh')
    "   let timer = timer_start(00, 'FixCursor', {'repeat': 1})
    " endfunction

    " function! ShowDocumentation()
    "   if CocAction('hasProvider', 'hover')
    "     call CocAction('doHover')
    "   else
    "     call feedkeys('K', 'in')
    "   endif
    " endfunction

    " " Highlight the symbol and its references when holding the cursor.
    " " autocmd CursorHold * silent call CocActionAsync('highlight')

    " " Symbol renaming.
    " nmap <F2> <Plug>(coc-rename)
    " xmap <leader>F  <Plug>(coc-format-selected)

    " " Applying codeAction to the selected region.
    " " Example: `<leader>aap` for current paragraph
    " xmap <space>aa  <Plug>(coc-codeaction-selected)
    " nmap <space>aa  <Plug>(coc-codeaction-selected)

    " " Remap keys for applying codeAction to the current buffer.
    " nmap <space>ac  <Plug>(coc-codeaction)
    " " Apply AutoFix to problem on the current line.
    " nmap <space>f  <Plug>(coc-fix-current)
    " " Apply AutoFix to problem on the current line.
    " command! -nargs=0 OR :call CocAction('organizeImport')

    " " Run the Code Lens action on the current line.
    " nmap <leader>cl  <Plug>(coc-codelens-action)

    " " Map function and class text objects
    " " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    " xmap if <Plug>(coc-funcobj-i)
    " omap if <Plug>(coc-funcobj-i)
    " xmap af <Plug>(coc-funcobj-a)
    " omap af <Plug>(coc-funcobj-a)
    " xmap ic <Plug>(coc-classobj-i)
    " omap ic <Plug>(coc-classobj-i)
    " xmap ac <Plug>(coc-classobj-a)
    " omap ac <Plug>(coc-classobj-a)

    " " Remap <C-f> and <C-b> for scroll float windows/popups.
    " " TODO map to all previews
    " if has('nvim-0.4.0') || has('patch-8.2.0750')
    "     nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    "     nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    "     inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    "     inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    "     vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    "     vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    " endif

    " " Use CTRL-S for selections ranges.
    " " Requires 'textDocument/selectionRange' support of language server.
    " nmap <silent> gs <Plug>(coc-range-select)
    " xmap <silent> gs <Plug>(coc-range-select)
    " " Add `:Format` command to format current buffer.
    " command! -nargs=0 Format :call CocActionAsync('format')

    " " Add `:Fold` command to fold current buffer.
    " command! -nargs=? Rename :call CocAction('rename')

    " " Add `:Fold` command to fold current buffer.
    " command! -nargs=? Fold :call CocAction('fold', <f-args>)

    " " Add `:Imports` command for organize imports of the current buffer.
    " command! -nargs=0 Imports :call CocActionAsync('runCommand', 'editor.action.organizeImport')

    " command! -nargs=0 Outline :call CocActionAsync('showOutline', 1)


    " allow to scroll in the preview
    set mouse=a

    " Mappings for CocFzfList
    " nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
    " nnoremap <silent> <space>g       :<C-u>CocFzfList diagnostics<CR>
    " nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
    " nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
    " nnoremap <silent> <space>e       :<C-u>CocFzfList extensions<CR>
    " nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
    " nnoremap <silent> <space>O       :<C-u>CocFzfList outline<CR>
    " nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
    " nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>
    " nmap <silent> <space>F :CocList --input=flutter commands<CR>

    fu! NormTag()
        try
            if &filetype == "vim"
                exec "help ". expand("<cword>")
            else
                norm! 
            endif
        catch /.*/
            echo v:exception
        endtry
    endfu

    func! Tag()
        if 0
            try
                let [bufnum, lnum, col, off, curswant] = getcurpos()
                norm gi
                let [bufnum1, lnum1, col1, off1, curswant1] = getcurpos()
                if bufnum1 == bufnum && lnum == lnum1 && col == col1 && off == off
                    call NormTag()
                endif
            catch /.*/
                call NormTag()
                echo v:exception
            endtry
        else
            call NormTag()
        endif
    endfunc
    nnoremap <silent> <c-]> <cmd>call Tag()<CR>
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

    nnoremap <silent><nowait> <space>O  :call <SID>toggle_outline()<CR>
    " function! s:toggle_outline() abort
    "   let winid = coc#window#find('cocViewId', 'OUTLINE')
    "   if winid == -1
    "     call CocActionAsync('showOutline', 1)
    "   else
    "     call coc#window#close(winid)
    "   endif
    " endfunction

" }}}

" Options: {{{
let g:rainbow_active = 1

let g:gitgutter_override_sign_column_highlight = 0
" TODO
let g:gitgutter_sign_added                   = ''
let g:gitgutter_sign_modified                = ''
let g:gitgutter_sign_removed                 = ''
let g:gitgutter_sign_removed_first_line      = ''
let g:gitgutter_sign_modified_removed        = ''
let g:gitgutter_sign_allow_clobber           = ''
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_priority                = ''
let g:gitgutter_highlight_linenrs = 1
let g:highlightactive = 1
let g:autoHighCurrent = 0
let g:undotree_WindowLayout = 2

func! SetGitGutterBranch(br)
    exec 'GitGutterLineHighlightsEnable'
    exec 'GitGutterLineNrHighlightsEnable'
    let g:gitgutter_diff_base=a:br
    exec 'e'
endfunc
command! -complete=customlist,GitBranchComplete -nargs=1 SetDiff call SetGitGutterBranch('<args>')

nmap <leader>dd :GitGutterPreviewHunk<cr>
nmap <leader>du :GitGutterUndoHunk<cr>
" }}}

" FZF {{{
if has('unix')
    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)
endif
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

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
" autocmd VimEnter,Tabnew *
 "      \ if empty(&buftype) | call CocActionAsync('showOutline', 1) | endif
" autocmd BufEnter * call <SID>check_outline()
" function! s:check_outline() abort
"   if &filetype ==# 'coctree' && winnr('$') == 1
"     if tabpagenr('$') != 1
"       close
"     else
"       quit
"     endif
"   endif
" endfunction
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

func! s:setFold()
    let file = expand("<afile>")
    echom "file" .. file
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set nofoldenable                     " Disable folding at startup.
endfunc
autocmd BufEnter, BufWinEnter, WinEnter, VimEnter * call s:setFold()

let s:meOptions =  [
    \ 'INIT',
    \ 'COLO',
    \ 'PLUG',
    \ 'JOURNAL',
    \ 'REMIND',
    \ 'CocConfig'
    \ ]

command! -nargs=0 INIT :e ~/Documents/bash-resources/nvim-plugs/init.vim
command! -nargs=0 PLUG :e ~/Documents/bash-resources/nvim-plugs/plug.vim
command! -nargs=0 COLO :e ~/.local/share/nvim/plugged/Restraint.vim/colors/restraint.vim
command! -nargs=0 JOURNAL :e ~/journal/journal.md
command! -nargs=0 REMIND :e ~/.reminders

func! s:fzfMe()
    call fzf#run({
          \        'source': s:meOptions,
          \        'sink': '',
          \        'window': { 'width': 0.9, 'height': 0.6 }
          \    })
endfunc

func! s:fzfMeSink(obj)
    exec a:obj
endfunc

command! -nargs=0 ME call s:fzfMe()
nnoremap <silent> <leader>m :ME<CR>

autocmd VimEnter * Copilot enable
nnoremap <silent> <space>p :Copilot panel<cr>
nnoremap <silent> <space>o :Copilot open<cr>
"
" function! s:DiagnosticNotify() abort
"   let l:info = get(b:, 'coc_diagnostic_info', {})
"   if empty(l:info) | return '' | endif
"   let l:msgs = []
"   let l:level = 'info'
"    if get(l:info, 'warning', 0)
"     let l:level = 'warn'
"   endif
"   if get(l:info, 'error', 0)
"     let l:level = 'error'
"   endif
" 
"   if get(l:info, 'error', 0)
"     call add(l:msgs, ' Errors: ' . l:info['error'])
"   endif
"   if get(l:info, 'warning', 0)
"     call add(l:msgs, ' Warnings: ' . l:info['warning'])
"   endif
"   if get(l:info, 'information', 0)
"     call add(l:msgs, 'ℹ Infos: ' . l:info['information'])
"   endif
"   if get(l:info, 'hint', 0)
"     call add(l:msgs, '✨ Hints: ' . l:info['hint'])
"   endif
"   let l:msg = join(l:msgs, "\n")
"   if empty(l:msg) | let l:msg = ' All OK' | endif
"   -- call v:lua.coc_diag_notify(l:msg, l:level)
" endfunction
" 
" function! s:StatusNotify() abort
"   let l:status = get(g:, 'coc_status', '')
"   let l:level = 'info'
"   if empty(l:status) | return '' | endif
"   -- call v:lua.coc_status_notify(l:status, l:level)
" endfunction
" 
" function! s:InitCoc() abort
"   runtime! autoload/coc/ui.vim
"   execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status' })"
" endfunction

" notifications
" autocmd User CocNvimInit call s:InitCoc()
" autocmd User CocDiagnosticChange call s:DiagnosticNotify()
" autocmd User CocStatusChange call s:StatusNotify()

" Osoi
let g:dart_format_on_save = 0
lua require('plug')

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

nnoremap <Space>dd :Trouble diagnostics toggle<cr>
nnoremap <Space>ds :Trouble symbols toggle pinned=true win.relative=win win.position=left<cr>
nnoremap <Space>dl :Trouble loclist toggle<cr>
nnoremap <Space>dq :Trouble qflist toggle<cr>
