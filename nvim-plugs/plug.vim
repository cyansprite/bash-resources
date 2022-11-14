" Plugins: (Plug.vim) {{{
call plug#begin('~/.local/share/nvim/plugged')
    " WIP: Need major updates before releasing.
    Plug 'cyansprite/nvim-gml'
    Plug 'cyansprite/nvim-unmatched'

    " Stuff:
    Plug 'cyansprite/vim-highlightedyank'
    Plug 'Shougo/context_filetype.vim'

    " Motion: My clips, visual star, , and comment stuff.
    Plug 'cyansprite/extract'
    Plug 'justinmk/vim-sneak'

    Plug 'thinca/vim-visualstar'

    Plug 'tyru/caw.vim' " Comments

    Plug 'AndrewRadev/dsf.vim' " delete surrounding function with dsf
    Plug 'AndrewRadev/deleft.vim' " delete surrounding blocks with dh

    " Syntax:
    Plug 'google/vim-jsonnet'
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
    Plug 'luochen1990/rainbow'

    " Format:
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " LSP and completion:
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
    Plug 'cympfh/journal.vim'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'cyansprite/logicalBuffers'

    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'junegunn/fzf.vim'
    Plug 'antoinemadec/coc-fzf'

    Plug 'Lenovsky/nuake'

    Plug 'mhinz/vim-grepper', { 'on' : 'Grepper' }
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

    Plug 'liuchengxu/vista.vim'

    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'

    Plug 'AndrewRadev/inline_edit.vim'

    Plug 'liuchengxu/vim-which-key'

    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " Optional
    Plug 'rcarriga/nvim-notify'

    " Color:
    Plug 'cyansprite/Restraint.vim'
call plug#end() " }}}

" {{{ Completion
    let g:coc_disable_transparent_cursor=0

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

    let g:coc_snippet_next = '<tab>'

    inoremap <silent><expr> <c-space> coc#refresh()

    " select
    inoremap <silent><expr> <c-y> coc#pum#visible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    nmap <silent> <space>i <Plug>(coc-implementation)
    nmap <silent> <space>d <Plug>(coc-type-definition)
    nmap <silent> <space>r <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (coc#rpc#ready())
            call CocActionAsync('definitionHover')
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
    nmap <space>f  <Plug>(coc-fix-current)

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
    " TODO map to all previews
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
    nmap <silent> gs <Plug>(coc-range-select)
    xmap <silent> gs <Plug>(coc-range-select)
    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Rename :call CocAction('rename')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call CocAction('fold', <f-args>)

    " Add `:Imports` command for organize imports of the current buffer.
    command! -nargs=0 Imports :call CocActionAsync('runCommand', 'editor.action.organizeImport')

    command! -nargs=0 Outline :call CocActionAsync('showOutline', 1)


    " allow to scroll in the preview
    set mouse=a

    " Mappings for CocFzfList
    nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
    nnoremap <silent> <space>g       :<C-u>CocFzfList diagnostics<CR>
    nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
    nnoremap <silent> <space>a       :<C-u>CocFzfList commands<CR>
    nnoremap <silent> <space>e       :<C-u>CocFzfList extensions<CR>
    nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
    nnoremap <silent> <space>o       :<C-u>CocFzfList outline<CR>
    nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
    nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>

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
        if g:coc_enabled
            try
                let [bufnum, lnum, col, off, curswant] = getcurpos()
                norm gi
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
    function! s:toggle_outline() abort
      let winid = coc#window#find('cocViewId', 'OUTLINE')
      if winid == -1
        call CocActionAsync('showOutline', 1)
      else
        call coc#window#close(winid)
      endif
    endfunction

" }}}

" Options: {{{
let g:rainbow_active = 1

let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                   = ''
let g:gitgutter_sign_modified                = ''
let g:gitgutter_sign_removed                 = ''
let g:gitgutter_sign_removed_first_line      = ''
let g:gitgutter_sign_modified_removed        = ''
let g:gitgutter_sign_allow_clobber           = ''
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_priority                = ''
let g:gitgutter_highlight_linenrs = 1
let g:highlightactive = 1
let g:autoHighCurrent = 0
let g:undotree_WindowLayout = 2
let g:vista_default_executive = 'nvim_lsp'

nmap <leader>dd :GitGutterPreviewHunk<cr>
nmap <leader>du :GitGutterUndoHunk<cr>
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

" Lua {{{
" TODO only if it exists
lua << EOF
function setup()
    require("nvim-tree").setup {
        disable_netrw = true,
        hijack_netrw = true,
        view = {
            number = true,
            relativenumber = true,
            },
        filters = {
            custom = { ".git" },
        },
    }
end
local status, err = pcall(setup)
if not status then
    print ("setup raised an error")
end
EOF
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
" autocmd VimEnter,Tabnew *
 "      \ if empty(&buftype) | call CocActionAsync('showOutline', 1) | endif
autocmd BufEnter * call <SID>check_outline()
function! s:check_outline() abort
  if &filetype ==# 'coctree' && winnr('$') == 1
    if tabpagenr('$') != 1
      close
    else
      quit
    endif
  endif
endfunction
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

let g:journal_dir = "~/journal"
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

