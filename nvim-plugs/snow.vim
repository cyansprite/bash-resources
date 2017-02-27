" Vim color file
" Remove all existing highlighting and set the defaults.
hi clear Normal
set bg&
hi clear

let colors_name = "snow"

hi Normal         ctermfg = NONE ctermbg = NONE cterm = NONE

"Visual effects relying on effects rather than colors
hi Cursor         ctermfg = NONE ctermbg = NONE cterm = standout
"hi CursorNC       ctermfg = NONE ctermbg = NONE cterm = inverse,underline
hi visual         ctermfg = NONE ctermbg = 193  cterm = NONE
hi cursorline     ctermfg = NONE ctermbg = 255  cterm = NONE
hi cursorcolumn   ctermfg = NONE ctermbg = NONE cterm = NONE
hi IncSearch      ctermfg = NONE ctermbg = NONE cterm = underline
hi Search         ctermfg = NONE ctermbg = 195  cterm = underline
hi MatchParen     ctermfg = NONE ctermbg = NONE cterm = underline,bold

"Help Stuff :: LineNumber, VertSplit, ModeMsg and PopupMenu
"NOTE       :: The color 3 is mapped to your first orange/yellow value
"              I personally use a pastel chartreuse
hi CursorLineNr ctermfg = 3 ctermbg = 255 cterm = inverse
hi LineNr       ctermfg = 3 ctermbg = 255 cterm = NONE
hi ModeMsg      ctermfg = 3 ctermbg = 255 cterm = inverse
hi Pmenu        ctermfg = 3 ctermbg = 255 cterm = NONE
hi PmenuSel     ctermfg = 3 ctermbg = 255 cterm = inverse
hi EndOfBuffer  ctermfg = 3 ctermbg = 255 cterm = NONE
hi VertSplit    ctermfg = 3 ctermbg = 255 cterm = inverse

"Background Color help
"NOTE       :: The color 11 is mapped to your second yellow/orange value and 8 is
"              The color 15 is mapped to dull gold, your second grey
"              second black I personally use a pastel gold, and a dull black
hi Comment    ctermfg = 250  ctermbg = NONE cterm = italic
hi Todo       ctermfg = 250  ctermbg = 8    cterm = bold,inverse
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
hi Boolean      ctermfg = 196 ctermbg = NONE cterm = NONE
hi Conditional  ctermfg = 13  ctermbg = NONE cterm = NONE
hi Constant     ctermfg = 127 ctermbg = NONE cterm = NONE
hi Character    ctermfg = 137 ctermbg = NONE cterm = NONE
hi Float        ctermfg = 76  ctermbg = NONE cterm = NONE
hi Function     ctermfg = 3   ctermbg = NONE cterm = NONE
hi Identifier   ctermfg = 12  ctermbg = NONE cterm = NONE
hi Label        ctermfg = 12  ctermbg = NONE cterm = NONE
hi Number       ctermfg = 209 ctermbg = NONE cterm = NONE
hi Keyword      ctermfg = 111 ctermbg = NONE cterm = NONE
hi Macro        ctermfg = 108 ctermbg = NONE cterm = NONE
hi PreProc      ctermfg = 14  ctermbg = NONE cterm = NONE
hi Special      ctermfg = 89  ctermbg = NONE cterm = NONE
hi Statement    ctermfg = 14  ctermbg = NONE cterm = NONE
hi StorageClass ctermfg = 6   ctermbg = NONE cterm = NONE
hi String       ctermfg = 10  ctermbg = NONE cterm = NONE
hi Type         ctermfg = 204 ctermbg = NONE cterm = NONE
hi Tag          ctermfg = 191 ctermbg = NONE cterm = NONE

syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"
hi OperatorChars ctermfg = 232 cterm = bold
hi Operator      ctermfg = 232 cterm = bold

hi Error ctermfg=0 ctermbg=1
hi ErrorMsg       ctermfg = 246  ctermbg = 160  cterm = NONE
hi WarningMsg     ctermfg = 246  ctermbg = 227  cterm = NONE
hi SpellCap       ctermfg = NONE ctermbg = 255  cterm = NONE

"dir
"hi Directory      ctermfg = 2  ctermbg = NONE cterm = NONE
"hi Folded         ctermfg = 242  ctermbg = 235  cterm = NONE

"types
"
hi Define         ctermfg = 197  ctermbg = NONE cterm = NONE
hi DiffAdd        ctermfg = 231  ctermbg = 64   cterm = bold
hi DiffDelete     ctermfg = 88   ctermbg = NONE cterm = NONE
hi DiffChange     ctermfg = NONE ctermbg = NONE cterm = NONE
hi DiffText       ctermfg = 231  ctermbg = 24   cterm = bold
hi NonText        ctermfg = 59   ctermbg = 236  cterm = NONE
hi Title          ctermfg = 231  ctermbg = NONE cterm = bold
hi Underlined     ctermfg = NONE ctermbg = NONE cterm = underline


