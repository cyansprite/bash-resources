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
hi comment      guifg=#784f28 guibg=none    gui=none
hi todo         guifg=bg      guibg=#87afc7 gui=bold
hi visual       guifg=none    guibg=#666666 gui=none
hi search       guifg=none    guibg=none    gui=inverse
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
hi diffchange   guifg=#88aaff guibg=none    gui=inverse
hi diffdelete   guifg=#ff88aa guibg=none    gui=inverse
hi diffdelete   guifg=#ff5555 guibg=none    gui=inverse
hi difftext     guifg=#fffcaa guibg=none    gui=inverse
hi signcolumn   guifg=#ffffff guibg=none    gui=none
hi endofbuffer  guifg=#555555 guifg=none    gui=none
hi vertsplit    guifg=#ccddff guibg=none    gui=none
hi matchparen   guifg=#ffffff guibg=none    gui=underline,bold
hi folded         guifg=bg      guibg=#999998 gui=none
set colorcolumn=130
hi colorcolumn  guifg=none    guibg=#443834 gui=none
hi cursorlinenr guifg=#acaafc guibg=none    gui=bold
hi cursorline   guifg=none    guibg=#334443 gui=none
hi nontext      guifg=#88cccc guibg=none    gui=none

hi link ycmwarningsign difftext
let g:bufferline_active_highlight = 'WildMenu'

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
