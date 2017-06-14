" Vim color file
set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "Chill"

" General colors
hi Normal       ctermfg=254 ctermbg=none cterm=none
hi Cursor       cterm=inverse
hi Visual       ctermfg=none ctermbg=235    cterm=none
hi Search       ctermfg=none ctermbg=none  cterm=inverse
hi IncSearch    ctermfg=232 ctermbg=231  cterm=underline
hi Folded       ctermfg=236 ctermbg=241 cterm=none
" hi Title  cterm=none
" hi StatusLine   ctermfg=16  ctermbg=251 cterm=none
" hi StatusLineNC ctermfg=241 ctermbg=251 cterm=none
hi LineNr ctermfg=240
" hi SpecialKey  cterm=oe
" hi WarningMsg  cterm=oe
hi NonText      ctermfg=232 ctermbg=233 cterm=none
hi ErrorMsg     ctermfg=254   cterm=none
hi Error        ctermfg=254   cterm=none
hi CursorLine   ctermbg=232   cterm=none
hi MatchParen   ctermfg=131 ctermbg=none cterm=bold
hi Pmenu        ctermfg=231 ctermbg=232 cterm=none
hi PmenuSel     ctermfg=131 ctermbg=231 cterm=bold

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
hi SignColumn ctermbg=none
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
hi WildMenu ctermfg=131 ctermbg=231 cterm=bold
hi StatusLine ctermfg=189 ctermbg=none cterm=none


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
hi EndOfBuffer  ctermfg=232  ctermbg=none cterm=underline


" Links
hi! link FoldColumn Folded
hi! link CursorColumn CursorLine
hi! link ColorColumn CursorLine

hi! link pythonBuiltin Builtin
hi! link pythonKeyword Statement

" Plug highlighting
highlight SignifySignAdd             ctermfg=193
highlight SignifySignChange          ctermfg=110
highlight SignifySignDelete          ctermfg=217
highlight SignifySignChangeDelete    ctermfg=131
highlight SignifySignDeleteFirstLine ctermfg=111

" Dyn colors

func! HiDyn()
    exec printf("hi VertSplit    ctermfg=%d ctermbg=none cterm=bold", g:jojo#current#color)
    exec printf("hi CursorLineNr    ctermfg=%d ctermbg=none cterm=bold", g:jojo#current#color)
endfun

let g:jojo#current#color = 150
call HiDyn()
