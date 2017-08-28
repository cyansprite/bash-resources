" {{{ Setup
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "chill"
"}}}

" {{{ Main
hi CursorLine   ctermbg=none ctermbg=none cterm=none
hi CursorLineNr ctermfg=116  ctermbg=none cterm=inverse,bold
hi MatchParen   ctermfg=none ctermbg=none cterm=bold,underline
hi Folded       ctermfg=147  ctermbg=none cterm=bold

hi Constant     ctermfg=130  ctermbg=none cterm=none
hi String       ctermfg=203  ctermbg=none cterm=none
hi SpecialChar  ctermfg=109  ctermbg=none cterm=none
hi ignore       ctermfg=109  ctermbg=none cterm=none
hi Character    ctermfg=201  ctermbg=none cterm=none
hi Number       ctermfg=142  ctermbg=none cterm=none
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

hi PreProc      ctermfg=156   ctermbg=none cterm=italic

hi Type         ctermfg=30   ctermbg=none cterm=none
hi StorageClass ctermfg=105  ctermbg=none cterm=none
hi Structure    ctermfg=71   ctermbg=none cterm=none

hi Special      ctermfg=33   ctermbg=none cterm=none
hi Error        ctermfg=196  ctermbg=none  cterm=none
hi Todo         ctermfg=197  ctermbg=none cterm=bold
hi Whitespace   ctermfg=88   ctermbg=124  cterm=bold

hi VertSplit    ctermfg=112  ctermbg=none cterm=bold

hi Pmenu        ctermfg=219  ctermbg=232  cterm=inverse
hi PmenuSel     ctermfg=219  ctermbg=232  cterm=bold
hi PmenuSbar    ctermfg=none ctermbg=241  cterm=none
hi PmenuThumb   ctermfg=0    ctermbg=219  cterm=none

hi ErrorMsg     ctermfg=160  ctermbg=none cterm=inverse,bold
hi WarningMsg   ctermfg=184  ctermbg=none cterm=inverse,bold
hi MoreMsg      ctermfg=113  ctermbg=none cterm=inverse,bold
hi ModeMsg      ctermfg=203  ctermbg=none cterm=bold
hi Question     ctermfg=063  ctermbg=none cterm=inverse,bold
hi Title        ctermfg=200  ctermbg=none cterm=bold

hi Search       ctermfg=none ctermbg=none cterm=bold,inverse

hi SpecialKey   ctermfg=55  ctermbg=none cterm=none
hi NonText      ctermfg=55  ctermbg=none cterm=none
hi Directory    ctermfg=148  ctermbg=none cterm=none
" }}}

" Light dark differences {{{
if &bg == 'light'
    hi ColorColumn  ctermbg=none ctermbg=231  cterm=none
    hi Visual       ctermfg=none ctermbg=250  cterm=bold
    hi IncSearch    ctermfg=none  ctermbg=232 cterm=none,bold
    hi Comment      ctermfg=249  ctermbg=none cterm=italic
    hi Normal       ctermfg=240  ctermbg=none cterm=none
    hi LineNr       ctermfg=108  ctermbg=250  cterm=none
    hi WildMenu     ctermfg=250  ctermbg=143  cterm=bold
    hi StatusLine   ctermfg=143  ctermbg=250  cterm=none
    hi StatusLineNC ctermfg=249  ctermbg=none cterm=italic

    hi DiffAdd      ctermfg=232  ctermbg=40   cterm=bold
    hi DiffChange   ctermfg=none ctermbg=232  cterm=none
    hi DiffText     ctermfg=none ctermbg=250  cterm=bold
    hi DiffDelete   ctermfg=232  ctermbg=196  cterm=bold
    hi EndOfBuffer  ctermfg=218  ctermbg=255  cterm=bold
else
    hi ColorColumn  ctermbg=none ctermbg=232  cterm=none
    hi Visual       ctermfg=none ctermbg=239  cterm=bold
    hi IncSearch    ctermfg=none ctermbg=231  cterm=none
    hi Comment      ctermfg=240  ctermbg=none cterm=italic
    hi Normal       ctermfg=249  ctermbg=none cterm=none
    hi LineNr       ctermfg=108  ctermbg=237  cterm=none
    hi WildMenu     ctermfg=237  ctermbg=143  cterm=bold
    hi StatusLine   ctermfg=143  ctermbg=237  cterm=none
    hi StatusLineNC ctermfg=240  ctermbg=none cterm=italic

    hi DiffAdd      ctermfg=231  ctermbg=40   cterm=bold
    hi DiffChange   ctermfg=none ctermbg=231  cterm=none
    hi DiffText     ctermfg=none ctermbg=237  cterm=bold
    hi DiffDelete   ctermfg=231  ctermbg=196  cterm=bold
    hi EndOfBuffer  ctermfg=218  ctermbg=234  cterm=bold
endif
" }}}

" Plugins {{{
hi link cCustomClass  Keyword
hi link cCustomMemVar Member
" }}}

" Vim Relink... Sometimes I think devs were like, random links!! {{{
hi link vimCommentTitle Title
hi link vimIsCommand Constant
" }}}
