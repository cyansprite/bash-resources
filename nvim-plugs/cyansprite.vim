"Vim Colorscheme file
"init
syntax reset
let colors_name = "cyansprite"

hi cursor       guifg=#ffffff
hi String       guifg=#afffff gui=none
hi cursorline   guibg=#666666 gui=none
hi statusline   guifg=#444444 guibg=#889999 gui=none
hi statuslinenc guifg=#444444 guibg=#889999 gui=inverse
hi pmenu        guifg=#444444 guibg=#889999 gui=none
hi endofbuffer  guifg=#444444 guibg=#333333 gui=underline,bold
hi number       guifg=#dfdf8f gui=none
hi type         guifg=#ff7f7f gui=none
hi comment      guifg=#8fafaf gui=italic
hi linenr       guifg=#aaaaaa gui=none
hi cursorlinenr guifg=#afffff gui=bold
hi keyword      guifg=#ffaf4f gui=none
hi special      guifg=#afafff gui=none
hi directory    guifg=#8fafff gui=none
hi statement    guifg=#aaff8f gui=none
hi preproc      guifg=#aaaaaa gui=none
hi visual       guibg=#888888 gui=bold
hi search       guifg=#000000 guibg=#aaaaaa gui=none
hi identifier   guifg=#aaffaa gui=none
hi function     guifg=#ffccca gui=none
hi warningmsg   guifg=#bfbfcf gui=none
hi specialkey   guifg=#fafa0f gui=none
hi nontext      guifg=#000000 gui=none
hi wildmenu     guifg=#0fffff guibg=#888888 gui=bold
hi pmenusel     guifg=#0fffff guibg=#888888 gui=bold
hi diffadd      guifg=#88ff88 guibg=none gui=none
hi diffchange   guifg=#f8bf88 guibg=none gui=none
hi diffdelete   guifg=#f88888 guibg=none gui=none
hi matchparen   guifg=none    guibg=#666666 gui=underline,bold
hi vertsplit    guifg=#afffff guibg=none gui=bold
hi Title        guifg=#0000aa gui=italic,bold

hi link vimMap string
hi link vimAutoEvent function
