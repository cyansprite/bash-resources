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
"global syntax
syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"

"Setting the standard | Will have autcmd to change this from light to dark,and vice
hi Normal                     ctermfg=231  ctermbg=232  cterm=NONE
hi ColorColumn                ctermfg=NONE ctermbg=NONE cterm=NONE
"Bg colors :
hi SearchNc                   ctermfg=NONE ctermbg=240  cterm=underline
hi Folded                     ctermfg=NONE ctermbg=237  cterm=underline
hi WildMenu                   ctermfg=6    ctermbg=236  cterm=bold,underline
hi Search                     ctermfg=NONE ctermbg=236  cterm=underline
hi Error                      ctermfg=1    ctermbg=235  cterm=NONE
hi ErrorMsg                   ctermfg=1    ctermbg=235  cterm=NONE
hi WarningMsg                 ctermfg=3    ctermbg=235  cterm=NONE
hi ModeMsg                    ctermfg=12   ctermbg=235  cterm=NONE
hi MoreMsg                    ctermfg=12   ctermbg=235  cterm=NONE
hi Ignore                     ctermfg=12   ctermbg=235  cterm=NONE
hi Question                   ctermfg=12   ctermbg=235  cterm=NONE
hi Tag                        ctermfg=12   ctermbg=235  cterm=NONE
hi PmenuSel                   ctermfg=6    ctermbg=235  cterm=NONE
hi IncSearch                  ctermfg=NONE ctermbg=235  cterm=underline
hi visual                     ctermfg=NONE ctermbg=234  cterm=NONE
hi Pmenu                      ctermfg=NONE ctermbg=234  cterm=NONE
hi CursorLineNr               ctermfg=NONE ctermbg=NONE cterm=bold
"Effects
hi LineNr                     ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm=standout
hi MatchParen                 ctermfg=NONE ctermbg=NONE cterm=underline,bold
hi OperatorChars              ctermfg=NONE ctermbg=NONE cterm=bold
hi Operator                   ctermfg=NONE ctermbg=NONE cterm=bold
hi link vimHiKeyList Operator
"hi SignColumn                ctermfg=NONE ctermbg=NONE cterm=bold,underline

fun! g:HandleOtherColors()
    "shadow group
    "Acceptable subtle colors :: TODO
    "C241,C244,C245,C246,C247,c144,c145,c146,c139,c137,c217,c143
    hi Comment                    ctermfg=143    ctermbg=NONE cterm=italic
    hi Todo                       ctermfg=217    ctermbg=NONE cterm=bold
    hi Constant                   ctermfg=142    ctermbg=NONE cterm=bold
    hi SpecialKey                 ctermfg=146    ctermbg=NONE cterm=NONE
    hi NonText                    ctermfg=146    ctermbg=NONE cterm=NONE
    "Acceptable red colors    :: c160,c161,c196,c197,c167,c203
    hi DiffDelete                 ctermfg=196    ctermbg=NONE cterm=NONE
    hi Boolean                    ctermfg=197    ctermbg=NONE cterm=bold
    hi Character                  ctermfg=160    ctermbg=NONE cterm=NONE
    hi Function                   ctermfg=203   ctermbg=NONE cterm=NONE
    "Acceptable green colors  :: c28,c34,c35,c40,c64,c65,c70,c76,c77,c106,,c107,c112,c113,c148
    hi DiffAdd                    ctermfg=40    ctermbg=NONE cterm=NONE
    hi String                     ctermfg=106    ctermbg=NONE cterm=NONE
    hi Label                      ctermfg=148   ctermbg=NONE cterm=NONE
    "orange group             :: c166,c172,c173,c178,c202,c208,c209,c214
    hi Title                      ctermfg=202   ctermbg=NONE cterm=NONE
    hi StorageClass               ctermfg=62   ctermbg=NONE cterm=NONE
    hi Special                    ctermfg=202   ctermbg=NONE cterm=NONE
    "blue group               :: c25,c26,c27,c31,c32,c33,c38,c39,c44,c45,c67,c68,c69
    "blue cont                :: c67,c68,c69,c74,c75,c109,c110,c111
    hi DiffChange                 ctermfg=39    ctermbg=NONE cterm=NONE
    hi VertSplit                  ctermfg=44    ctermbg=NONE cterm=NONE
    hi Directory                  ctermfg=69    ctermbg=NONE cterm=NONE
    hi Statement                  ctermfg=39    ctermbg=NONE cterm=NONE
    "cyan group               :: c66,c29,c30,c36,c37,c41,c42,c43,c66,c71,c72,c73
    "cyan cont                :: c78,c79,c80,c81,c108
    hi Keyword                    ctermfg=81    ctermbg=NONE cterm=NONE
    hi Type                       ctermfg=73    ctermbg=NONE cterm=NONE
    hi EndOfBuffer                ctermfg=108   ctermbg=NONE cterm=NONE
    "Pink group"              ::c96,c139,c168,c169,c170,c171,c174,c175,c176,c177,c211,c212
    "Pint cont                ::c197,c198,c199,c200,c201,c204,c205,c206,c207,c210
    "purple group             ::c62,c63,c92,c93,c97,c98,c99,c103,c104,c105,c128,c129,c162,c163,c164,c165
    hi Identifier                 ctermfg=197   ctermbg=NONE cterm=NONE
    hi PreProc                    ctermfg=167   ctermbg=NONE cterm=bold
    hi Number                     ctermfg=165   ctermbg=NONE cterm=bold
    hi Conditional                ctermfg=105   ctermbg=NONE cterm=bold
    hi DiffText                   ctermfg=102   ctermbg=NONE cterm=NONE
endfun

cal g:HandleOtherColors()
