" Vim color file
" Remove all existing highlighting and set the defaults.
" The goal is to NOT use any terminal defaults
set bg&
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset

let colors_name = "ice"
syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"

hi Normal        ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor        ctermfg=NONE ctermbg=NONE cterm=standout
hi visual        ctermfg=NONE ctermbg=15   cterm=NONE
hi IncSearch     ctermfg=NONE ctermbg=NONE cterm=underline
hi Search        ctermfg=NONE ctermbg=15   cterm=underline
hi MatchParen    ctermfg=NONE ctermbg=NONE cterm=underline,bold
hi CursorLineNr  ctermfg=NONE ctermbg=NONE cterm=italic
hi LineNr        ctermfg=NONE ctermbg=NONE cterm=NONE
hi colorcolumn   ctermfg=NONE ctermbg=7    cterm=NONE
hi FoldColumn    ctermfg=NONE ctermbg=7    cterm=NONE
hi Title         ctermfg=11   ctermbg=NONE cterm=NONE
hi DiffAdd       ctermfg=3    ctermbg=NONE cterm=NONE
hi DiffDelete    ctermfg=1    ctermbg=NONE cterm=NONE
hi DiffChange    ctermfg=4    ctermbg=NONE cterm=NONE
hi DiffText      ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn    ctermfg=NONE ctermbg=NONE cterm=bold
hi Folded        ctermfg=NONE ctermbg=250  cterm=underline
hi WildMenu      ctermfg=6    ctermbg=NONE cterm=bold,underline
hi PmenuSel      ctermfg=6    ctermbg=NONE cterm=none
hi Pmenu         ctermfg=NONE ctermbg=NONE cterm=NONE
hi Directory     ctermfg=4    ctermbg=NONE cterm=NONE
hi VertSplit     ctermfg=6    ctermbg=None cterm=NONE
hi EndOfBuffer   ctermfg=6    ctermbg=None cterm=NONE
hi Comment       ctermfg=8   ctermbg=NONE cterm=italic
hi Todo          ctermfg=15   ctermbg=NONE cterm=bold,inverse
hi Boolean       ctermfg=1    ctermbg=NONE cterm=NONE
hi Conditional   ctermfg=6    ctermbg=NONE cterm=bold
hi Constant      ctermfg=11   ctermbg=NONE cterm=bold
hi Character     ctermfg=9    ctermbg=NONE cterm=NONE
hi Function      ctermfg=4    ctermbg=NONE cterm=NONE
hi Identifier    ctermfg=12   ctermbg=NONE cterm=NONE
hi Label         ctermfg=12   ctermbg=NONE cterm=NONE
hi Number        ctermfg=13   ctermbg=NONE cterm=NONE
hi Keyword       ctermfg=9    ctermbg=NONE cterm=NONE
hi Macro         ctermfg=11   ctermbg=NONE cterm=bold
hi PreProc       ctermfg=3    ctermbg=NONE cterm=NONE
hi Special       ctermfg=6    ctermbg=NONE cterm=NONE
hi Statement     ctermfg=9    ctermbg=NONE cterm=NONE
hi StorageClass  ctermfg=6    ctermbg=NONE cterm=NONE
hi String        ctermfg=2    ctermbg=NONE cterm=NONE
hi Type          ctermfg=10   ctermbg=NONE cterm=NONE
hi Error         ctermfg=1    ctermbg=7   cterm=NONE
hi ErrorMsg      ctermfg=1    ctermbg=7   cterm=NONE
hi WarningMsg    ctermfg=3    ctermbg=7   cterm=NONE
hi ModeMsg       ctermfg=12   ctermbg=7   cterm=NONE
hi MoreMsg       ctermfg=12   ctermbg=7   cterm=NONE
hi Ignore        ctermfg=12   ctermbg=7   cterm=NONE
hi Question      ctermfg=12   ctermbg=7   cterm=NONE
hi Tag           ctermfg=12   ctermbg=7   cterm=NONE
hi SpecialKey    ctermfg=7    ctermbg=NONE cterm=NONE
hi NonText       ctermfg=7    ctermbg=NONE cterm=NONE
hi OperatorChars ctermfg=NONE ctermbg=NONE cterm=bold
hi Operator      ctermfg=NONE ctermbg=NONE cterm=bold
hi link vimHiKeyList Operator

"hi StatusLine    ctermfg=87   ctermbg=235  cterm=NONE
"hi StatusLineNC  ctermfg=81   ctermbg=240  cterm=NONE
