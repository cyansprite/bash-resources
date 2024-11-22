" vi: foldmethod=marker
" Vim:          Color file
" Maintainer:   Jojo Brandon Coffman <https://github.com/cyansprite>
" Title:        Restraint - WIP
" Description:  Theme based on term colors and espurr.
" Requirements: Term Colors for terminal or GUI color support.
" Note:         *Xresources Not Updated*
"               Don't use more than 16 term colors
"               Use light colors ontop of dark colors for normal, inverse for
"               selected.

set termguicolors
let &pumblend=0
let &winblend=0

" Setup:  +{{{1
hi clear
if exists("syntax_on")
    syntax reset
endif

" term bg color: #000000
let s:colorlist_dark = {
            \ "TermBG": '#000000',
            \ "fg"   : 'none',
            \ "fg0"  : 'none',
            \ "bg"   : 'none',
            \ "bg0"  : 'none',
            \ "bgHigh"  : '#222222',
            \ '000'  : '#4A4A4A',
            \ '00'   : '#2A2A2A',
            \ '01'   : '#2A1F1F',
            \ '02'   : '#1F2A1F',
            \ '03'   : '#2A2A1F',
            \ '04'   : '#1F1F2A',
            \ '05'   : '#2A1F2A',
            \ '011'  : '#5A4141',
            \ '022'  : '#415A41',
            \ '033'  : '#5A5A41',
            \ '044'  : '#44445A',
            \ '088'  : '#333333',
            \ 0      : '#121212',
            \ 8      : '#5F5959',
            \ 1      : '#FF6030',
            \ '19'   : '#884444',
            \ '91'   : '#FC4eFC',
            \ 9      : '#FA406A',
            \ 99     : '#FA406A',
            \ 2      : '#43AC40',
            \ '21'   : '#55CC00',
            \ '101'  : '#5CF400',
            \ 10     : '#00CC00',
            \ '300'  : '#4f4000',
            \ '30'   : '#8f8040',
            \ '32'   : '#b7b27d',
            \ 3      : '#E67F2C',
            \ 11     : '#F8AD3C',
            \ '113'  : '#F8BD6C',
            \ '111'  : '#F8DD0C',
            \ 4      : '#5B90B7',
            \ 12     : '#0F7FF4',
            \ '121'  : '#00CCFF',
            \ '51'   : '#528EC2',
            \ '52'   : '#C040C0',
            \ '54'   : '#9070F0',
            \ 5      : '#2F5A94',
            \ 55     : '#AFFAF4',
            \ 13     : '#CF0FC4',
            \ 199    : '#D0E5F3',
            \ '61'   : '#35FFAA',
            \ '62'   : '#60CFCF',
            \ 6      : '#44F5C0',
            \ 14     : '#4ADF7F',
            \ 141    : '#70F5E3',
            \ '71'   : '#62ada2',
            \ '72'   : '#ada262',
            \ '73'   : '#a262ad',
            \ '74'   : '#AD628B',
            \ '75'   : '#6D62AD',
            \ '76'   : '#FDFD96',
            \ 7      : '#CACACD',
            \ 15     : '#E6E4D6',
            \ 83     : '#706080',
            \ 383    : '#707060',
            \ 831    : '#2A2A2A',
            \ '150'  : '#8dbd73',
            \ '151'  : '#ffffe5',
            \ 'none' : 'none',
            \ 'Operator' : '#38FFAF',
            \ 'ParenChars' : '#CCCCCC',
            \ 'QuoteChars' : '#7777BB',
            \ 'MatchParen' : '#FFFF00',
            \ 'Visual' : '#2F2F4F',
            \ 'CC' : '#2A2020',
            \ 'Search' : '#3f3f00',
            \ 'IncSearch' : '#5f3f00',
            \ }

" term bg color: #D9D7D5
let s:colorlist_light = {
            \ "TermBG": '#F5F3ED',
            \ "fg"   : 'none',
            \ "fg0"  : 'none',
            \ "bg"   : 'none',
            \ "bg0"  : 'none',
            \ "bgHigh": '#FFFFFF',
            \ '00'   : '#DDDDDD',
            \ '01'   : '#FAEAEA',
            \ '02'   : '#EAFAEA',
            \ '03'   : '#FAFAEA',
            \ '04'   : '#EAEAFA',
            \ '05'   : '#DDA0DD',
            \ '011'  : '#AF6060',
            \ '022'  : '#608F60',
            \ '033'  : '#AFAF60',
            \ '044'  : '#6060AF',
            \ '088'  : '#CCCCCC',
            \ 0      : '#493E3E',
            \ 8      : '#5F5959',
            \ 1      : '#C12E2E',
            \ '19'   : '#DF6204',
            \ '91'   : '#cc2070',
            \ 9      : '#CD0D52',
            \ 99     : '#CD0D52',
            \ 2      : '#1A8B1A',
            \ 21     : '#4A8B1A',
            \ '101'  : '#5CA400',
            \ 10     : '#1D883C',
            \ '300'   : '#8f4000',
            \ '30'   : '#8f4000',
            \ '32'   : '#b7b24d',
            \ 3      : '#917D12',
            \ 11     : '#917D12',
            \ '111'  : '#B87D1C',
            \ '113'  : '#F8AD3C',
            \ 4      : '#4F9BB6',
            \ 12     : '#2F5A94',
            \ '121'  : '#7950C3',
            \ '51'   : '#F22EF2',
            \ '52'   : '#C000C0',
            \ '54'   : '#9000D0',
            \ 5      : '#754C8E',
            \ 55     : '#754C8E',
            \ 13     : '#D608DA',
            \ '61'   : '#00A055',
            \ '62'   : '#009A9A',
            \ 6      : '#199E7F',
            \ 14     : '#2D9960',
            \ 141    : '#305553',
            \ '71'   : '#9B811F',
            \ '72'   : '#BAAA55',
            \ '73'   : '#D9A14A',
            \ '75'   : '#A941DA',
            \ '76'   : '#29919A',
            \ 7      : '#989089',
            \ 15     : '#FFFFF7',
            \ 83     : '#9A8AAA',
            \ 383    : '#9A8AAA',
            \ 831    : '#EFECEA',
            \ '150'  : '#fdfdf3',
            \ '151'  : '#ffffe5',
            \ 'none' : 'none',
            \ 'Operator' : '#5C4174',
            \ 'ParenChars' : '#3B916F',
            \ 'QuoteChars' : '#7777BB',
            \ 'MatchParen' : '#FF00FF',
            \ 'Visual' : '#FFFFFF',
            \ 'CC' : '#ffcece',
            \ 'Search' : '#d5df00',
            \ 'IncSearch' : '#f5df00',
            \ }

if &bg == "dark"
    let s:colorList = s:colorlist_dark
else
    let s:colorList = s:colorlist_light
endif
let msg = 15
let msg2 = 8
if &bg == "dark"
    let msg = 0
    let msg2 = 7
    let temp = s:colorList['fg']
    let temp0 = s:colorList['fg0']
    let s:colorList['fg'] = s:colorList['bg']
    let s:colorList['fg0'] = s:colorList['bg0']
    let s:colorList['bg'] = temp
    let s:colorList['bg0'] = temp0
else
endif

let g:accentColor = '199'
let g:accentColorLight = '72'
let g:accentColorDiff = '75'
let g:accentColorTert = '73'
let g:colors_name = "restraint"

let s:colorList['GrepSearch']  = '#886800'
let s:colorList['GrepSearchC'] = '#bb9900'

func! s:cterm(c)
    if a:c =~# '^\d\+$'
        if a:c < 16 && a:c > -1
            return a:c
        endif
    endif

    return 'none'
endfunc

func! s:hy(name, f, b, t, ...)
    try
        exec 'hi '.a:name.' ctermfg='.s:cterm(a:f).' ctermbg='.s:cterm(a:b).' cterm='.a:t. ' guifg='.s:colorList[a:f].' guibg='.s:colorList[a:b].' gui='.a:t
    cat /.*/
        echohl ErrorMsg | echom v:exception . 'in :' . v:throwpoint . ' for ' . a:name | echohl None
    endtry
endfunc

" EasyAlign*/,\|)/

" Special:|{{{1
    call s:hy ( 'Search'       , 'none'       , 'Search'  , 'none'           )
    call s:hy ( 'IncSearch'    , 'none'       , 'IncSearch'    , 'underline' )
    call s:hy ( 'MatchParen'   , 'MatchParen' , 'none'    , 'bold'           )
    call s:hy ( 'BraceChars'   , 'ParenChars' , 'none'    , 'bold'           )
    call s:hy ( 'BracketChars' , 'ParenChars' , 'none'    , 'bold'           )
    call s:hy ( 'ParenChars'   , 'ParenChars' , 'none'    , 'bold'           )
    call s:hy ( 'QuoteChars'   , 'QuoteChars' , 'none'    , 'bold'           )
    call s:hy ( 'Operator'     , 'Operator'   , 'none'    , 'bold'           )

    " I'm not sure why I used User4 for the tabline fill... but I did
    call s:hy ( 'User4'        , 'none'             , 'none'   , 'bold' )
    call s:hy ( 'Folded'       , g:accentColorDiff  , 'none'   , 'none' )
    call s:hy ( 'Whitespace'   , 1                  , 'none'   , 'none' )
    call s:hy ( 'Visual'       , 'none'             , 'Visual' , 'none' )
    call s:hy ( 'EndOfBuffer'  , g:accentColorLight , 'none'   , 'bold' )
    call s:hy ( 'CursorLine'   , 'none'             , '831'   , 'none' )
    call s:hy ( 'Pmenu'        , g:accentColor      , 'TermBG' , 'none' )
    call s:hy ( 'PmenuSel'     , 141                , '831'    , 'bold' )
    call s:hy ( 'CocFloatActive'     , 141                , '831'    , 'bold' )
    call s:hy ( 'CocHintFloat'     , 141                , '831'    , 'bold' )
    call s:hy ( 'CocMenuSel'     , 141                , '831'    , 'bold' )
    call s:hy ( 'Comment'      , '83'               , 'none'   , 'none' )
    call s:hy ( 'GComment'      , '383'               , 'none'   , 'none' )

    call s:hy ( 'InnerScope'    , 'none'             , 'none' , 'none'         )
    call s:hy ( 'OuterScope'    , 'none'             , 'none' , 'none'         )
    call s:hy ( 'LinkScope'     , 'none'             , 'none' , 'none'         )

    call s:hy ( 'NormalMode'    , g:accentColor      , 'none' , 'bold'         )
    call s:hy ( 'InsertMode'    , 14                 , 'none' , 'bold'         )
    call s:hy ( 'VisualMode'    , 10                 , 'none' , 'bold'         )
    call s:hy ( 'SelectMode'    , 15                 , 'none' , 'bold'         )
    call s:hy ( 'CommandMode'   , 9                  , 'none' , 'bold'         )
    call s:hy ( 'TerminalMode'  , 12                 , 'none' , 'bold'         )
    call s:hy ( 'OtherMode'     , 8                  , 'none' , 'bold'         )
    call s:hy ( 'ReplaceMode'   , 1                  , 'none' , 'bold'         )

    call s:hy ( 'NormalMode1'   , g:accentColor      , 'none' , 'bold'         )
    call s:hy ( 'InsertMode1'   , 11                 , 'none' , 'bold'         )
    call s:hy ( 'VisualMode1'   , 10                 , 'none' , 'bold'         )
    call s:hy ( 'SelectMode1'   , 15                 , 'none' , 'bold'         )
    call s:hy ( 'CommandMode1'  , 9                  , 'none' , 'bold'         )
    call s:hy ( 'TerminalMode1' , 12                 , 'none' , 'bold'         )
    call s:hy ( 'OtherMode1'    , 8                  , 'none' , 'bold'         )
    call s:hy ( 'ReplaceMode1'  , 1                  , 'none' , 'bold'         )

    call s:hy ( 'NormalMode2'   , g:accentColor      , 'none' , 'bold'         )
    call s:hy ( 'InsertMode2'   , 11                 , 'none' , 'bold'         )
    call s:hy ( 'VisualMode2'   , 10                 , 'none' , 'bold'         )
    call s:hy ( 'SelectMode2'   , 15                 , 'none' , 'bold'         )
    call s:hy ( 'CommandMode2'  , 9                  , 'none' , 'bold'         )
    call s:hy ( 'TerminalMode2' , 12                 , 'none' , 'bold'         )
    call s:hy ( 'OtherMode2'    , 8                  , 'none' , 'bold'         )
    call s:hy ( 'ReplaceMode2'  , 1                  , 'none' , 'bold'         )

    call s:hy ( 'GitGutterDelete'             , '01'  , '011' , 'bold,inverse' )
    call s:hy ( 'GitGutterAdd'                , '02'  , '022' , 'bold,inverse' )
    call s:hy ( 'GitGutterChangeDelete'       , '03'  , '033' , 'bold,inverse' )
    call s:hy ( 'GitGutterChange'             , '04'  , '044' , 'bold,inverse' )
    call s:hy ( 'GitGutterDeleteLineNr'       , '011' , '01'  , 'bold' )
    call s:hy ( 'GitGutterAddLineNr'          , '022' , '02'  , 'bold' )
    call s:hy ( 'GitGutterChangeDeleteLineNr' , '033' , '03'  , 'bold' )
    call s:hy ( 'GitGutterChangeLineNr'       , '044' , '04'  , 'bold' )

" Nons:   -{{{1
    call s:hy ( 'Normal'       , 'fg'   , 'none' , 'none'    )
    call s:hy ( 'NormalNC'     , 'fg0'  , 'bg0'  , 'none'    )
    call s:hy ( 'UnderLine'    , 'none' , 'none' , 'none'    )
    call s:hy ( 'CursorColumn' , 'none' , 'none' , 'none'    )
    call s:hy ( 'Cursor'       , 'none' , 'none' , 'inverse' )
    call s:hy ( 'QuickFixLine' , 'none' , 'none' , 'inverse' )
    call s:hy ( 'DiffChange'   , 'none' , '088'  , 'none'    )
    call s:hy ( 'ColorColumn'  , 'none' , 'TermBG'   , 'none'    )
    call s:hy ( 'Bold'         , 'none' , 'none' , 'bold'    )

"1       9{{{1
    call s:hy ( 'Error'        , 1      , 'none' , 'none' )
    call s:hy ( 'DiffDelete'   , 'none' , '01'   , 'none' )
    call s:hy ( 'SpellBad'     , msg   , 1      , 'none' )
    call s:hy ( 'ErrorMsg'     , msg   , 19      , 'bold' )
    call s:hy ( 'ErrorMsgLite' , msg   , 'CC'      , 'bold' )
    call s:hy ( 'DiffRemoved'  , 'none' , '01'   , 'none' )
    call s:hy ( 'Function'     , 99   , 'none' , 'none' )
    call s:hy ( 'UserFunction' , 9    , 'none' , 'none' )
    call s:hy ( 'Number'       , '11'   , 'none' , 'none' )
    call s:hy ( 'Float'        , 113      , 'none' , 'none' )

" 2      10{{{1
    call s:hy ( 'StorageClass' , 10     , 'none' , 'none' )
    call s:hy ( 'Char'         , '21'   , 'none' , 'none' )
    call s:hy ( 'StringSpecial', '101'   , 'none' , 'none' )
    call s:hy ( 'DiffAdd'      , 'none' , '02'   , 'none' )
    call s:hy ( 'diffAdded'    , 'none' , '02'   , 'none' )
    call s:hy ( 'QShit'        , 2      , 'none' , 'none' )


" 3      11{{{1
    call s:hy ( 'Parameter'  , '1' , 'none' , 'none'      )
    call s:hy ( 'OtherYellow', '11' , 'none' , 'none'      )
    call s:hy ( 'Silver', '199' , 'none' , 'none'      )
    call s:hy ( 'Directory'  , 3     , 'none' , 'none'      )
    call s:hy ( 'Title'      , 13     , 'fg0'  , 'bold'      )
    call s:hy ( 'Macro'      , 91     , 'none' , 'none'      )
    call s:hy ( 'Todo'       , msg   , 11     , 'bold'      )
    call s:hy ( 'WarningMsg' , msg     , 300    , 'bold'      )
    call s:hy ( 'WarningMsgLite' , msg     , 300    , 'bold'      )
    call s:hy ( 'Special'    , 111   , 'none' , 'none'      )
    call s:hy ( 'Ignore'     , 3     , 'none' , 'none'      )
    call s:hy ( 'Delimeter'  , 72   , 'none' , 'none'      )
    call s:hy ( 'Identifier' , 11     , 'none' , 'none'      )
    call s:hy ( 'Yellow' , 11     , 'none' , 'none'      )
" 4      12{{{1
    call s:hy ( 'NonText'   , 4      , 'none' , 'none' )
    call s:hy ( 'PreCondit' , 4      , 'none' , 'none' )
    call s:hy ( 'Constant'  , 12     , 'none' , 'none' )
    call s:hy ( 'Modifier'  , 12     , 'none' , 'bold' )
    call s:hy ( 'Member'    , 12      , 'none' , 'none' )
    call s:hy ( 'Property'  , '141'   , 'none' , 'none'         )
    call s:hy ( 'Variable'  , '76' , 'none' , 'none' )
    call s:hy ( 'DiffText'  , 'none' , '04'   , 'none' )
    call s:hy ( 'Class'      , '121' , 'none' , 'none' )

" 5      13{{{1
    call s:hy ( 'TypeDef'     , '52'   , 'none' , 'none'         )
    call s:hy ( 'Boolean'     , '54'   , 'none' , 'none'         )
    call s:hy ( 'Conditonal'  , '51'   , 'none' , 'none'         )
    call s:hy ( 'Character'   , 5      , 'none' , 'none'         )
    call s:hy ( 'SpecialChar' , 55      , 'none' , 'none'         )
    call s:hy ( 'diffSubname' , 5      , '05'   , 'none'         )
    call s:hy ( 'PreProc'     , 5      , 'none' , 'none'         )
    call s:hy ( 'MoreMsg'     , 5     , 'none'      , 'bold'         )
    call s:hy ( 'Repeat'      , 13     , 'none' , 'none'         )
    call s:hy ( 'SignColumn'  , 5      , 'none' , 'none'         )
    call s:hy ( 'WildMenu'    , 'none' , 'none' , 'bold,inverse' )

" 6      14{{{1
    call s:hy ( 'Label'      , '61' , 'none' , 'none' )
    call s:hy ( 'Type'       , '61' , 'none' , 'none' )
    call s:hy ( 'SpecialKey' , 6    , 'none' , 'none' )
    call s:hy ( 'Keyword'    , '12' , 'none' , 'none' )
    call s:hy ( 'Frost'      , '141' , 'none' , 'none' )
    call s:hy ( 'Statement'  , 14   , 'none' , 'none' )

" 7      15{{{1
    call s:hy ( 'Question'      , 7      , msg      , 'inverse'      )
    call s:hy ( 'LogicalBuffer' , '15' , "0"   , 'inverse,bold' )
    call s:hy ( 'Logical7'      , '71'   , "TermBG"   , 'bold'         )
    call s:hy ( 'String'       , 10      , 'none' , 'none' )

    for x in range(9, 15)
        call s:hy ("Logical".string(x-9), x, 'TermBG', 'bold')
    endfor
    for x in range(1, 7)
        call s:hy ("Logical".string(x+7), x, 'TermBG', 'bold')
    endfor

    call s:hy ( 'CocCodeLens'  , msg2, 'TermBG' , 'none' )
    call s:hy ( 'LspCodeLens'  , msg2, 'TermBG' , 'none' )
    call s:hy ( 'CocInfoLine'  , 11, 'TermBG' , 'none' )

" 0       8{{{1
    call s:hy ( 'StatuslineNc' , g:accentColor , 'fg0'  , 'none' )
    call s:hy ( 'VertSplit'    , g:accentColor, 'none' , 'bold' )
    call s:hy ( 'LineNr'       , g:accentColorLight , 'TermBG' , 'none' )
    call s:hy ( 'CursorLineNr' , g:accentColor, '831'    , 'bold' )


" Dynamic:x{{{1
    call s:hy ( 'FoldColumn' , g:accentColorLight , 'none' , 'none'    )
    call s:hy ( 'StatusLine' , g:accentColor      , 'none' , 'none'    )
    call s:hy ( 'ModeMsg'    , g:accentColor      , 'none' , 'inverse,bold' )
    call s:hy ( 'PmenuSbar'  , 'none'             , '0'    , 'none'    )
    call s:hy ( 'PMenuThumb' , g:accentColorDiff  , 'none' , 'inverse' )
    call s:hy ( 'CocFloatSbar'  , 'none'             , '0'    , 'none'    )
    call s:hy ( 'CocFloatThumb' , g:accentColorDiff  , 'none' , 'inverse' )


" Relink: >{{{1
    hi link luaTable BraceChars
    hi link luaParen ParenChars
    hi link Exception Error

    hi link vimCommentTitle       Title
    hi link vimCommentTitleLeader Title
    hi link vimIsCommand          Constant
    hi link vimHighlight          Member
    hi link vimHighClear          Identifier
    hi link vimUserFunc           UserFunction
    hi link vimFunction           UserFunction
    hi link vimContinue           ParenChars
    hi link vimParenSep           ParenChars
    hi link vimExecute            Operator

    hi link helpExample     Title

    hi link gitCommitSummary Title

    hi link CocSemClass     Class
    hi link CocSemModifier  Modifier
    hi link CocSemProperty  Property
    hi link CocSemParameter Parameter

    hi link csClass         Structure
    hi link csType          Member

    hi link cConditional    Conditonal
    hi link cRepeat         Repeat
    hi link cCustomMemVar   Member
    hi link cCustomClass    Class
    hi link cRepeat         Repeat

    hi link cppSTLnamespace Label

    hi link pythonDecoratorName Constant
    hi link pythonBuiltin       Label

    hi link javaConditional   Conditional
    hi link javaExternal   Macro
    hi link javaExternal   Macro

    hi link javaScriptConditional Conditional

    hi link jsonKeyword       Function
    hi link jsonQuote         QuoteChars
    hi link jsonKeywordMatch  Operator

    hi link builtInLibrary    Macro

    hi link htmlTag Keyword
    hi link htmlArg Property
    hi link htmlTagName Function

    hi link typescriptTernary Property
    hi link typescriptProp Property
    hi link typescriptES6SetMethod method
    " hi link typescriptBlock Property
    hi link typescriptArray Identifier
    hi link typescriptTypeReference class
    hi link typescriptObjectLabel property
    hi link typescriptTypeReference Class
    hi link typescriptStatementKeyword Keyword
    hi link typescriptIdentifier Special
    " hi link typescriptDecorator type
    hi link typescriptCall parameter
    hi link typescriptCase Identifier
    hi link typescriptMember Member
    hi link typescriptBraces None
    hi link typescriptVariable Keyword
    hi link typescriptIdentifierName Identifier
    hi link typescriptTemplateSubstitution Char
    hi link typescriptTemplateSB StringSpecial

    hi link TSAttribute        Macro
    hi link TSConstBuiltIn     Macro
    hi link TSConstructor      StorageClass
    hi link TSEmphasis         bold
    hi link TSFuncBuiltIn      Function
    hi link TSFunction         UserFunction
    hi link TSKeywordFunction  Function
    hi link TSKeywordReturn    Statement
    hi link TSKeyword          Keyword
    hi link TSParameter        Parameter
    hi link TSProperty         Property
    hi link TSPunctBracket     BracketChars
    hi link TSPunctSpecial     Special
    hi link TSVariableBuiltIn  TypeDef

    hi link CocHighlightText cursorline

    hi link OperatorChars     Operator

    hi link LspDiagnosticsDefaultError ErrorMsg
    hi link LspDiagnosticsDefaultWarning WarningMsg
    hi link LspDiagnosticsDefaultInformation MoreMsg
    hi link LspDiagnosticsDefaultHint Question
    hi link CocCodeLens MoresMsg
    hi link FgCocInfoFloatBgNormal None
    hi link FgCocWarningFloatBgNormal Ignore

    hi link tapTestResultsOKRegion GitGutterAdd
    hi link tapTestResultsNotOKRegion GitGutterDiff

    hi link tapTest Title
    hi link CocFadeOut WarningMsg
    hi link CocSelectedText PmenuSel
    hi link CocHighlightText PmenuSel
    hi link CocFloating PmenuSel
    hi link CocErrorFloat PmenuSel
    hi link CocMenueSel PmenuSel
    hi link CocErrorSign ErrorMsgLite
    hi link CocErrorHighlight ErrorMsgLite
    hi link CocErrorLine ErrorMsgLite

    hi link @text.literal      Comment
    hi link @text.reference    PreCondit
    hi link @text.title        Title
    hi link @text.uri          Underlined
    hi link @text.underline    Underlined
    hi link @text.todo         Todo

    hi link @comment           Comment
    hi link @punctuation       ParenChars

    hi link @constant          Constant
    hi link @constant.builtin  Special
    hi link @constant.macro    Define
    hi link @define            TypeDef
    hi link @macro             Macro
    hi link @string            String
    hi link @string.escape     SpecialChar
    hi link @string.special    SpecialChar
    hi link @character         Character
    hi link @character.special SpecialChar
    hi link @number            Number
    hi link @boolean           Boolean
    hi link @float             Float

    hi link @function          Function
    hi link @function.builtin  Special
    hi link @function.macro    Macro
    hi link @parameter         Parameter
    hi link @method            UserFunction
    hi link @field             OtherYellow
    hi link @property          Property
    hi link @constructor       Silver

    hi link @conditional       Conditional
    hi link @repeat            Repeat
    hi link @label             Label
    hi link @operator          Operator
    hi link @keyword           Keyword
    hi link @exception         Exception

    hi link @variable          Variable
    hi link @type              Type
    hi link @type.definition   Typedef
    hi link @storageclass      StorageClass
    hi link @structure         Structure
    hi link @namespace         Parameter
    hi link @include           Include
    hi link @preproc           PreProc
    hi link @debug             Debug
    hi link @tag               Tag
    hi link ansinone normal
    hi link DiagnosticVirtualTextHint Question

    hi link CocInfoVirtualText Question
    hi link CocHintHighlight Question
    hi link CocHintSign Question
    hi link CocHintVirtualText Question
    hi link CocInlayHint Question
    hi link CocInlayHintParameter Question
    hi link CocSymbolUnit Parameter
    hi link CocSymbolFolder Yellow
    hi link CocSymbolText String
    hi link CocSymbolObject Class
    hi link NotifyINFOIcon MoreMsg
    hi link NotifyINFO MoreMsg
    hi link NotifyINFOTitle MoreMsg
    hi link NotifyINFOBody MoreMsg
    " TODO
    " hi link @lsp.type.class Class
    " hi link @lsp.type.comment Comment
    " hi link @lsp.type.decorator SpecialChar
    " hi link @lsp.type.enum Enum
    " hi link @lsp.type.enumMember Parameter
    " hi link @lsp.type.event Question
    " hi link @lsp.type.function Function
    " hi link @lsp.type.interface Identifier
    " hi link @lsp.type.keyword Keyword
    " hi link @lsp.type.macro Macro
    " hi link @lsp.type.method UserFunction
    " hi link @lsp.type.modifier Modifier
    " hi link @lsp.type.namespace Property
    " hi link @lsp.type.number Number
    " hi link @lsp.type.operator Operator
    hi link @lsp.type.parameter Parameter
    " hi link @lsp.type.property Property
    hi link @lsp.type.regexp StringSpecial
    " hi link @lsp.type.string String
    " hi link @lsp.type.struct Structure
    " hi link @lsp.type.type Type
    " hi link @lsp.type.typeParameter Parameter
    hi link @lsp.type.variable Frost
    hi link @variable.builtin.typescript Special
    hi link @type.builtin.typescript Type
    hi link @punctuation.special.typescript SpecialChar
    hi link @punctuation.bracket.typescript ParenChars

    " hi link @lsp.mod.abstract Class
    " hi link @lsp.mod.async Function
    " hi link @lsp.mod.declaration Identifier
    " hi link @lsp.mod.defaultLibrary Special
    " hi link @lsp.mod.definition Identifier
    " hi link @lsp.mod.deprecated Comment
    " hi link @lsp.mod.documentation Special
    " hi link @lsp.mod.modification Special
    hi link @lsp.mod.readonly Macro
    " hi link @lsp.mod.static Special
    hi link LspCodeLens GComment
    hi link LspLens GComment
    hi link @variable.builtin.typescript Silver
    hi link @lsp.type.variable.typescript Variable
    hi link @lsp.type.class.typescript Class
    hi link @tag.angular Function
    hi link @tag.delimiter.angular Function
    hi link @tag.attribute.angular Variable
    hi link @punctuation.special.angular ParenChars
    hi link @lsp.typemod.parameter.readonly.kotlin Parameter
    hi link @variable.kotlin Variable
    hi link @lsp.mod.readonly.kotlin None

    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    highlight! link CmpItemAbbrMatch Frost
    highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
    highlight! link CmpItemKindVariable Variable
    highlight! link CmpItemKindInterface CmpItemKindVariable
    highlight! link CmpItemKindText CmpItemKindVariable
    highlight! link CmpItemKindFunction Function
    highlight! link CmpItemKindMethod UserFunction
    highlight! link CmpItemKindKeyword Keyword
    highlight! link CmpItemKindProperty Property
    highlight! link CmpItemKindUnit Class

" }}}
" Plugin: & {{{1

call s:hy('GrepperCurrent', 0, 'GrepSearchC', 'none')
call s:hy('GrepperMatch'  , 0, 'GrepSearch' , 'none')

call s:hy('TreesitterContext', 0, 'bgHigh' , 'none')
