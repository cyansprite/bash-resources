set bg&
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset

let colors_name = "shadow"

"Setting the standard | Will have autcmd to change this from light to dark,and vice
hi Normal                     ctermfg=231  ctermbg=232  cterm=NONE

"Effects
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm=standout
hi MatchParen                 ctermfg=NONE ctermbg=NONE cterm=underline,bold
hi SignColumn                 ctermfg=NONE ctermbg=NONE cterm=NONE
"hi ColorColumn                ctermfg=NONE ctermbg=NONE cterm=NONE

let g:theme=0
let g:colorList=[[231,232,234,236,238,240,233,],
            \    [232,231,254,255,252,251,255,]]
let g:accentColor=70
let g:offColor=141
let g:backcentColor=103
let g:modColor=40
let g:backModColor=22
let g:selectColor=125
let g:normalColor=37
"Bg colors :
fun! g:HandleBackgroundColors()
    exec printf("hi Normal ctermfg=%d ctermbg=%d cterm=NONE"      , g:colorList[g:theme][0]  , g:colorList[g:theme][1])
    exec printf("hi CursorLine ctermfg=NONE ctermbg=%d cterm=NONE", g:colorList[g:theme][2])
    exec printf("hi Visual ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][3])
    exec printf("hi Incsearch ctermfg=NONE ctermbg=%d cterm=NONE" , g:colorList[g:theme][3])
    exec printf("hi Tag ctermfg=NONE ctermbg=%d cterm=NONE"       , g:colorList[g:theme][4])
    exec printf("hi Question ctermfg=NONE ctermbg=%d cterm=NONE"  , g:colorList[g:theme][4])
    exec printf("hi Ignore ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][4])
    exec printf("hi MoreMsg ctermfg=45 ctermbg=%d cterm=NONE"     , g:colorList[g:theme][4])
    exec printf("hi ModeMsg ctermfg=45 ctermbg=%d cterm=NONE"     , g:colorList[g:theme][4])
    exec printf("hi WarningMsg ctermfg=178 ctermbg=%d cterm=NONE" , g:colorList[g:theme][4])
    exec printf("hi SpellCap ctermfg=178 ctermbg=%d cterm=NONE"   , g:colorList[g:theme][4])
    exec printf("hi SpellBad ctermfg=196 ctermbg=%d cterm=NONE"   , g:colorList[g:theme][4])
    exec printf("hi ErrorMsg ctermfg=196 ctermbg=%d cterm=NONE"   , g:colorList[g:theme][4])
    exec printf("hi Error ctermfg=196 ctermbg=%d cterm=NONE"      , g:colorList[g:theme][4])
    exec printf("hi Search ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][5])
    exec printf("hi SearchNC ctermfg=142 ctermbg=%d cterm=underline"  , g:colorList[g:theme][3])
endfun

"let g:accentColor=73
"let g:backcentColor=52
"let g:selectColor=203
"let g:normalColor=101
fun! g:HandleAccentColors()
    exec printf("hi LineNr ctermfg=%d ctermbg=%d cterm=NONE"         , g:normalColor            , g:colorList[g:theme][6])
    exec printf("hi StatusLine ctermfg=%d ctermbg=%d cterm=NONE"     , g:selectColor            , g:colorList[g:theme][6])
    exec printf("hi StatusLineNC ctermfg=%d ctermbg=%d cterm=NONE"   , g:backcentColor          , g:colorList[g:theme][6])
    exec printf("hi CursorLineNr ctermfg=%d  ctermbg=%d cterm=bold"  , g:selectColor            , g:colorList[g:theme][2])
    exec printf("hi VertSplit ctermfg=%d  ctermbg=%d cterm=inverse"  , g:backcentColor          , g:colorList[g:theme][6])
    exec printf("hi EndOfBuffer ctermfg=%d  ctermbg=NONE cterm=NONE" , g:backcentColor)
    exec printf("hi WildMenu ctermfg=NONE ctermbg=%d cterm=NONE"     , g:colorList[g:theme][4])
    exec printf("hi Pmenu ctermfg=%d ctermbg=%d cterm=NONE"          , g:accentColor            , g:colorList[g:theme][2])
    exec printf("hi PmenuSel ctermfg=%d ctermbg=%d cterm=NONE"       , g:selectColor            , g:colorList[g:theme][1])
endfun

fun! g:HandleOtherColors()
    cal HandleAccentColors()
    hi Comment                       ctermfg=245 ctermbg=NONE cterm=italic
    hi Folded                        ctermfg=59  ctermbg=NONE cterm=underline
    hi Todo                          ctermfg=178 ctermbg=NONE cterm=inverse
    hi Constant                      ctermfg=142 ctermbg=NONE cterm=bold
    hi SpecialKey                    ctermfg=146 ctermbg=NONE cterm=NONE
    hi NonText                       ctermfg=180 ctermbg=NONE cterm=NONE
    hi DiffDelete                    ctermfg=196 ctermbg=NONE cterm=NONE
    hi link diffRemoved DiffDelete
    hi Boolean                       ctermfg=142 ctermbg=NONE cterm=bold
    hi Number                        ctermfg=165 ctermbg=NONE cterm=bold
    hi Character                     ctermfg=160 ctermbg=NONE cterm=NONE
    hi Identifier                    ctermfg=203 ctermbg=NONE cterm=NONE
    hi DiffAdd                       ctermfg=40  ctermbg=NONE cterm=NONE
    hi link diffAdded DiffAdd
    hi String                        ctermfg=64  ctermbg=NONE cterm=NONE
    hi Label                         ctermfg=175 ctermbg=NONE cterm=NONE
    hi Title                         ctermfg=202 ctermbg=NONE cterm=NONE
    hi StorageClass                  ctermfg=166 ctermbg=NONE cterm=bold
    hi Special                       ctermfg=107 ctermbg=NONE cterm=bold
    hi DiffChange                    ctermfg=39  ctermbg=NONE cterm=NONE
    hi Directory                     ctermfg=69  ctermbg=NONE cterm=NONE
    hi Statement                     ctermfg=31  ctermbg=NONE cterm=NONE
    hi Keyword                       ctermfg=81  ctermbg=NONE cterm=NONE
    hi Type                          ctermfg=106 ctermbg=NONE cterm=NONE
    hi Function                      ctermfg=39  ctermbg=NONE cterm=bold
    hi link diffSubname Function
    hi PreProc                       ctermfg=66  ctermbg=NONE cterm=bold
    hi Conditional                   ctermfg=105 ctermbg=NONE cterm=bold
    hi DiffText                      ctermfg=102 ctermbg=NONE cterm=NONE
    hi link notesSubtleURL Directory
endfun

cal g:HandleBackgroundColors()
cal g:HandleOtherColors()
