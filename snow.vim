" Vim color file
" Remove all existing highlighting and set the defaults.
hi clear Normal
set bg&
hi clear

let colors_name = "snow"

"Visual effects relying on effects rather than colors
hi Cursor         ctermfg = NONE ctermbg = NONE cterm = standout
"hi CursorNC       ctermfg = NONE ctermbg = NONE cterm = inverse,underline
hi visual         ctermfg = NONE ctermbg = NONE cterm = standout
hi cursorline     ctermfg = NONE ctermbg = NONE cterm = NONE
hi cursorcolumn   ctermfg = NONE ctermbg = NONE cterm = NONE
hi IncSearch      ctermfg = NONE ctermbg = NONE cterm = underline
hi Search         ctermfg = NONE ctermbg = NONE cterm = inverse
hi MatchParen     ctermfg = NONE ctermbg = NONE cterm = underline,bold

"Help Stuff :: LineNumber, VertSplit, ModeMsg and PopupMenu
"NOTE       :: The color 3 is mapped to your first orange/yellow value
"              I personally use a pastel chartreuse
hi CursorLineNr   ctermfg = 3   ctermbg = 237  cterm = inverse
hi LineNr         ctermfg = 3   ctermbg = 237  cterm = NONE
hi ModeMsg        ctermfg = 3 ctermbg = 237 cterm = inverse
hi Pmenu          ctermfg = 3 ctermbg = 237 cterm = NONE
hi PmenuSel       ctermfg = 3 ctermbg = 237 cterm = inverse
hi EndOfBuffer    ctermfg = 3 ctermbg = 237 cterm = underline
hi VertSplit      ctermfg = 3 ctermbg = 237 cterm = inverse

"Background Color help
"NOTE       :: The color 11 is mapped to your second yellow/orange value and 8 is
"              The color 15 is mapped to dull gold, your second grey
"              second black I personally use a pastel gold, and a dull black
hi Comment    ctermfg = 7    ctermbg = 8    cterm = italic
hi SpecialKey ctermfg = 15   ctermbg = NONE cterm = italic
hi Conceal    ctermfg = 15   ctermbg = NONE cterm = italic
hi SignColumn ctermfg = 15   ctermbg = NONE cterm = NONE

"tab line! I use plugin vim-airline...so...yup
"hi clear TabLine TabLineSel TabLineFill
"Status line! Aka the line you use in command line mode
hi StatusLine     ctermfg = 51 ctermbg = 241 cterm = bold
hi StatusLineNC   ctermfg = 51 ctermbg = 241 cterm = NONE
hi WildMenu       ctermfg = 51 ctermbg = 241 cterm = bold,underline,inverse

"Syn highlighting
"Colors 6 : first teal, Color 9 Second Red, 5 first purple
"5 mapped to pastel purple
"6 mapped to pastel cyan
"9 mapped to pastel red
hi Boolean        ctermfg = 196  ctermbg = NONE cterm = NONE
hi Conditional    ctermfg = 5  ctermbg = NONE cterm = bold
hi Character      ctermfg = 137   ctermbg = NONE cterm = NONE
hi Float          ctermfg = 76   ctermbg = NONE cterm = NONE
hi Identifier     ctermfg = 17  ctermbg = NONE cterm = NONE
hi Number         ctermfg = 130  ctermbg = NONE cterm = NONE
hi Keyword        ctermfg = 10   ctermbg = NONE cterm = bold
hi Macro          ctermfg = 108 ctermbg = NONE cterm = NONE
hi Special        ctermfg = 89  ctermbg = NONE cterm = bold
hi Statement      ctermfg = 14  ctermbg = NONE cterm = NONE
hi String         ctermfg = 71 ctermbg = NONE cterm = NONE
hi Type           ctermfg = 9  ctermbg = NONE cterm = NONE

hi ErrorMsg       ctermfg = 246  ctermbg = 160  cterm = NONE
hi WarningMsg     ctermfg = 246  ctermbg = 227  cterm = NONE

"dir
"hi Directory      ctermfg = 141  ctermbg = NONE cterm = NONE
"hi Folded         ctermfg = 242  ctermbg = 235  cterm = NONE

"types
"
hi Constant       ctermfg = 202  ctermbg = 232  cterm = underline
hi Define         ctermfg = 197  ctermbg = NONE cterm = NONE
hi DiffAdd        ctermfg = 231  ctermbg = 64   cterm = bold
hi DiffDelete     ctermfg = 88   ctermbg = NONE cterm = NONE
hi DiffChange     ctermfg = NONE ctermbg = NONE cterm = NONE
hi DiffText       ctermfg = 231  ctermbg = 24   cterm = bold
hi Function       ctermfg = 79   ctermbg = NONE cterm = NONE
hi Label          ctermfg = 186  ctermbg = NONE cterm = NONE
hi NonText        ctermfg = 59   ctermbg = 236  cterm = NONE
hi Operator       ctermfg = 231  ctermbg = NONE cterm = NONE
hi PreProc        ctermfg = 14   ctermbg = NONE cterm = NONE
hi StorageClass   ctermfg = 81   ctermbg = NONE cterm = NONE
hi Tag            ctermfg = 9    ctermbg = NONE cterm = NONE
hi Title          ctermfg = 231  ctermbg = NONE cterm = bold
hi Todo           ctermfg = NONE ctermbg = NONE cterm = inverse
hi Underlined     ctermfg = NONE ctermbg = NONE cterm = underline
"End of colors

