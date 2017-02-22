map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"plugin pathogen stuf
execute pathogen#infect()
" activates filetype detection
filetype plugin indent on

" activates syntax highlighting among other things
syntax on
set hidden

" change cursor to i-beam in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

"list me tabs
set listchars=tab:>-
set list
set splitbelow
set splitright

"I like numbers, relative and cursor line sometimes
set relativenumber
set number
set cursorline

"always have that tabline :)
set laststatus=2

"Keymaps
"map enter to insert cr and exit insert below, and shift enter for above
nmap <CR> o<Esc>
"map ctrl + D to clipboard
map <C-D> "+
"I use ctrl+c instead of escape...idk why
inoremap  
"Undo tree toggle! and assuming persistant undo!
nnoremap <F5> :UndotreeToggle<cr>

set t_Co=256
colorscheme snow

"Rainbow Para
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"ctags
set tags=./tags;
let g:easytags_dynamic_files = 2
let g:easytags_events = ['BufWritePost']
let g:easytags_auto_update = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Airline stuff"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

let g:OmniSharp_selector_ui = 'ctrlp'
set completeopt=longest,menuone,preview
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
augroup omnisharp_commands
	autocmd!
	autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
	autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
	autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
	autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
	autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
	autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	"finds members in the current buffer
	autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
	" cursor can be anywhere on the line containing an issue
	autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
	autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
	autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
	autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
	"navigate up by method/property/field
	autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
	"navigate down by method/property/field
	autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>
augroup END
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
let g:OmniSharp_want_snippet=1
