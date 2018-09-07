sign define GdbBreakpoint text=o linehl=Search
sign define GdbCurrentLine text=> linehl=Search


let s:gdb_port = 6666
let s:run_gdb = get(g:, "run_gdb", "gdb -q -f /bonus/scratch/build-bundle/poky/touch/tmp/work/i586-poky-linux/ui-qt-touch/0.0+git999-r0/ui-qt-touch-0.0+git999/ui-qt")
let s:breakpoints = {}
let s:max_breakpoint_sign_id = 0


let s:GdbServer = {}


function s:GdbServer.new(gdb)
  let this = copy(self)
  let this._gdb = a:gdb
  return this
endfunction


function s:GdbServer.on_exit()
  let self._gdb._server_exited = 1
endfunction


let s:GdbPaused = vimexpect#State([
      \ ['Continuing.', 'continue'],
      \ ['\v[\o32]{2}([^:]+):(\d+):\d+', 'jump'],
      \ ['Remote communication error.  Target disconnected.:', 'retry'],
      \ ])


function s:GdbPaused.continue(...)
  call self._parser.switch(s:GdbRunning)
  call self.update_current_line_sign(0)
endfunction


function s:GdbPaused.jump(file, line, ...)
  if tabpagenr() != self._tab
    " Don't jump if we are not in the debugger tab
    return
  endif
  let window = winnr()
  exe self._jump_window 'wincmd w'
  let self._current_buf = bufnr('%')
  let target_buf = bufnr(a:file, 1)
  if bufnr('%') != target_buf
    exe 'buffer ' target_buf
    let self._current_buf = target_buf
  endif
  exe ':' a:line
  let self._current_line = a:line
  exe window 'wincmd w'
  call self.update_current_line_sign(1)
endfunction


function s:GdbPaused.retry(...)
  if self._server_exited
    return
  endif
  sleep 1
  call self.attach()
  call self.send('continue')
endfunction


let s:GdbRunning = vimexpect#State([
      \ ['\v^Breakpoint \d+', 'pause'],
      \ ['\v\[Inferior\ +.{-}\ +exited\ +normally', 'disconnected'],
      \ ['(gdb)', 'pause'],
      \ ])


function s:GdbRunning.pause(...)
  call self._parser.switch(s:GdbPaused)
  if !self._initialized
    call self.send('set confirm off')
    call self.send('set pagination off')
    if !empty(self._server_addr)
      call self.send('set remotetimeout 50')
      call self.attach()
      call s:RefreshBreakpoints()
      call self.send('c')
    endif
    let self._initialized = 1
  endif
endfunction


function s:GdbRunning.disconnected(...)
  if !self._server_exited && self._reconnect
    " Refresh to force a delete of all watchpoints
    call s:RefreshBreakpoints()
    sleep 1
    call self.attach()
    call self.send('continue')
  endif
endfunction


let s:Gdb = {}


function s:Gdb.kill()
  tunmap <f8>
  tunmap <f10>
  tunmap <f11>
  tunmap <f12>
  call self.update_current_line_sign(0)
  exe 'bd! '.self._client_buf
  if self._server_buf != -1
    exe 'bd! '.self._server_buf
  endif
  exe 'tabnext '.self._tab
  tabclose
  unlet g:gdb
endfunction


function! s:Gdb.send(data)
  call jobsend(self._client_id, a:data."\<cr>")
endfunction


function! s:Gdb.attach()
  call self.send(printf('target remote %s', self._server_addr))
endfunction


function! s:Gdb.update_current_line_sign(add)
  " to avoid flicker when removing/adding the sign column(due to the change in
  " line width), we switch ids for the line sign and only remove the old line
  " sign after marking the new one
  let old_line_sign_id = get(self, '_line_sign_id', 4999)
  let self._line_sign_id = old_line_sign_id == 4999 ? 4998 : 4999
  if a:add && self._current_line != -1 && self._current_buf != -1
    exe 'sign place '.self._line_sign_id.' name=GdbCurrentLine line='
          \.self._current_line.' buffer='.self._current_buf
  endif
  exe 'sign unplace '.old_line_sign_id
endfunction


function! s:Spawn(server_cmd, client_cmd, server_addr, reconnect)
  if exists('g:gdb')
    throw 'Gdb already running'
  endif
  let gdb = vimexpect#Parser(s:GdbRunning, copy(s:Gdb))
  " gdbserver port
  let gdb._server_addr = a:server_addr
  let gdb._reconnect = a:reconnect
  let gdb._initialized = 0
  " window number that will be displaying the current file
  let gdb._jump_window = 1
  let gdb._current_buf = -1
  let gdb._current_line = -1
  let gdb._has_breakpoints = 0 
  let gdb._server_exited = 0
  " Create new tab for the debugging view
  tabnew
  let gdb._tab = tabpagenr()
  " create horizontal split to display the current file and maybe gdbserver
  sp
  let gdb._server_buf = -1
  if type(a:server_cmd) == type('')
    " spawn gdbserver in a vertical split
    let server = s:GdbServer.new(gdb)
    vsp | enew | let gdb._server_id = termopen(a:server_cmd, server)
    let gdb._jump_window = 2
    let gdb._server_buf = bufnr('%')
  endif
  " go to the bottom window and spawn gdb client
  wincmd j
  enew | let gdb._client_id = termopen(a:client_cmd, gdb)
  let gdb._client_buf = bufnr('%')
  tnoremap <silent> <f8> <c-\><c-n>:GdbContinue<cr>i
  tnoremap <silent> <f10> <c-\><c-n>:GdbNext<cr>i
  tnoremap <silent> <f11> <c-\><c-n>:GdbStep<cr>i
  tnoremap <silent> <f12> <c-\><c-n>:GdbFinish<cr>i
  " go to the window that displays the current file
  exe gdb._jump_window 'wincmd w'
  let g:gdb = gdb
endfunction

function! s:ToggleBreak()
  let file_name = bufname('%')
  let file_breakpoints = get(s:breakpoints, file_name, {})
  let linenr = line('.')
  if has_key(file_breakpoints, linenr)
    call remove(file_breakpoints, linenr)
  else
    let file_breakpoints[linenr] = 1
  endif
  let s:breakpoints[file_name] = file_breakpoints
  call s:RefreshBreakpointSigns()
  call s:RefreshBreakpoints()
endfunction


function! s:ClearBreak()
  let s:breakpoints = {}
  call s:RefreshBreakpointSigns()
  call s:RefreshBreakpoints()
endfunction


function! s:RefreshBreakpointSigns()
  let buf = bufnr('%')
  let i = 5000
  while i <= s:max_breakpoint_sign_id
    exe 'sign unplace '.i
    let i += 1
  endwhile
  let s:max_breakpoint_sign_id = 0
  let id = 5000
  for linenr in keys(get(s:breakpoints, bufname('%'), {}))
    exe 'sign place '.id.' name=GdbBreakpoint line='.linenr.' buffer='.buf
    let s:max_breakpoint_sign_id = id
    let id += 1
  endfor
endfunction


function! s:RefreshBreakpoints()
  if !exists('g:gdb')
    return
  endif
  if g:gdb._parser.state() == s:GdbRunning
    " pause first
    call jobsend(g:gdb._client_id, "\<c-c>")
  endif
  if g:gdb._has_breakpoints
    call g:gdb.send('delete')
  endif
  let g:gdb._has_breakpoints = 0
  for [file, breakpoints] in items(s:breakpoints)
    for linenr in keys(breakpoints)
      let g:gdb._has_breakpoints = 1
      call g:gdb.send('break '.file.':'.linenr)
    endfor
  endfor
endfunction


function! s:GetExpression(...) range
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][:col2 - 1]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction


function! s:Send(data)
  if !exists('g:gdb')
    throw 'Gdb is not running'
  endif
  call g:gdb.send(a:data)
endfunction


function! s:Eval(expr)
  call s:Send(printf('print %s', a:expr))
endfunction


function! s:Watch(expr)
  let expr = a:expr
  if expr[0] != '&'
    let expr = '&' . expr
  endif

  call s:Eval(expr)
  call s:Send('watch *$')
endfunction


function! s:Interrupt()
  if !exists('g:gdb')
    throw 'Gdb is not running'
  endif
  call jobsend(g:gdb._client_id, "\<c-c>info line\<cr>")
endfunction


function! s:Kill()
  if !exists('g:gdb')
    throw 'Gdb is not running'
  endif
  call g:gdb.kill()
endfunction


command! -nargs=1 GdbDebugServer call s:Spawn(0, s:run_gdb, ''.<q-args>.':'.s:gdb_port, 0)
command! GdbDebugStop call s:Kill()
command! GdbToggleBreakpoint call s:ToggleBreak()
command! GdbClearBreakpoints call s:ClearBreak()
command! GdbContinue call s:Send("c")
command! GdbNext call s:Send("n")
command! GdbStep call s:Send("s")
command! GdbFinish call s:Send("finish")
command! GdbFrameUp call s:Send("up")
command! GdbFrameDown call s:Send("down")
command! GdbInterrupt call s:Interrupt()
command! GdbRefresh call s:RefreshBreakpoints()
command! GdbEvalWord call s:Eval(expand('<cword>'))
command! -range GdbEvalRange call s:Eval(s:GetExpression(<f-args>))
command! GdbWatchWord call s:Watch(expand('<cword>')
command! -range GdbWatchRange call s:Watch(s:GetExpression(<f-args>))


nnoremap <silent> <f1> :GdbToggleBreakpoint<cr>

nnoremap <silent> <f8> :GdbContinue<cr>

nnoremap <silent> <f9> :GdbEvalWord<cr>
vnoremap <silent> <f9> :GdbEvalRange<cr>

nnoremap <silent> <m-f9> :GdbWatchWord<cr>
vnoremap <silent> <m-f9> :GdbWatchRange<cr>

nnoremap <silent> <f10> :GdbNext<cr>
nnoremap <silent> <f11> :GdbStep<cr>
nnoremap <silent> <f12> :GdbFinish<cr>

nnoremap <silent> <m-pageup> :GdbFrameUp<cr>
nnoremap <silent> <m-pagedown> :GdbFrameDown<cr>
