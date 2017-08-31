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

    " Get the position to see if the pair is matched below, putting it here {{{2
    " removes a duplicate setline() but causes this to run regardless of if
    " string or comment, but the position will be restored either way.
    let backsearch = s:getpairinside(a:char, 'b')

    " if comment/string, then return (if user didn't override) {{{2
    call setline('.', s:first . a:char . s:last)
    let higroup = synIDattr(synIDtrans(synID(line("."),s:charPos,1)),"name")
    if  (higroup ==# "Comment" && g:automatch_matchInComment == 0)
                \|| (higroup ==# "String" && g:automatch_matchInString == 0)
        undo
        return '' . a:char
    endif

    " If there is already one beside it that isn't matched... don't make a pair.
    " Backsearch checks if it is ALREADY matched, search checks if it CAN be
    " matched, Examples :
    " back -> (|) type ( => (())
    " front search |) type ( => () (fix broken matches){{{2
    let search = s:getpairinside(a:char, '')
    " echom '-----'
    " echom string(backsearch)
    " echom col('.')
    " echom string(search)
    " echom '-----'

    let override = col('.') > backsearch[1] && col('.') < search[1] && backsearch != [0,0]

    undo "the set line
    if !override && search != [0, 0] && backsearch == [0,0]
        return '' . a:char
    endif

    " If it's in the middle of a word, don't, assuming it's not overriden {{{2
    if !override
        let l:WORD = expand( "<cWORD>" )
        let l:word = expand( "<cword>" )
        let l:idx  = stridx(s:uline,expand( "<cWORD>" ))
        let l:idx2 = stridx(s:uline,expand( "<cword>" ))

        " TODO remove word if you don't use it here...
        " So far we aren't...
        " echom '--'
        " echom 'WORD :: ' .  l:idx . ' ' .  l:WORD . ' ' . s:charPos . ' ' (l:idx  + len(l:WORD))
        " echom 'word :: ' .  l:idx2 . ' ' . l:word . ' ' . s:charPos . ' ' (l:idx2 + len(l:word))
        " echom '--'

        if l:idx < s:charPos && s:charPos < l:idx + len(l:WORD)
            return '' . a:char
        endif
    endif

    " set the line.. {{{2
    call setline('.', s:first . a:char . g:automatch_matchings[a:char] . s:last)
    norm! l

    " Handle mapping {{{2
    call s:savemaps()
    inoremap <space> <space><c-r>=<SID>dospacematch()<cr>
    inoremap <cr> <c-r>=<SID>docarriagematch()<cr>
    "exe 'inoremap ' . g:automatch_matchings[a:char] . ' <c-r>=<SID>getout()<CR>'

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
" space applied TODO optional
    if (col('.') - 2 != s:charPos)
        return ''
    endif

    call s:clearAfterSpaceCrBs()

    undo
    return ''
endfunc
func! s:dospacematch() "{{{1
" space applied TODO optional
    if (col('.') - 2 != s:charPos)
        return ''
    endif

    call s:clearAfterSpaceCrBs()

    norm! h
    return ' '
endfunc

func! s:docarriagematch() "{{{1
" carriage applied TODO optional
" TODO, optionally if inside always format it? Idk... I don't LIKE this...
"  FIXME: FIX UNDO
    if (col('.') - 1 != s:charPos)
        return ''
    endif

    call s:clearAfterSpaceCrBs()

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

func! s:getout() "{{{1
    redir >> ~/.fuckinvim
    echom "JOJO 1"
    call s:clearAll()
    let l:para = s:getcurrentpara()
    if l:para != [0,0]
        call cursor(l:para[0], l:para[1] + 1)
    endif
    redir END
    return ''
endfunc

"TODO give current s:char precedence
func! s:getcurrentpara() "{{{1
    echom "JOJO 2"
    let origpos = getcurpos()
    let searchesFound = []
    for key in keys(g:automatch_matchings)
        echom "JOJO 3 " . key
        if key ==# "'" || key ==# '"'
            let hi = synIDattr(synIDtrans(synID(line('.'),col('.'),1)),"name")
            if hi != "String"
                continue
            endif

            if key ==# "'"
                call search("'")
            else
                call search('"')
            endif

            let search = s:getpairinside(key, "bc")
        else
            if key ==# "["
                call search("\[")
            else
                call search(key)
            endif
            let search = s:getpairinside(key, "")
            if search == [0,0]
                let search = s:getpairinside(key, "")
            endif
        endif

        echom "JOJO 4 " . key
        if search == [0,0]
            call setpos('.', origpos)
            continue
        endif

        let cursorpos = getcurpos()
        let insertion = copy(search)
        call insert(insertion, 0, 0)
        call setpos('.', insertion)

        let backsearch = s:getpairinside(key, "b")

        call setpos('.', origpos)
        echom "JOJO 5 " . key . " line :  " . line('.') . " col " . col('.')
        if backsearch != [0,0] && search != [0,0]
            if col('.') <= search[1] && line('.') <= search[0]
                if (col('.') > backsearch[1] || (backsearch[1] >= col('.') && backsearch[0] >= line('.')))
                    echom string(search) . '  ' . string(backsearch)
                    call add(searchesFound, [search, backsearch])
                endif
            endif
        endif
    endfor

    " echom string(searchesFound)
    " echom '  ' . line('.') . " , " . col('.')

    let mindist = line('$')
    let mindex  = -1
    let index = 0
    for x in searchesFound
        let d = sqrt(pow(line('.') - x[0][0], 2) + pow(col('.') - x[0][1], 2))
        let d2 = sqrt(pow(x[1][0] - line('.'), 2) + pow(x[1][1] - col('.'), 2))

        if col('.') > x[1][1]
            let d += l:d2
        else
            let d = l:d2
        endif

        echom " d " . string(l:d) . " d2 " . string(l:d2) . ' col(.) ' . col('.')

        if l:mindist > l:d
            let mindex = index
            let mindist = l:d
        endif

        let index = index + 1
    endfor
    echom string(l:mindex) . ' ' . string(l:mindist)

    call setpos('.', origpos)

    if l:mindex == -1
        return [0,0]
    elseif l:searchesFound[l:mindex][1][1] >= col('.')
        return l:searchesFound[l:mindex][1]
    else
        return l:searchesFound[l:mindex][0]
endfunc

func! s:getpairinside(char, exflags) "{{{1
    let cursorpos = getcurpos()
    let rtn = [0,0]
    let loop = 1
    " If it's " or ', we need to take that into account for strings
    let revealstring = 0
    let oldrtn = [0,0]

    echom "JOJO a " . a:char
    while loop
        echom "JOJO b "
        let oldrtn = copy(rtn)
        if a:char ==# "'"
            let rtn = searchpairpos("" . a:char, "", "" . g:automatch_matchings[a:char], a:exflags . "Wz")
            let revealstring = 1
        else
            if a:char ==# '"'
                let revealstring = 1
            endif

            if a:char ==# '['
                let rtn = searchpairpos('\' . a:char, '', '\' . g:automatch_matchings[a:char], a:exflags . 'Wz')
            else
                let rtn = searchpairpos('' . a:char, '', '' . g:automatch_matchings[a:char], a:exflags . 'Wz')
            endif
        endif

        echom "JOJO c "

        if rtn != [0,0]
            let hi = synIDattr(synIDtrans(synID(rtn[0],rtn[1],1)),"name")
            if l:hi == 'Comment' || (l:hi == 'String' && !l:revealstring)
                if oldrtn == rtn
                    let loop = 0
                    let rtn = [0,0]
                else
                    let loop = 1
                endif
            else
                let loop = 0
            endif
        else
            let loop = 0
        endif
        echom "JOJO d " . loop . "  " . string(rtn) . '  ' . string(oldrtn)
    endwhile

    echom "JOJO e " . loop . "  " . string(rtn) . '  ' . string(oldrtn)
    call setpos('.', cursorpos)
    echom "JOJO f " . loop . "  " . string(rtn) . '  ' . string(oldrtn)
    return rtn
endfun

" TODO make these variables? I don't know man...
func! s:clearAll() "{{{1
    call s:clearAfterSpaceCrBs()
    call s:clearAfterOut()
endfunc

func! s:clearAfterSpaceCrBs() " {{{1
    if s:spacesave != ''
        let spacesplit = split(s:spacesave)
        if l:spacesplit[2] == "found"
            silent! iunmap <space>
        else
            exe 'silent! inoremap <cr> ' . l:spacesplit[3]
        endif
    endif

    if s:crsave != ''
        let crsplit = split(s:crsave)
        if l:crsplit[2] == "found"
            silent! iunmap <cr>
        else
            exe 'silent! inoremap <cr> ' . l:crsplit[3]
        endif
    endif

    " if s:bssave != ''
    "     let bssplit = split(s:bssave)
    "     if l:bssplit[2] == "found"
    "         silent! iunmap <bs>
    "     else
    "         exe 'silent! inoremap <bs> ' . l:bssplit[3]
    "     endif
    " endif
endfunc

func! s:clearAfterOut() "{{{1
    " silent! iunmap <tab>
endfunc
func! s:savemaps() "{{{1
    " echom "Start save"
    call s:clearAll()

    redir => s:spacesave
        silent! imap <space>
    redir END
    redir => s:bssave
        silent! imap <bs>
    redir END
    redir => s:crsave
        silent! imap <cr>
    redir END
    " echom s:crsave
    " echom s:spacesave
    " echom s:tabsave
    " echom "End save"
endfunc "}}}1

" End functions

" Start Script Finish
"{{{
autocmd InsertLeave * call <SID>clearAll()

for key in keys(g:automatch_matchings)
    if key ==# "'"
        exe 'inoremap ' . key . " " . "<c-r>=<SID>main(".'"'.key.'"'.")<cr>"
    else
        exe 'inoremap ' . key . " " . "<c-r>=<SID>main("."'".key."'".")<cr>"
    endif
endfor
inoremap <tab> <c-r>=<SID>getout()<CR>
" inoremap <bs> <c-r>=<SID>deletematch()<CR>
"}}}
" End Script Finish
