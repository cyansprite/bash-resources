let g:airline#themes#dark#palette = {}

let g:airline#themes#dark#palette.accents = {
      \ 'red': [ '#ff2121' , '' , 196 , '' , '' ],
      \ }

let s:N1 = [ '' , '' , 7 , 235 ]
let s:N2 = [ '' , '' , 7 , 235 ]
let s:N3 = [ '' , '' , 7 , 235 ]
let g:airline#themes#dark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#dark#palette.normal_modified = {
      \ 'airline_c': [ '#e25000' , '#2e2e2e' , 0 , 9 , '' ] ,
      \ }

let s:I1 = [ '' , '' , 232 , 8 ]
let s:I2 = [ '' , '' , 232 , 8 ]
let s:I3 = [ '' , '' , 232 , 8 ]
let g:airline#themes#dark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#dark#palette.insert_modified = {
      \ 'airline_c': [ '' , '' , 0 , 1 , '' ] ,
      \ }
let g:airline#themes#dark#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '' , s:I1[2] , 2 , '' ] ,
      \ }

let g:airline#themes#dark#palette.replace = copy(g:airline#themes#dark#palette.insert)
let g:airline#themes#dark#palette.replace.airline_a = [ '#' , s:I1[1] , 1 , s:I1[3] , '' ]
let g:airline#themes#dark#palette.replace.airline_z = [ '#' , s:I1[1] , 1 , s:I1[3] , '' ]
let g:airline#themes#dark#palette.replace_modified = g:airline#themes#dark#palette.insert_modified

let s:V1 = [ '' , '' , 13 , 7 ]
let s:V2 = [ '' , '' , 13 , 7 ]
let s:V3 = [ '' , '' , 13 , 7 ]
let g:airline#themes#dark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#dark#palette.visual_modified = {
      \ 'airline_c': [ '' , '' , 0 , 9 , '' ] ,
      \ }

let s:IA = [ '' , '' , 59 , 235 , '' ]
let g:airline#themes#dark#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#dark#palette.inactive_modified = {
      \ 'airline_c': [ '' , '' , 240 , '' , '' ] ,
       \ }

let g:airline#themes#dark#palette.tabline = {
      \ 'airline_tab':      ['' , '' , 0 , 240 , '' ],
      \ 'airline_tabsel':   ['' , '' , 0 , 8 , '' ],
      \ 'airline_tabtype':  ['' , '' , 188 , 235 , '' ],
      \ 'airline_tabfill':  ['' , '' , 188 , 235 , '' ],
      \ 'airline_tabmod':   ['' , '' , 0 , 189 , '' ],
      \ }

let s:WI = [ '', '', 196, 235 ]
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
      \ [ '' , '' , 188 , 235 , ''     ] ,
      \ [ '' , '' , 188 , 235 , ''     ] ,
      \ [ '' , '' , 235 , 2 , ''     ] )
