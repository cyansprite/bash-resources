" Vim:          Color file / Generate Color file
" Maintainer:   Jojo Brandon Coffman <https://github.com/cyansprite>
" Title:        Chill
" Description:  Theme based on dull colors and espurr.
" Requirements: Rxvt Colors or GUI color support.
" Setup   +{{{1
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "chill"

" If you want it to spit out what's happening/generate a color file.
let s:debug     = 0

" Function to make life easier.
func! s:hy(name,cf,cb,gf,gb,t)
    if s:debug
        echom 'hi '.a:name.' ctermfg='.a:cf.' ctermbg='.a:cb.' cterm='.a:t.
                    \    ' guifg='  .a:gf.' guibg='  .a:gb.' gui='   a:t
    endif
    exec 'hi '.a:name.' ctermfg='.a:cf.' ctermbg='.a:cb.' cterm='.a:t.
                 \    ' guifg='  .a:gf.' guibg='  .a:gb.' gui='   a:t
endfunc

" GuiDef: o{{{1
" Foreground and Background.
let s:fg        = '#9595ac'
let s:bg        = '#1a1a1a'

" Rxvt spoiled me.
let s:bold      = '#cfc5fc'
let s:italic    = '#f0c0c0'
let s:underline = '#f0ffca'

" Term colors go here.
let s:color0    = '#000000'
let s:color8    = '#6f6f6f'

let s:color1    = '#db9090'
let s:color9    = '#c24343'

let s:color2    = '#b6db90'
let s:color10   = '#82c243'

let s:color3    = '#dbcf90'
let s:color11   = '#db9970'

let s:color4    = '#9090db'
let s:color12   = '#90b6db'

let s:color5    = '#b690db'
let s:color13   = '#db90b6'

let s:color6    = '#90dbdb'
let s:color14   = '#6acfcf'

let s:color7    = '#909090'
let s:color15   = '#dbdbdb'

" If you don't like grey, change these.
let s:xGrey = {
    \'232': '#080808',
    \'233': '#121212',
    \'234': '#1c1c1c',
    \'235': '#262626',
    \'236': '#303030',
    \'237': '#3a3a3a',
    \'238': '#444444',
    \'239': '#4e4e4e',
    \'240': '#585858',
    \'241': '#606060',
    \'242': '#666666',
    \'243': '#767676',
    \'244': '#808080',
    \'245': '#8a8a8a',
    \'246': '#949494',
    \'247': '#9e9e9e',
    \'248': '#a8a8a8',
    \'249': '#b2b2b2',
    \'250': '#bcbcbc',
    \'251': '#c6c6c6',
    \'252': '#d0d0d0',
    \'253': '#dadada',
    \'254': '#e4e4e4',
    \'255': '#eeeeee'
\}

" Nons:   -{{{1
  call s:hy('Normal',       'none', 'none', s:fg,      s:bg,   'none'         )
  call s:hy('Folded',       'none', 'none', s:bold,    s:bg,   'bold'         )
  call s:hy('ModeMsg',      'none', 'none', s:bold,    s:bg,   'bold'         )
  call s:hy('QuickFixLine', 'none', 'none', s:bold,    s:bg,   'bold'         )
  call s:hy('Cursor',       'none', 'none', s:color15, s:bg,   'bold'         )
  call s:hy('Search',       'none', 'none', 'none',    'none', 'bold,inverse' )
  call s:hy('EndOfBuffer',  'none', 'none', 'none',    'none', 'none'         )

" Red:    1{{{1
  call s:hy('String',     '1',  'none', s:color1,  'bg',     'none')
  call s:hy('Boolean',    '1',  'none', s:color1,  'bg',     'none')

  call s:hy('Keyword',    '9',  'none', s:color9,  'bg',     'none')
  call s:hy('Character',  '9',  'none', s:color9,  'bg',     'none')

  call s:hy('Error',      '1',  '9',    s:color1,  s:color9, 'none')
  call s:hy('ErrorMsg',   '15', '9',    s:color15, s:color9, 'bold')
  call s:hy('Whitespace', '15', '9',    s:color15, s:color9, 'bold')
  call s:hy('DiffDelete', '15', '9',    s:color15, s:color9, 'bold')

" Green:  2{{{1
  call s:hy('StorageClass', '2',  'none', s:color2,  'bg',      'none'         )
  call s:hy('Structure',    '2',  'none', s:color2,  'bg',      'none'         )
  call s:hy('Typedef',      '2',  'none', s:color2,  'bg',      'none'         )

  call s:hy('Type',         '10', 'none', s:color10, 'bg',      'none'         )

  call s:hy('MoreMsg',      '10', 'none', s:color10, 'bg',      'bold,inverse' )
  call s:hy('DiffAdd',      '15', '10',   s:color15, s:color10, 'none'         )

" Yellow: 3{{{1
  call s:hy('PreCondit',    '3',  'none', s:color3,  'bg', 'none'         )
  call s:hy('Structure',    '3',  'none', s:color3,  'bg', 'none'         )
  call s:hy('TypeDef',      '3',  'none', s:color3,  'bg', 'none'         )

  call s:hy('StorageClass', '11', 'none', s:color11, 'bg', 'none'         )
  call s:hy('Directory',    '11', 'none', s:color11, 'bg', 'none'         )
  call s:hy('Todo',         '11', 'none', s:color11, 'bg', 'bold'         )

  call s:hy('MoreMsg',      '3',  'none', s:color3,  'bg', 'bold,inverse' )


" Blue:   4{{{1
  call s:hy('NonText',     '4',  'none', s:color4,  'bg', 'none')
  call s:hy('Special',     '4',  'none', s:color4,  'bg', 'none')
  call s:hy('SpecialChar', '4',  'none', s:color4,  'bg', 'none')
  call s:hy('SpecialKey',  '4',  'none', s:color4,  'bg', 'none')
  call s:hy('Label',       '12', 'none', s:color12, 'bg', 'none')
  call s:hy('Identifier',  '12', 'none', s:color12, 'bg', 'none')

" Purple: 5{{{1
  call s:hy('Delimeter',  '5',  'none', s:color5,  'bg', 'none'         )
  call s:hy('Constant',   '5',  'none', s:color5,  'bg', 'none'         )
  call s:hy('Number',     '5',  'none', s:color5,  'bg', 'none'         )
  call s:hy('Statement',  '5',  'none', s:color5,  'bg', 'none'         )
  call s:hy('Conditonal', '5',  'none', s:color5,  'bg', 'none'         )

  call s:hy('Repeat',     '13', 'none', s:color13, 'bg', 'none'         )
  call s:hy('Float',      '13', 'none', s:color13, 'bg', 'none'         )
  call s:hy('Title',      '13', 'none', s:color13, 'bg', 'bold'         )

  call s:hy('Question',   '13', 'none', s:color13, 'bg', 'bold,inverse' )

" Cyan:   6{{{1
  call s:hy('Member',     '6',    'none', s:color6,  'bg',      'none')
  call s:hy('Function',   '6',    'none', s:color6,  'bg',      'none')
  call s:hy('PMenuThumb', 'none', '6',    'none',    s:color6,  'none')

  call s:hy('DiffText',   '15',   '14',   s:color15, s:color14, 'none')

" Grey:   7{{{1
  call s:hy('Ignore',   '7', 'none', s:color7, 'bg', 'italic' )
  call s:hy('PreProc',  '7', 'none', s:color7, 'bg', 'none'   )
  call s:hy('Class',    '7', 'none', s:color7, 'bg', 'none'   )
  call s:hy('Operator', '7', 'none', s:color7, 'bg', 'none'   )

" Black:  0{{{1
" TODO discover why gui hates italics.
  call s:hy('VertSplit',    '0', 'none', s:color0, 'bg',           'none')
  call s:hy('Comment',      '8', 'none', s:color8, 'bg',           'none')
  call s:hy('StatuslineNc', '8', '235',  s:color8, s:xGrey['235'], 'none')

" Accent: *{{{1
" dark
  call s:hy('StatusLine',   'none', '233 ', 'fg',           s:xGrey['233'], 'none'           )
  call s:hy('LineNr',       '8   ', '234 ', s:color8,       s:xGrey['234'], 'none'           )
  call s:hy('Pmenu',        '8   ', '234 ', s:color8,       s:xGrey['234'], 'none'           )
  call s:hy('CursorLine',   'none', '235 ', 'none',         s:xGrey['235'], 'none'           )
  call s:hy('CursorLineNr', 'none', '235 ', s:bold,         s:xGrey['235'], 'bold'           )
  call s:hy('PmenuSbar',    'none', '236 ', 'none',         s:xGrey['236'], 'none'           )
  call s:hy('ColorColumn',  'none', '236 ', 'none',         s:xGrey['236'], 'none'           )
  call s:hy('DiffChange',   '236 ', 'none', s:xGrey['236'], 'none',         'bold,inverse'   )
  call s:hy('Visual',       'none', '237 ', 'none',         s:xGrey['237'], 'bold'           )
  call s:hy('PmenuSel',     'none', '237 ', s:bold,         s:xGrey['237'], 'bold'           )
  call s:hy('IncSearch',    'none', '237 ', s:bold,         s:xGrey['237'], 'bold,underline' )
  call s:hy('WildMenu',     'none', '238 ', s:bold,         s:xGrey['238'], 'bold'           )
  call s:hy('MatchParen',   'none', '238 ', s:bold,         s:xGrey['238'], 'bold,underline' )

  call s:hy('User6',        'none', '234',  'none',         s:xGrey['234'], 'none'           )
  call s:hy('User3',        'none', '235',  'none',         s:xGrey['235'], 'bold'           )
  call s:hy('User1',        '2   ', '235',  s:color2,       s:xGrey['235'], 'bold'           )
  call s:hy('User2',        '1   ', '235',  s:color1,       s:xGrey['235'], 'bold'           )
  call s:hy('User5',        '7   ', '235',  s:color7,       s:xGrey['235'], 'bold'           )
  call s:hy('User4',        'none', '236',  'none',         s:xGrey['236'], 'none'           )

  call s:hy('holdSearch',   'none', '240',  'none',         s:xGrey['240'], 'none'           )

" Relink  >{{{1
hi link vimCommentTitle Title
hi link vimIsCommand    Constant
hi link vimHighlight    Member
hi link diffAdded       DiffAdd
hi link diffRemoved     DiffDelete
" }}}
