" Setup {{{
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "chill"
"}}}

" Nons:   -{{{1
hi Normal       ctermfg=none ctermbg=none cterm=none
hi MatchParen   ctermfg=none ctermbg=none cterm=bold,underline
hi Folded       ctermfg=none ctermbg=none cterm=bold
hi EndOfBuffer  ctermfg=none ctermbg=none cterm=none
hi ModeMsg      ctermfg=none ctermbg=none cterm=inverse,bold
hi CursorLineNr ctermfg=none ctermbg=none cterm=inverse

" Gui define s:colors {{{1
let s:color0  = '000000'
let s:color8  = '8a8a8a'

let s:color1  = 'db9090'
let s:color9  = 'c24343'

let s:color2  = 'b6db90'
let s:color10 = '82c243'

let s:color3  = 'dbcf90'
let s:color11 = 'db9970'

let s:color4  = '9090db'
let s:color12 = '90b6db'

let s:color5  = 'b690db'
let s:color13 = 'cf6acf'

let s:color6  = '90dbdb'
let s:color14 = '6acfcf'

let s:color7  = 'b6b6b6'
let s:color15 = 'e7efe2'

" Red:    1{{{1
hi String       ctermfg=1  ctermbg=none cterm=none
hi Boolean      ctermfg=1  ctermbg=none cterm=none

hi Keyword      ctermfg=9  ctermbg=none cterm=none
hi Character    ctermfg=9  ctermbg=none cterm=none

hi Error        ctermfg=1  ctermbg=9    cterm=none
hi ErrorMsg     ctermfg=15 ctermbg=9    cterm=bold
hi Whitespace   ctermfg=15 ctermbg=9    cterm=bold
hi DiffDelete   ctermfg=15 ctermbg=9    cterm=bold

" Green:  2{{{1
hi StorageClass ctermfg=2    ctermbg=none cterm=none
hi Structure    ctermfg=2    ctermbg=none cterm=none
hi Typedef      ctermfg=2    ctermbg=none cterm=none

hi Type         ctermfg=10   ctermbg=none cterm=none
hi MoreMsg      ctermfg=10   ctermbg=none cterm=inverse,bold
hi DiffAdd      ctermfg=15   ctermbg=10   cterm=bold

" Yellow: 3{{{1
hi PreCondit    ctermfg=3    ctermbg=none cterm=none
hi Structure    ctermfg=3    ctermbg=none cterm=none
hi TypeDef      ctermfg=3    ctermbg=none cterm=none

hi StorageClass ctermfg=11   ctermbg=none cterm=none
hi Directory    ctermfg=11   ctermbg=none cterm=none
hi Todo         ctermfg=11   ctermbg=none cterm=bold

hi WarningMsg   ctermfg=3    ctermbg=none cterm=inverse,bold


" Blue:   4{{{1
hi NonText      ctermfg=4    ctermbg=none cterm=none
hi Special      ctermfg=4    ctermbg=none cterm=none
hi SpecialChar  ctermfg=4    ctermbg=none cterm=none
hi SpecialKey   ctermfg=4    ctermbg=none cterm=none
hi Label        ctermfg=12   ctermbg=none cterm=none
hi Identifier   ctermfg=12   ctermbg=none cterm=none

" Purple: 5{{{1
hi Delimeter    ctermfg=5    ctermbg=none cterm=none
hi Constant     ctermfg=5    ctermbg=none cterm=none
hi Number       ctermfg=5    ctermbg=none cterm=none
hi Statement    ctermfg=5    ctermbg=none cterm=none
hi Conditional  ctermfg=5    ctermbg=none cterm=none

hi Repeat       ctermfg=13   ctermbg=none cterm=none
hi Float        ctermfg=13   ctermbg=none cterm=none
hi Title        ctermfg=13   ctermbg=none cterm=bold

hi Question     ctermfg=13   ctermbg=none cterm=inverse,bold

" Cyan:   6{{{1
hi Member       ctermfg=6    ctermbg=none cterm=none
hi function     ctermfg=6    ctermbg=none cterm=none
hi PmenuThumb   ctermfg=none ctermbg=6    cterm=none
hi Function     ctermfg=6    ctermbg=none cterm=none
hi DiffText     ctermfg=7    ctermbg=14   cterm=bold

" Grey:   7{{{1
hi LineNr       ctermfg=7    ctermbg=none cterm=none
hi ignore       ctermfg=7    ctermbg=none cterm=italic
hi PreProc      ctermfg=7    ctermbg=none cterm=none
hi Class        ctermfg=7    ctermbg=none cterm=none
hi Operator     ctermfg=8    ctermbg=none cterm=bold
hi Search       ctermfg=none ctermbg=15   cterm=bold,inverse

" Black:  0{{{1
hi VertSplit    ctermfg=0    ctermbg=none cterm=none
hi StatusLineNC ctermfg=8    ctermbg=232  cterm=none
hi Comment      ctermfg=8    ctermbg=none cterm=italic
hi Visual       ctermfg=7    ctermbg=8 cterm=bold

" 256 colors need converting FIXME {{{1
if &bg == 'dark'
    " dark
    hi StatusLine   ctermfg=none ctermbg=233  cterm=none
    hi Pmenu        ctermfg=none ctermbg=234  cterm=none
    hi CursorLine   ctermfg=none ctermbg=235  cterm=none
    hi PmenuSbar    ctermfg=none ctermbg=236  cterm=none
    hi ColorColumn  ctermbg=none ctermbg=236  cterm=none
    hi DiffChange   ctermfg=236  ctermbg=none cterm=inverse,bold
    hi Visual       ctermfg=none ctermbg=237  cterm=bold
    hi PmenuSel     ctermfg=none ctermbg=237  cterm=bold
    hi IncSearch    ctermfg=none ctermbg=237  cterm=underline,bold
    hi WildMenu     ctermfg=none ctermbg=238  cterm=bold
else
    " light
    hi StatusLine   ctermfg=none ctermbg=255  cterm=none
    hi Pmenu        ctermfg=none ctermbg=254  cterm=none
    hi CursorLine   ctermfg=none ctermbg=253  cterm=none
    hi PmenuSbar    ctermfg=none ctermbg=252  cterm=none
    hi ColorColumn  ctermbg=none ctermbg=251  cterm=none
    hi DiffChange   ctermfg=251  ctermbg=none cterm=inverse,bold
    hi PmenuSel     ctermfg=none ctermbg=250  cterm=bold
    hi IncSearch    ctermfg=none ctermbg=250  cterm=underline,bold
    hi WildMenu     ctermfg=none ctermbg=248  cterm=bold
endif


" User {{{1
hi User1        ctermfg=2    ctermbg=none cterm=bold
hi User2        ctermfg=1    ctermbg=none cterm=bold
hi User3        ctermfg=5    ctermbg=none cterm=bold
hi User5        ctermfg=7    ctermbg=none cterm=bold
hi User4        ctermfg=none ctermbg=0    cterm=none
" }}}1

" Vim Relink {{{
hi link vimCommentTitle Title
hi link vimIsCommand Constant
hi link vimHighlight Member
hi link diffAdded   DiffAdd
hi link diffRemoved DiffDelete
hi link QuickFixLine ModeMsg
" }}}
