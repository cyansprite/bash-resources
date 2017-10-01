" Setup {{{
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "chill"
"}}}

" Nons:   0{{{1
hi Normal        ctermfg=none  ctermbg=none cterm=none
hi MatchParen    ctermfg=none  ctermbg=none cterm=bold,underline
hi Folded        ctermfg=none  ctermbg=none cterm=bold
hi EndOfBuffer   ctermfg=none  ctermbg=none cterm=none
hi Visual        ctermfg=none  ctermbg=none cterm=bold,reverse
hi ModeMsg       ctermfg=none  ctermbg=none cterm=inverse,bold

" Red:    1{{{1
hi Boolean    ctermfg=9  ctermbg=none cterm=none
hi Keyword    ctermfg=9  ctermbg=none cterm=bold
hi Character  ctermfg=9  ctermbg=none cterm=none
hi String     ctermfg=1  ctermbg=none cterm=none

hi Error      ctermfg=7 ctermbg=9  cterm=bold
hi ErrorMsg   ctermfg=7 ctermbg=9  cterm=bold
hi Whitespace ctermfg=7 ctermbg=9  cterm=bold
hi DiffDelete ctermfg=7 ctermbg=9  cterm=bold

" Green:  2{{{1
hi StorageClass    ctermfg=2 ctermbg=none cterm=none
hi Structure    ctermfg=2 ctermbg=none cterm=none
hi Typedef    ctermfg=10 ctermbg=none cterm=none
hi Type       ctermfg=10 ctermbg=none cterm=bold
hi DiffAdd    ctermfg=231 ctermbg=2 cterm=bold

" Yellow: 3{{{1
hi PreCondit ctermfg=11 ctermbg=none cterm=none
hi StorageClass ctermfg=11 ctermbg=none cterm=none
hi Structure ctermfg=11 ctermbg=none cterm=none
hi TypeDef ctermfg=11 ctermbg=none cterm=none
hi Directory ctermfg=11 ctermbg=none cterm=none
hi Directory     ctermfg=11    ctermbg=none  cterm=none
hi Todo          ctermfg=11   ctermbg=none  cterm=bold
hi WarningMsg    ctermfg=11   ctermbg=none  cterm=inverse,bold
hi Search        ctermfg=0  ctermbg=11     cterm=bold

" Blue:   4{{{1
hi NonText       ctermfg=4    ctermbg=none  cterm=none
hi Special       ctermfg=4    ctermbg=none  cterm=none
hi SpecialChar   ctermfg=4    ctermbg=none  cterm=none
hi SpecialKey    ctermfg=10   ctermbg=none  cterm=none
hi Identifier    ctermfg=4  ctermbg=none cterm=none

" Purple: 5{{{1
hi Statement     ctermfg=13   ctermbg=none  cterm=bold
hi Delimeter     ctermfg=5    ctermbg=none  cterm=none
hi Number ctermfg=5 ctermbg=none cterm=none
hi Title ctermfg=5 ctermbg=none cterm=bold

" Cyan:   6{{{1
hi Member        ctermfg=6    ctermbg=none  cterm=bold
hi function      ctermfg=6    ctermbg=none  cterm=none
hi PmenuThumb    ctermfg=none  ctermbg=14    cterm=none

" Grey:   7{{{1
hi LineNr  ctermfg=7   ctermbg=none  cterm=none
hi ignore        ctermfg=7   ctermbg=none  cterm=italic

" Black:  8{{{1
hi PreProc    ctermfg=8 ctermbg=none cterm=bold

" 256 colors {{{1
" Grey
hi StatusLineNC  ctermfg=7   ctermbg=232   cterm=none

hi StatusLine    ctermfg=none  ctermbg=233   cterm=none

hi Pmenu         ctermfg=none  ctermbg=234     cterm=none

hi CursorLine    ctermfg=none  ctermbg=235   cterm=none

hi PmenuSbar     ctermfg=none  ctermbg=236   cterm=none
hi ColorColumn   ctermbg=none  ctermbg=236   cterm=none
hi DiffChange    ctermfg=231   ctermbg=236 cterm=inverse,bold

hi PmenuSel      ctermfg=none  ctermbg=237   cterm=bold
hi IncSearch     ctermfg=none  ctermbg=237  cterm=underline,bold

hi WildMenu      ctermfg=none  ctermbg=238   cterm=bold

" Blue
hi DiffText      ctermfg=7 ctermbg=32 cterm=bold

" Orange
hi Comment       ctermfg=130   ctermbg=none  cterm=italic

" Green
hi MoreMsg       ctermfg=113   ctermbg=none  cterm=inverse,bold
hi Question      ctermfg=063   ctermbg=none  cterm=inverse,bold

" Interface
hi CursorLineNr  ctermfg=063   ctermbg=none  cterm=bold
hi VertSplit     ctermfg=063   ctermbg=none  cterm=bold

" TODO
hi Conditional   ctermfg=177   ctermbg=none  cterm=bold
hi Repeat        ctermfg=177   ctermbg=none  cterm=bold,italic
hi Label         ctermfg=30    ctermbg=none  cterm=bold
hi Operator      ctermfg=60    ctermbg=none  cterm=bold

hi Class         ctermfg=38    ctermbg=none  cterm=none
hi Constant      ctermfg=126   ctermbg=none  cterm=none
hi Character     ctermfg=203   ctermbg=none  cterm=none
hi Float         ctermfg=106   ctermbg=none  cterm=none
hi Function      ctermfg=66    ctermbg=none  cterm=none

" User/StatusLine {{{1
hi User1         ctermfg=46    ctermbg=none  cterm=bold
hi User2         ctermfg=196   ctermbg=none  cterm=bold
hi User3         ctermfg=63    ctermbg=none  cterm=bold
hi User5         ctermfg=59    ctermbg=none  cterm=bold
hi User4         ctermfg=none  ctermbg=0     cterm=none

" }}}1

" Vim Relink {{{
hi link vimCommentTitle Title
hi link vimIsCommand Constant
hi link vimHighlight Member
hi link diffAdded   DiffAdd
hi link diffRemoved DiffDelete
" }}}
