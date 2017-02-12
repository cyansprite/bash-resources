"plugin pathogen stuf
execute pathogen#infect()
syntax on
filetype plugin indent on

"Rainbow Para
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"Airline stuff"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='vice'
"Undo tree toggle! and assuming persistant undo!
nnoremap <F5> :UndotreeToggle<cr>
if has("persistent_undo")
	    set undodir=~/.undodir/
	        set undofile
endif

"vim stuff
"let g:loaded_matchparen=1
set relativenumber 
set number
set wildmode=longest,list
set wrap nowrap
set hlsearch
inoremap  
set cursorline
set cuc
set mouse=a
"map enter to insert cr and exit insert below, and shift enter for above
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
"map ctrl + D to clipboard
map <C-D> "+
inoremap <C-Z> <Esc>ui

"gvim stuff...
set guioptions-=T
set laststatus=2

"It's color time! 
"Finished for gvim, not for vim-vim yet >.> cterms don't have the color range
"I want -.-
"main
set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

"basics!
hi Cursor ctermfg       = NONE ctermbg = NONE cterm = standout guifg = NONE guibg    = NONE gui    = standout
hi visual ctermfg       = NONE ctermbg = NONE cterm = standout guifg = NONE guibg    = NONE gui    = standout
hi cursorline ctermfg   = NONE ctermbg = 0 cterm    = NONE guifg     = NONE guibg    = #000000 gui = NONE
hi cursorcolumn ctermfg = NONE ctermbg = 0 cterm    = NONE guifg     = NONE guibg    = #000000 gui = NONE
hi colorcolumn ctermfg  = NONE ctermbg = 16 cterm   = NONE guifg     = NONE guibg    = #3c3d37 gui = NONE
hi CursorLineNr ctermfg = 51 ctermbg   = 0 cterm    = NONE guifg     = #88ffff guibg = #111111 gui = bold
hi LineNr ctermfg       = 51 ctermbg   = 0 cterm    = NONE guifg     = #883388 guibg = NONE gui = NONE
hi VertSplit ctermfg    = 241 ctermbg  = 241 cterm  = NONE guifg     = #000000 guibg = #88ffff gui = NONE
hi MatchParen ctermfg   = NONE ctermbg = NONE cterm = standout guifg = NONE guibg    = NONE gui    = standout
hi ModeMsg ctermfg      = NONE ctermbg = NONE cterm = standout guifg = NONE guibg    = NONE gui    = standout

"tab line!
hi TabLine ctermfg   = NONE ctermbg = NONE cterm = NONE guifg = #555555 guibg    = #000000 gui    = NONE
hi TabLineSel ctermfg   = NONE ctermbg = NONE cterm = NONE guifg = #000000 guibg    = #aa44aa gui    = bold,underline
hi TabLineFill ctermfg   = NONE ctermbg = NONE cterm = NONE guifg = #000000 guibg    = #aa44aa gui    = bold,underline

"Status line!
hi StatusLine ctermfg   = 231 ctermbg  = 241 cterm  = bold guifg         = #88ffff guibg = #000000 gui = inverse
hi StatusLineNC ctermfg = 231 ctermbg  = 241 cterm  = NONE guifg         = #226666 guibg = #111111 gui = NONE
hi WildMenu ctermfg = 231 ctermbg  = 241 cterm  = NONE guifg         = #226666 guibg =#000000  gui = NONE

"hint popup-menu!
hi Pmenu ctermfg        = NONE ctermbg = NONE cterm = NONE guifg         = #33bbbb guibg    = #000000 gui    = underline
hi PmenuSel ctermfg     = NONE ctermbg = 59 cterm   = NONE guifg         = #000000 guibg    = #33bbbb    gui = bold

"searching!
hi IncSearch ctermfg    = NONE ctermbg  = NONE cterm  = NONE guifg         = NONE guibg = NONE gui = inverse
hi Search ctermfg       = NONE ctermbg = NONE cterm = underline guifg    = NONE guibg    = NONE gui    = inverse,bold

"dir
hi Directory ctermfg    = 141 ctermbg  = NONE cterm = NONE guifg         = #ae81ff guibg = NONE gui    = NONE
hi Folded ctermfg       = 242 ctermbg  = 235 cterm  = NONE guifg         = #75715e guibg = #000000 gui = NONE

"types
hi SignColumn ctermfg   = NONE ctermbg = 237 cterm  = NONE guifg         = NONE guibg    = #3c3d37 gui = NONE
hi Normal ctermfg       = 231 ctermbg  = 235 cterm  = NONE guifg         = #f8f8f2 guibg = #282828 gui = NONE
hi Boolean ctermfg      = 141 ctermbg  = NONE cterm = NONE guifg         = #cc3333 guibg = NONE gui    = bold
hi Character ctermfg    = 141 ctermbg  = NONE cterm = NONE guifg         = #cc0000 guibg = NONE gui    = NONE
hi Comment ctermfg      = 242 ctermbg  = NONE cterm = NONE guifg         = #833383 guibg = #000000 gui    = NONE
hi Conditional ctermfg  = 197 ctermbg  = NONE cterm = NONE guifg         = #ff88ff guibg = NONE gui    = NONE
hi Constant ctermfg     = NONE ctermbg = NONE cterm = NONE guifg         = #228822 guibg    = NONE gui    = NONE
hi Define ctermfg       = 197 ctermbg  = NONE cterm = NONE guifg         = #f92672 guibg = NONE gui    = NONE
hi DiffAdd ctermfg      = 231 ctermbg  = 64 cterm   = bold guifg         = #f8f8f2 guibg = #46830c gui = bold
hi DiffDelete ctermfg   = 88 ctermbg   = NONE cterm = NONE guifg         = #8b0807 guibg = NONE gui    = NONE
hi DiffChange ctermfg   = NONE ctermbg = NONE cterm = NONE guifg         = #f8f8f2 guibg = #243955 gui = NONE
hi DiffText ctermfg     = 231 ctermbg  = 24 cterm   = bold guifg         = #f8f8f2 guibg = #204a87 gui = bold
hi ErrorMsg ctermfg     = 231 ctermbg  = 197 cterm  = NONE guifg         = #000000 guibg = #aa3535 gui = underline
hi WarningMsg ctermfg   = 231 ctermbg  = 197 cterm  = NONE guifg         = #000000 guibg = #aaaa35 gui = NONE
hi Float ctermfg        = 141 ctermbg  = NONE cterm = NONE guifg         = #ccbbff guibg = NONE gui    = NONE
hi Number ctermfg        = 141 ctermbg  = NONE cterm = NONE guifg         = #ccffbb guibg = NONE gui    = NONE
hi Function ctermfg     = 148 ctermbg  = NONE cterm = NONE guifg         = #9999ee guibg = NONE gui    = NONE
hi Identifier ctermfg   = 81 ctermbg   = NONE cterm = NONE guifg         = #eeffee guibg = NONE gui    = NONE
hi Keyword ctermfg      = 197 ctermbg  = NONE cterm = NONE guifg         = #cc33f3 guibg = NONE gui    = NONE
hi Label ctermfg        = 186 ctermbg  = NONE cterm = NONE guifg         = #e6db74 guibg = NONE gui    = NONE
hi NonText ctermfg      = 59 ctermbg   = 236 cterm  = NONE guifg         = #49483e guibg = #31322c gui = NONE
hi Operator ctermfg     = 197 ctermbg  = NONE cterm = NONE guifg         = #aaffff guibg = NONE gui    = bold
hi PreProc ctermfg      = 197 ctermbg  = NONE cterm = NONE guifg         = #f92672 guibg = NONE gui    = NONE
hi Special ctermfg      = 231 ctermbg  = NONE cterm = NONE guifg         = #f8f8f2 guibg = NONE gui    = NONE
hi SpecialKey ctermfg   = 59 ctermbg   = 237 cterm  = NONE guifg         = #49483e guibg = #3c3d37 gui = NONE
hi Statement ctermfg    = 197 ctermbg  = NONE cterm = NONE guifg         = #33bbbb guibg = NONE gui    = NONE
hi StorageClass ctermfg = 81 ctermbg   = NONE cterm = NONE guifg         = #ffaa33 guibg = NONE gui    = italic
hi String ctermfg       = 186 ctermbg  = NONE cterm = NONE guifg         = #33cc5c guibg = NONE gui    = NONE
hi Tag ctermfg          = 197 ctermbg  = NONE cterm = NONE guifg         = #f92672 guibg = NONE gui    = NONE
hi Title ctermfg        = 231 ctermbg  = NONE cterm = bold guifg         = #f8f8f2 guibg = NONE gui    = bold
hi Todo ctermfg         = 95 ctermbg   = NONE cterm = inverse,bold guifg = #fcfc6c guibg = NONE gui    = inverse,bold
hi Type ctermfg         = 197 ctermbg  = NONE cterm = NONE guifg         = #ff4f4f guibg = NONE gui    = NONE
hi Underlined ctermfg   = NONE ctermbg = NONE cterm = underline guifg    = NONE guibg    = NONE gui    = underline
"end of main
