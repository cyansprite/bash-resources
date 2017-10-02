" Setup {{{
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "chill"
"}}}

" Nons:   -{{{1
hi Normal       ctermfg=none ctermbg=none cterm=none
hi MatchParen   ctermfg=none ctermbg=none cterm=bold,underline
hi Folded       ctermfg=none ctermbg=none cterm=bold
hi EndOfBuffer  ctermfg=none ctermbg=none cterm=none
hi ModeMsg      ctermfg=none ctermbg=none cterm=inverse,bold
hi CursorLineNr ctermfg=none ctermbg=none cterm=inverse

" Red:    1{{{1
hi String       ctermfg=1    ctermbg=none cterm=none
hi Boolean      ctermfg=1    ctermbg=none cterm=none

hi Keyword      ctermfg=9    ctermbg=none cterm=none
hi Character    ctermfg=9    ctermbg=none cterm=none

hi Error        ctermfg=7    ctermbg=9    cterm=bold
hi ErrorMsg     ctermfg=7    ctermbg=9    cterm=bold
hi Whitespace   ctermfg=7    ctermbg=9    cterm=bold
hi DiffDelete   ctermfg=7    ctermbg=9    cterm=bold

" Green:  2{{{1
hi StorageClass ctermfg=2    ctermbg=none cterm=none
hi Structure    ctermfg=2    ctermbg=none cterm=none
hi Typedef      ctermfg=2    ctermbg=none cterm=none

hi Type         ctermfg=10   ctermbg=none cterm=none
hi MoreMsg      ctermfg=10   ctermbg=none cterm=inverse,bold
hi DiffAdd      ctermfg=15   ctermbg=10   cterm=bold

" Yellow: 3{{{1
hi PreCondit    ctermfg=3    ctermbg=none cterm=none
hi Structure    ctermfg=3    ctermbg=none cterm=none
hi TypeDef      ctermfg=3    ctermbg=none cterm=none

hi StorageClass ctermfg=11   ctermbg=none cterm=none
hi Directory    ctermfg=11   ctermbg=none cterm=none
hi Todo         ctermfg=11   ctermbg=none cterm=bold

hi WarningMsg   ctermfg=3    ctermbg=none cterm=inverse,bold


" Blue:   4{{{1
hi NonText      ctermfg=4    ctermbg=none cterm=none
hi Special      ctermfg=4    ctermbg=none cterm=none
hi SpecialChar  ctermfg=4    ctermbg=none cterm=none
hi SpecialKey   ctermfg=4    ctermbg=none cterm=none
hi Label        ctermfg=12   ctermbg=none cterm=none
hi Identifier   ctermfg=12   ctermbg=none cterm=none

" Purple: 5{{{1
hi Delimeter    ctermfg=5    ctermbg=none cterm=none
hi Constant     ctermfg=5    ctermbg=none cterm=none
hi Number       ctermfg=5    ctermbg=none cterm=none
hi Statement    ctermfg=5    ctermbg=none cterm=none
hi Conditional  ctermfg=5    ctermbg=none cterm=none

hi Repeat       ctermfg=13   ctermbg=none cterm=none
hi Float        ctermfg=13   ctermbg=none cterm=none
hi Title        ctermfg=13   ctermbg=none cterm=bold

hi Question     ctermfg=13   ctermbg=none cterm=inverse,bold

" Cyan:   6{{{1
hi Member       ctermfg=6    ctermbg=none cterm=none
hi function     ctermfg=6    ctermbg=none cterm=none
hi PmenuThumb   ctermfg=none ctermbg=6    cterm=none
hi Function     ctermfg=6    ctermbg=none cterm=none
hi DiffText     ctermfg=7    ctermbg=14   cterm=bold

" Grey:   7{{{1
hi LineNr       ctermfg=7    ctermbg=none cterm=none
hi ignore       ctermfg=7    ctermbg=none cterm=italic
hi PreProc      ctermfg=7    ctermbg=none cterm=none
hi Class        ctermfg=7    ctermbg=none cterm=none
hi Operator     ctermfg=7    ctermbg=none cterm=bold

" Black:  0{{{1
hi VertSplit    ctermfg=0    ctermbg=none cterm=none
hi StatusLineNC ctermfg=8    ctermbg=232  cterm=none
hi Comment      ctermfg=8    ctermbg=none cterm=italic
hi Search       ctermfg=15   ctermbg=8    cterm=bold

" 256 colors need converting FIXME {{{1
" Grey
hi StatusLine   ctermfg=none ctermbg=233  cterm=none
hi Pmenu        ctermfg=none ctermbg=234  cterm=none
hi CursorLine   ctermfg=none ctermbg=235  cterm=none
hi PmenuSbar    ctermfg=none ctermbg=236  cterm=none
hi ColorColumn  ctermbg=none ctermbg=236  cterm=none
hi DiffChange   ctermfg=236  ctermbg=none cterm=inverse,bold
hi Visual       ctermfg=none ctermbg=237  cterm=bold
hi PmenuSel     ctermfg=none ctermbg=237  cterm=bold
hi IncSearch    ctermfg=none ctermbg=237  cterm=underline,bold
hi WildMenu     ctermfg=none ctermbg=238  cterm=bold


" User {{{1
hi User1        ctermfg=2    ctermbg=none cterm=bold
hi User2        ctermfg=1    ctermbg=none cterm=bold
hi User3        ctermfg=5    ctermbg=none cterm=bold
hi User5        ctermfg=7    ctermbg=none cterm=bold
hi User4        ctermfg=none ctermbg=0    cterm=none
" }}}1

" Vim Relink {{{
hi link vimCommentTitle Title
hi link vimIsCommand Constant
hi link vimHighlight Member
hi link diffAdded   DiffAdd
hi link diffRemoved DiffDelete
hi link QuickFixLine ModeMsg
" }}}

" Special {{{1
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif
