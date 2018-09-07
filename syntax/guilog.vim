if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn case ignore

syn match   id          /[0-9]\+\t/
syn match   timestamp   /\(0[1-9]\|1[012]\)-[0123][0-9]-20[0-9][0-9] \(0[0-9]\|1[012]\):[0-5][0-9]:[0-5][0-9]\.[0-9]\{3}/
syn match   separator   / - /
syn match   assert      /\(Trivial\|Recoverable\) error occured:.*/
syn match   error       /Fatal error occured:.*/
syn match   event       /Event: .*/
"syn region  received    start=+Message received: id = + skip=+"+ end=+, data = +
syn match   key         /".\{-}"\ze:/
syn match   key         /:\zs.\{-}/
syn match   json        /[\[\]:\{\}\,]/ contained

syn match   statetrans  /\w* transitioned from '.\{-}' to '.\{-}'.*\( on event '.\{-}'\)\=/ contains=oldstateid,newstateid,transevent
syn match   oldstateid  /from '\zs.\{-}\ze'/ contained
syn match   newstateid  /to '\zs.\{-}\ze'/ contained
syn match   transevent  /on event '\zs.\{-}\ze'/ contained

syn match   sent        /Message sent:.\{-}, data =/ contains=msgid
syn match   received    /Message received:.\{-}, data =/ contains=msgid
syn match   msgid       /id = \zs".\{-}"/  contained

"hi link timestamp Comment
hi timestamp        ctermfg=DarkGray
hi separator        ctermfg=LightBlue
hi id               ctermfg=DarkGreen
hi assert           ctermfg=DarkRed
hi event            ctermfg=DarkYellow
hi key              ctermfg=LightGreen
hi error            ctermfg=Red
hi json             ctermfg=DarkCyan

hi statetrans       ctermfg=Blue
hi oldstateid       ctermfg=Red
hi newstateid       ctermfg=Green
hi transevent       ctermfg=Cyan

hi sent             ctermfg=Cyan
hi received         ctermfg=Magenta
hi msgid            ctermfg=White

syntax match   jsonNoise           /\%(:\|,\)/

syn match  jsonKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonKeyword
if has('conceal')
   syn region  jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ concealends contains=jsonEscape contained
else
   syn region  jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contains=jsonEscape contained
endif
syn match   jsonEscape    "\\["\\/bfnrt]" contained
syn match   jsonEscape    "\\u\x\{4}" contained
syn match   jsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n]*[,}\]]"
syn match  jsonBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/
syn keyword  jsonNull      null
hi def link jsonPadding       Operator
hi def link jsonString        String
hi def link jsonTest          Label
hi def link jsonEscape        Special
hi def link jsonNumber        Number
hi def link jsonBraces        Delimiter
hi def link jsonNull          Function
hi def link jsonBoolean       Boolean
hi def link jsonKeyword       Label
hi def link jsonQuote         Quote

function! SuperSexyFoldText() "{{{
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = printf("%s", lines_count)
    let foldchar = " "
    let foldtextstart = strpart('' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = ' ( ' . repeat(" ", 5 - len(lines_count_text)) . lines_count_text . repeat(" ", 2) . "lines" . '   )  '
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return '....' . repeat('.', winwidth('.') / 4) . " " . line . repeat(foldchar, winwidth('.') / 3 - len(line)) . foldtextend . repeat(".", winwidth('.'))
endfunction
set foldtext=SuperSexyFoldText()
"}}}

" I don't trust vim to do this correctly with syntax, so I'm going to force {{{
set foldmethod=manual

func! FoldTheShit()
    try
        let g:bracket = search('[', 'n')
        let g:brace = search('{', 'n')
        echom g:bracket . ' - ' . g:brace
        if g:bracket <= line('.') + 2 && g:bracket != 0 | let g:curLine = line('.')
            call search('[')
            exe 'norm! %'
            exe printf('%d,%dfold', g:curLine, line('.'))
        elseif g:brace <= line('.') + 2 && g:brace != 0
            let g:curLine = line('.')
            call search('{')
            exe 'norm! %'
            exe printf('%d,%dfold', g:curLine, line('.'))
        endif
    catch /.*/
    endtry
endfunc

if get(s:, 'loaded')
    norm! zE
endif

silent noautocmd global /RemoteObjectProxy/call FoldTheShit()
let s:loaded = 1
"}}}
" }}}
