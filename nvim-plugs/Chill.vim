" Vim color file
"
" Port of gtksourceview babymate color scheme for 256-color terminals by Anton Bobrov (bobrov@vl.ru)

set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "Chill"

" General colors
hi Normal       ctermfg=254 ctermbg=none cterm=none
hi Cursor       cterm=inverse
hi Visual       ctermfg=232 ctermbg=231    cterm=none
"hi VisualNOS    ctermfg=254 ctermbg=241 cterm=none
hi Search       ctermfg=none ctermbg=none  cterm=inverse
hi IncSearch    ctermfg=232 ctermbg=231  cterm=underline
hi Folded       ctermfg=236 ctermbg=241 cterm=none
" hi Title  cterm=none
" hi StatusLine   ctermfg=16  ctermbg=251 cterm=none
" hi StatusLineNC ctermfg=241 ctermbg=251 cterm=none
hi VertSplit    ctermfg=189 ctermbg=238 cterm=none
hi LineNr       ctermfg=245 ctermbg=236 cterm=none
hi CursorLineNr ctermfg=159 ctermbg=232 cterm=none
hi NonText      ctermfg=232 ctermbg=236 cterm=none
" hi SpecialKey  cterm=oe
" hi WarningMsg  cterm=oe
hi ErrorMsg     ctermfg=254   cterm=none
hi Error        ctermfg=254   cterm=none

hi CursorLine   ctermbg=232   cterm=none
hi MatchParen   ctermfg=162 ctermbg=none cterm=bold
hi Pmenu        ctermfg=254 ctermbg=237 cterm=none
hi PmenuSel     ctermfg=131 ctermbg=251 cterm=bold

" Diff highlighting
hi DiffAdd      ctermfg=235 ctermbg=193 cterm=none
hi DiffDelete   ctermfg=235 ctermbg=217 cterm=none
hi DiffChange   ctermfg=235 ctermbg=110 cterm=none
hi DiffText     ctermfg=235 ctermbg=189 cterm=none

"hi CursorIM
"hi Directory
"hi IncSearch
"hi Menu
"hi ModeMsg
"hi MoreMsg
"hi PmenuSbar
"hi PmenuThumb
"hi Question
"hi Scrollbar
"hi SignColumn
"hi SpellBad
"hi SpellCap
"hi SpellLocal
"hi SpellRare
"hi TabLine
"hi TabLineFill
"hi TabLineSel
"hi Tooltip
"hi User1
"hi User9
"hi WildMenu
hi WildMenu ctermfg=black ctermbg=189 cterm=bold
hi StatusLine ctermfg=189 ctermbg=233 cterm=none


" Syntax highlighting
hi Keyword      ctermfg=109   cterm=none
"Yellow :: 178 Red :: 167?
hi Statement    ctermfg=153   cterm=none
hi Conditonal   ctermfg=141   cterm=none
hi Constant     ctermfg=189
hi PreProc      ctermfg=180   cterm=none
hi Function     ctermfg=193   cterm=none
hi Identifier   ctermfg=66   cterm=none
hi Builtin      ctermfg=110   cterm=none
hi Type         ctermfg=193   cterm=none
hi Special      ctermfg=212   cterm=none
hi String       ctermfg=217   cterm=none
hi Character    ctermfg=219   cterm=none
hi Comment      ctermfg=130   ctermbg=none
hi Todo         ctermfg=254 ctermbg=16  cterm=none
hi Boolean      ctermfg=110   cterm=none
hi Directory    ctermfg=4    cterm=bold
hi EndOfBuffer  ctermfg=232  ctermbg=236 cterm=bold


" Links
hi! link FoldColumn Folded
hi! link CursorColumn CursorLine
hi! link ColorColumn CursorLine

hi! link pythonBuiltin Builtin
hi! link pythonKeyword Statement

" xterm color fix:
" printf '\033]11;#222429\007\033]4;16;#000000;60;#506681;110;#9CBDDD;189;#D0CFFE;193;#CBF8B0;217;#FFC0CB;233;#15171C;235;#222429;237;#3A3D45;241;#666666;251;#C7C7C7;254;#E3E3E3\007'

" urxvt color fix:
" urxvt -bg #222429
" urxvt*background: #222429
" printf '\033]4;16;#000000;60;#506681;110;#9CBDDD;189;#D0CFFE;193;#CBF8B0;217;#FFC0CB;233;#15171C;235;#222429;237;#3A3D45;241;#666666;251;#C7C7C7;254;#E3E3E3\007'
