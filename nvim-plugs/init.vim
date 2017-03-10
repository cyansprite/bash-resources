"The single most important line to me
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
"Begin pathogen
    execute pathogen#infect()
    let g:gradle_path = '/home/joj/bin/android-studio/gradle/gradle-2.14.1'
    let g:android_sdk_path = '/home/joj/Android/Sdk'
    tnoremap <Esc> <C-\><C-n>
    nmap     <C-F>f <Plug>CtrlSFPrompt
    vmap     <C-F>f <Plug>CtrlSFVwordPath
    let g:golden_ratio_exclude_nonmodifiable = 1
"End pathogen
    "Airline stuff"
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    "let g:golden_ratio_exclude_nonmodifiable = 1

    nmap / /<F12>
    cmap <F12> <Plug>(Cmd2Suggest)
    nmap <F8> :TagbarToggle<CR>

    let g:bookmark_sign = "★"
    nmap <silent> <C-g> :GitGutterNextHunk<CR>
    nnoremap gn :GitGutterNextHunk<cr>
    nnoremap gb :GitGutterPrevHunk<cr>

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
    set ignorecase
    set smartcase
    set smartindent
    set smarttab
    set scrolloff=10    " Minumum lines to keep above and below cursor
    set list
    set number
    set wrap nowrap
    set hidden         " Allow buffer switching without saving
    inoremap  
    set showmatch      " Show matching brackets/parentthesis
    set matchtime=5    " Show matching time
    set report=0       " Always report changed lines
    set linespace=0    " No extra spaces between rows
"end vim

"Map Stuff and functions
    "Map control + x to cut current text into clipboard
    vmap <c-x> "+x
    "map control + v in insert mode to paste
    imap <C-v> <C-r>+
    vmap <C-v> "+P
    vnoremap i <s-i>

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
    nnoremap <silent> <CR> @=(foldlevel('.')?'zO':"\<CR>")<CR>

    "Copy full path of filename to black hole
    nnoremap <C-Y> :let @" = expand("%:p")<cr>

    " Highlight all instances of word under cursor, when idle.
    " Useful when studying strange source code.
    " Type z/ to toggle highlighting on/off.
    nnoremap <F1> :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
    function! AutoHighlightToggle()
        let @/ = ''
        if exists('#auto_highlight')
            au! auto_highlight
            augroup! auto_highlight
                setl updatetime=4000
                echo 'Highlight current word: off'
                return 0
            else
                augroup auto_highlight
                    au!
                    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
                augroup end
                    setl updatetime=500
                    echo 'Highlight current word: ON'
                    return 1
                endif
            endfunction

    "I like playing with colors
    map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"end map stuff

"color
    set t_Co=256
    colorscheme snow
"end color

"Aucmd time!
    autocmd WinEnter * set number
    autocmd WinLeave * set number nonumber
