" {{{ Setup
set termguicolors
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "chill"
"}}}

" {{{ Main
hi Normal        guifg=fg      guibg=bg
hi CursorLine    guifg=none    guibg=#1f1f3f
hi CursorLineNr  ctermfg=156   ctermbg=none  cterm=bold
hi MatchParen    ctermfg=none  ctermbg=none  cterm=bold,underline
hi Folded        ctermfg=147   ctermbg=none  cterm=bold

" Bold, i.e. not modifiable
hi Boolean       ctermfg=142   ctermbg=none  cterm=bold
hi Statement     ctermfg=200   ctermbg=none  cterm=bold
hi Conditional   ctermfg=177   ctermbg=none  cterm=bold
hi Repeat        ctermfg=177   ctermbg=none  cterm=bold,italic
hi Label         ctermfg=30    ctermbg=none  cterm=bold
hi Type          ctermfg=11    ctermbg=none  cterm=bold
hi StorageClass  ctermfg=197   ctermbg=none  cterm=bold
hi Structure     ctermfg=95    ctermbg=none  cterm=bold
hi Operator      ctermfg=60    ctermbg=none  cterm=bold
hi Keyword       ctermfg=75    ctermbg=none  cterm=bold

" We specify these things
hi Member        ctermfg=87    ctermbg=none  cterm=none
hi Class         ctermfg=38    ctermbg=none  cterm=none
hi PreProc       ctermfg=156   ctermbg=none  cterm=none
hi Constant      ctermfg=126   ctermbg=none  cterm=none
hi String        ctermfg=217   ctermbg=none  cterm=none
hi SpecialChar   ctermfg=77    ctermbg=none  cterm=none
hi Character     ctermfg=203   ctermbg=none  cterm=none
hi Number        ctermfg=77    ctermbg=none  cterm=none
hi Float         ctermfg=106   ctermbg=none  cterm=none
hi Identifier    ctermfg=40    ctermbg=none  cterm=none
hi Function      ctermfg=66    ctermbg=none  cterm=none

" Weird
hi SpecialKey    ctermfg=33    ctermbg=none  cterm=none
hi NonText       ctermfg=55    ctermbg=none  cterm=none
hi ignore        ctermfg=109   ctermbg=none  cterm=none

" Interface
hi Special       ctermfg=29    ctermbg=none  cterm=none
hi Error         ctermfg=196   ctermbg=none  cterm=none
hi Todo          ctermfg=197   ctermbg=none  cterm=bold
hi Whitespace    ctermfg=197   ctermbg=none  cterm=bold,underline
hi VertSplit     ctermfg=197   ctermbg=none  cterm=bold

" This is thanks to urxvt, if you don't have it, I would change this :)
hi Pmenu         ctermfg=none  ctermbg=0     cterm=none
hi PmenuSel      ctermfg=none  ctermbg=235   cterm=bold
hi PmenuSbar     ctermfg=none  ctermbg=235   cterm=none
hi PmenuThumb    ctermfg=none  ctermbg=13    cterm=none

hi ErrorMsg      ctermfg=160   ctermbg=none  cterm=inverse,bold
hi WarningMsg    ctermfg=184   ctermbg=none  cterm=inverse,bold
hi MoreMsg       ctermfg=113   ctermbg=none  cterm=inverse,bold
hi ModeMsg       ctermfg=147   ctermbg=none  cterm=bold
hi Question      ctermfg=063   ctermbg=none  cterm=inverse,bold
hi Search        ctermfg=none  ctermbg=0     cterm=inverse,bold

" Terminal {{{1
hi Title         ctermfg=13    ctermbg=none  cterm=bold
hi Directory     ctermfg=11    ctermbg=none  cterm=none
hi Delimiter     ctermfg=24    ctermbg=none  cterm=none
hi Visual        ctermfg=none  ctermbg=16     cterm=bold

" Dark {{{1
hi ColorColumn   ctermbg=none  ctermbg=0     cterm=none
hi IncSearch     ctermfg=none  ctermbg=none  cterm=inverse
hi Comment       ctermfg=240   ctermbg=none  cterm=italic
hi LineNr        ctermfg=65    ctermbg=0     cterm=none

hi WildMenu      ctermfg=237   ctermbg=143   cterm=bold
hi StatusLine    ctermfg=143   ctermbg=237   cterm=none
hi StatusLineNC  ctermfg=255   ctermbg=232   cterm=none
hi User1         ctermfg=46    ctermbg=none  cterm=bold
hi User2         ctermfg=196   ctermbg=none  cterm=bold
hi User3         ctermfg=63    ctermbg=none  cterm=bold
hi User5         ctermfg=59    ctermbg=none  cterm=bold
hi User4         ctermfg=none  ctermbg=0     cterm=none

" hi TabLineSel   ctermfg=132  ctermbg=0   cterm=bold,inverse
" hi TabLine      ctermfg=132  ctermbg=none cterm=none
" hi TabLineFill  ctermfg=none ctermbg=none cterm=none

hi DiffAdd       ctermfg=231   ctermbg=28    cterm=bold
hi DiffText      ctermfg=231   ctermbg=32    cterm=bold
hi DiffChange    ctermfg=none  ctermbg=237   cterm=none
hi DiffDelete    ctermfg=231   ctermbg=196   cterm=bold
hi EndOfBuffer   ctermfg=65    ctermbg=0     cterm=bold

hi link diffAdded DiffAdd
hi link diffRemoved DiffDelete


" }}}1

" Vim Relink... Sometimes I think devs were like, random links!! {{{
hi link vimCommentTitle Title
hi link vimIsCommand Constant
hi link vimHighlight Member
" }}}
