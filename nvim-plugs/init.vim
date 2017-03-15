"The single most important line to me
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

"Begin pathogen {{{
    execute pathogen#infect()
    let g:gradle_path = '/home/joj/bin/android-studio/gradle/gradle-2.14.1'
    let g:android_sdk_path = '/home/joj/Android/Sdk'
    tnoremap <Esc> <C-\><C-n>
    nmap     <C-F> <Plug>CtrlSFPrompt
    vmap     <C-F> <Plug>CtrlSFVwordPath

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:ctrlp_map = '<c-space>'
    nmap <c-p> :CtrlPMRU<cr>
    nmap <c-b> :CtrlPBuffer<cr>
    let g:ctrlp_switch_buffer = 'et'

    cmap <F12> <Plug>(Cmd2Suggest)
    nmap / /<F12>
    nmap <F8> :TagbarToggle<CR>
    nmap <c-n> :NERDTreeToggle<cr>

    let g:bookmark_sign = "★"
    let g:bookmark_save_per_working_dir = 1
    nmap <silent> <C-g> :GitGutterNextHunk<CR>
    autocmd VimEnter * GitGutterToggle
    nnoremap gn :GitGutterNextHunk<cr>
    nnoremap gb :GitGutterPrevHunk<cr>
    let g:neomake_cs_enabled_makers = ['mcs']
"End pathogen }}}

"being vim source {{{│
"XTerm*cursorBlink: on
    set fillchars=vert:⏽,stlnc:-,stl:=,fold:,diff:
    set foldmethod=manual
    set updatetime=2000
    set foldmethod=manual
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
    nnoremap  i
    set showmatch      " Show matching brackets/parentthesis
    set matchtime=1    " Show matching time
    set report=0       " Always report changed lines
"end vim }}}

"Map Stuff and functions {{{
    "Map control + x to cut current text into clipboard
    "map control + v in insert mode to paste
    imap <C-v> <esc>"+pi
    vmap <C-v> "+P
    vmap <C-c> "+Y
    vmap <c-x> "+x
    nnoremap <F6> :%s/<C-r><C-w>/

    "Map c-leftright to switch between buffers, ctrlupdown for taps
    nnoremap <C-left> :bp<cr>
    nnoremap <C-right> :bn<cr>
    nnoremap <C-up> :tabprevious<CR>
    nnoremap <C-down> :tabnext<CR>

    " Use ctrl-[wasd] to select the active split and s-lrud
    nnoremap <silent> <c-k> :wincmd k<CR>
    nnoremap <silent> <c-j> :wincmd j<CR>
    nnoremap <silent> <c-h> :wincmd h<CR>
    nnoremap <silent> <c-l> :wincmd l<CR>
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
                return 0
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
    let g:theme=0
    let g:colorList=[[231,232,235,236,237,238,240,],
                    \[232,231,255,254,254,255,253,]]
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
        exec printf("hi Normal ctermfg=%d ctermbg=%d cterm=NONE"      , g:colorList[g:theme][0]  , g:colorList[g:theme][1])
        exec printf("hi Pmenu ctermfg=73 ctermbg=%d cterm=NONE"       , g:colorList[g:theme][2])
        exec printf("hi Visual ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][2])
        exec printf("hi Incsearch ctermfg=NONE ctermbg=%d cterm=NONE" , g:colorList[g:theme][2])
        exec printf("hi PmenuSel ctermfg=80 ctermbg=%d cterm=NONE"    , g:colorList[g:theme][3])
        exec printf("hi Tag ctermfg=NONE ctermbg=%d cterm=NONE"       , g:colorList[g:theme][3])
        exec printf("hi Question ctermfg=NONE ctermbg=%d cterm=NONE"  , g:colorList[g:theme][3])
        exec printf("hi Ignore ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][3])
        exec printf("hi MoreMsg ctermfg=45 ctermbg=%d cterm=NONE"     , g:colorList[g:theme][3])
        exec printf("hi ModeMsg ctermfg=45 ctermbg=%d cterm=NONE"     , g:colorList[g:theme][3])
        exec printf("hi WarningMsg ctermfg=178 ctermbg=%d cterm=NONE" , g:colorList[g:theme][3])
        exec printf("hi ErrorMsg ctermfg=203 ctermbg=%d cterm=NONE"   , g:colorList[g:theme][3])
        exec printf("hi Error ctermfg=160 ctermbg=%d cterm=NONE"      , g:colorList[g:theme][3])
        exec printf("hi Search ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][4])
        exec printf("hi WildMenu ctermfg=NONE ctermbg=%d cterm=NONE"  , g:colorList[g:theme][4])
        exec printf("hi Folded ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][5])
        exec printf("hi SearchNC ctermfg=NONE ctermbg=%d cterm=NONE"  , g:colorList[g:theme][6])
        cal g:HandleOtherColors()
    endfun
    "}}}
"end color }}}

"Aucmd time! {{{
"Support for tagbar and ctrlsf
    let g:doGoldRatioActive=1
    let g:GoldRatio=1.6
    let g:doAutoNumInActive=1
    let g:doAutoDimInactive=1

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
            for i in range(1,windowCount)
                echo ratio/windowCount
                exec printf("vertical resize %d", float2nr((ratio)/(windowCount)))
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
