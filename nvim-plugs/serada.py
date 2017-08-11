from multiprocessing import Process, JoinableQueue, Lock
from multiprocessing.sharedctypes import Value

import neovim
import os
import re
import shutil
import subprocess
import tempfile
import time

@neovim.plugin
class Ser(object):#sirsirsirsirs-ir-ser-ser
    def __init__(self, nvim):
        # These should be constant
        self.nvim = nvim
        self.cacheDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.sircache' )
        self.backupDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.serbackup' )
        self.cacheReplaceDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.serReplaceUp' )
        self.searchCacheSuggestionFile    = os.path.join(self.cacheDir, 'sirSuggest.ser')

        if not os.path.exists(self.cacheDir):
            os.makedirs(self.cacheDir)
        if not os.path.exists(self.backupDir):
            os.makedirs(self.backupDir)
        if not os.path.exists(self.cacheReplaceDir):
            os.makedirs(self.cacheReplaceDir)

        # needs to be lowercase, let user know they should add onto this list...?
        # I need to find somewhere that docs all these and make a "Complete" list
        # TODO FIXME
        self.extensionBlackList  = (
            '.pdf','.safariextz','.idx','.store','.ap_','.webm','.aar',
            '.gif','.pack','.sym','.keystream','.values','.shada','.tzo','.db','.sqlite','.ttf','.dex',
            '.bin', '.dat', '.tar', '.gz' , '.properties', '.json' ,
            '.xml', '.so' , 'r.java', '.class', '.jar' , '.png' , '.jpg' ,
            'r.txt', '.pyc' , '.ser', 'tags', '.taghl', '.fls', '.ppt', '.tif', '.bmp', '.exe', '.dcx', '.ico', '.dll', '.apk',
            'gpath', '.png', '=', '.rawproto', '.svn-base', '.pnm', '.eot', '.zip', '.gitignore',
        )
        self.dirNameBlackList  = (
            "AppData",
        )

        self.progressBuffer = None
        self.ignoreDotFiles = True
        self.whitelist     =      ()

        # Searching vars
        # These DON'T need to reset each time :)
        self.calls       = 0
        #  self.dictResults = {}
        #  self.searchBuffers = {}
        self.searchBuffer = None
        self.cwd = os.getcwd()
        self.filesCached = False
        self.temp        = tempfile.NamedTemporaryFile(mode   = 'w')

        # These NEED to be threadsafe
        self.readyToReplace = False
        self.finSearching   = True
        self.mutex          = Lock ()

        #  These get reset each time...
        self.skipper       = []
        self.files         = []
        self.tempFiles     = []
        self.results   = []
        self.patString     = ""
        self.pat           = None
        self.folds         = []
        self.foldsplit     = ""
        self.fileIndex     = 0
        self.ind           = 0

        # Speeding this up
        self.processes    = []
        self.queue        = JoinableQueue()
        self.result_queue = JoinableQueue()
        self.writer_queue = JoinableQueue()
        self.value = Value('i',0)

        self.p=Finder(self.queue, self.result_queue, self.writer_queue, self.value)

        #  for i in range(0, 16):
        #      p = Finder(self.queue, self.result_queue, self.writer_queue, value)
        #      p.start()
        #      self.processes.append(p)

        self.writer = Writer(self.temp, self.writer_queue)
        #  self.writer.start()

    @neovim.command("SerAcceptReplace", sync=True)
    def ser_accept(self):
        # If we haven't run replace don't accept a replace >.>
        if not self.readyToReplace:
            self.nvim.err_write("You should probably run Ser find replace first!\n")
            return
        start = time.time()
        # Cycle through the results
        for result in self.dictResults[self.searchBuffer.win.number]:
            # Skip those we didn't find anything in
            if not self.skipper[result.fileIndex] and not result.is_all_greyed():
                fi = self.tempFiles[result.fileIndex].rstrip()
                # If we modified the buffer then make sure we apply them...
                if result.overRideLineNumbers or result.killLineNumbers:
                    temper = os.path.join( self.cacheReplaceDir, fi.replace("/","?" ))
                    shutil.copyfile(fi, temper)
                    self.find_in_file(fi, temper, result)
                    fi = temper
                shutil.copyfile(self.files[result.fileIndex], os.path.join( self.backupDir, self.files[result.fileIndex].replace("/","?" )))
                os.replace(fi, self.files[result.fileIndex])

        # Reset vars!
        self.nvim.current.window = self.searchBuffer.win.number
        self.nvim.command("bw!")
        prewin = self.nvim.current.window

        # Close buffers and notify the user
        self.nvim.out_write("Fin Accept{} : If you replaced in an open buffer you should reload them (hint: run argdo e)!\n".format(time.time() - start))

    @neovim.command("Ser", range='', nargs='+', complete='custom,SirSuggestSearch')
    def ser(self,args,range):
        if len(args) > 2:
            self.nvim.err_write("Max args of 2 can be passed to Ser\n");
            return;
        elif len(args) == 2:
            if not self.finSearching:
                self.nvim.err_write("Can only run one replace at a time!\n")
                return
            elif args[0] == args[1]:
                self.nvim.err_write("You can't replace with the same value!\n")
                return
            else:
                self.readyToReplace = False
        elif len(args) == 1:
            if not self.finSearching:
                self.nvim.err_write("Can only run one search at a time!\n")
                return

        start = time.time()
        self.finSearching = False
        self.temp.seek(0)
        self.temp.truncate()

        with open(self.searchCacheSuggestionFile, 'a+') as wf:
            wf.seek(0)
            if not any(args[0] == l.rstrip() for l in wf.readlines()):
                wf.write(args[0] + '\n')
            if len(args) == 2:
                if not any(args[1] == l.rstrip() for l in wf.readlines()):
                    wf.write(args[1] + '\n')

        # Reset these
        self.skipper   = []
        self.tempFiles = []
        self.results   = []
        self.patString = args[0]
        self.pat       = re.compile(self.patString)
        self.folds     = self.nvim.vars[self.foldMarkerKey]
        self.foldsplit = self.folds.split(',')
        self.fileIndex = 0
        self.ind       = 0

        self.make_progress_scratch()

        if len(args) == 1:
            self.temp.write("Find actions : e/o=open, v=vsplit, s=split, p=preview\n")
            self.value.value = 2
        elif len(args) == 2:
            self.temp.write("Repl actions : d=delete line, <bs>=ignore line, <cr><cr>=Accept replace\n")
            self.temp.write("Find actions : e/o=open, v=vsplit, s=split, p=preview\n")
            self.repl     = args[1]
            self.replpat  = self.patString
            self.replrepl = re.compile(self.repl)
            self.value.value = 3

        def process(fi):
            self.queue.put((fi, self.pat, self.foldsplit))
            result = self.p.run()
            self.writer.run()
            self.nvim.out_write("start : {} end: {} lineNumbers : {} \n".format(result.start, result.end, result.lineNumbers))

        #  Get me some files
        if (not self.filesCached):
            for dirpath,filenames in self.omni_walk():
                for fi in filenames:
                    fi = os.path.join(dirpath,fi).rstrip()
                    self.files.append(fi)
        for fi in self.files:
            process(fi)

        self.nvim.out_write("here 1" + " \n")
        self.filesCached = True
        self.readyToReplace = True

        self.queue.join()
        self.nvim.out_write("here 2" + " \n")
        self.writer_queue.join()
        self.nvim.out_write("here 3" + " \n")

        self.temp.flush()
        os.fsync(self.temp)

        if len(args) == 1:
            self.make_scratch(args[len(args) - 1], 'SER')
        else:
            self.make_scratch(args[len(args) - 1], 'SERR')

        self.nvim.out_write("here 4" + " \n")
        #  self.results = self.result_queue.get(True, 5)

        self.nvim.out_write(str(self.results) + "\n")
        self.nvim.out_write("Fin {} \n".format(time.time() - start))


    def make_progress_scratch(self):
        prewin = self.nvim.current.window

        if self.progressBuffer == None:
            self.nvim.command('silent {} {}'.format("botright", "1new"))
            pbuf = self.nvim.current.buffer
            pwin = self.nvim.current.window

            pbuf.options['buftype']    = 'nofile'
            pbuf.options['filetype']   = "SER_PROGRESS"
            pbuf.options['bufhidden']  = 'hide'
            pbuf.options['buflisted']  = True
            pbuf.options['modifiable'] = False
            pbuf.options['readonly']   = True
            pbuf.options['undolevels'] = -1
            pbuf.options['swapfile']   = False
            pbuf.options['buflisted']  = False
            pwin.options['cursorline'] = False
            pwin.options['cc'] = ""

            self.progressBuffer = pbuf
            self.nvim.current.window = prewin

    def make_scratch(self, mat, sername):
        prewin = self.nvim.current.window

        if self.searchBuffer is not None:
            self.nvim.out_write('{}\n'.format(str(self.searchBuffer.buf.vars.get('windows'))))
            try:
                self.nvim.current.window = self.searchBuffer.win
                self.nvim.command("bw!")
                self.nvim.current.window = prewin
            except:
                lol = ""

        self.calls = self.calls + 1
        self.nvim.command('silent {} {}'.format(self.nvim.vars[self.openSerMethodKey],self.temp.name))

        pbuf = self.nvim.current.buffer
        pwin = self.nvim.current.window
        pbuf.options['buftype']    = 'nofile'
        pbuf.options['filetype']   = sername
        pbuf.options['bufhidden']  = 'hide'
        pbuf.options['buflisted']  = True
        pbuf.options['modifiable'] = False
        pbuf.options['readonly']   = True
        pbuf.options['undolevels'] = -1
        pbuf.options['swapfile']   = False
        pbuf.options['buflisted']  = False
        pwin.options['foldmarker'] = self.folds
        pwin.options['foldlevel'] = 0
        pwin.options['foldmethod'] = 'marker'
        pwin.options['wrap']       = self.nvim.vars[self.wrapKey]
        pwin.options['cursorline'] = False
        self.nvim.command("setlocal ar")
        self.nvim.command('setlocal nonu')

        #  self.sbuf = SearchBuffer(pbuf, pwin, SearchBuffer.get_key(pbuf,pwin))
        #  self.searchBuffers[self.sbuf.ID] = self.sbuf
        self.searchBuffer = SearchBuffer(pbuf, pwin, SearchBuffer.get_key(pbuf,pwin))
        #  self.nvim.out_write("{}\n".format(self.sbuf.ID))

        if sername == "SERR":
            self.nvim.command('map <buffer><nowait><cr><cr> :call SirActionTime(line(\".\"), {})<cr>'.format("\"accept\""))
            self.nvim.command('map <buffer><nowait><bs> :call SirActionTime(line(\".\"), {})<cr>'.format("\"toggle_grey\""))
            self.nvim.command('map <buffer><nowait>d :call SirActionTime(line(\".\"), {})<cr>'.format("\"toggle_kill\""))
            #TODO other editing tools!! but what could i add...
        elif sername == "SER":
            self.finSearching = True

        # Normal overwrite edit
        self.nvim.command('map <buffer><nowait>e :call SirActionTime(line(\".\"), {})<cr>'.format("\"e\""))
        self.nvim.command('map <buffer><nowait>o :call SirActionTime(line(\".\"), {})<cr>'.format("\"e\""))

        #TODO Make silent versions of these! ?? be easy...
        self.nvim.command('map <buffer><nowait>v :call SirActionTime(line(\".\"), {})<cr>'.format("\"vsp\""))
        self.nvim.command('map <buffer><nowait>t :call SirActionTime(line(\".\"), {})<cr>'.format("\"tabedit\""))
        self.nvim.command('map <buffer><nowait>s :call SirActionTime(line(\".\"), {})<cr>'.format("\"sp\""))
        self.nvim.command('map <buffer><nowait>p :call SirActionTime(line(\".\"), {})<cr>'.format("\"prev\""))

        foldsplit = self.nvim.vars[self.foldMarkerKey].split(',')
        mat = mat
        #  self.nvim.out_write("{}\n".format(mat))
        self.nvim.command( 'syntax match SerFind /{}\|{}/'.format(mat , re.escape(mat)))
        self.nvim.command( 'syntax match SerNumber /{}/'.format('^\d*\s*') )
        self.nvim.command( 'syntax match SerFile /{}.*\|{}/'.format(foldsplit[0],foldsplit[1]) )

        pbuf.add_highlight('SerHelp', 0, 0)
        if sername == "SERR":
            pbuf.add_highlight('SerHelp', 1, 0)

        # See if i should make this a var?
        # self.nvim.current.window = prewin

        return (pbuf,pwin)

    @neovim.function("SirActionTime", sync=True)
    def ser_action_time(self, args):
        def toggle_line(greyorkill):
            if greyorkill == "SerGreyOut":
                greyed = i.toggle_over_ride_for_line(index,i.overRideLineNumbers,i.killLineNumbers)
            elif greyorkill == "SerKill":
                greyed = i.toggle_over_ride_for_line(index,i.killLineNumbers,i.overRideLineNumbers)

            if greyed:
                self.sbuf.buf.add_highlight(greyorkill, nu - 1, 0)
            else:
                self.sbuf.buf.clear_highlight(nu - 1, 0)
                self.sbuf.buf.add_highlight('SerNumber', nu -1 , 0, 10)
                for tup in i.get_match_start_and_end(index):
                    self.sbuf.buf.add_highlight('SerFind'  , nu -1 , 11 + tup[0], 11 + tup[1])

        nu = args[0]
        fun = args[1]
        for i in self.dictResults[self.searchBuffer.buf.number]:
            true = i.in_my_range(nu)
            #  self.nvim.out_write("e : {} s : {} nu : {}\n".format(i.end, i.start, nu))
            if true:
                index = i.convert_nu_to_index(nu)
                if fun == "toggle_grey" or fun == "toggle_kill":
                    # TODO consider adding toggle allunder file if on name...?
                    if i.is_nu_start_or_end(nu):
                        lol = "fuck"
                    else:
                        if fun == "toggle_grey":
                            toggle_line("SerGreyOut")
                        elif fun == "toggle_kill":
                            toggle_line("SerKill")

                elif fun == "vsp" or fun == "tabedit" or fun == "sp" or fun == "e":
                    try:
                        self.nvim.command( "{} {}".format(fun, i.fileName) )
                    except Exception:
                        lol = ""
                elif fun == "accept":
                    self.ser_accept()
                elif fun == "prev":
                #TODO make this a var for user -->(10) also for all other sp/vsp/etc
                    prewin = self.nvim.current.window
                    try:
                        if(self.sbuf.prev is not None):
                            self.nvim.current.window = self.sbuf.prev
                            self.nvim.command( "{} {}".format('e', i.fileName) )
                        else:
                            self.nvim.command( "10{} {}".format('sp', i.fileName) )
                    except Exception:
                        lol = ""

                    if(self.sbuf.prev is None):
                        self.sbuf.prev = self.nvim.current.window

                    self.nvim.current.window = prewin

    def handle_var(self):
        #Keys users can pick
        self.nvim.command('nnoremap <nowait><leader>f :Ser ')
        self.useWhiteListKey              = 'Sir_useWhiteList'
        self.extensionBlackListKey        = 'Sir_extensionBlackList'
        self.whitelistKey                 = 'Sir_whiteList'
        self.tabLengthKey                 = 'Sir_tabLength'
        self.foldMarkerKey                = 'Sir_foldmarker'
        self.wrapKey                      = 'Sir_doWrap'
        self.showRealTimeKey              = 'Sir_realTime'
        self.openSerMethodKey             = 'Sir_openMethod'
        self.vars                         = {
                    self.useWhiteListKey     : False,
                    self.wrapKey             : False,
                    self.showRealTimeKey     : True,
                    self.whitelistKey        : self.whitelist,
                    self.extensionBlackListKey        : self.extensionBlackList,
                    self.tabLengthKey        : 4,
                    self.foldMarkerKey       : 'XX|>,<|XX',
                    self.openSerMethodKey    : 'vsp',
        }

        # Handle highlighting, users can pick !hlexists() ensures this :)
        self.nvim.command('exec printf(\"let g:Sir_Fg_Color=\'%s\' | let g:Sir_Bg_Color=\'%s\'\",synIDattr(hlID(\'Normal\'), \'fg#\'), synIDattr(hlID(\'Normal\'), \'bg#\'))')
        bg = self.nvim.vars['Sir_Bg_Color']
        fg = self.nvim.vars['Sir_Fg_Color']

        ctermorgui = ""
        number = '#ffaf00'
        kill   = '#ff0000'
        grey   = '#aaaaaa'
        fi     = '#ff00ff'
        he     = '#aaddaa'
        find   = '#ffff00'

        if len(fg) > 3 or len(bg) > 3:
            ctermorgui = 'gui'
        else:
            ctermorgui = 'cterm'
            if len(fg) == 0:
                fg = '0'
            if len(bg) == 0:
                bg = '15'
            number = '3'
            kill   = '1'
            grey   = '8'
            fi     = '5'
            he     = '2'
            find   = '11'

        self.nvim.command('if !hlexists( \'SerNone\')    | hi SerNone    ' + ctermorgui + 'fg = ' + fg     + ' ' + ctermorgui + 'bg = ' + bg   + ' ' + ctermorgui + ' = {}'.format('none'))
        self.nvim.command('if !hlexists( \'SerNumber\')  | hi SerNumber  ' + ctermorgui + 'fg = ' + number + ' ' + ctermorgui + 'bg = ' + bg   + ' ' + ctermorgui + ' = {}'.format('bold'))
        self.nvim.command('if !hlexists( \'SerKill\')    | hi SerKill    ' + ctermorgui + 'fg = ' + bg     + ' ' + ctermorgui + 'bg = ' + kill + ' ' + ctermorgui + ' = {}'.format('italic'))
        self.nvim.command('if !hlexists( \'SerGreyOut\') | hi SerGreyOut ' + ctermorgui + 'fg = ' + bg     + ' ' + ctermorgui + 'bg = ' + grey + ' ' + ctermorgui + ' = {}'.format('italic'))
        self.nvim.command('if !hlexists( \'SerFile\')    | hi SerFile    ' + ctermorgui + 'fg = ' + fi     + ' ' + ctermorgui + 'bg = ' + bg   + ' ' + ctermorgui + ' = {}'.format('bold'))
        self.nvim.command('if !hlexists( \'SerHelp\')    | hi SerHelp    ' + ctermorgui + 'fg = ' + he     + ' ' + ctermorgui + 'bg = ' + bg   + ' ' + ctermorgui + ' = {}'.format('underline'))
        self.nvim.command('if !hlexists( \'SerFind\')    | hi SerFind    ' + ctermorgui + 'fg = ' + bg     + ' ' + ctermorgui + 'bg = ' + find + ' ' + ctermorgui + ' = {}'.format('bold'))

        for key in self.vars:
            if ( not key in self.nvim.vars ):
                self.nvim.vars[key] = self.vars[key]

    @neovim.function("SirReopenSuggest", sync=True)
    def sir_reopen_suggest(self,args):
        return "\n".join(str(s) for s in self.buflist)

    @neovim.command("SirReopen", range='', nargs='1', complete='custom,SirReopenSuggest')
    def reopen_sir(self,args,range):
        self.nvim.command('vsplit {}'.format(args[0]))

    @neovim.function("SirSuggestSearch", sync=True)
    def sir_suggest_search(self, args):
        if not os.path.exists(self.searchCacheSuggestionFile):
            return ''
        with open(self.searchCacheSuggestionFile, 'r') as sf:
            return "".join(str(s) for s in sf.readlines())

    def omni_walk(self):
        start = time.time()
        extensionBlackList = self.nvim.vars[ self.extensionBlackListKey ]
        for dirpath, dirnames, filenames in os.walk(self.cwd):

            dirnames[:] = [
                    dn for dn in dirnames
                    if not ( (self.ignoreDotFiles and dn.startswith(".") ) or dn in self.dirNameBlackList )
            ]

            filenames[:] = [
                    fn for fn in filenames
                    if not ( (self.ignoreDotFiles and fn.startswith(".") ) or fn.endswith(tuple(extensionBlackList)) )
            ]

            yield dirpath, filenames

    @neovim.autocmd('VimEnter', pattern='*')
    def on_vimenter(self):
        self.handle_var()
        self.omni_walk()

    @neovim.autocmd('VimLeave', pattern='*')
    def on_vimleave(self):
        self.temp.close()
        if False:
            self.writer_queue.put(None)
            self.writer_queue.join()

        for p in self.processes:
            self.queue.put(None)
        self.queue.join()

        #  self.result_queue.join()

    @neovim.autocmd('DirChanged', pattern='*', eval="getcwd()")
    def on_dirchanged(self, newcwd):
        if newcwd != self.cwd:
            self.files = []
            self.filesCached = False
            self.cwd = newcwd

    @neovim.autocmd('BufEnter', pattern='*', eval='&filetype')
    def on_bufenter(self, filetype):
        if filetype == 'SER' or filetype == 'SERR':
            self.nvim.current.window.options['cursorline'] = False

    @neovim.autocmd('BufWinLeave,TabLeave', pattern='*', eval='&filetype')
    def on_bufwinleave(self, filetype):
        try:
            if filetype == 'SERR':
                self.finSearching = True
                self.readyToReplace = False
                self.nvim.out_write("Fin Replacing!!\n");
        except Exception:
            lol = ""

class SearchBuffer():
    def __init__(self, buf, win, ID):
        self.buf  = buf
        self.win  = win
        self.prev = None
        self.ID = ID

    def get_key(buf, win):
        return "buf{}win{}".format(buf.number, win.number)

    def set_prev(self,prev):
        if self.prev is None:
            self.prev = prev

class Result():
    def __init__(self, lineNumbers, allMatches, fileName):
        self.fileName            = fileName
        self.lineNumbers         = lineNumbers
        self.allMatches          = allMatches
        self.overRideLineNumbers = []
        self.killLineNumbers     = []

    def is_all_greyed(self):
        return len(self.overRideLineNumbers) == len(self.lineNumbers);

    def in_my_range(self, point):
        return point <= self.end and point >= self.start

    def convert_nu_to_index(self, nu):
        return nu - self.start - 1;

    def is_nu_start_or_end(self, nu):
        return nu == self.start or nu == self.end ;

    def get_match_start_and_end(self, index):
        return [(m.start(),m.end()) for m in self.allMatches[index]];

    def toggle_over_ride_for_line(self, index, curlist, otherlist):
        linenr = self.lineNumbers[index]
        if linenr not in curlist:
            curlist.append(linenr)
            if linenr in otherlist:
                otherlist.remove(linenr)
            return True
        else:
            curlist.remove(linenr)
            return False

class Finder(Process):
    def __init__(self, queue, result_queue, writer_queue, line_count):
        super(Finder, self).__init__()
        self.queue = queue
        self.results = []
        self.currentResult = None
        self.mutex = Lock()
        self.result_queue = result_queue
        self.writer_queue = writer_queue
        self.line_count = line_count

    def run(self):
        #  while True:
        item = self.queue.get()
        if item is None:
            self.queue.task_done()
            #  break;
        write = self.find_in_file(item[0], item[1], item[2])
        if write:
            with self.mutex:
                self.currentResult.start = self.line_count.value
                self.line_count.value   += len(write)
                self.currentResult.end   = self.line_count.value - 2
                self.result_queue.put(self.currentResult)
                self.writer_queue.put(write)
        self.queue.task_done()
        return self.currentResult


    def find_in_file(self,fi, pat, foldsplit, repl = None, tempcache = None, result = None):
        rtn = []
        # if we are replacing open the file
        if tempcache is not None:
            cacheFile = open(tempcache, "w")

        # We need to open the file we are looking at...
        with open(fi, 'r+') as curFile:
            titled = False
            wroteto = False
            lineNumbers = []
            allMatches = []

            try:
                # For each line get the match
                for linenr,line in enumerate(curFile.readlines(), 1):
                    matches = list(filter(lambda true:true, (match for match in pat.finditer(line))))

                    # If we are replacing write to cacheFile
                    if tempcache is not None:
                        # And accepting, then ignore line numbers or kill them
                        if result is not None:
                            if linenr in result.overRideLineNumbers:
                                line = self.pat.sub(repl, line)
                            elif linenr in result.killLineNumbers:
                                line = ""
                        # other wise just replace
                        else:
                            line = self.pat.sub(repl, line)
                        cacheFile.write(line)

                    # If we got a match, append the data to list and update ind
                    if( len( matches ) > 0 ):
                        lineNumbers.append(linenr)
                        allMatches.append(matches)
                        # If we AREN'T accepting, then we need to title the temp
                        if result is None:
                            if not titled:
                                rtn.append(foldsplit[0] + curFile.name + "\n")
                                wroteto = True
                                titled = True
                            rtn.append("{:<10} {}".format(linenr, line))
                            self.currentResult = Result( lineNumbers, allMatches, curFile.name )

                # If we are replacing clean up the cacheFile
                if tempcache is not None:
                    cacheFile.flush()
                    cacheFile.close()

                # If we aren't accepting, write temp info
                if result is None :
                    # If we did work, show it otherwise we will skip this later
                    if wroteto:
                        rtn.append(foldsplit[1] + "\n")
                        rtn.append("\n")

                return rtn

            except UnicodeDecodeError:
                ifitsnotunicodeithasbinarynothankyou = ""
            except PermissionError:
                windowsisderpderp = ""

class Writer(Process):
    def __init__(self, temp, writer_queue):
        super(Writer, self).__init__()
        self.temp = temp
        self.writer_queue = writer_queue

    def run(self):
        #  while True:
        try:
            item = self.writer_queue.get(False)
            if item is None:
                self.writer_queue.task_done()
                #  break;
            for r in item:
                self.temp.write(r)

            self.writer_queue.task_done()
        except Exception:
            lol = ""
        return
