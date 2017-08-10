scriptencoding utf-8

let g:airline#themes#dark#palette = {}

let s:N1   = [ 'bg' , '#88aaaa' , 255 , 238 ]
let s:N2   = [ '#88aaaa' , '#111111' , 85  , 234 ]
let s:N3   = [ '#88aaaa' , '#333333' , 17  , 190 ]
let g:airline#themes#dark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#dark#palette.normal_modified = {
      \ 'airline_a': [ '#ffffff' , '#557777' , 255     , 53      , ''     ] ,
      \ 'airline_c': [ '#ffffff' , '#557777' , 255     , 53      , ''     ] ,
      \ }

let s:I1   = [ 'bg' , '#88aa88' , 255 , 238 ]
let s:I2   = [ '#88aa88' , '#111111' , 85  , 234 ]
let s:I3   = [ '#88aa88' , '#333333' , 17  , 190 ]
let g:airline#themes#dark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#dark#palette.insert_modified = {
      \ 'airline_a': [ '#ffffff' , '#557755' , 255     , 53      , ''     ] ,
      \ 'airline_c': [ '#ffffff' , '#557755' , 255     , 53      , ''     ] ,
      \ }


let g:airline#themes#dark#palette.replace = copy(g:airline#themes#dark#palette.insert)
let g:airline#themes#dark#palette.replace.airline_a = [ s:I2[0]   , '#af0000' , s:I2[2] , 124     , ''     ]
let g:airline#themes#dark#palette.replace_modified = g:airline#themes#dark#palette.insert_modified

let s:V1   = [ 'bg' , '#aa88aa' , 255 , 238 ]
let s:V2   = [ '#aa88aa' , '#111111' , 85  , 234 ]
let s:V3   = [ '#aa88aa' , '#333333' , 17  , 190 ]

let g:airline#themes#dark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#dark#palette.visual_modified = {
      \ 'airline_a': [ '#ffffff' , '#775577' , 255     , 53      , ''     ] ,
      \ 'airline_c': [ '#ffffff' , '#775577' , 255     , 53      , ''     ] ,
      \ }

let s:IA1 = [ '#888888' , 'bg' , 239 , 234 , '' ]
let s:IA2 = [ '#888888' , 'bg' , 239 , 235 , '' ]
let s:IA3 = [ '#888888' , 'bg' , 239 , 236 , '' ]

let g:airline#themes#dark#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#dark#palette.inactive_modified = {
      \ 'airline_a': [ '#999999' , '#223322' , 97 , '' , '' ] ,
      \ 'airline_b': [ '#999999' , '#223322' , 97 , '' , '' ] ,
      \ 'airline_c': [ '#999999' , '#223322' , 97 , '' , '' ] ,
      \ }

let g:airline#themes#dark#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , ''  ]
      \ }

let g:airline#themes#dark#palette.tabline = {
    \ 'airline_tab':    ['#bcbcbc', 'bg','250','22'],
    \ 'airline_tabsel': ['#404042', '#dfdfdf','238','148'],
    \ 'airline_tabtype':['#ffffff', 'bg','148','22'],
    \ 'airline_tabfill':['#afd700', '#000000','148','22'],
    \ 'airline_tabhid': ['#aaaaaa', '#555555','251','238'],
    \ 'airline_tabmod': ['#ffffff', '#008800','190','148', 'bold'],
    \ 'airline_tabmod_unsel':  ['#009900', 'bg','190','22']
    \ }
