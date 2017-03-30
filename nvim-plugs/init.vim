"If I can only have TWO lines, these would be it
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
set termguicolors
colorscheme cyansprite
"Leader maps
map <space> <leader>
"gen tags
map <leader>gc <c-\>c
map <leader>gd <c-\>d
map <leader>ge <c-\>e
map <leader>gf <c-\>f
map <leader>gg <c-\>g
map <leader>gi <c-\>i
map <leader>gs <c-\>s
map <leader>gt <c-\>t
"Far
nmap <leader>ff :F<space>*/*<s-lefT><space><left>
nmap <leader>fr :Far<space>
nmap <leader>fc :Fardo<space>
nmap <leader>m :make<cr>
let g:far#window_layout='tab'
let g:far#file_mask_favorites = ['**/*.*', '%']
let g:far#collapse_result=1

"Denite
nmap <leader>grep :DeniteBufferDir grep<cr>
nmap <leader><space> :DeniteBufferDir file_rec<cr>
nmap <leader>d :DeniteBufferDir directory_rec<cr>
nmap <leader>u :DeniteBufferDir change<cr>
nmap <leader>p :DeniteBufferDir file_old<cr>
nmap <leader>H :DeniteBufferDir help<cr>
nmap <leader>r :DeniteBufferDir register<cr>
nmap <leader>y :DeniteBufferDir miniyank<cr>
nmap <leader>b :DeniteBufferDir buffer<cr>
nmap <leader>' :DeniteBufferDir jump<cr>
nmap <leader>* :DeniteCursorWord grep<cr>
nmap <Leader>1 :1tabn<cr>
nmap <Leader>2 :2tabn<cr>
nmap <Leader>3 :3tabn<cr>
nmap <Leader>4 :4tabn<cr>
nmap <Leader>5 :5tabn<cr>
nmap <Leader>6 :6tabn<cr>
nmap <Leader>7 :7tabn<cr>
nmap <Leader>8 :8tabn<cr>
nmap <Leader>9 :9tabn<cr>
tmap <Leader>1 :1tabn<cr>
tmap <Leader>2 :2tabn<cr>
tmap <Leader>3 :3tabn<cr>
tmap <Leader>4 :4tabn<cr>
tmap <Leader>5 :5tabn<cr>
tmap <Leader>6 :6tabn<cr>
tmap <Leader>7 :7tabn<cr>
tmap <Leader>8 :8tabn<cr>
tmap <Leader>9 :9tabn<cr>
nmap <cr> gg
vmap <cr> gg

"dein Scripts-----------------------------
" Required:
set runtimepath+=/home/joj/.config/nvim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/joj/.config/nvim/bundle')
    call dein#begin('/home/joj/.config/nvim/bundle')

    " Let dein manage dein
    " Required:
    call dein#add('/home/joj/.config/nvim/bundle/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    "Deoplete
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('zchee/deoplete-jedi')
    call dein#add('tweekmonster/deoplete-clang2')
    call dein#add('Shougo/neco-vim')
    call dein#add('Shougo/neco-syntax')
    call dein#add('Shougo/echodoc.vim')
    call dein#add('Shougo/neopairs.vim')
    call dein#add('Shougo/context_filetype.vim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Robzz/deoplete-omnisharp')

    "Nerd tree and comment
    call dein#add('scrooloose/nerdcommenter')
    call dein#add('scrooloose/nerdtree')
    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
    "Git
    call dein#add('xuyuanp/nerdtree-git-plugin')
    call dein#add('tpope/vim-fugitive')
    call dein#add('gregsexton/gitv')

    "Other nice things
    call dein#add('jsfaint/gen_tags.vim')
    call dein#add('gelguy/cmd2.vim')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('godlygeek/tabular')
    call dein#add('brooth/far.vim')
    call dein#add('neomake/neomake')
    call map(dein#check_clean(), "delete(v:val, 'rf')")

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"Denite
" Change mappings.
call denite#custom#map(
            \ 'insert',
            \ '<C-P>',
            \ '<denite:do_action:preview>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-S>',
            \ '<denite:do_action:split>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-V>',
            \ '<denite:do_action:vsplit>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<down>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<up>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<c-up>',
            \ '<denite:assign_previous_matched_text>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<c-down>',
            \ '<denite:assign_next_matched_text>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<Pagedown>',
            \ '<denite:scroll_page_forwards>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<PageUp>',
            \ '<denite:scroll_page_backwards>',
            \ 'noremap'
            \)

"cmd2
nmap / /<F12>
cmap <F12> <Plug>(Cmd2Suggest)

" Add custom menus example
let s:menus = {}

let s:menus.zsh = {
            \ 'description': 'Edit your import zsh configuration'
            \ }
let s:menus.zsh.file_candidates = [
            \ ['zshrc', '~/.config/zsh/.zshrc'],
            \ ['zshenv', '~/.zshenv'],
            \ ]

let s:menus.my_commands = {
            \ 'description': 'Example commands'
            \ }
let s:menus.my_commands.command_candidates = [
            \ ['Split the window', 'vnew'],
            \ ['Open zsh menu', 'Denite menu:zsh'],
            \ ]

call denite#custom#var('menu', 'menus', s:menus)

"deoplete
autocmd CompleteDone * pclose!

let g:deoplete#enable_at_startup=0
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<cr>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

"NerdTree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

"End dein Scripts-------------------------

"Begin Vim set   -------------------------
auto BufEnter * let &titlestring = "NVIM   %f%h%m%r%y   "
set foldcolumn=1
set mouse=a
set title titlestring=%P
set wrap nowrap
set cursorline "set cursorline to highlight the current line I'm no
set showmode noshowmode "don't show mode in cmd line, I hate when it clears an echo
set shiftwidth=4               " Use indents of 4 spaces
set tabstop=4                  " An indentation every four columns
set softtabstop=4              " Let backspace delete indent
set expandtab                  " Expands tab to spaces
set splitbelow "when split, split below the window instead of above
set splitright "when vsplit, splt to the right instead of left
set showcmd                    "Show cmd while typing
set ignorecase "in the name
set smartcase  "makes things a bit better
set smartindent "indent things well
set smarttab	"tab plays nicer
set list        "list my chars╳
set fillchars=vert:╳,stlnc:-,stl:\ ,fold:*,diff: "set fill chars to things that make me happy
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶ "Changes listchars to more suitable chars
let &showbreak = '↳ '          "Change show break thing
set showmatch      " Show matching brackets/parentthesis
set matchtime=1    " Show matching time
set report=0       " Always report changed lines
if &modifiable | set number | endif "If it's modifable, turn on numbers
"End   Vim set   -------------------------

"Begin Mappings  -------------------------
"Fuck escape
map  
lmap  
tmap <leader><leader> <C-\><C-n>

"[Pre/App]end to the word under the cursor
"And in visual mode, slow movement
map <m-a> ea
map <m-i> bi
map <m-p> ep
map <m-P> bP

"Smooth scroll
map <PageUp> <C-Y><C-Y><C-Y><C-Y>
map <Pagedown> <C-E><C-E><C-E><C-E>
vmap <S-up> <C-Y><C-Y><C-Y><C-Y>
vmap <S-down> <C-E><C-E><C-E><C-E>
imap <PageUp> <esc><C-Y><C-Y><C-Y><C-Y>i
imap <Pagedown> <esc><C-E><C-E><C-E><C-E>i

"Map some clipboard function
vnoremap  "+y
vnoremap <c-v> "+P
vnoremap <c-x> "+d
imap <c-v> <c-r><c-r>+

"Search and replace word under cursor
nnoremap <F6> :%s/<C-r><C-w>/

"Map home and end to ^$ respect'
nnoremap <End> $
nnoremap <Home> ^
vnoremap <End> $
vnoremap <Home> ^

"s-lrud for window movement
nnoremap <silent> <s-up> :wincmd k<CR>
nnoremap <silent> <s-down> :wincmd j<CR>
nnoremap <silent> <s-left> :wincmd h<CR>
nnoremap <silent> <s-right> :wincmd l<CR>
tnoremap <silent> <s-up> <C-\><C-n>:wincmd k<CR>
tnoremap <silent> <s-down> <C-\><C-n>:wincmd j<CR>
tnoremap <silent> <s-left> <C-\><C-n>:wincmd h<CR>
tnoremap <silent> <s-right> <C-\><C-n>:wincmd l<CR>

"Copy full path of filename to black hole
nnoremap <M-Y> :let @" = expand("%:p")<cr>

"I like playing with colors (Gives me hi-lo ids)
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"End   Mappings   -------------------------

"Aucmd time       -------------------------
let g:doGoldRatioActive=0
let g:GoldRatio=1.6
let g:doAutoNumInActive=1
let g:doAutoDimInactive=0
let g:killInactiveCursor=1
let g:dynamicStatusLine=1

function! EnterWin()
    let curWinIndex = winnr()
    let windowCount = winnr('$')

    for i in range(1,winnr('$'))
        if( i != curWinIndex )
            wincmd w
            if(g:doGoldRatioActive && (&modifiable || (&lines-winheight(curWinIndex) != 3)))
                let ratio = &columns/g:GoldRatio
                let minRatio = float2nr(ratio/windowCount)

                cal setwinvar(i,"&winminwidth",minRatio)
                cal setwinvar(i,"&winwidth",minRatio)
            endif
            if(g:doAutoNumInActive)
                setlocal number nonumber
                setlocal relativenumber norelativenumber
            endif
            if(g:killInactiveCursor)
                set cursorline nocursorline
            endif
        endif
    endfor

    wincmd w
    if(&modifiable && &buftype != 'terminal')
        if(g:doGoldRatioActive)
            exec printf("vertical resize %d", float2nr(ratio))
        endif
        if(g:killInactiveCursor)
            set cursorline
        endif
        if(g:doAutoNumInActive)
            setlocal number
        endif
        if(g:doAutoDimInactive && !getbufvar(bufnr(1),'&diff'))
            call setwinvar(winnr(),'&colorcolumn',0)
        endif
    endif
endfunction

"I want to save my session/view on leave automatically
set viewoptions=cursor,folds
set sessionoptions=help,resize,sesdir,tabpages,winpos,winsize,buffers,folds

augroup init
    autocmd!
    autocmd WinEnter * cal EnterWin()
    autocmd VimLeave * nested if (!isdirectory($HOME . "/.config/nvim")) |
                \ call mkdir($HOME . "/.config/nvim") |
                \ endif |
                \ execute "mksession! " . $HOME . "/.config/nvim/lastSession.vim"
    autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.config/nvim/lastSession.vim") |
                \ execute "source " . $HOME . "/.config/nvim/lastSession.vim"
    autocmd BufWinEnter,Syntax * syn sync minlines=100 maxlines=100
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END

set showtabline=2
set tabline=%!MyTabLine()

function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
	    let s .= '%=%#TabLine#%999X'
    endif

    return s
endfunction
function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return a:n . ' -- '. bufname(buflist[winnr - 1])
endfunction

"End    Aucmd   -------------------------
