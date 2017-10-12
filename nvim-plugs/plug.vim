" Plugins: (Plug.vim) {{{1
call plug#begin('~/.local/share/nvim/plugged')

    " Motion:
    Plug 'cyansprite/extract'
    Plug 'cyansprite/confine'
    Plug 'thinca/vim-visualstar'
    Plug 'junegunn/vim-after-object'
    Plug 'tpope/vim-commentary'

    " Format: Wrap it and align it.
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/vim-easy-align'

    " Syntax: The default is mediocre
    Plug 'cyansprite/vim-csharp'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'keith/tmux.vim'
    Plug 'Valloric/vim-operator-highlight'

    " Completion: This can be painful on certain machines...
    if hostname() !=? 'kistune' || hostname() !=? 'kuroi' || hostname !=? 'demi'
        Plug 'Valloric/YouCompleteMe'
        Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    endif

    " Git: Including runtime
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-git'

    " IDElike: I am looking into stuff like this, don't know if I will use.
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

    " Navigation: (<3 fzf) and my own custom that I need to fin.
    Plug 'cyansprite/logicalBuffers'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Grep: the context grep sucks; but quickfix is nice, look into others.
    Plug 'mhinz/vim-grepper'

    " Output: Fancy shit kiddo.
    Plug 'AndrewRadev/bufferize.vim'
    Plug 'AndrewRadev/linediff.vim'

    " Color: My personal theme featuring Espurr
    Plug 'cyansprite/Restraint.vim'

call plug#end()

" Mappings: {{{1
    "<3 fzf
    nnoremap <c-t> :Files<cr>
    nnoremap ? :Lines<cr>
    nnoremap <c-p> :Buffers<cr>

    let g:UltiSnipsJumpForwardTrigger="<c-f>"
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"

    nnoremap <silent> <leader>A :ArgWrap<CR>

    let g:wordmotion_mappings = {
                \ 'w' : 'W',
                \ 'b' : 'B',
                \ 'e' : 'E',
                \ 'iw' : 'iW',
                \ '<C-R><C-W>' : '<C-R><M-w>'
                \ }

    nmap <leader>a :A<cr>

    nmap <leader><leader>] :TagbarToggle<CR>

    nmap gs <plug>(GrepperOperator)
    xmap gs <plug>(GrepperOperator)

    nnoremap <leader>gg :Grepper -tool git<cr>
    nnoremap <leader>ga :Grepper -tool ag<cr>
    nnoremap <leader>gs :Grepper -tool ag -side<cr>
    nnoremap <leader>*  :Grepper -tool ag -cword -noprompt<cr>

    let g:grepper           = {}
    let g:grepper.tools     = ['git', 'ag', 'grep']
    let g:grepper.open      = 0
    let g:grepper.jump      = 1
    let g:grepper.next_tool = '<leader>g'

    command! Todo :Grepper
          \ -noprompt
          \ -tool git
          \ -grepprg git grep -nIi '\(TODO\|FIXME\)'


" Options: {{{1
" FZF {{{2
let g:fzf_layout = { 'up': '~20%' }
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Type'],
  \ 'bg+':     ['bg', 'Cursorline', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Label'],
  \ 'spinner': ['fg', 'Keyword'],
  \ 'header':  ['fg', 'Comment'] }

" Insert mode completion
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})


" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)
" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
function! s:fzf_statusline()
  setlocal statusline=%#ModeMsg#\ >\ fzf\ %#User4#
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
" Cpp highlight {{{2
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1

"Ycm {{{2
" I'm not sure if I've ever used this...
let g:ycm_always_populate_location_list = 1
" Please, for the love of all that is vim, do not fuckin highlight my stuff.
let g:ycm_enable_diagnostic_highlighting = 0
" I might change these one day to something prettier, but who the fuck knows.
let g:ycm_warning_symbol = '>>'
let g:ycm_error_symbol = 'XX'
" Don't limit strings and comments
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings  = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" Preview.
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" Don't you fuckin popup unless I say
let g:ycm_auto_trigger = 0
" I don't actually use these... but I will be damned before I use tab/s-tab
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" Nerd Commenter {{{2
" Just make it pretty please
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
"Grepper {{{2
nnoremap <leader>gg :Grepper -tool git<cr>
nnoremap <leader>ga :Grepper -tool ag<cr>
nnoremap <leader>gs :Grepper -tool ag -side<cr>
nnoremap <leader>*  :Grepper -tool ag -cword -noprompt<cr>
let g:grepper           = {}
let g:grepper.tools     = ['git', 'ag', 'grep']

" Easy align {{{2
    let g:easy_align_delimiters = {
    \ 'c': {
    \     'pattern':      'cterm',
    \     'left_margin':  2,
    \     'right_margin': 0
    \   }
    \ }
" Extract {{{2
let g:extract_maxCount = 20


" Autocmd: {{{1
autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')
autocmd FileType GrepperSide
  \  silent normal! gg
  \  silent execute 'keeppatterns v#'.b:grepper_side.'#>'
  \| silent normal! ggn

" Highlight: {{{1
    let g:ophigh_highlight_link_group = 'Operator'
    let g:indent_guides_auto_colors = 0
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size  = 2
    hi link StartifyPath     StorageClass
    hi link StorageClass     Keyword
    hi link cppSTLnamespace  Label
    hi link cCustomMemVar    Member
    hi link cCustomClass     Class
    hi link cRepeat          Repeat
    let g:ophigh_filetypes_to_ignore = {'jinja': 1, 'help': 1, 'notes': 1,
                \ 'markdown': 1, 'less': 1, 'sh': 1, 'html': 1, 'diff': 1,
                \ 'bash': 1, 'qf': 1, 'css': 1, 'vim': 1
    \}
"}}}1

" test-zone
