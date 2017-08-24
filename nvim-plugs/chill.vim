hi clear

if exists("syntax_on")
    syntax reset
endif

if has('termguicolors')
    set termguicolors
endif

let g:colors_name="chill"

" Main
hi Normal            ctermfg=241 ctermbg=231  cterm=none      guifg=#112211 guibg=#eeeee0 gui=none
hi Comment           ctermfg=246 ctermbg=231  cterm=none      guifg=#948474 guibg=&bg gui=none

hi Constant          ctermfg=130 ctermbg=231  cterm=none      guifg=#aa0000 guibg=&bg gui=none
hi String            ctermfg=136 ctermbg=231  cterm=none      guifg=#0f8aaa guibg=&bg gui=none
hi Character         ctermfg=136 ctermbg=231  cterm=none      guifg=#0faa8a guibg=&bg gui=none
hi Number            ctermfg=131 ctermbg=231  cterm=none      guifg=#aa0f8a guibg=&bg gui=none
hi Float             ctermfg=131 ctermbg=231  cterm=none      guifg=#8a0fba guibg=&bg gui=none
hi Boolean           ctermfg=136 ctermbg=231  cterm=none      guifg=#5f0faa guibg=&bg gui=bold

hi Identifier        ctermfg=133 ctermbg=231  cterm=none      guifg=#FF0000 guibg=&bg gui=none
hi Function          ctermfg=133 ctermbg=231  cterm=none      guifg=#FF0000 guibg=&bg gui=none

hi Statement         ctermfg=32  ctermbg=231  cterm=none      guifg=#0087d7 guibg=&bg gui=none
hi Conditional       ctermfg=32  ctermbg=231  cterm=none      guifg=#0087d7 guibg=&bg gui=none
hi Repeat            ctermfg=32  ctermbg=231  cterm=none      guifg=#0087d7 guibg=&bg gui=none
hi Label             ctermfg=32  ctermbg=231  cterm=none      guifg=#0087d7 guibg=&bg gui=none
hi Operator          ctermfg=32  ctermbg=231  cterm=none      guifg=#0087d7 guibg=&bg gui=none
hi Keyword           ctermfg=32  ctermbg=231  cterm=none      guifg=#0087d7 guibg=&bg gui=none
hi Exception         ctermfg=32  ctermbg=231  cterm=none      guifg=#0087d7 guibg=&bg gui=none

hi PreProc           ctermfg=28  ctermbg=231  cterm=none      guifg=#008700 guibg=&bg gui=none
hi Include           ctermfg=28  ctermbg=231  cterm=none      guifg=#008700 guibg=&bg gui=none
hi Define            ctermfg=28  ctermbg=231  cterm=none      guifg=#008700 guibg=&bg gui=none
hi Macro             ctermfg=28  ctermbg=231  cterm=none      guifg=#008700 guibg=&bg gui=none
hi PreCondit         ctermfg=28  ctermbg=231  cterm=none      guifg=#008700 guibg=&bg gui=none

hi Type              ctermfg=61  ctermbg=231  cterm=none      guifg=#4040af guibg=&bg gui=none
hi StorageClass      ctermfg=61  ctermbg=231  cterm=none      guifg=#5f5faf guibg=&bg gui=none
hi Structure         ctermfg=61  ctermbg=231  cterm=none      guifg=#5f5faf guibg=&bg gui=none
hi Typedef           ctermfg=61  ctermbg=231  cterm=none      guifg=#5f5faf guibg=&bg gui=none

hi Special           ctermfg=167 ctermbg=231  cterm=none      guifg=#d75f5f guibg=&bg gui=none
hi SpecialChar       ctermfg=167 ctermbg=231  cterm=none      guifg=#d75f5f guibg=&bg gui=none
hi Tag               ctermfg=167 ctermbg=231  cterm=none      guifg=#d75f5f guibg=&bg gui=none
hi Delimiter         ctermfg=167 ctermbg=231  cterm=none      guifg=#d75f5f guibg=&bg gui=none
hi SpecialComment    ctermfg=167 ctermbg=231  cterm=none      guifg=#d75f5f guibg=&bg gui=none
hi Debug             ctermfg=167 ctermbg=231  cterm=none      guifg=#d75f5f guibg=&bg gui=none
hi Underlined        ctermfg=241 ctermbg=231  cterm=underline guifg=#626262 guibg=&bg gui=underline
hi Ignore            ctermfg=231 ctermbg=231  cterm=none      guifg=#ffffff guibg=&bg gui=none
hi Error             ctermfg=231 ctermbg=160  cterm=none      guifg=#ffffff guibg=#d70000 gui=none
hi Todo              ctermfg=246 ctermbg=231  cterm=none      guifg=#949494 guibg=#ffffff gui=none

hi StatusLine        ctermfg=241 ctermbg=254  cterm=none      guifg=#626262 guibg=#e4e4e4 gui=none
hi StatusLineNC      ctermfg=246 ctermbg=254  cterm=none      guifg=#949494 guibg=#e4e4e4 gui=none
hi TabLine           ctermfg=241 ctermbg=254  cterm=none      guifg=#626262 guibg=#e4e4e4 gui=none
hi TabLineSel        ctermfg=238 ctermbg=188  cterm=none      guifg=#444444 guibg=#d7d7d7 gui=none
hi TabLineFill       ctermbg=254 ctermbg=none cterm=none      guibg=#e4e4e4 guibg=&bg     gui=none
hi VertSplit         ctermfg=254 ctermbg=254  cterm=none      guifg=#e4e4e4 guibg=#e4e4e4 gui=none

hi Pmenu             ctermfg=241 ctermbg=254  cterm=none      guifg=#626262 guibg=#e4e4e4 gui=none
hi PmenuSel          ctermfg=235 ctermbg=145  cterm=none      guifg=#262626 guibg=#afafaf gui=none
hi PmenuSbar         ctermbg=250 ctermbg=none cterm=none      guibg=#bcbcbc guibg=&bg     gui=none
hi PmenuThumb        ctermbg=102 ctermbg=none cterm=none      guibg=#878787 guibg=&bg     gui=none
hi WildMenu          ctermfg=231 ctermbg=98   cterm=none      guifg=#ffffff guibg=#875fd7 gui=none

hi Visual            ctermfg=231 ctermbg=24   cterm=none      guifg=#ffffff guibg=#005f87 gui=none
hi VisualNOS         ctermfg=231 ctermbg=23   cterm=none      guifg=#ffffff guibg=#005f5f gui=none

hi ErrorMsg          ctermfg=197 ctermbg=231  cterm=none      guifg=#ff005f guibg=#ffffff gui=none
hi WarningMsg        ctermfg=134 ctermbg=231  cterm=none      guifg=#af5fd7 guibg=#ffffff gui=none
hi MoreMsg           ctermfg=35  ctermbg=231  cterm=none      guifg=#00af5f guibg=#ffffff gui=none
hi ModeMsg           ctermfg=130 ctermbg=231  cterm=bold      guifg=#af5f00 guibg=#ffffff gui=bold
hi Question          ctermfg=38  ctermbg=231  cterm=none      guifg=#00afd7 guibg=#ffffff gui=none

hi Folded            ctermfg=246 ctermbg=231  cterm=none      guifg=#949494 guibg=#ffffff gui=none
hi FoldColumn        ctermfg=29  ctermbg=254  cterm=none      guifg=#00875f guibg=#e4e4e4 gui=none
hi SignColumn        ctermfg=130 ctermbg=254  cterm=none      guifg=#af5f00 guibg=#e4e4e4 gui=none
hi ColorColumn       ctermbg=254 ctermbg=none cterm=none      guibg=#e4e4e4 guibg=&bg     gui=none
hi LineNr            ctermfg=246 ctermbg=254  cterm=none      guifg=#949494 guibg=#e4e4e4 gui=none
hi MatchParen        ctermfg=231 ctermbg=166  cterm=none      guifg=none guibg=none gui=bold,underline

hi CursorColumn      ctermbg=254 ctermbg=none cterm=none      guibg=#e4e4e4 guibg=&bg     gui=none
hi CursorLine        ctermbg=254 ctermbg=none cterm=none      guibg=#e4e4e4 guibg=&bg     gui=none
hi CursorLineNr      ctermfg=241 ctermbg=254  cterm=none      guifg=#626262 guibg=#e4e4e4 gui=none

hi Search            ctermfg=231 ctermbg=136  cterm=none      guifg=none guibg=none gui=inverse
hi IncSearch         ctermfg=231 ctermbg=204  cterm=none      guifg=#ffffff guibg=#000000 gui=none

hi DiffAdd           ctermfg=255 ctermbg=70   cterm=none      guifg=#eeeeee guibg=#5faf00 gui=none
hi DiffChange        ctermfg=255 ctermbg=88   cterm=none      guifg=#eeeeee guibg=#870000 gui=none
hi DiffText          ctermfg=255 ctermbg=162  cterm=bold      guifg=#eeeeee guibg=#d70087 gui=bold
hi DiffDelete        ctermfg=255 ctermbg=241  cterm=none      guifg=#eeeeee guibg=#626262 gui=none

hi SpellBad          ctermfg=197 ctermbg=231  cterm=underline guifg=#ff005f guibg=#ffffff gui=underline
hi SpellCap          ctermfg=167 ctermbg=231  cterm=underline guifg=#d75f5f guibg=#ffffff gui=underline
hi SpellRare         ctermfg=95  ctermbg=231  cterm=underline guifg=#875f5f guibg=#ffffff gui=underline
hi SpellLocal        ctermfg=94  ctermbg=231  cterm=underline guifg=#875f00 guibg=#ffffff gui=underline

hi SpecialKey        ctermfg=74  ctermbg=231  cterm=none      guifg=#5fafd7 guibg=#ffffff gui=none
hi NonText           ctermfg=246 ctermbg=231  cterm=none      guifg=#949494 guibg=#ffffff gui=none
hi Directory         ctermfg=104 ctermbg=231  cterm=none      guifg=#8787d7 guibg=#ffffff gui=none
hi Title             ctermfg=30  ctermbg=none cterm=none      guifg=#008787 guibg=&bg     gui=none
hi Conceal           ctermfg=103 ctermbg=231  cterm=none      guifg=#8787af guibg=#ffffff gui=none
hi Noise             ctermfg=243 ctermbg=231  cterm=none      guifg=#767676 guibg=#ffffff gui=none

hi vimFold           ctermfg=246 ctermbg=231  cterm=none      guifg=#949494 guibg=#ffffff gui=none
hi vimCommentTitle   ctermfg=241 ctermbg=231  cterm=none      guifg=#626262 guibg=#ffffff gui=none

hi diffFile          ctermfg=246 ctermbg=231  cterm=none      guifg=#949494 guibg=#ffffff gui=none
hi diffLine          ctermfg=241 ctermbg=231  cterm=none      guifg=#626262 guibg=#ffffff gui=none
hi diffAdded         ctermfg=28  ctermbg=231  cterm=none      guifg=#008700 guibg=#ffffff gui=none
hi diffRemoved       ctermfg=169 ctermbg=231  cterm=none      guifg=#d75faf guibg=#ffffff gui=none
hi diffChanged       ctermfg=136 ctermbg=231  cterm=none      guifg=#af8700 guibg=#ffffff gui=none
hi diffSubname       ctermfg=239 ctermbg=231  cterm=none      guifg=#4e4e4e guibg=#ffffff gui=none
hi diffOldLine       ctermfg=69  ctermbg=231  cterm=none      guifg=#5f87ff guibg=#ffffff gui=none

hi markdownCode      ctermfg=246 ctermbg=231  cterm=none      guifg=#949494 guibg=#ffffff gui=none
hi markdownCodeBlock ctermfg=246 ctermbg=231  cterm=none      guifg=#949494 guibg=#ffffff gui=none
hi markdownItalic    ctermfg=239 ctermbg=231  cterm=none      guifg=#4e4e4e guibg=#ffffff gui=none
