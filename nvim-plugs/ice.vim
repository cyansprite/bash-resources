" Vim color file
" Remove all existing highlighting and set the defaults.
" The goal is to NOT use any terminal defaults
set background=light
hi clear Normal
hi clear SpecialKey
hi clear
syntax reset

let colors_name = "ice"
syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"

hi Normal        ctermfg=black ctermbg=231 cterm=NONE

hi Cursor        ctermfg=NONE ctermbg=NONE cterm=standout
hi visual        ctermfg=NONE ctermbg=195  cterm=NONE
hi IncSearch     ctermfg=NONE ctermbg=NONE cterm=underline
hi Search        ctermfg=NONE ctermbg=222  cterm=underline
hi MatchParen    ctermfg=NONE ctermbg=NONE cterm=underline,bold

hi CursorLineNr  ctermfg=NONE ctermbg=NONE cterm=italic
hi LineNr        ctermfg=NONE ctermbg=NONE  cterm=NONE
hi FoldColumn    ctermfg=NONE ctermbg=255  cterm=NONE
hi Title         ctermfg=29   ctermbg=255  cterm=NONE
hi DiffAdd       ctermfg=34   ctermbg=NONE cterm=NONE
hi DiffDelete    ctermfg=160  ctermbg=NONE cterm=NONE
hi DiffChange    ctermfg=208  ctermbg=NONE cterm=NONE
hi DiffText      ctermfg=81   ctermbg=NONE cterm=NONE
hi SignColumn    ctermfg=NONE ctermbg=NONE cterm=bold
hi Folded        ctermfg=NONE ctermbg=250  cterm=underline
hi StatusLine    ctermfg=87   ctermbg=235  cterm=NONE
hi StatusLineNC  ctermfg=81   ctermbg=240  cterm=NONE
hi WildMenu      ctermfg=81   ctermbg=240  cterm=bold,underline
hi PmenuSel      ctermfg=87   ctermbg=235  cterm=none
hi Pmenu         ctermfg=81   ctermbg=240  cterm=NONE
hi Directory     ctermfg=75   ctermbg=NONE cterm=NONE

hi VertSplit     ctermfg=81   ctermbg=None  cterm=NONE
hi link EndOfBuffer Pmenu

hi Comment       ctermfg=250  ctermbg=NONE cterm=italic
hi Todo          ctermfg=250  ctermbg=NONE cterm=bold,inverse

hi Boolean       ctermfg=197 ctermbg=NONE cterm=NONE
hi Conditional   ctermfg=103 ctermbg=NONE cterm=bold
hi Constant      ctermfg=106 ctermbg=NONE cterm=bold
hi Character     ctermfg=22  ctermbg=NONE cterm=NONE
hi Function      ctermfg=216 ctermbg=NONE cterm=NONE
hi Identifier    ctermfg=30 ctermbg=NONE cterm=NONE
hi Label         ctermfg=12  ctermbg=NONE cterm=NONE
hi Number        ctermfg=171 ctermbg=NONE cterm=NONE
hi Keyword       ctermfg=81  ctermbg=NONE cterm=NONE
hi Macro         ctermfg=196 ctermbg=NONE cterm=NONE
hi PreProc       ctermfg=69  ctermbg=NONE cterm=NONE
hi Special       ctermfg=89  ctermbg=NONE cterm=NONE
hi Statement     ctermfg=197  ctermbg=NONE cterm=NONE
hi StorageClass  ctermfg=6   ctermbg=NONE cterm=NONE
hi String        ctermfg=97  ctermbg=NONE cterm=NONE
hi Type          ctermfg=113 ctermbg=NONE cterm=NONE

hi OperatorChars ctermfg=232  ctermbg = NONE cterm = bold
hi Operator      ctermfg=232  ctermbg = NONE cterm = bold
hi link vimHiKeyList Operator

hi Error      ctermfg=240  ctermbg=203 cterm=inverse
hi ErrorMsg   ctermfg=240  ctermbg=203 cterm=inverse
hi WarningMsg ctermfg=240  ctermbg=227 cterm=inverse
hi ModeMsg    ctermfg=240  ctermbg=81  cterm=inverse
hi MoreMsg    ctermfg=240  ctermbg=108 cterm=inverse
hi Ignore     ctermfg=240  ctermbg=108 cterm=inverse
hi Question   ctermfg=240  ctermbg=108 cterm=inverse
hi Tag        ctermfg=240  ctermbg=108 cterm=inverse

hi SpecialKey    ctermfg=189  ctermbg=NONE cterm=NONE
hi NonText       ctermfg=189  ctermbg=NONE cterm=NONE

"TODO Do these lol
hi SpellCap      ctermfg=NONE ctermbg=255  cterm=NONE
hi Define        ctermfg=197  ctermbg=NONE cterm=NONE

"Differences when switching between modes
"autocmd InsertEnter * highlight CursorLine   ctermfg=NONE ctermbg=8
"autocmd InsertLeave * highlight CursorLine   ctermfg=NONE ctermbg=7
"autocmd InsertEnter * highlight CursorLineNr ctermfg=NONE ctermbg=8
"autocmd InsertLeave * highlight CursorLineNr ctermfg=NONE ctermbg=7
"autocmd InsertEnter * highlight LineNr ctermfg=NONE ctermbg=8
"autocmd InsertLeave * highlight LineNr ctermfg=NONE ctermbg=235
"
""Plugins
"highlight link GitGutterAdd DiffAdd
"highlight link GitGutterChange DiffChange
"highlight link GitGutterDelete DiffDelete
"highlight BookmarkSign           ctermbg=NONE ctermfg=38
"highlight BookmarkLine           ctermbg=227  ctermfg=NONE
"highlight BookmarkAnnotationSign ctermbg=NONE ctermfg=0
"highlight BookmarkAnnotationLine ctermbg=188  ctermfg=NONE
"
"hi link CtrlSpaceSearch IncSearch
"hi Conceal       ctermfg=15   ctermbg=NONE cterm=italic
"hi CursorLine    ctermfg=NONE ctermbg=NONE cterm=NONE
"hi cursorcolumn  ctermfg=NONE ctermbg=NONE cterm=NONE
"hi colorcolumn   ctermfg=NONE ctermbg=NONE cterm=NONE
"hi Float         ctermfg=76  ctermbg=NONE cterm=NONE
