"The single most important line to me
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

"Begin pathogen {{{
execute pathogen#infect()
call pathogen#helptags()
let g:gradle_path = '/home/joj/bin/android-studio/gradle/gradle-2.14.1'
let g:android_sdk_path = '/home/joj/Android/Sdk'
tnoremap <Esc> <C-\><C-n>
nmap     <C-F> <Plug>CtrlSFPrompt
vmap     <C-F> <Plug>CtrlSFVwordPath

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
call g:airline#parts#define_accent('file','italic')
call g:airline#parts#define_accent('filetype','italic')

autocmd Vimenter * GitGutterDisable

let g:ctrlp_line_prefix = ''
let g:ctrlp_map = '<c-space>'
let g:ctrlp_mruf_max=30
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:20'
let g:ctrlp_switch_buffer = 'etvh'
nmap <c-p> :CtrlPMRU<cr>
nmap <c-b> :CtrlPBuffer<cr>
nmap <c-w> :CtrlPBookmarkDir<cr>
nmap <m-]> :CtrlPTag<cr>

let gutentags_add_default_project_roots = 1

cmap <F12> <Plug>(Cmd2Suggest)
nmap / /<F12>
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 30
let g:ctrlsf_winsize='20%'

nmap <c-n> :NERDTreeToggle<cr>

let g:bookmark_sign = "★"
let g:bookmark_save_per_working_dir = 1
let g:neomake_cs_enabled_makers = ['mcs']
"End pathogen }}}

"being vim source {{{│
"XTerm*cursorBlink: on
set fillchars=vert:⏽,stlnc:-,stl:=,fold:,diff:
set foldmethod=manual
set updatetime=500
set lazyredraw
set cmdwinheight=10
set cmdheight=1
set scrolljump=0
set shiftwidth=4               " Use indents of 4 spaces
set tabstop=4                  " An indentation every four columns
set softtabstop=4              " Let backspace delete indent
set expandtab                  " Expands tab to spaces
set wildmode=list:longest:full "Nobody likes to use the vim default autocomplete in command line mode
set splitbelow "when split, split below the window instead of above
set splitright
set showcmd                    "Show cmd while typing
let &showbreak = '↳ '          "Change show break thing
set cpo=n                      "Show break in line numbers with wrap on
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶ "Changes listchars to more suitable chars
set laststatus=2
set ignorecase
set smartcase
set smartindent
set winwidth=1
set equalalways noequalalways
set smarttab
set list
if &modifiable | set number | endif "If it's modifable, turn on numbers
set wrap nowrap
inoremap  
set showmatch      " Show matching brackets/parentthesis
set matchtime=1    " Show matching time
set report=0       " Always report changed lines
"end vim }}}

"Map Stuff and functions {{{
"Map control + x to cut current text into clipboard
"map control + v in insert mode to paste
map <silent> <c-q> :bd<cr>
imap <C-v> <esc>"+pi
vmap <C-v> "+P
vmap <C-c> "+y
vmap <c-x> "+x
nnoremap <F6> :%s/<C-r><C-w>/

"Map c-left and right to switch between buffers
nnoremap <C-left> :tabprevious<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <C-up> 4k
nnoremap <C-down> 4j

" Use ctrl-[wasd] to select the active split and s-lrud
nnoremap <silent> <s-up> :wincmd k<CR>
nnoremap <silent> <s-down> :wincmd j<CR>
nnoremap <silent> <s-left> :wincmd h<CR>
nnoremap <silent> <s-right> :wincmd l<CR>

"allow if folding we hit space and it unfolds/folds, otherwise default
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

"Copy full path of filename to black hole
nnoremap <M-Y> :let @" = expand("%:p")<cr>

map <PageUp> <C-Y><C-Y><C-Y><C-Y>
map <Pagedown> <C-E><C-E><C-E><C-E>
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
            echo 'Highlight current word: off'
            return
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
            echo 'Highlight current word: ON'
            return 1
    endif
endfunction
nnoremap <F1> :if AutoHighlightToggle() <Bar> endif<CR>

"I like playing with colors
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"end map stuff }}}

"color {{{
set t_Co=256
colorscheme shadow
nnoremap <F9> :cal ColorMeHappy()<cr>
"switch between light and dark theme with <F9> {{{
fun! ColorMeHappy()
    syntax reset
    let g:theme=xor(1,g:theme)
    let start=255
    let end=233
    let acc=-1
    if g:theme
        let start=233
        let end=255
        let acc=1
    endif
    while start != end
        exec printf("hi Normal ctermbg=%d",start)
        sleep 10m
        let start = start + acc
    endwhile
    cal g:HandleBackgroundColors()
    cal g:HandleOtherColors()
    exec printf("%s","AirlineRefresh")
endfun
"}}}
"end color }}}

"Aucmd time! {{{
"Support for tagbar and ctrlsf
let g:doGoldRatioActive=1
let g:GoldRatio=1.6
let g:doAutoNumInActive=1
let g:doAutoDimInactive=0

autocmd CursorHold * if &number | set relativenumber | endif
autocmd CursorMoved * if &relativenumber | set relativenumber norelativenumber | endif
autocmd WinEnter * cal EnterWin()
autocmd WinLeave * cal LeaveWin()

function! LeaveWin()
    let curWinIndex = winnr()
    let windowCount = winnr('$')

    if(&modifiable && g:doAutoNumInActive)
        setlocal number nonumber
        setlocal relativenumber norelativenumber
    endif
    if(&modifiable && g:doAutoDimInactive && !getbufvar(bufnr(1),'&diff'))
        call setwinvar(winnr(),'&colorcolumn',join(range(1,&columns),','))
    endif
endfunction

function! EnterWin()
    let curWinIndex = winnr()
    let windowCount = winnr('$')

    if(g:doGoldRatioActive && (&modifiable || (&lines-winheight(curWinIndex) != 3)))
        let ratio = &columns/g:GoldRatio
        let minRatio = float2nr(ratio/windowCount)
        for i in range(1,winnr('$'))
            if i != curWinIndex
                cal setwinvar(i,"&winminwidth",minRatio)
                cal setwinvar(i,"&winwidth",minRatio)
            endif
        endfor

        exec printf("vertical resize %d", float2nr(ratio))
    endif

    if(&modifiable && g:doAutoNumInActive)
        setlocal number number
    endif
    if(&modifiable && g:doAutoDimInactive && !getbufvar(bufnr(1),'&diff'))
        call setwinvar(winnr(),'&colorcolumn',0)
    endif
endfunction
"end aucmd!! }}}
