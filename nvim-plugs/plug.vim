" Plugins: (Plug.vim) {{{
call plug#begin('~/.local/share/nvim/plugged')
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
    Plug 'mcauley-penney/visual-whitespace.nvim'
    Plug 'hat0uma/csvview.nvim'

    " LSP and completion:
    Plug 'mfussenegger/nvim-lint'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'SmiteshP/nvim-navic'
    Plug 'udalov/kotlin-vim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    " Plug 'hrsh7th/cmp-git'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'stevearc/conform.nvim'
    Plug 'arnar/vim-matchopen'
    Plug 'sontungexpt/better-diagnostic-virtual-text'
    Plug 'rachartier/tiny-inline-diagnostic.nvim'
    Plug 'onsails/lspkind.nvim'
    Plug 'gfanto/fzf-lsp.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'VidocqH/lsp-lens.nvim'
    Plug 'soulis-1256/eagle.nvim'
    Plug 'folke/which-key.nvim'
    Plug 'artemave/workspace-diagnostics.nvim'

    if has('unix')
        Plug '~/.fzf'
    elseif has('win32')
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    endif
    Plug 'ibhagwan/fzf-lua'

    " Git:
    Plug 'akinsho/git-conflict.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive', { 'on' : ['Gdiff', 'Gblame'] } " add more if I ever use
    Plug 'f-person/git-blame.nvim'

    " Interface:
    Plug 'uga-rosa/ccc.nvim'
    Plug 'yorickpeterse/nvim-pqf'
    Plug 'dzfrias/arena.nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
    Plug 'rcarriga/nvim-notify'
    Plug 'cyansprite/nvim-deardiary'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'NvChad/nvim-colorizer.lua'
    Plug 'ziontee113/icon-picker.nvim'

    Plug 'vim-scripts/undofile_warn.vim'
    Plug 'junegunn/fzf.vim'

    Plug 'mhinz/vim-grepper', { 'on' : 'Grepper' }
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'liuchengxu/vim-which-key'

    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " Optional
    Plug 'rcarriga/nvim-notify'

    " Color:
    Plug 'cyansprite/Restraint.vim'
    Plug 'github/copilot.vim'
    Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }

call plug#end() " }}}

" {{{ Completion
    imap <silent><script><expr> <c-k> copilot#Accept("\<CR>")
    hi link MatchOpen Error
    let g:copilot_no_tab_map = v:true

    " allow to scroll in the preview
    set mouse=a

    fu! NormTag()
        try
            if &filetype == "vim"
                exec "help ". expand("<cword>")
            else
                norm! 
            endif
        catch /.*/
            " echo v:exception
        endtry
    endfu

    func! Tag()
        try
            let [bufnum, lnum, col, off, curswant] = getcurpos()
            tag
            let [bufnum1, lnum1, col1, off1, curswant1] = getcurpos()
            if bufnum1 == bufnum && lnum == lnum1 && col == col1 && off == off
                call NormTag()
            endif
        catch /.*/
            call NormTag()
            " echo v:exception
        endtry
    endfunc
    nnoremap <silent> <c-]> <cmd>call Tag()<CR>
" }}}

" Various Mappings With No Options: {{{
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

let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                   = '┃'
let g:gitgutter_sign_modified                = '┃'
let g:gitgutter_sign_removed                 = '_'
let g:gitgutter_sign_removed_first_line      = '‾'
let g:gitgutter_sign_modified_removed        = '+'
let g:gitgutter_sign_removed_above_and_below = '*'
let g:gitgutter_sign_priority                = 10
let g:gitgutter_sign_allow_clobber           = 1
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
nmap <leader>do :GitGutterUndoHunk<cr>
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
nmap  :BLines<cr>
nmap <leader>fo :History<cr>
nmap <leader>fh :Helptags<cr>
nmap <leader>f] :BTags<cr>
nmap <leader>fc :Commands<cr>
nnoremap <leader>fn :Buffers<cr>
nnoremap <leader>f/ :Lines<cr>
" }}}

"Grepper {{{
    let g:grepper           = {}
    let g:grepper.tools     = ['git', 'ag', 'grep']
    let g:grepper.open      = 0
    let g:grepper.jump      = 1
    let g:grepper.highlight = 1
    nnoremap <leader>ag :Grepper -tool ag<cr>
    nmap <leader>af :Ag<space>
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
    \ 'LUA'
    \ ]

command! -nargs=0 INIT :e ~/Documents/bash-resources/nvim-plugs/init.vim
command! -nargs=0 PLUG :e ~/Documents/bash-resources/nvim-plugs/plug.vim
command! -nargs=0 COLO :e ~/.local/share/nvim/plugged/Restraint.vim/colors/restraint.vim
command! -nargs=0 JOURNAL :e ~/journal/journal.md
command! -nargs=0 REMIND :e ~/.reminders
command! -nargs=0 LUA :e ~/Documents/bash-resources/nvim-plugs/plug.lua

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
let g:dart_format_on_save = 0
lua require('plug')

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

nnoremap <silent> <Space>dd :Diagnostics<cr>
nnoremap <silent> <Space>ds :DocumentSymbols<cr>
nnoremap <silent> <Space>dw :WorkspaceSymbols<cr>
nnoremap <silent> <Space>dr :References<cr>
nnoremap <silent> <Space>di :Implementations<cr>
nnoremap <silent> <Space>df :Definitions<cr>
nnoremap <silent> <Space>dc :Declarations<cr>
nnoremap <silent> <Space>dt :TypeDefinitions<cr>
nnoremap <silent> <Space>da :DiagnosticsAll<cr>
