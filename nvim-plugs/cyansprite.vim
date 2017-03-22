"true color time...omg...
set bg&
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset

let colors_name = "cyansprite"

"Setting the standard | Will have autcmd to change this from light to dark,and vice
hi Normal                     guifg=231  guibg=232  gui=NONE

"Effects
hi Cursor                     guifg=NONE guibg=NONE gui=standout
hi MatchParen                 guifg=NONE guibg=NONE gui=underline,bold
hi SignColumn                 guifg=NONE guibg=NONE gui=NONE
"hi ColorColumn                guifg=NONE guibg=NONE gui=NONE

let g:theme=0
let g:colorList=[['#ffffff','#000000','#202020','#202020','#202020','#202020','#202020',],
            \    ['#000000','#ffffff','#eeeeee','#eeeeee','#eeeeee','#eeeeee','#eeeeee',]]
let g:accentColor   = '#ff7777'
let g:offColor      = '#7788aa'
let g:backcentColor = '#aa0088'
let g:modColor      = '#00ff00'
let g:backModColor  = '#00aa00'
let g:selectColor   = '#33cccc'
let g:normalColor   =  g:offColor
let g:insertColor   =  g:accentColor
let g:visualColor   = '#cc33cc'
let g:visualLColor  = '#aa55aa'
let g:visualBColor  = '#775577'
let g:replaceColor  = '#ff0000'

fun! g:HandleBackgroundColors()
    exec printf("hi Normal guifg=%s guibg=%s gui=NONE"      , g:colorList[g:theme][0]  , g:colorList[g:theme][1])
    exec printf("hi CursorLine guifg=NONE guibg=%s gui=NONE", g:colorList[g:theme][2])
    exec printf("hi Visual guifg=NONE guibg=%s gui=NONE"    , g:colorList[g:theme][3])
    exec printf("hi Incsearch guifg=NONE guibg=%s gui=NONE" , g:colorList[g:theme][3])
    exec printf("hi Tag guifg=NONE guibg=%s gui=NONE"       , g:colorList[g:theme][4])
    exec printf("hi Question guifg=NONE guibg=%s gui=NONE"  , g:colorList[g:theme][4])
    exec printf("hi Ignore guifg=NONE guibg=%s gui=NONE"    , g:colorList[g:theme][4])
    exec printf("hi MoreMsg guifg=NONE guibg=%s gui=NONE"     , g:colorList[g:theme][4])
    exec printf("hi ModeMsg guifg=NONE guibg=%s gui=NONE"     , g:colorList[g:theme][4])
    exec printf("hi WarningMsg guifg=#aaaa00 guibg=%s gui=NONE" , g:colorList[g:theme][4])
    exec printf("hi SpellCap guifg=#ff0000 guibg=%s gui=NONE"   , g:colorList[g:theme][4])
    exec printf("hi SpellBad guifg=#ff0000 guibg=%s gui=NONE"   , g:colorList[g:theme][4])
    exec printf("hi ErrorMsg guifg=#ff0000 guibg=%s gui=NONE"   , g:colorList[g:theme][4])
    exec printf("hi Error guifg=196 guibg=%s gui=NONE"      , g:colorList[g:theme][4])
    exec printf("hi Search guifg=NONE guibg=%s gui=NONE"    , g:colorList[g:theme][5])
    exec printf("hi SearchNC guifg=142 guibg=%s gui=underline"  , g:colorList[g:theme][3])
endfun

fun! g:HandleDynamicColors(color)
    exec printf("hi LineNr guifg=%s guibg=%s gui=NONE"        , a:color       , g:colorList[g:theme][6])
    exec printf("hi CursorLineNr guifg=%s  guibg=%s gui=bold" , g:selectColor , g:colorList[g:theme][2])
    redraw
endfun

fun! g:HandleAccentColors()
    exec printf("hi StatusLineNC guifg=%s guibg=%s gui=NONE"   , g:backcentColor  , g:colorList[g:theme][6])
    exec printf("hi VertSplit guifg=%s  guibg=%s gui=bold"     , g:colorList[g:theme][1]  , g:colorList[g:theme][2])
    exec printf("hi EndOfBuffer guifg=%s  guibg=%s gui=NONE"   , g:backcentColor  , g:colorList[g:theme][6])
    exec printf("hi WildMenu guifg=%s guibg=%s gui=NONE"       , g:normalColor    , g:colorList[g:theme][4])
    exec printf("hi Pmenu guifg=%s guibg=%s gui=NONE"          , g:accentColor    , g:colorList[g:theme][2])
    exec printf("hi PmenuSel guifg=%s guibg=%s gui=NONE"       , g:selectColor    , g:colorList[g:theme][1])
endfun

"NOTE: change this to printf? TODO Love it
fun! g:HandleOtherColors()
    cal HandleDynamicColors(g:normalColor)
    cal HandleAccentColors()
    hi Comment                       guifg=#888866 guibg=NONE gui=italic
    hi Folded                        guifg=#cccc88 guibg=NONE gui=underline
    hi Todo                          guifg=#df9a3a guibg=NONE gui=inverse
    hi PreProc                       guifg=#df9a3a guibg=NONE gui=bold
    hi Constant                      guifg=#cccc33 guibg=NONE gui=bold
    hi SpecialKey                    guifg=#aa33aa guibg=NONE gui=NONE
    hi NonText                       guifg=#aaaaaa guibg=NONE gui=NONE
    hi Boolean                       guifg=#baba33 guibg=NONE gui=bold
    hi Number                        guifg=#ff00ff guibg=NONE gui=bold
    hi Character                     guifg=#ff00aa guibg=NONE gui=NONE
    hi Identifier                    guifg=#ff7777 guibg=NONE gui=NONE
    hi String                        guifg=#aa0088 guibg=NONE gui=NONE
    hi Label                         guifg=#4488cc guibg=NONE gui=NONE
    hi Title                         guifg=#ffaa00 guibg=NONE gui=NONE
    hi StorageClass                  guifg=#4444ff guibg=NONE gui=bold
    hi Special                       guifg=#9d92da guibg=NONE gui=bold
    hi Conditional                   guifg=#ad72fa guibg=NONE gui=bold
    hi DiffChange                    guifg=#44cc44 guibg=NONE gui=NONE
    hi Statement                     guifg=#33cccc guibg=NONE gui=bold
    hi Keyword                       guifg=#ec5e8e guibg=NONE gui=NONE
    hi Type                          guifg=#55bb55 guibg=NONE gui=NONE
    hi DiffText                      guifg=#8f8fcc guibg=NONE gui=NONE
    hi DiffAdd                       guifg=#00ff00 guibg=NONE gui=NONE
    hi link diffAdded DiffAdd
    hi DiffDelete                    guifg=#ff0000 guibg=NONE gui=NONE
    hi link diffRemoved DiffDelete
    hi Directory                     guifg=#4444ff guibg=NONE gui=NONE
    hi link notesSubtleURL Directory
    hi Function                      guifg=#5f5fff guibg=NONE gui=bold
    hi link diffSubname Function
endfun

cal g:HandleBackgroundColors()
cal g:HandleOtherColors()
