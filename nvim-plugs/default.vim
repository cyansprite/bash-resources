" ============================================================================
" File:        default.vim
" Description:
" Author:      Yggdroot <archofortune@gmail.com>
" Website:     https://github.com/Yggdroot
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

let s:palette = {
            \   'stlName': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '#2F5C00',
            \       'guibg': '#BAFFA3',
            \       'cterm': 'bold',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   },
            \   'stlCategory': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#000000',
            \       'guibg': '#F28379',
            \       'cterm': 'NONE',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   },
            \   'stlNameOnlyMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#000000',
            \       'guibg': '#E8ED51',
            \       'cterm': 'NONE',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   },
            \   'stlFullPathMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#000000',
            \       'guibg': '#AAAAFF',
            \       'cterm': 'NONE',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   },
            \   'stlFuzzyMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#000000',
            \       'guibg': '#E8ED51',
            \       'cterm': 'NONE',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   },
            \   'stlRegexMode': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#000000',
            \       'guibg': '#7FECAD',
            \       'cterm': 'NONE',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   },
            \   'stlCwd': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#EBFFEF',
            \       'guibg': '#606168',
            \       'cterm': 'NONE',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   },
            \   'stlBlank': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': 'NONE',
            \       'guibg': '#3B3E4C',
            \       'cterm': 'NONE',
            \       'ctermfg': 'NONE',
            \       'ctermbg': 'none'
            \   },
            \   'stlLineInfo': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#000000',
            \       'guibg': '#EBFFEF',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '195'
            \   },
            \   'stlTotal': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '#000000',
            \       'guibg': '#BCDC5C',
            \       'cterm': 'NONE',
            \       'ctermfg': 'none',
            \       'ctermbg': 'none'
            \   }
            \ }

let g:leaderf#colorscheme#default#palette = leaderf#colorscheme#mergePalette(s:palette)
