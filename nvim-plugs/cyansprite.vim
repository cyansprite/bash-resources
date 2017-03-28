"Vim Colorscheme file
"init
set bg&
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset
syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|)\|(\|{\|}\|\.\|\[\|\]\|/\(/\|*\)\@!"

"vars
let colors_name             = "cyansprite"
let g:theme                 = 0

let g:fgColor               = '#ffffff'
let g:bgColor               = '#35352f'
let g:accentBackgroundColor = '#505050'
let g:harshAccentColor      = '#000000'
let g:searchColor           = '#2f3f7a'
let g:visualColor           = '#4a6a4a'
let g:cursorColor           = '#555555'
let g:lightBackModColor     = '#4f684f'
let g:neutralColor          = '#888860'

let g:offBackcentColor      = neutralColor
let g:accentColor           = '#aaffff'
let g:origAccentColor       = '#87cccc'
let g:inactiveColor         = '#9a8a8a'
let g:backcentColor         = '#ff0088'
let g:modColor              = '#52cc52'
let g:envModColor           = '#95ff95'
let g:backModColor          = '#339933'
let g:selectColor           = '#ff8888'

let g:offYellow             = '#df9a3a'
let g:yellow                = '#cccc33'
let g:orange                = '#fa8666'
let g:magenta               = '#ff00ff'
let g:pink                  = '#ff00aa'
let g:blue                  = '#4488cc'
let g:lavender              = '#afafff'
let g:purple                = '#af8fff'
let g:cyan                  = '#44dddd'
let g:hotPink               = '#ff5588'
let g:green                 = '#8adf8a'
let g:red                   = '#ff2223'
"end vars

fun! g:HandleDynamicColors()
    exec printf("hi Normal       guifg = %s      guibg = %s   gui = NONE"      , g:fgColor           , g:bgColor               )

    exec printf("hi Search       guifg = NONE    guibg = %s   gui = NONE"      , g:searchColor                                 )

    exec printf("hi Visual       guifg = NONE    guibg = %s   gui = NONE"      , g:visualColor                                 )


    exec printf("hi StatusLineNc guifg = %s      guibg = %s   gui = NONE"      , g:offBackcentColor  , g:accentBackgroundColor )
    exec printf("hi TabLine      guifg = %s      guibg = %s   gui = NONE"      , g:offBackcentColor  , g:accentBackgroundColor )

    exec printf("hi TabLineFill  guifg = %s      guibg = %s   gui = NONE"      , g:backcentColor     , g:accentBackgroundColor )
    exec printf("hi EndOfBuffer  guifg = %s      guibg = %s   gui = NONE"      , g:backcentColor     , g:harshAccentColor      )

    exec printf("hi PmenuSel     guifg = %s      guibg = %s   gui = NONE"      , g:selectColor       , g:harshAccentColor      )
    exec printf("hi WildMenu     guifg = %s      guibg = %s   gui = underline" , g:selectColor       , g:harshAccentColor      )
    exec printf("hi CursorLineNr guifg = %s      guibg = %s   gui = bold"      , g:selectColor       , g:harshAccentColor      )

    exec printf("hi SignColumn   guifg = %s      guibg = %s   gui = NONE"      , g:backcentColor     , g:accentBackgroundColor )

    exec printf("hi Tag          guifg = NONE    guibg = %s   gui = NONE"      , g:cursorColor                                 )
    exec printf("hi Question     guifg = NONE    guibg = %s   gui = NONE"      , g:cursorColor                                 )
    exec printf("hi Ignore       guifg = NONE    guibg = %s   gui = NONE"      , g:cursorColor                                 )
    exec printf("hi MoreMsg      guifg = NONE    guibg = %s   gui = NONE"      , g:cursorColor                                 )
    exec printf("hi ModeMsg      guifg = NONE    guibg = %s   gui = NONE"      , g:cursorColor                                 )
    exec printf("hi WarningMsg   guifg = #aaaa00 guibg = %s   gui = bold"      , g:cursorColor                                 )
    exec printf("hi SpellCap     guifg = #ff0000 guibg = %s   gui = bold"      , g:cursorColor                                 )
    exec printf("hi SpellBad     guifg = #ff0000 guibg = %s   gui = bold"      , g:cursorColor                                 )
    exec printf("hi SearchNC     guifg = NONE    guibg = %s   gui = inverse"   , g:cursorColor                                 )
    exec printf("hi CursorLine   guifg = NONE    guibg = %s   gui = NONE"      , g:cursorColor                                 )


    exec printf("hi Todo         guifg = %s      guibg = NONE gui = inverse"   , g:offYellow                                   )
    exec printf("hi PreProc      guifg = %s      guibg = NONE gui = none"      , g:orange                                      )
    exec printf("hi Constant     guifg = %s      guibg = NONE gui = NONE"      , g:yellow                                      )
    exec printf("hi SpecialKey   guifg = %s      guibg = NONE gui = NONE"      , g:hotPink                                     )
    exec printf("hi NonText      guifg = %s      guibg = NONE gui = NONE"      , g:neutralColor                                )
    exec printf("hi Comment      guifg = %s      guibg = NONE gui = italic"    , g:neutralColor                                )
    exec printf("hi Boolean      guifg = %s      guibg = NONE gui = NONE"      , g:yellow                                      )
    exec printf("hi Number       guifg = %s      guibg = NONE gui = NONE"      , g:magenta                                     )
    exec printf("hi Character    guifg = %s      guibg = NONE gui = NONE"      , g:pink                                        )
    exec printf("hi Identifier   guifg = %s      guibg = NONE gui = NONE"      , g:selectColor                                 )
    exec printf("hi String       guifg = %s      guibg = NONE gui = NONE"      , g:modColor                                    )
    exec printf("hi Label        guifg = %s      guibg = NONE gui = NONE"      , g:blue                                        )
    exec printf("hi Title        guifg = %s      guibg = NONE gui = NONE"      , g:orange                                      )
    exec printf("hi Special      guifg = %s      guibg = NONE gui = bold"      , g:lavender                                    )
    exec printf("hi Conditional  guifg = %s      guibg = NONE gui = NONE"      , g:purple                                      )
    exec printf("hi DiffChange   guifg = %s      guibg = NONE gui = NONE"      , g:orange                                      )
    exec printf("hi Statement    guifg = %s      guibg = NONE gui = NONE"      , g:cyan                                        )
    exec printf("hi Keyword      guifg = %s      guibg = NONE gui = NONE"      , g:backcentColor                               )
    exec printf("hi Type         guifg = %s      guibg = NONE gui = NONE"      , g:green                                       )
    exec printf("hi DiffAdd      guifg = %s      guibg = NONE gui = NONE"      , g:modColor                                    )
    exec printf("hi DiffDelete   guifg = %s      guibg = NONE gui = NONE"      , g:red                                         )
    exec printf("hi ErrorMsg     guifg = %s      guibg = %s   gui = NONE"      , g:red               , g:harshAccentColor      )
    exec printf("hi Error        guifg = %s      guibg = %s   gui = NONE"      , g:red               , g:harshAccentColor      )
    exec printf("hi Directory    guifg = %s      guibg = NONE gui = NONE"      , g:blue                                        )
    exec printf("hi Function     guifg = %s      guibg = NONE gui = NONE"      , g:hotPink                                     )
    exec printf("hi MatchParen   guifg = %s      guibg = %s   gui = reverse"   , g:bgColor           , g:accentColor           )

endfun

fun! g:HandleModColor(mod)
    if a:mod
        let g:accentColor = g:envModColor
    else
        let g:accentColor = g:origAccentColor
    endif
    exec printf("hi StorageClass guifg = %s      guibg = NONE gui = bold"      , g:accentColor                                 )
    exec printf("hi Folded       guifg = %s      guibg = NONE gui = underline" , g:accentColor                                 )
    exec printf("hi VertSplit    guifg = %s      guibg = %s   gui = bold"      , g:accentColor       , g:bgColor               )
    exec printf("hi Incsearch    guifg = %s      guibg = %s   gui = underline" , g:accentColor       , g:neutralColor          )
    exec printf("hi LineNr       guifg = %s      guibg = %s   gui = NONE"      , g:accentColor       , g:accentBackgroundColor )
    exec printf("hi Pmenu        guifg = %s      guibg = %s   gui = NONE"      , g:accentColor       , g:accentBackgroundColor )
    exec printf("hi TabLineSel   guifg = %s      guibg = %s   gui = NONE"      , g:accentColor       , g:harshAccentColor      )
    exec printf("hi StatusLine   guifg = %s      guibg = %s   gui = NONE"      , g:accentColor       , g:accentBackgroundColor )
    exec printf("hi SignColumn   guifg = %s      guibg = %s   gui = bold"      , g:accentColor       , g:bgColor               )
    exec printf("hi FoldColumn   guifg = %s      guibg = %s   gui = bold"      , g:accentColor       , g:bgColor               )
endfun

"Make it happen
cal g:HandleDynamicColors()
cal g:HandleModColor(0)

"Effects
hi Cursor                     guifg=NONE guibg=NONE gui=inverse

"Links
hi link diffAdded DiffAdd
hi link diffRemoved DiffDelete
hi link notesSubtleURL Directory
hi link diffSubname Function
hi link OperatorChars vertsplit
