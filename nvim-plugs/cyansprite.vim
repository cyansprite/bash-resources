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

let g:theme=0
                  "fg      , bg      , acnt-bg , blk/wht , b,srch  , g/vis   , lgry    , cy/tb/cl, crsgry  , lmodg/tbm
let g:colorList=[['#ffffff','#0f0f0f','#202020','#000000','#2f6faa','#2a3a2a','#464474','#1f3838','#2f2f2f','#4f684f'],
            \    ['#000000','#f6f6f6','#dedede','#ffffff','#ddddee','#ddeedd','#cccccc','#ddffff','#ccffff','ddffdd']]
let g:offColor         = '#d778aa'
let g:inactiveColor    = '#9a8a8a'
let g:backcentColor    = '#ff4088'
let g:offBackcentColor = '#ff40ff'
let g:modColor         = '#95ff95'
let g:backModColor     = '#339933'
let g:selectColor      = '#83ffff'

fun! g:HandleBackgroundColors()
    "fg/bg
    exec printf("hi Normal guifg=%s guibg=%s gui=NONE"                   , g:colorList[g:theme][0]  , g:colorList[g:theme][1])
    "cyansprite :P
    exec printf("hi CursorLine guifg=NONE guibg=%s gui=NONE"             , g:colorList[g:theme][8])
    "blue grey
    exec printf("hi Search guifg=white guibg=%s gui=NONE"                , g:colorList[g:theme][4])
    "green grey
    exec printf("hi Visual guifg=NONE guibg=%s gui=NONE"                 , g:colorList[g:theme][5])
    "grey grey lol
    exec printf("hi Tag guifg=NONE guibg=%s gui=NONE"                    , g:colorList[g:theme][6])
    exec printf("hi Question guifg=NONE guibg=%s gui=NONE"               , g:colorList[g:theme][6])
    exec printf("hi Ignore guifg=NONE guibg=%s gui=NONE"                 , g:colorList[g:theme][6])
    exec printf("hi MoreMsg guifg=NONE guibg=%s gui=NONE"                , g:colorList[g:theme][6])
    exec printf("hi ModeMsg guifg=NONE guibg=%s gui=NONE"                , g:colorList[g:theme][6])
    exec printf("hi WarningMsg guifg=#aaaa00 guibg=%s gui=NONE"          , g:colorList[g:theme][6])
    exec printf("hi SpellCap guifg=#ff0000 guibg=%s gui=NONE"            , g:colorList[g:theme][6])
    exec printf("hi SpellBad guifg=#ff0000 guibg=%s gui=NONE"            , g:colorList[g:theme][6])
    exec printf("hi ErrorMsg guifg=#ff0000 guibg=%s gui=NONE"            , g:colorList[g:theme][6])
    exec printf("hi Error guifg=196 guibg=%s gui=NONE"                   , g:colorList[g:theme][6])
    exec printf("hi SearchNC guifg=NONE guibg=%s gui=inverse"               , g:colorList[g:theme][6])
    exec printf("hi Incsearch guifg=%s guibg=%s gui=underline"           , g:offColor                , g:colorList[g:theme][6])
endfun

fun! g:HandleDynamicColors(color)
    "background
    exec printf("hi LineNr guifg=%s guibg=%s gui=NONE"        , a:color       , g:colorList[g:theme][2])
    "black
    exec printf("hi CursorLineNr guifg=%s  guibg=%s gui=bold" , g:selectColor , g:colorList[g:theme][7])
    redraw
endfun

fun! g:HandleAccentColors()
    "none
    exec printf("hi StatusLineNC guifg=%s guibg=%s gui=underline" , g:offColor              , g:colorList[g:theme][1])
    exec printf("hi SignColumn guifg=%s guibg=%s gui=bold" , g:offColor              , g:colorList[g:theme][1])
    "background
    exec printf("hi StatusLine guifg=%s guibg=%s gui=NONE"        , g:selectColor           , g:colorList[g:theme][2])
    exec printf("hi VertSplit guifg=%s  guibg=%s gui=NONE"        , g:offBackcentColor      , g:colorList[g:theme][3])
    exec printf("hi Pmenu guifg=%s guibg=%s gui=NONE"             , g:offColor              , g:colorList[g:theme][2])
    "end of buffer is black
    exec printf("hi EndOfBuffer guifg=%s  guibg=%s gui=NONE"      , g:backcentColor         , g:colorList[g:theme][3])
    exec printf("hi SignColumn guifg=%s  guibg=%s gui=NONE"      , g:backcentColor         , g:colorList[g:theme][3])
    "cyan :P
    exec printf("hi PmenuSel guifg=%s guibg=%s gui=NONE"          , g:selectColor           , g:colorList[g:theme][7])
    exec printf("hi WildMenu guifg=%s guibg=%s gui=underline"       , g:offColor              , g:colorList[g:theme][7])
endfun

"NOTE: change this to printf? TODO Love it
fun! g:HandleOtherColors()
    cal HandleDynamicColors(g:offColor)
    cal HandleAccentColors()
    hi Comment                       guifg=#8f8f8f guibg=NONE gui=italic
    hi Folded                        guifg=#cccc88 guibg=NONE gui=underline
    hi Todo                          guifg=#df9a3a guibg=NONE gui=inverse
    hi PreProc                       guifg=#fa8666 guibg=NONE gui=none
    hi Constant                      guifg=#cccc33 guibg=NONE gui=bold
    hi SpecialKey                    guifg=#aa33aa guibg=NONE gui=NONE
    hi NonText                       guifg=#aaaaaa guibg=NONE gui=NONE
    hi Boolean                       guifg=#baba33 guibg=NONE gui=bold
    hi Number                        guifg=#ff00ff guibg=NONE gui=bold
    hi Character                     guifg=#ff00aa guibg=NONE gui=NONE
    hi Identifier                    guifg=#ff5757 guibg=NONE gui=NONE
    hi String                        guifg=#55aa55 guibg=NONE gui=NONE
    hi Label                         guifg=#4488cc guibg=NONE gui=NONE
    hi Title                         guifg=#ffaa00 guibg=NONE gui=NONE
    hi StorageClass                  guifg=#77ccff guibg=NONE gui=bold
    hi Special                       guifg=#9d92da guibg=NONE gui=bold
    hi Conditional                   guifg=#af6fcf guibg=NONE gui=bold
    hi DiffChange                    guifg=#44cc44 guibg=NONE gui=NONE
    hi Statement                     guifg=#33cccc guibg=NONE gui=bold
    hi Keyword                       guifg=#ec5e8e guibg=NONE gui=bold
    hi Type                          guifg=#8adf8a guibg=NONE gui=bold
    hi DiffText                      guifg=#8f8fcc guibg=NONE gui=NONE
    hi DiffAdd                       guifg=#00ff00 guibg=NONE gui=NONE
    hi link diffAdded DiffAdd
    hi DiffDelete                    guifg=#ff0000 guibg=NONE gui=NONE
    hi link diffRemoved DiffDelete
    hi Directory                     guifg=#6666ff guibg=NONE gui=NONE
    hi link notesSubtleURL Directory
    hi Function                      guifg=#ff0088 guibg=NONE gui=bold
    hi link diffSubname Function
endfun

cal g:HandleBackgroundColors()
cal g:HandleOtherColors()
