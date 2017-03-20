set bg&
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset

let colors_name = "shadow"

"Setting the standard | Will have autcmd to change this from light to dark,and vice
hi Normal                     ctermfg=231  ctermbg=232  cterm=NONE

"Effects
hi LineNr                     ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm=standout
hi MatchParen                 ctermfg=NONE ctermbg=NONE cterm=underline,bold
hi SignColumn                 ctermfg=NONE ctermbg=NONE cterm=NONE
"hi ColorColumn                ctermfg=NONE ctermbg=NONE cterm=NONE

let g:theme=0
let g:colorList=[[231,16,237,238,240,241,242,],
            \    [232,231,254,255,252,251,250,]]
"Bg colors :
fun! g:HandleBackgroundColors()
    exec printf("hi Normal ctermfg=%d ctermbg=%d cterm=NONE"      , g:colorList[g:theme][0]  , g:colorList[g:theme][1])
    exec printf("hi Pmenu ctermfg=73 ctermbg=%d cterm=NONE"       , g:colorList[g:theme][2])
    exec printf("hi PmenuSel ctermfg=40 ctermbg=%d cterm=NONE"    , g:colorList[g:theme][1])
    exec printf("hi Visual ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][2])
    exec printf("hi Incsearch ctermfg=NONE ctermbg=%d cterm=NONE" , g:colorList[g:theme][2])
    exec printf("hi Tag ctermfg=NONE ctermbg=%d cterm=NONE"       , g:colorList[g:theme][3])
    exec printf("hi Question ctermfg=NONE ctermbg=%d cterm=NONE"  , g:colorList[g:theme][3])
    exec printf("hi Ignore ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][3])
    exec printf("hi MoreMsg ctermfg=45 ctermbg=%d cterm=NONE"     , g:colorList[g:theme][3])
    exec printf("hi ModeMsg ctermfg=45 ctermbg=%d cterm=NONE"     , g:colorList[g:theme][3])
    exec printf("hi WarningMsg ctermfg=178 ctermbg=%d cterm=NONE" , g:colorList[g:theme][3])
    exec printf("hi SpellCap ctermfg=178 ctermbg=%d cterm=NONE"   , g:colorList[g:theme][3])
    exec printf("hi SpellBad ctermfg=196 ctermbg=%d cterm=NONE"   , g:colorList[g:theme][3])
    exec printf("hi ErrorMsg ctermfg=196 ctermbg=%d cterm=NONE"   , g:colorList[g:theme][3])
    exec printf("hi Error ctermfg=196 ctermbg=%d cterm=NONE"      , g:colorList[g:theme][3])
    exec printf("hi Search ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][4])
    exec printf("hi WildMenu ctermfg=NONE ctermbg=%d cterm=NONE"  , g:colorList[g:theme][4])
    exec printf("hi Folded ctermfg=NONE ctermbg=%d cterm=NONE"    , g:colorList[g:theme][5])
    exec printf("hi SearchNC ctermfg=NONE ctermbg=%d cterm=NONE"  , g:colorList[g:theme][6])
endfun


fun! g:HandleOtherColors()
    hi Comment                       ctermfg=245 ctermbg=NONE cterm=italic
    hi Todo                          ctermfg=143 ctermbg=NONE cterm=inverse
    hi Constant                      ctermfg=142 ctermbg=NONE cterm=bold
    hi SpecialKey                    ctermfg=146 ctermbg=NONE cterm=NONE
    hi NonText                       ctermfg=180 ctermbg=NONE cterm=NONE
    hi DiffDelete                    ctermfg=196 ctermbg=NONE cterm=NONE
    hi link diffRemoved DiffDelete
    hi Boolean                       ctermfg=197 ctermbg=NONE cterm=bold
    hi Character                     ctermfg=160 ctermbg=NONE cterm=NONE
    hi Identifier                    ctermfg=203 ctermbg=NONE cterm=NONE
    hi DiffAdd                       ctermfg=40  ctermbg=NONE cterm=NONE
    hi link diffAdded DiffAdd
    hi String                        ctermfg=35  ctermbg=NONE cterm=NONE
    hi Label                         ctermfg=175 ctermbg=NONE cterm=NONE
    hi Title                         ctermfg=202 ctermbg=NONE cterm=NONE
    hi StorageClass                  ctermfg=100  ctermbg=NONE cterm=NONE
    hi Special                       ctermfg=73 ctermbg=NONE cterm=bold
    hi DiffChange                    ctermfg=39  ctermbg=NONE cterm=NONE
    hi Directory                     ctermfg=69  ctermbg=NONE cterm=NONE
    hi Statement                     ctermfg=25  ctermbg=NONE cterm=NONE
    hi VertSplit                     ctermfg=52  ctermbg=NONE cterm=bold
    hi Keyword                       ctermfg=81  ctermbg=NONE cterm=NONE
    hi Type                          ctermfg=64  ctermbg=NONE cterm=NONE
    hi EndOfBuffer                   ctermfg=52  ctermbg=NONE cterm=NONE
    hi CursorLineNr                  ctermfg=73  ctermbg=NONE cterm=NONE
    hi Function                      ctermfg=39 ctermbg=NONE cterm=bold
    hi link diffSubname Function
    hi PreProc                       ctermfg=125 ctermbg=NONE cterm=bold
    hi Number                        ctermfg=201 ctermbg=NONE cterm=bold
    hi Conditional                   ctermfg=105 ctermbg=NONE cterm=bold
    hi DiffText                      ctermfg=102 ctermbg=NONE cterm=NONE
    hi link notesSubtleURL Directory
endfun

cal g:HandleBackgroundColors()
cal g:HandleOtherColors()
