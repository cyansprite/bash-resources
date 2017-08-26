" {{{ Setup
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "chill"
"}}}

" {{{ Main
hi CursorLine   ctermbg=none ctermbg=none cterm=none
hi CursorLineNr ctermfg=107  ctermbg=none cterm=inverse,bold
hi LineNr       ctermfg=107  ctermbg=none cterm=none
hi MatchParen   ctermfg=none ctermbg=none cterm=bold,underline
hi Folded       ctermfg=109  ctermbg=none cterm=bold,inverse

hi Constant     ctermfg=59   ctermbg=none cterm=none
hi String       ctermfg=203  ctermbg=none cterm=none
hi SpecialChar  ctermfg=109  ctermbg=none cterm=none
hi ignore       ctermfg=109  ctermbg=none cterm=none
hi Character    ctermfg=201  ctermbg=none cterm=none
hi Number       ctermfg=143  ctermbg=none cterm=none
hi Float        ctermfg=106  ctermbg=none cterm=none
hi Boolean      ctermfg=142  ctermbg=none cterm=none
hi Identifier   ctermfg=40   ctermbg=none cterm=none
hi Function     ctermfg=107  ctermbg=none cterm=none

hi Statement    ctermfg=39   ctermbg=none cterm=bold
hi Conditional  ctermfg=177  ctermbg=none cterm=italic
hi Label        ctermfg=62   ctermbg=none cterm=none
hi Member       ctermfg=29   ctermbg=none cterm=none
hi Operator     ctermfg=51   ctermbg=none cterm=bold
hi Keyword      ctermfg=130  ctermbg=none cterm=none

hi PreProc      ctermfg=70   ctermbg=none cterm=italic

hi Type         ctermfg=30   ctermbg=none cterm=none
hi StorageClass ctermfg=105  ctermbg=none cterm=none
hi Structure    ctermfg=71   ctermbg=none cterm=none

hi Special      ctermfg=33   ctermbg=none cterm=none
hi Error        ctermfg=196  ctermbg=none  cterm=none
hi Todo         ctermfg=197  ctermbg=none cterm=bold
hi Whitespace   ctermfg=88   ctermbg=124  cterm=bold

hi VertSplit    ctermfg=222  ctermbg=none cterm=bold,inverse

hi Pmenu        ctermfg=224  ctermbg=232  cterm=inverse
hi PmenuSel     ctermfg=224  ctermbg=232  cterm=bold
hi PmenuSbar    ctermfg=none ctermbg=241  cterm=none
hi PmenuThumb   ctermfg=0    ctermbg=224  cterm=none
hi WildMenu     ctermfg=236  ctermbg=201  cterm=bold

hi ErrorMsg     ctermfg=160  ctermbg=none cterm=inverse,bold
hi WarningMsg   ctermfg=184  ctermbg=none cterm=inverse,bold
hi MoreMsg      ctermfg=113  ctermbg=none cterm=inverse,bold
hi ModeMsg      ctermfg=57   ctermbg=none cterm=bold
hi Question     ctermfg=130  ctermbg=none cterm=inverse,bold

hi Title        ctermfg=200  ctermbg=none cterm=bold

hi Search       ctermfg=none ctermbg=none cterm=bold,inverse

hi DiffAdd      ctermfg=232  ctermbg=40   cterm=bold
hi DiffChange   ctermfg=27   ctermbg=250  cterm=none
hi DiffText     ctermfg=161  ctermbg=250  cterm=bold
hi DiffDelete   ctermfg=231  ctermbg=196  cterm=bold

hi SpecialKey   ctermfg=139  ctermbg=none cterm=none
hi NonText      ctermfg=139  ctermbg=none cterm=none
hi Directory    ctermfg=148  ctermbg=none cterm=none
" }}}

" Light dark differences {{{
if &bg == 'light'
    hi ColorColumn  ctermbg=none ctermbg=231  cterm=none
    hi Visual       ctermfg=none ctermbg=231  cterm=bold
    hi IncSearch    ctermfg=none  ctermbg=232 cterm=none,bold
    hi Comment      ctermfg=249  ctermbg=none cterm=italic
    hi StatusLineNC ctermfg=249  ctermbg=none cterm=italic
    hi StatusLine   ctermfg=232  ctermbg=231  cterm=none
    hi Normal       ctermfg=240  ctermbg=none cterm=none
    hi LineNr       ctermfg=107  ctermbg=231  cterm=none
else
    hi ColorColumn  ctermbg=none ctermbg=232  cterm=none
    hi Visual       ctermfg=none ctermbg=232  cterm=bold
    hi IncSearch    ctermfg=none ctermbg=231  cterm=none
    hi Comment      ctermfg=240  ctermbg=none cterm=italic
    hi Normal       ctermfg=249  ctermbg=none cterm=none
    hi LineNr       ctermfg=107  ctermbg=232  cterm=none
    hi StatusLineNC ctermfg=240  ctermbg=none cterm=italic
    hi StatusLine   ctermfg=231  ctermbg=232  cterm=none
endif
" }}}

" Plugins {{{
hi link cCustomClass  Keyword
hi link cCustomMemVar Member
" }}}
