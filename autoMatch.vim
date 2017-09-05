" Vars users can pick {{{1
" search skipper ( we don't like comments and strings
let s:skip ='synIDattr(synID(line("."), col("."), 0), "name") ' .
            \ '=~?	"string\\|comment"'

" By default use these matches
if !has_key(g:,"automatch_matchings")
    let g:automatch_matchings = {
                \ "'" : "'",
                \ '"' : '"',
                \ "(" : ")",
                \ "[" : "]",
                \ "{" : "}"}
endif

if !has_key(g:,"automatch_delimeters")
    let g:automatch_delimeters = [ ',' ]
endif

" by default ignore strings
if !has_key(g:, "automatch_matchInString")
    let g:automatch_matchInString = 0
endif

if !has_key(g:, "automatch_matchInComment")
    let g:automatch_matchInComment = 0
endif

" by default use default ... >.> duh
if !has_key(g:, "autoMatch_useDefaults")
    let g:autoMatch_useDefaults = 1
endif
"}}}1
" #region    helpers
func! s:amICommentOrString(ignoreString) "{{{1
    " ignore comments and strings given that's the users desire
    let higroup = synIDattr(synIDtrans(synID(line("."),col('.') - 1,1)),"name")

    return  (higroup ==# "Comment" && g:automatch_matchInComment == 0)
                \ || (a:ignoreString == 0 && (higroup ==# "String" && g:automatch_matchInString == 0))
endfun "}}}1
func! s:vimComments(char) "{{{1
    " Vim comments are " therefore we need to ignore them
    return &filetype == 'vim' && a:char ==# '"' && col('.') == len(getline('.'))
endfun "}}}
func! s:amIApostrophe(char) "{{{1
    " If we are right in front of a-zA-Z then we should not complete, because
    " this is more than likely an apostrophe
    let l:asc = char2nr(getline('.')[col('.') - 2])
    return a:char == "'" && ((l:asc >= char2nr('a') && l:asc <= char2nr('z')) ||
                \ (l:asc >= char2nr('A') && l:asc <= char2nr('Z')))
endfunc "}}}1
" #endregion helpers

" #region    functions
func! s:invmain(char) "{{{1
    " -------------------------------------------------------------------------
    " NOTE: cases to be valid  | Result |
    " (|)       : para inside. |   ()|  |
    " -------------------------------------------------------------------------
    if a:char == getline('.')[col('.') - 1]
        let pos = getcurpos()
        let pos[2] = pos[2] + 1
        let pos[4] = pos[4] + 1
        call setpos('.', pos)
        return ''
    endif

    " If it's existant, the same thing and it's not an immediate match, go to main...
    if has_key(g:automatch_matchings, a:char)
        if a:char == g:automatch_matchings[a:char]
            return s:main(a:char)
        endif
    endif

    return a:char
endfunc
" }}}1
func! s:main(char) "{{{1
    " Initialize
    let l:col = col('.')

    let l:uline = getline('.')
    let l:last = strpart(l:uline, l:col - 1, len(l:uline) - l:col + 1)
    let l:first =  strpart(l:uline, 0, l:col - 1)

    " if comment/string, then return (if user didn't override)
    call setline('.', l:first . a:char . l:last)

    if s:amICommentOrString(0) || s:vimComments(a:char) || s:amIApostrophe(a:char)
        undo
        return a:char
    endif

    " if it has an unpaired ) somewhere in the future, match it with that
    " don't add a new one. with [] we need a prefix of \ so searching works
    let prefix = ''
    if a:char == '['
        let l:prefix = '\'
    endif

    undo
    let sp1 = searchpairpos(l:prefix . a:char, '', l:prefix . g:automatch_matchings[a:char], 'Wzcn' , s:skip)
    let sp2 = searchpairpos(l:prefix . a:char, '', l:prefix . g:automatch_matchings[a:char], 'Wzbcn', s:skip)
    if l:sp1 != [0,0] && l:sp2 == [0,0]
        return a:char
    endif

    " if it has an unpaired ) somewhere in the future, match it with that
    " set the line..
    call setline('.', l:first . a:char . g:automatch_matchings[a:char] . l:last)
    norm! l

    return ""
endfunc

func! s:dobackspace() "{{{1
    " -------------------------------------------------------------------------
    " NOTE: cases to be valid
    " ()|       : para in front.
    " (|)       : para inside.
    " (| )      : para space in front (rare case).
    " ( | )     : para just expanded.
    " (   )|    : para just expanded, and in front of.
    " (|  )     : para just expanded, and in front of left.
    " -------------------------------------------------------------------------
    " NOTE: Cases that might seem valid but aren't
    " (  |)     : This might be user desire to get rid of spacing by hitting
    "             right, then <bs>
    " ( |)      : This might be user desire to get rid of spacing by hitting
    "             delete then <bs>
    " (  | )    : Some weird amount of space, this seems edge case and maybe
    "             the user wanted the weird spacing such as in strings
    " Any other case I haven't analyzed or have come across.
    " -------------------------------------------------------------------------

    " ignore comments and strings given that's the users desire
    if s:amICommentOrString(1)
        return ''
    endif

    let pos = getcurpos()
    undo
    let col = col('.')
    let possible = [[3,2], [2,1], [3,0], [5,2], [2,0], [2,-1]]
    let line = getline('.')
    let moveleft = 0
    let redo = 1

    " loop through each key, if it's one of the positions above, save things.
    for key in keys(g:automatch_matchings)
        for val in possible
            if (l:line[l:col - val[0]] == key &&
            \   l:line[l:col - val[1]] == g:automatch_matchings[key])
                " Now set the line
                call setline('.',
                            \ strpart(l:line, 0, l:col - val[0]) .
                            \ strpart(l:line, l:col - val[1] + 1, len(l:line) - l:col + 1))

                if val[1] == 2
                    let moveleft = val[0] - val[1]
                elseif val[1] == 0
                    let moveleft = 1
                endif
                let l:redo = 0

                break
            endif
        endfor
    endfor

    " restore things.
    if l:redo
        redo
    endif
    call setpos('.', pos)

    " if we are at the end of the line there is no need to adjust.
    if len(getline('.')) != col('.') - 1
        if l:moveleft != 0
            exe 'norm ' . l:moveleft . 'h'
        endif
    endif

    " We don't want to return something... a.k.a 0
    return ''
endfunc

func! s:dospacematch() "{{{1
    " -------------------------------------------------------------------------
    " NOTE: cases to be valid
    " (|)       : para inside.
    " -------------------------------------------------------------------------

    " ignore comments and strings given that's the users desire
    if s:amICommentOrString(1)
        return ''
    endif

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
    " -------------------------------------------------------------------------
    " NOTE: cases to be valid                       (
    " (|)       : para inside.                          |
    " ( | )     : para just expanded.               )
    " -------------------------------------------------------------------------
    " NOTE: special cases to be valid, words after  (
    " (|)xyz    : para inside                           xyz|
    " ( | )xyz  : para just expanded                )
    " -------------------------------------------------------------------------

    " ignore comments and strings given that's the users desire
    if s:amICommentOrString(1)
        return ''
    endif

    let pos = getcurpos()
    undo
    let col = col('.')
    let possible = [[2,1], [3,0]]
    let line = getline('.')

    " loop through each key, if it's one of the positions above, save things.
    for key in keys(g:automatch_matchings)
        for val in possible
            if (l:line[l:col - val[0]] == key &&
            \   l:line[l:col - val[1]] == g:automatch_matchings[key])

                let diff = val[0] - 2
                let l:uline = getline('.')
                let l:last = strpart(l:uline, l:col + l:diff , len(l:uline) - l:col + l:diff)
                let l:first =  strpart(l:uline, 0, l:col - l:diff - 2)

                call setline('.', l:first . key)
                norm! o
                call setline('.', g:automatch_matchings[key])

                norm! ==
                let l:indent = indent('.')
                norm! O

                " echom "jojo ---------"
                " echom l:last
                " echom "jojo ---------"

                if &expandtab
                    return repeat(' ', (l:indent) + &tabstop) . l:last
                else
                    return repeat('	', (&tabstop + l:indent) / &tabstop) . l:last
                endif
            endif
        endfor
    endfor

    redo
    call setpos('.', pos)
    return ''
endfunc


" TODO make these variables? I don't know man... }}}1
func! s:dotab() " {{{1 {{{2
    return s:doeithertab(1)
endfun
func! s:dostab() "{{{2
    return s:doeithertab(0)
endfun
func! s:dodelim(forward, line, col, inbetween, betweensplit, diffmaker) "{{{2
    " is it just space or more?
    if len(a:betweensplit) == 0
        if a:forward
            return (len(a:inbetween) / 2 + 1) + a:col
        else
            return a:col - (len(a:inbetween) / 2 + 1)
        endif
    else
        if a:forward
            let l:min = 99999

            for lol in g:automatch_delimeters
                let l:new = stridx(a:line, lol, a:col)
                if l:new != -1 && l:new < l:min
                    let l:min = l:new
                endif
            endfor

            echom 'min -- ' . l:min

            if l:min == -1 || l:min == 99999
                return -1
            endif

            return l:min + 1
        else
            let l:max = -99999

            for lol in g:automatch_delimeters
                let l:new = strridx(a:line, lol, a:col - 4)
                if l:new > l:max
                    let l:max = l:new
                endif
            endfor

            echom 'max -- ' . l:max

            if l:max == -99999 || l:max == -1
                return -1
            endif

            return l:max + 1
        endif
    endif
endfunc
func! s:doeithertab(forward) "{{{2
    " -------------------------------------------------------------------------
    " NOTE: Cursor jumps out
    " forward == 1 | right | Example :  ( | )   ->  (   )|
    " forward == 0 | left  | Example :  ( | )  S-> |(   )
    " forward == 1 | right | Example : |(   )   ->  ( | )
    " forward == 0 | left  | Example :  (   )| S->  ( | )
    " -------------------------------------------------------------------------

    " ignore comments and strings given that's the users desire
    if s:amICommentOrString(1)
        return ''
    endif

    let pos = getcurpos()
    undo

    let col      = col('.')
    let line     = getline('.')
    let min      = 99999
    let minValue = -1
    let keysorted = []

    " loop through each key, if it's one of the positions above, save things.
    " for key in keys(g:automatch_matchings)
    " endfor
    " need to sort these based on how close they are.

    for key in keys(g:automatch_matchings)
        if a:forward
            let diffmaker = 1
        else
            let diffmaker = 2
        endif

        let keyidx = strridx(l:line, key, l:col - l:diffmaker)
        let matchkeyidx = stridx(l:line, g:automatch_matchings[key], l:col - l:diffmaker)
        let recurse = 0
        echom l:keyidx . ' - ' . l:matchkeyidx

        " If we are before or after ()
        if l:keyidx      == (l:col - l:diffmaker) && a:forward  && l:matchkeyidx != -1 ||
         \ l:matchkeyidx == (l:col - l:diffmaker) && !a:forward && l:keyidx      != -1 ||
         \ l:keyidx != -1 && l:matchkeyidx != -1
            " Special case for whenever we are outside the para on right side
            let pos = getcurpos()
            if l:col > l:matchkeyidx + 1
                let pos[2] = l:matchkeyidx + 1
                call setpos('.', pos)
                return ''
            endif

            let l:inbetween = strpart(l:line, l:keyidx + 1, l:matchkeyidx - l:keyidx - 1)
            let l:betweensplit = split(l:inbetween)

            let rtn = s:dodelim(a:forward, l:line, l:col, l:inbetween, l:betweensplit, l:diffmaker)

            if l:rtn != -1
                let l:pos[2] = l:rtn
            else
                if a:forward
                    if l:col <= l:matchkeyidx
                        let l:pos[2] = l:matchkeyidx + 1
                    else
                        let l:pos[2] = l:matchkeyidx + 2
                    endif
                else
                    let l:pos[2] = l:keyidx + 1
                endif
            endif

            let l:pos[4] = l:pos[2]
            call setpos('.', l:pos)
            return ''
        endif
    endfor

    echom l:minValue

    " If we have a find do it
    if l:minValue != -1
        let pos[2] = l:minValue + a:forward + 1
        let pos[4] = l:minValue + a:forward + 1
        call setpos('.', pos)
        return ''
    endif

    redo
    call setpos('.', pos)
    return ''
endfunc "}}}2


" TODO make these variables? I don't know man... }}}1

" #endregion functions

" {{{ Defaults, mappings, and finish

for key in keys(g:automatch_matchings)
    if key ==# "'"
        exe 'inoremap ' . key . " " . "<c-r>=<SID>main(".'"'.key.'"'.")<cr>"
        exe 'inoremap ' . g:automatch_matchings[key] . " " . "<c-r>=<SID>invmain(".'"'. g:automatch_matchings[key] .'"'.")<cr>"
    else
        exe 'inoremap ' . key . " " . "<c-r>=<SID>main("."'".key."'".")<cr>"
        exe 'inoremap ' . g:automatch_matchings[key] . " " . "<c-r>=<SID>invmain("."'". g:automatch_matchings[key] ."'".")<cr>"
    endif
endfor

if g:autoMatch_useDefaults
    inoremap <space> <space><c-r>=<SID>dospacematch()<cr>
    inoremap <bs> <c-g>u<bs><c-r>=<SID>dobackspace()<cr>
    inoremap <cr> <c-g>u<cr><c-r>=<SID>docarriagematch()<cr>
    " TODO map something other than tab/s-tab
    inoremap <tab> <c-g>u<tab><c-r>=<SID>dotab()<cr>
    inoremap <s-tab> <c-g>u<tab><c-r>=<SID>dostab()<cr>
endif
" }}}
