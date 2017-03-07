" Vim color file
" Remove all existing highlighting and set the defaults.
hi clear Normal
hi clear SpecialKey
set bg&
hi clear

let colors_name = "snow"
syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"

hi Normal        ctermfg = NONE ctermbg = NONE cterm = NONE

hi Cursor        ctermfg = NONE ctermbg = NONE cterm = standout
hi visual        ctermfg = NONE ctermbg = 193  cterm = NONE
hi CursorLine    ctermfg = NONE ctermbg = 7    cterm = NONE
hi cursorcolumn  ctermfg = NONE ctermbg = NONE cterm = NONE
hi IncSearch     ctermfg = NONE ctermbg = NONE cterm = underline
hi Search        ctermfg = NONE ctermbg = 15   cterm = underline
hi MatchParen    ctermfg = NONE ctermbg = NONE cterm = underline,bold

hi LineNr        ctermfg = 3    ctermbg = 255  cterm = NONE
hi CursorLineNr  ctermfg = 218  ctermbg = NONE cterm = bold,italic
hi DiffAdd       ctermfg = 34   ctermbg = NONE cterm = NONE
hi DiffDelete    ctermfg = 160  ctermbg = NONE cterm = NONE
hi DiffChange    ctermfg = 202  ctermbg = NONE cterm = NONE
hi SignColumn    ctermfg = NONE ctermbg = NONE cterm = bold
hi ModeMsg       ctermfg = 3    ctermbg = 8    cterm = inverse
hi Folded        ctermfg = NONE ctermbg = 255  cterm = underline
hi Pmenu         ctermfg = 3    ctermbg = 8    cterm = NONE
hi PmenuSel      ctermfg = 3    ctermbg = 0    cterm = bold,italic
hi EndOfBuffer   ctermfg = 3    ctermbg = 255  cterm = NONE
hi VertSplit     ctermfg = 3    ctermbg = 8    cterm = inverse

hi Comment       ctermfg = 250  ctermbg = NONE cterm = italic
hi Todo          ctermfg = 250  ctermbg = 8    cterm = bold,inverse
hi Conceal       ctermfg = 15   ctermbg = NONE cterm = italic
hi StatusLine    ctermfg = 51   ctermbg = 241  cterm = bold
hi StatusLineNC  ctermfg = 51   ctermbg = 241  cterm = NONE
hi WildMenu      ctermfg = 51   ctermbg = 241  cterm = bold,underline,inverse

hi Boolean       ctermfg = 196 ctermbg = NONE cterm = NONE
hi Conditional   ctermfg = 13  ctermbg = NONE cterm = bold
hi Constant      ctermfg = 127 ctermbg = NONE cterm = NONE
hi Character     ctermfg = 137 ctermbg = NONE cterm = NONE
hi Float         ctermfg = 76  ctermbg = NONE cterm = NONE
hi Function      ctermfg = 3   ctermbg = NONE cterm = NONE
hi Identifier    ctermfg = 12  ctermbg = NONE cterm = NONE
hi Label         ctermfg = 12  ctermbg = NONE cterm = NONE
hi Number        ctermfg = 11   ctermbg = NONE cterm = NONE
hi Keyword       ctermfg = 111 ctermbg = NONE cterm = NONE
hi Macro         ctermfg = 108 ctermbg = NONE cterm = NONE
hi PreProc       ctermfg = 14  ctermbg = NONE cterm = NONE
hi Special       ctermfg = 89  ctermbg = NONE cterm = NONE
hi Statement     ctermfg = 14  ctermbg = NONE cterm = NONE
hi StorageClass  ctermfg = 6   ctermbg = NONE cterm = NONE
hi String        ctermfg = 10  ctermbg = NONE cterm = NONE
hi Type          ctermfg = 204 ctermbg = NONE cterm = NONE
hi Tag           ctermfg = 191 ctermbg = NONE cterm = NONE

hi OperatorChars ctermfg = 0  ctermbg = NONE cterm = bold
hi Operator      ctermfg = 0  ctermbg = NONE cterm = bold

hi Error         ctermfg =0     ctermbg =1
hi ErrorMsg      ctermfg = 246  ctermbg = 160  cterm = NONE
hi WarningMsg    ctermfg = 246  ctermbg = 227  cterm = NONE

"TODO Do these lol
hi SpellCap      ctermfg = NONE ctermbg = 255  cterm = NONE
hi Define        ctermfg = 197  ctermbg = NONE cterm = NONE
hi DiffText      ctermfg = 6    ctermbg = NONE cterm = bold
hi NonText       ctermfg = 59   ctermbg = 236  cterm = NONE
hi Title         ctermfg = 231  ctermbg = NONE cterm = bold
hi Underlined    ctermfg = NONE ctermbg = NONE cterm = underline
hi SpecialKey    ctermfg = 189  ctermbg = NONE cterm = NONE
hi NonText       ctermfg = 189  ctermbg = NONE cterm = NONE
"hi Directory      ctermfg = 2  ctermbg = NONE cterm = NONE
"Differences when switching between modes
autocmd InsertEnter * highlight CursorLine ctermfg=NONE ctermbg=195
autocmd InsertLeave * highlight CursorLine ctermfg=NONE ctermbg=7

highlight link GitGutterAdd DiffAdd
highlight link GitGutterChange DiffChange
highlight link GitGutterDelete DiffDelete
