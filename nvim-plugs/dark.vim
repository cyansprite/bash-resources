let g:airline#themes#dark#palette = {}

let g:airline#themes#dark#palette.accents = {
      \ 'red': [ '' , '' , '' , '' , '' ],
      \ }
"shadow
let s:N1 = [ '' , '' , 75 , '' ]
let s:N2 = [ '' , '' , 75 , '' ]
let s:N3 = [ '' , '' , 75 , '' ]
let g:airline#themes#dark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#dark#palette.normal_modified = {
      \ 'airline_c': [ '' , '' , 40 , '' , 'bold' ] ,
      \ }
"cyan
let s:I1 = [ '' , '' , 167 , '' ]
let s:I2 = [ '' , '' , 167 , '' ]
let s:I3 = [ '' , '' , 167 , '' ]
let g:airline#themes#dark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
"blue
let g:airline#themes#dark#palette.insert_modified = {
      \ 'airline_c': [ '' , '' , 40 , '' , 'bold' ] ,
      \ }
let g:airline#themes#dark#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '' , s:I1[2] , '' , '' ] ,
      \ }
"red
let g:airline#themes#dark#palette.replace = copy(g:airline#themes#dark#palette.insert)
let g:airline#themes#dark#palette.replace.airline_a = [ '#' , s:I1[1] , 1 , s:I1[3] , '' ]
let g:airline#themes#dark#palette.replace.airline_z = [ '#' , s:I1[1] , 1 , s:I1[3] , '' ]
let g:airline#themes#dark#palette.replace_modified = g:airline#themes#dark#palette.insert_modified
"purple
let s:V1 = [ '' , '' , 141 , '' ]
let s:V2 = [ '' , '' , 141 , '' ]
let s:V3 = [ '' , '' , 141 , '' ]
"blue
let g:airline#themes#dark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#dark#palette.visual_modified = {
      \ 'airline_c': [ '' , '' , 40 , '' , 'bold' ] ,
      \ }

"grey
let s:IA = [ '' , '' , 59 , '' , '' ]
let g:airline#themes#dark#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#dark#palette.inactive_modified = {
      \ 'airline_c': [ '' , '' , '' , '' , '' ] ,
       \ }

let g:airline#themes#dark#palette.tabline = {
      \ 'airline_tab':      ['' , '' , 59 , '' , '' ],
      \ 'airline_tabsel':   ['' , '' , 45 , '' , 'bold' ],
      \ 'airline_tabtype':  ['' , '' , 196 , '' , '' ],
      \ 'airline_tabfill':  ['' , '' , 197 , '' , '' ],
      \ 'airline_tabmod':   ['' , '' , 40 , '' , 'italic' ],
      \ }

let s:WI = [ '', '', '', '' ]
let g:airline#themes#dark#palette.normal.airline_warning = [
     \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
     \ ]

let g:airline#themes#dark#palette.normal_modified.airline_warning =
    \ g:airline#themes#dark#palette.normal.airline_warning

let g:airline#themes#dark#palette.insert.airline_warning =
    \ g:airline#themes#dark#palette.normal.airline_warning

let g:airline#themes#dark#palette.insert_modified.airline_warning =
    \ g:airline#themes#dark#palette.normal.airline_warning

let g:airline#themes#dark#palette.visual.airline_warning =
    \ g:airline#themes#dark#palette.normal.airline_warning

let g:airline#themes#dark#palette.visual_modified.airline_warning =
    \ g:airline#themes#dark#palette.normal.airline_warning

let g:airline#themes#dark#palette.replace.airline_warning =
    \ g:airline#themes#dark#palette.normal.airline_warning

let g:airline#themes#dark#palette.replace_modified.airline_warning =
    \ g:airline#themes#dark#palette.normal.airline_warning

if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#dark#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '' , '' , 23 , '' , ''     ] ,
      \ [ '' , '' , 59 , '' , ''     ] ,
      \ [ '' , '' , 70 , '' , 'bold'     ] )
