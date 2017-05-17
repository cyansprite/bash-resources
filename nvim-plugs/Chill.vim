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
hi Normal       ctermfg=254 ctermbg=235 cterm=none
hi Cursor       cterm=inverse
hi Visual       ctermbg=242    cterm=none
"hi VisualNOS    ctermfg=254 ctermbg=241 cterm=none
hi Search       ctermfg=254 ctermbg=60  cterm=none
hi Folded       ctermfg=241 ctermbg=235 cterm=none
" hi Title  cterm=none
" hi StatusLine   ctermfg=16  ctermbg=251 cterm=none
" hi StatusLineNC ctermfg=241 ctermbg=251 cterm=none
hi VertSplit    ctermfg=251 ctermbg=251 cterm=none
hi LineNr       ctermfg=241 ctermbg=236 cterm=none
hi CursorLineNr ctermfg=189 ctermbg=238 cterm=none
hi NonText      ctermfg=241 ctermbg=235 cterm=none
" hi SpecialKey  cterm=oe
" hi WarningMsg  cterm=oe
hi ErrorMsg     ctermfg=254   cterm=none
hi Error        ctermfg=254   cterm=none

hi CursorLine   ctermbg=237   cterm=none
hi MatchParen   ctermfg=254 ctermbg=16  cterm=none
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


" Syntax highlighting
hi Keyword      ctermfg=217   cterm=none
" hi Statement  ctermfg19  cterm=noe
hi Statement    ctermfg=217   cterm=none
hi Constant     ctermfg=254   cterm=none
hi Number       ctermfg=189   cterm=none
hi PreProc      ctermfg=217   cterm=none
hi Function     ctermfg=193   cterm=none
hi Identifier   ctermfg=110   cterm=none
hi Builtin      ctermfg=110   cterm=none
hi Type         ctermfg=193   cterm=none
hi Special      ctermfg=254   cterm=none
hi String       ctermfg=110   cterm=none
hi Character    ctermfg=217   cterm=none
hi Comment      ctermfg=241   cterm=italic
hi Todo         ctermfg=254 ctermbg=16  cterm=none
hi Boolean      ctermfg=110   cterm=none


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
