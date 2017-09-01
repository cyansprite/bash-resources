" Start vars
" Script vars {{{1

func! autoMatch#clear()
    let s:char = ''
    let s:charPos = 0
    let s:line = ''
    let s:crsave = ''
    let s:spacesave = ''
    let s:bssave = ''
endfun
call autoMatch#clear()
" end local vars
" Vars users can pick {{{1
if !has_key(g:,"automatch_matchings")
    let g:automatch_matchings = {
                \ "'" : "'",
                \ '"' : '"',
                \ "(" : ")",
                \ "[" : "]",
                \ "{" : "}"}
endif

if !has_key(g:, "automatch_matchInString")
    let g:automatch_matchInString = 0
endif

if !has_key(g:, "automatch_matchInComment")
    let g:automatch_matchInComment = 0
endif "}}}1
" End vars

" Start functions
func! s:main(char) "{{{1
    " Initialize {{{2
    let s:char  = a:char
    let s:charPos = col('.')

    let s:uline = getline('.')
    let s:last = strpart(s:uline, s:charPos - 1, len(s:uline) - s:charPos + 1)
    let s:first =  strpart(s:uline, 0, s:charPos - 1)
    let s:commented = 0

    " if comment/string, then return (if user didn't override) {{{2
    call setline('.', s:first . a:char . s:last)
    let higroup = synIDattr(synIDtrans(synID(line("."),s:charPos,1)),"name")

    if  (higroup ==# "Comment" && g:automatch_matchInComment == 0)
                \|| (higroup ==# "String" && g:automatch_matchInString == 0)
        undo
        return '' . a:char
    endif

    " if it has an unpaired ) somewhere in the future, match it with that
    " don't add a new one.


    " If it's in the middle of a word, don't, assuming it's not overriden {{{2
    let l:WORD = expand( "<cWORD>" )
    let l:word = expand( "<cword>" )
    let l:idx  = stridx(s:uline,expand( "<cWORD>" ))
    let l:idx2 = stridx(s:uline,expand( "<cword>" ))

    " TODO remove word if you don't use it here...
    " So far we aren't...
    echom '--'
    echom 'WORD :: ' .  l:idx . ' ' .  l:WORD . ' ' . s:charPos . ' ' (l:idx  + len(l:WORD))
    echom 'word :: ' .  l:idx2 . ' ' . l:word . ' ' . s:charPos . ' ' (l:idx2 + len(l:word))
    echom '--'

    if l:idx < s:charPos && s:charPos < l:idx + len(l:WORD)
        return '' . a:char
    endif

    " If there is already one beside it that isn't matched... don't make a pair.
    " Backsearch checks if it is ALREADY matched, search checks if it CAN be
    " matched, Examples :
    " back -> (|) type ( => (())
    " front search |) type ( => () (fix broken matches){{{2

    undo

    " set the line.. {{{2
    call setline('.', s:first . a:char . g:automatch_matchings[a:char] . s:last)
    norm! l

    return ""
endfunc "  }}}1

func! s:dojump() "{{{1
    " elseif l:idx == s:charPos
    " let last = strpart(s:uline, l:idx + len(l:word) + 1, len(s:uline) - s:charPos)
    " let first =  strpart(s:uline, 0, l:idx + len(l:word) + 1)
    " call setline('.', first . a:char . last)
    " return ''
endfunc

func! s:dobackspace() "{{{1
    " -------------------------------------------------------------------------
    " NOTE: cases to be valid
    " ()|       : para in front.
    " (|)       : para inside.
    " (| )      : para space in front (rare case).
    " (  |  )   : para just expanded.
    " (     )|  : para just expanded, and in front of.
    " -------------------------------------------------------------------------
    " NOTE: Cases that might seem valid but aren't
    " ( |)      : This might be user desire to get rid of spacing therefore, I
    "             respect this.
    " (   |  )  : Some weird amount of space, this seems edge case and maybe
    "             the user wanted the weird spacing such as in strings
    " Any other case I haven't analyzed or have come across...
    " -------------------------------------------------------------------------

    let pos = getcurpos()
    undo

    for key in keys(g:automatch_matchings)
        if (getline('.')[col('.') - 3] == key &&
        \   getline('.')[col('.') - 2] == g:automatch_matchings[key]) ||
        \  (getline('.')[col('.') - 2] == key &&
        \   getline('.')[col('.') - 1] == g:automatch_matchings[key]) ||
        \  (getline('.')[col('.') - 3] == key &&
        \   getline('.')[col('.') - 0] == g:automatch_matchings[key]) ||
        \  (getline('.')[col('.') - 5] == key &&
        \   getline('.')[col('.') - 2] == g:automatch_matchings[key]) ||
        \  (getline('.')[col('.') - 2] == key &&
        \   getline('.')[col('.') - 0] == g:automatch_matchings[key])
            echom 'jojo over here! ' . key
        endif
    endfor

    redo
    call setpos('.', pos)

    return ''
endfunc

func! s:dospacematch() "{{{1
    " If inside of para and they haven't expanded yet...
    for key in keys(g:automatch_matchings)
        if getline('.')[col('.') - 3] == key &&
        \  getline('.')[col('.') - 1] == g:automatch_matchings[key]
            "center and insert a space
            norm! h
            return ' '
        endif
    endfor

    return ''
endfunc

func! s:docarriagematch() "{{{1
    if (col('.') - 1 != s:charPos)
        return ''
    endif

    let l:last = ''

    if s:charPos == len(s:uline)
        call setline('.', s:first . s:char . s:last)
        norm! o
        call setline('.', g:automatch_matchings[s:char])
    else
        call setline('.', s:first . s:char)
        norm! o
        call setline('.', g:automatch_matchings[s:char])
        let l:last = s:last
    endif

    norm! ==
    let l:indent = indent('.')
    norm! O

    if &expandtab
        return repeat(' ', (l:indent) + &tabstop) . l:last
    else
        return repeat('	', (&tabstop + l:indent) / &tabstop) . l:last
endfunc


" TODO make these variables? I don't know man... }}}1



" End functions

" Start Script Finish
"{{{

for key in keys(g:automatch_matchings)
    if key ==# "'"
        exe 'inoremap ' . key . " " . "<c-r>=<SID>main(".'"'.key.'"'.")<cr>"
    else
        exe 'inoremap ' . key . " " . "<c-r>=<SID>main("."'".key."'".")<cr>"
    endif
endfor
" inoremap <tab> <c-r>=<SID>getout()<CR>
" inoremap <bs> <c-r>=<SID>deletematch()<CR>
"}}}
" End Script Finish

inoremap <space> <space><c-r>=<SID>dospacematch()<cr>
inoremap <bs> <c-g>u<bs><c-r>=<SID>dobackspace()<cr>
" inoremap <cr> <c-r>=<SID>docarriagematch()<cr>
    "exe 'inoremap ' . g:automatch_matchings[a:char] . ' <c-r>=<SID>getout()<CR>'
