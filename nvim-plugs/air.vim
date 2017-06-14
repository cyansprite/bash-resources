" vim-airline template by chartoin (http://github.com/chartoin)
" Base 16 Twilight Scheme by David Hart (http://hart-dev.com)
let g:airline#themes#base16_twilight#palette = {}

let s:N1   =  [ "", "", 150, "" ]
let s:N2   =  [ "", "", 22, "" ]
let s:N3   =  [ "", "", 189, "" ]
let g:airline#themes#base16_twilight#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:I1   =  [ "", "", 159, "" ]
let s:I2   =  [ "", "", 24, "" ]
let s:I3   =  [ "", "", 189, "" ]
let g:airline#themes#base16_twilight#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1   =  [ "", "", 180, "" ]
let s:R2   =  [ "", "", 33, "" ]
let s:R3   =  [ "", "", 189, "" ]
let g:airline#themes#base16_twilight#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:V1   =  [ "", "", 250, "" ]
let s:V2   =  [ "", "", 59, "" ]
let s:V3   =  [ "", "", 189, "" ]
let g:airline#themes#base16_twilight#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:IA1   = [ "", "", 239, 235 ]
let s:IA2   = [ "", "", 239, 235 ]
let s:IA3   = [ "", "", 239, 235 ]
let g:airline#themes#base16_twilight#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
