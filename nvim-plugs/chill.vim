" Vim Color File
" Name:       chill.vim
" Version:    0.01
" Maintainer: Jojo
" License:    The MIT License (MIT)
" Based On:   Me

" +----------------+ | Magic Happens Here | +----------------+

set background=dark

highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name="chill"

hi normal       guifg=#afaabb guibg=#1f2828 gui=none
hi title        guifg=#dd66dd guibg=none    gui=bold
hi directory    guifg=#aaaa33 guibg=none    gui=none
hi comment      guifg=#c46f28 guibg=none    gui=none
hi todo         guifg=bg      guibg=#87afc7 gui=bold
hi visual       guifg=none    guibg=#666666 gui=none
hi search       guifg=none    guibg=none    gui=inverse,underline,bold
hi incsearch    guifg=#ffffff guibg=#000000 gui=inverse
hi identifier   guifg=#cccdff guibg=none    gui=none
hi type         guifg=#77cccf guibg=none    gui=none
hi structure    guifg=#aff6af guibg=none    gui=none
hi constant     guifg=#f9f922 guibg=none    gui=none
hi preproc      guifg=#ff88a8 guibg=none    gui=none
hi special      guifg=#caffff guibg=none    gui=none
hi statement    guifg=#9cfd6c guibg=none    gui=none
hi number       guifg=#ffcfa8 guibg=none    gui=none
hi linenr       guifg=#7c8f7c guibg=none    gui=none
hi cursor       guifg=none    guibg=none    gui=underline
hi conditional  guifg=#ac80fa guibg=none    gui=none
hi csRepeat     guifg=#c699cc guibg=none    gui=none
hi string       guifg=#dddd88 guibg=none    gui=none
hi function     guifg=#fa6d57 guibg=none    gui=none
hi whitespace   guifg=#ff44f4 guibg=#443363 gui=bold
hi pmenu        guifg=#acbfac guibg=#444844 gui=none
hi statusline   guifg=#acbfac guibg=#444844 gui=none
hi statuslineNC guifg=#777777 guibg=none    gui=none
hi pmenusel     guifg=#acaafc guibg=#444844 gui=bold,inverse
hi wildmenu     guifg=#acaafc guibg=#444844 gui=bold,inverse
hi diffadd      guifg=#aaff88 guibg=none    gui=inverse
hi diffadded      guifg=#aaff88 guibg=none    gui=inverse
hi diffchange   guifg=#88aaff guibg=none    gui=inverse
hi diffdelete   guifg=#ff5555 guibg=none    gui=inverse
hi difftext     guifg=#fffcaa guibg=none    gui=inverse
hi diffremoved   guifg=#ff5555 guibg=none    gui=inverse
hi signcolumn   guifg=#ffffff guibg=none    gui=none
hi endofbuffer  guifg=#555555 guifg=none    gui=none
hi vertsplit    guifg=#ccddff guibg=none    gui=none
hi matchparen   guifg=#ffffff guibg=none    gui=underline,bold
hi folded       guifg=#446664 guibg=#223334 gui=inverse,bold,underline
" let &colorcolumn="80,".join(range(120,400),",")
set cc=80,130
hi colorcolumn  guifg=none    guibg=#683434 gui=none
hi cursorlinenr guifg=#acaafc guibg=#283434 gui=bold
hi cursorline   guifg=none    guibg=#283434 gui=none
hi nontext      guifg=#88cccc guibg=none    gui=none

hi Tagbarhighlight guifg=#dcbc88 guibg=#444455 gui=none

hi esearchFName guifg=#a0ff40 guibg=none gui=bold,underline
hi esearchMatch guifg=none    guibg=#204f10

hi link ycmwarningsign difftext
let g:bufferline_active_highlight = 'WildMenu'
let g:esearch#out#win#context_syntax_highlight = 1

hi link vimoper special
hi link csString string
hi link csModifier preproc
hi link CTagsField identifier
hi link CTagsEnumerationName constant
hi link CTagsMember string
hi link CTagsStructure structure
hi link CTagsProperty statement
hi link CTagsMethod function
hi link CTagsClass special
hi link CTagsEnumerationValue preproc
hi link NERDTreeCWD constant
hi link NERDTreeHelp comment
hi link NerdTreeFile special

"matching
"match comment /\%>80v./
