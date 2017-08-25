hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="chill"

" Main
hi Normal         ctermfg=247  ctermbg=none cterm=none
hi Comment        ctermfg=241  ctermbg=none cterm=none

hi CursorLine     ctermbg=232  ctermbg=none cterm=none
hi CursorLineNr   ctermfg=107  ctermbg=none cterm=inverse
hi LineNr         ctermfg=107  ctermbg=none cterm=none
hi ColorColumn    ctermbg=none ctermbg=167   cterm=none
hi MatchParen     ctermfg=none ctermbg=47   cterm=bold,underline
hi Folded         ctermfg=32   ctermbg=none cterm=bold,inverse

hi Constant       ctermfg=142  ctermbg=none cterm=none
hi String         ctermfg=110  ctermbg=none cterm=none
hi Character      ctermfg=36   ctermbg=none cterm=none
hi Number         ctermfg=161  ctermbg=none cterm=none
hi Float          ctermfg=165  ctermbg=none cterm=none
hi Boolean        ctermfg=98   ctermbg=none cterm=none

hi Identifier     ctermfg=34   ctermbg=none cterm=none
hi Function       ctermfg=214  ctermbg=none cterm=none

hi Statement      ctermfg=33   ctermbg=none cterm=none
hi Conditional    ctermfg=90   ctermbg=none cterm=none
hi Label          ctermfg=62   ctermbg=none cterm=none
hi Operator       ctermfg=131  ctermbg=none cterm=none
hi Keyword        ctermfg=57   ctermbg=none cterm=none

hi PreProc        ctermfg=58   ctermbg=none cterm=none

hi Type           ctermfg=30   ctermbg=none cterm=none
hi StorageClass   ctermfg=103  ctermbg=none cterm=none
hi Structure      ctermfg=65   ctermbg=none cterm=none

hi Special        ctermfg=167  ctermbg=none cterm=none
hi SpecialChar    ctermfg=167  ctermbg=none cterm=none
hi Tag            ctermfg=167  ctermbg=none cterm=none
hi Delimiter      ctermfg=167  ctermbg=none cterm=none
hi SpecialComment ctermfg=167  ctermbg=none cterm=none
hi Debug          ctermfg=167  ctermbg=none cterm=none
hi Underlined     ctermfg=241  ctermbg=none cterm=underline
hi Error          ctermfg=196  ctermbg=232  cterm=none
hi Todo           ctermfg=100  ctermbg=none cterm=bold
hi Whitespace     ctermfg=none ctermbg=124  cterm=bold

hi StatusLine     ctermfg=none ctermbg=none cterm=none
hi StatusLineNC   ctermfg=241  ctermbg=none cterm=none
hi VertSplit      ctermfg=90   ctermbg=none cterm=bold

hi Pmenu          ctermfg=0    ctermbg=107  cterm=none
hi PmenuSel       ctermfg=0    ctermbg=107  cterm=inverse,bold
hi PmenuSbar      ctermfg=none ctermbg=241  cterm=none
hi PmenuThumb     ctermfg=0    ctermbg=127  cterm=none
hi WildMenu       ctermfg=236  ctermbg=40   cterm=bold

hi Visual         ctermfg=none ctermbg=8    cterm=bold

hi ErrorMsg       ctermfg=160  ctermbg=none cterm=inverse,bold
hi WarningMsg     ctermfg=184  ctermbg=none cterm=inverse,bold
hi MoreMsg        ctermfg=113  ctermbg=none cterm=inverse,bold
hi ModeMsg        ctermfg=57   ctermbg=none cterm=bold
hi Question       ctermfg=130  ctermbg=none cterm=inverse,bold

hi Title          ctermfg=200  ctermbg=none cterm=bold

hi Search         ctermfg=none ctermbg=none cterm=bold,inverse
hi IncSearch      ctermfg=231  ctermbg=232  cterm=none

hi DiffAdd        ctermfg=232  ctermbg=40   cterm=bold
hi DiffChange     ctermfg=27   ctermbg=250  cterm=none
hi DiffText       ctermfg=161  ctermbg=250  cterm=bold
hi DiffDelete     ctermfg=231  ctermbg=196  cterm=bold

hi SpecialKey     ctermfg=139  ctermbg=none cterm=none
hi NonText        ctermfg=139  ctermbg=none cterm=none
hi Directory      ctermfg=148  ctermbg=none cterm=none
