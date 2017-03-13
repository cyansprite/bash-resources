" Vim color file
" Remove all existing highlighting and set the defaults.
" The goal is to make a night and day theme that can be used on either dark or
" light with keeping the same colors OTHER than the bg highlighting colors
set bg&
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset

let colors_name = "shadow"
syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"
"Setting the standard | Will have autcmd to change this from light to dark,and vice
"LIGHT : c231
"DARK  : c232
hi Normal                     ctermfg=231  ctermbg=232  cterm=NONE
hi ColorColumn                ctermfg=NONE ctermbg=NONE cterm=NONE
"Bg colors :
"Light: c255,c254,c253,c252,c251,c250,c249,c248,c247,c246,c245,c244
"Dark : c233,c234,c235,c236,c237,c238,c238,c239,c240,C241,c242,c243
"bg plus 8
hi SearchNc                   ctermfg=NONE ctermbg=240  cterm=underline
hi Folded                     ctermfg=NONE ctermbg=240  cterm=underline
"bg plus 4
hi WildMenu                   ctermfg=6    ctermbg=236  cterm=bold,underline
hi StatusLine                 ctermfg=NONE ctermbg=236  cterm=bold,underline
hi StatusLineNc               ctermfg=NONE ctermbg=236  cterm=bold,underline
hi Search                     ctermfg=NONE ctermbg=236  cterm=underline
hi Error                      ctermfg=1    ctermbg=236  cterm=NONE
hi ErrorMsg                   ctermfg=1    ctermbg=236  cterm=NONE
hi WarningMsg                 ctermfg=3    ctermbg=236  cterm=NONE
hi ModeMsg                    ctermfg=12   ctermbg=236  cterm=NONE
hi MoreMsg                    ctermfg=12   ctermbg=236  cterm=NONE
hi Ignore                     ctermfg=12   ctermbg=236  cterm=NONE
hi Question                   ctermfg=12   ctermbg=236  cterm=NONE
hi Tag                        ctermfg=12   ctermbg=236  cterm=NONE
"bg plus 2
hi visual                     ctermfg=NONE ctermbg=234  cterm=NONE
hi Pmenu                      ctermfg=NONE ctermbg=234  cterm=NONE
hi PmenuSel                   ctermfg=6    ctermbg=234  cterm=none

"Effects
hi LineNr                     ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorLineNr               ctermfg=NONE ctermbg=NONE cterm=italic
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm=standout
hi IncSearch                  ctermfg=NONE ctermbg=NONE cterm=underline
hi MatchParen                 ctermfg=NONE ctermbg=NONE cterm=underline,bold
hi OperatorChars              ctermfg=NONE ctermbg=NONE cterm=bold
hi Operator                   ctermfg=NONE ctermbg=NONE cterm=bold
hi link vimHiKeyList Operator
"hi FoldColumn                ctermfg=NONE ctermbg=NONE cterm=bold,underline
"hi SignColumn                ctermfg=NONE ctermbg=NONE cterm=bold,underline

"shadow group
"Acceptable subtle colors :: C241,C244,C245,C246,C247
hi Comment                    ctermfg=8    ctermbg=NONE cterm=italic
hi Todo                       ctermfg=8    ctermbg=NONE cterm=bold,inverse
hi Constant                   ctermfg=0    ctermbg=NONE cterm=bold

"red group
"Acceptable subtle colors :: c160,c161,c196,c197
hi DiffDelete                 ctermfg=1    ctermbg=NONE cterm=NONE
hi Boolean                    ctermfg=1    ctermbg=NONE cterm=NONE
hi Keyword                    ctermfg=9    ctermbg=NONE cterm=NONE
hi Character                  ctermfg=9    ctermbg=NONE cterm=NONE

"green group
"Acceptable green colors  :: c28,c34,c35,c40,c64,c65,c70,c76,c77,c106,,c107,c112,c113,c148
hi DiffAdd                    ctermfg=2    ctermbg=NONE cterm=NONE
hi String                     ctermfg=2    ctermbg=NONE cterm=NONE
hi Function                   ctermfg=10   ctermbg=NONE cterm=NONE

"orange group             :: c166,c167,c172,c173,c178,c202,c208,c209,c203,c214
hi Title                      ctermfg=3    ctermbg=NONE cterm=NONE
hi Identifier                 ctermfg=11   ctermbg=NONE cterm=NONE

"blue group               :: c25,c26,c27,c31,c32,c33,c38,c39,c44,c45,c67,c68,c69
"blue cont                :: c67,c68,c69,c74,c75,c109,c110,c111
hi DiffChange                 ctermfg=4    ctermbg=NONE cterm=NONE
hi Directory                  ctermfg=4    ctermbg=NONE cterm=NONE
hi Statement                  ctermfg=4    ctermbg=NONE cterm=NONE
hi Label                      ctermfg=12   ctermbg=NONE cterm=NONE

"cyan group               :: c66,c29,c30,c36,c37,c41,c42,c43,c66,c71,c72,c73
"cyna cont                :: c78,c79,c80,c81,c108
hi Type                       ctermfg=14   ctermbg=NONE cterm=NONE
hi VertSplit                  ctermfg=6    ctermbg=NONE cterm=NONE
hi EndOfBuffer                ctermfg=6    ctermbg=NONE cterm=NONE
hi StorageClass               ctermfg=6    ctermbg=NONE cterm=NONE

"Pink group"              ::c96,c139,c168,c169,c170,c171,c174,c175,c176,c177
"Pint cont                ::c197,c198,c199,c200,c201,c204,c205,c206,c207,c210
"Pint cont                ::c211,c212
hi Special                    ctermfg=5    ctermbg=NONE cterm=NONE
hi SpecialKey                 ctermfg=5    ctermbg=NONE cterm=NONE
hi NonText                    ctermfg=5    ctermbg=NONE cterm=NONE
hi Number                     ctermfg=13   ctermbg=NONE cterm=NONE

"purple group             ::c62,c63,c92,c93,c97,c98,c99,c103,c104,c105,c128,c129,c162,c163,c164,c165
hi PreProc                    ctermfg=5    ctermbg=NONE cterm=NONE
hi Conditional                ctermfg=15   ctermbg=NONE cterm=bold

"idk...
hi DiffText                   ctermfg=NONE ctermbg=NONE cterm=NONE
