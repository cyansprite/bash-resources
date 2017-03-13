" Vim color file
" Remove all existing highlighting and set the defaults.
" The goal is to NOT use any terminal defaults
set bg&
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset

let colors_name = "shadow"
syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"
"Setting the standard | Will have autcmd to change this from light to dark,and vice
hi Normal                     ctermfg=231  ctermbg=232  cterm =NONE
hi ColorColumn                ctermfg=235  ctermbg=NONE cterm =NONE
"bg plus 8
hi SearchNc                   ctermfg=NONE ctermbg=240  cterm =underline
hi Folded                     ctermfg=NONE ctermbg=240  cterm =underline
"bg plus 4
hi WildMenu                   ctermfg=6    ctermbg=236  cterm =bold,underline
hi StatusLine                 ctermfg=NONE ctermbg=236  cterm =bold,underline
hi StatusLineNc               ctermfg=NONE ctermbg=236  cterm =bold,underline
hi Search                     ctermfg=NONE ctermbg=236  cterm =underline
hi Error                      ctermfg=1    ctermbg=236  cterm =NONE
hi ErrorMsg                   ctermfg=1    ctermbg=236  cterm =NONE
hi WarningMsg                 ctermfg=3    ctermbg=236  cterm =NONE
hi ModeMsg                    ctermfg=12   ctermbg=236  cterm =NONE
hi MoreMsg                    ctermfg=12   ctermbg=236  cterm =NONE
hi Ignore                     ctermfg=12   ctermbg=236  cterm =NONE
hi Question                   ctermfg=12   ctermbg=236  cterm =NONE
hi Tag                        ctermfg=12   ctermbg=236  cterm =NONE
"bg plus 2
hi visual                     ctermfg=NONE ctermbg=234  cterm =NONE
hi Pmenu                      ctermfg=NONE ctermbg=234  cterm =NONE
hi PmenuSel                   ctermfg=6    ctermbg=234  cterm =none

"Effects
hi LineNr                     ctermfg=NONE ctermbg=NONE cterm =NONE
hi CursorLineNr               ctermfg=NONE ctermbg=NONE cterm =italic
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm =standout
hi IncSearch                  ctermfg=NONE ctermbg=NONE cterm =underline
hi MatchParen                 ctermfg=NONE ctermbg=NONE cterm =underline,bold
hi OperatorChars              ctermfg=NONE ctermbg=NONE cterm =bold
hi Operator                   ctermfg=NONE ctermbg=NONE cterm =bold
hi link vimHiKeyList Operator
"hi FoldColumn                ctermfg=NONE ctermbg=NONE cterm =bold,underline
"hi SignColumn                ctermfg=NONE ctermbg=NONE cterm =bold,underline

"shadow group
hi Comment                    ctermfg=8    ctermbg=NONE cterm =italic
hi Todo                       ctermfg=8    ctermbg=NONE cterm =bold,inverse
hi Constant                   ctermfg=0    ctermbg=NONE cterm =bold

"red group
hi DiffDelete                 ctermfg=1    ctermbg=NONE cterm =NONE
hi Boolean                    ctermfg=1    ctermbg=NONE cterm =NONE
hi Keyword                    ctermfg=9    ctermbg=NONE cterm =NONE
hi Character                  ctermfg=9    ctermbg=NONE cterm =NONE

"green group
hi DiffAdd                    ctermfg=2    ctermbg=NONE cterm =NONE
hi String                     ctermfg=2    ctermbg=NONE cterm =NONE
hi Function                   ctermfg=10   ctermbg=NONE cterm =NONE

"orange group
hi Title                      ctermfg=3    ctermbg=NONE cterm =NONE
hi Identifier                 ctermfg=11   ctermbg=NONE cterm =NONE

"blue group
hi DiffChange                 ctermfg=4    ctermbg=NONE cterm =NONE
hi Directory                  ctermfg=4    ctermbg=NONE cterm =NONE
hi Statement                  ctermfg=4    ctermbg=NONE cterm =NONE
hi Label                      ctermfg=12   ctermbg=NONE cterm =NONE

"cyan group
hi Type                       ctermfg=14   ctermbg=NONE cterm =NONE
hi VertSplit                  ctermfg=6    ctermbg=NONE cterm =NONE
hi EndOfBuffer                ctermfg=6    ctermbg=NONE cterm =NONE
hi StorageClass               ctermfg=6    ctermbg=NONE cterm =NONE

"Pink group
hi Special                    ctermfg=5    ctermbg=NONE cterm =NONE
hi SpecialKey                 ctermfg=5    ctermbg=NONE cterm =NONE
hi NonText                    ctermfg=5    ctermbg=NONE cterm =NONE
hi Number                     ctermfg=13   ctermbg=NONE cterm =NONE

"purple group
hi PreProc                    ctermfg=5    ctermbg=NONE cterm =NONE
hi Conditional                ctermfg=15   ctermbg=NONE cterm =bold

"idk...
hi DiffText                   ctermfg=NONE ctermbg=NONE cterm =NONE
