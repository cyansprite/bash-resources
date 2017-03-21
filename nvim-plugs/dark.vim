let g:airline#themes#dark#palette = {}

let g:airline#themes#dark#palette.accents = {
      \ 'red': [ '' , '' , '' , '' , '' ],
      \ }
"normal
let s:N1 = [ '' , '' , g:normalColor , '' ]
let s:N2 = [ '' , '' , g:normalColor , '' ]
let s:N3 = [ '' , '' , g:normalColor , '' ]
let g:airline#themes#dark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#dark#palette.normal_modified = {
      \ 'airline_c': [ '' , '' , g:modColor , '' , 'bold' ] ,
      \ }
"insert
let s:I1 = [ '' , '' , g:selectColor , '' ]
let s:I2 = [ '' , '' , g:selectColor , '' ]
let s:I3 = [ '' , '' , g:selectColor , '' ]
let g:airline#themes#dark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#dark#palette.insert_modified = {
      \ 'airline_c': [ '' , '' , g:modColor , '' , 'bold' ] ,
      \ }
let g:airline#themes#dark#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '' , s:I1[2] , '' , '' ] ,
      \ }
"replace
let g:airline#themes#dark#palette.replace = copy(g:airline#themes#dark#palette.insert)
let g:airline#themes#dark#palette.replace.airline_a = [ '#' , s:I1[1] , 1 , s:I1[3] , '' ]
let g:airline#themes#dark#palette.replace.airline_z = [ '#' , s:I1[1] , 1 , s:I1[3] , '' ]
let g:airline#themes#dark#palette.replace_modified = g:airline#themes#dark#palette.insert_modified
"visual
let s:V1 = [ '' , '' , g:offColor , '' ]
let s:V2 = [ '' , '' , g:offColor , '' ]
let s:V3 = [ '' , '' , g:offColor , '' ]
let g:airline#themes#dark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#dark#palette.visual_modified = {
      \ 'airline_c': [ '' , '' , g:modColor , '' , 'bold' ] ,
      \ }

"inactive tab
let s:IA = [ '' , '' , g:backcentColor , '' , '' ]
let g:airline#themes#dark#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#dark#palette.inactive_modified = {
      \ 'airline_c': [ '' , '' , g:backModColor , '' , '' ] ,
       \ }

let g:airline#themes#dark#palette.tabline = {
      \ 'airline_tab':      ['' , '' , g:backcentColor , '' , 'underline' ],
      \ 'airline_tabsel':   ['' , '' , g:selectColor , '' , 'bold' ],
      \ 'airline_tabtype':  ['' , '' , g:selectColor , '' , '' ],
      \ 'airline_tabfill':  ['' , '' , g:selectColor , '' , '' ],
      \ 'airline_tabmod':   ['' , '' , g:modColor , '' , 'italic' ],
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
      \ [ '' , '' , 142 , '' , ''     ] ,
      \ [ '' , '' , g:backcentColor , '' , ''     ] ,
      \ [ '' , '' , g:selectColor , '' , 'bold'     ] )
