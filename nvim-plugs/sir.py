import os
from threading import Lock

import shutil
import re
import subprocess
import tempfile
import time
from stat import S_ISREG
import neovim
import sys

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
        self.blacklist  = (
                '.pdf','.safariextz','.idx','.store','.ap_','.webm','.aar',
                '.gif','.pack','.sym','.keystream','.values','.shada','.tzo','.db','.sqlite','.ttf','.dex',
                '.bin', '.dat', '.tar', '.gz' , '.properties', '.json' ,
                '.xml', '.so' , 'r.java', '.class', '.jar' , '.png' , '.jpg' ,
                'r.txt', '.pyc' , '.ser', 'tags', '.taghl', '.fls', '.ppt', '.tif', '.bmp', '.exe', '.dcx', '.ico', '.dll', '.apk',
                'gpath', '.png', '=', '.rawproto', '.svn-base', '.pnm', '.eot', '.zip', '.gitignore'
        )
        self.whitelist     =      ()

        # Searching vars
        # These DON'T need to reset each time :)
        self.calls       = 0
        self.buflist     = []
        self.dictResults = {}
        self.searchBuffers = []

        # These NEED to be threadsafe
        self.readyToReplace    = False
        self.finishedReplacing = True
        self.mutex             = Lock ()

        #  These get reset each time...
        self.replaceBufWin = ()
        self.skipper       = []
        self.files         = []
        self.tempFiles     = []
        self.resultIndex   = []
        self.patString     = ""
        self.pat           = None
        self.temp          = None
        self.folds         = []
        self.foldsplit     = ""
        self.fileIndex     = 0
        self.ind           = 0

# If we have a tempcache: we are replacing
# If we have a result   : we are accepting
    def find_in_file(self,fileLine, tempcache = None, result = None):
        # if we are replacing open the file
        if tempcache is not None:
            cacheFile = open(tempcache, "w")
            # if we aren't accepting, then we should set the defaults
            if result is None:
                self.mutex.acquire()
                self.finishedReplacing = False
                self.replpat  = self.patString
                self.replrepl = re.compile(self.repl)
                self.mutex.release()

        # We need to open the file we are looking at...
        with open(fileLine, 'r+') as curFile:
            titled = False
            wroteto = False
            lastind = self.ind
            lineNumbers = []
            allMatches = []

            try:
                # For each line get the match
                for linenr,line in enumerate(curFile.readlines(), 1):
                    matches = list(filter(lambda true:true, (match for match in self.pat.finditer(line))))

                    # If we are replacing write to cacheFile
                    if tempcache is not None:
                        # And accepting, then over line numbers or kill them
                        if result is not None:
                            if linenr in result.overRideLineNumbers:
                                #  self.nvim.out_write("Linenr to modify! {}\n".format( linenr ))
                                line = self.pat.sub(self.repl, line)
                            elif linenr in result.killLineNumbers:
                                line = ""
                        # other wise just replace
                        else:
                            line = self.pat.sub(self.repl, line)
                        cacheFile.write(line)

                    # If we got a match, append the data to list and update ind
                    if( len( matches ) > 0 ):
                        lineNumbers.append(linenr)
                        allMatches.append(matches)
                        self.ind += 1
                        # If we AREN'T accepting, then we need to title the temp
                        if result is None:
                            if not titled:
                                self.temp.write(self.foldsplit[0] + curFile.name + "\n")
                                wroteto = True
                                titled = True
                            self.temp.write("{:<10} {}".format(linenr, line))

                # If we are NOT accepting, we write a temp buffer for the user
                if result is None :
                    # If we did work, show it otherwise we will skip this later
                    if wroteto:
                        self.temp.write(self.foldsplit[1] + "\n")
                        self.temp.write("\n")
                        self.resultIndex.append( Result( lastind, self.ind + 1, self.fileIndex, lineNumbers, allMatches, curFile.name) )
                        self.skipper.append ( False )
                        self.ind += 3
                    else:
                        self.skipper.append ( True )

                # If we are replacing clean up the cacheFile
                if tempcache is not None:
                    cacheFile.flush()
                    cacheFile.close()

                # lets update the buffer now
                return wroteto

            except UnicodeDecodeError:
                ifitsnotunicodeithasbinarynothankyou = ""
            except PermissionError:
                windowsisderpderp = ""

    @neovim.command("SerAcceptReplace", sync=True)
    def ser_accept(self):
        # If we haven't run replace don't accept a replace >.>
        if not self.readyToReplace:
            self.nvim.err_write("You should probably run Ser find replace first!\n")
            return
        start = time.time()
        # Cycle through the results
        for result in self.dictResults[self.replaceBufWin[0].number]:
            # Skip those we didn't find anything in
            if not self.skipper[result.fileIndex]:
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
        self.mutex.acquire()
        self.readyToReplace=False
        self.finishedReplacing=True
        self.nvim.current.window = self.replaceBufWin[1]
        self.mutex.release()
        prewin = self.nvim.current.window

        # Close buffers and notify the user
        self.nvim.command("q!")
        self.nvim.out_write("Fin Accept{} : If you replaced in an open buffer you should reload them (hint: run argdo e)!\n".format(time.time() - start))

    @neovim.command("Ser", range='', nargs='+', complete='custom,SirSuggestSearch')
    def ser(self,args,range):
        if len(args) > 2:
            self.nvim.err_write("Max args of 2 can be passed to Ser\n");
            return;
        elif len(args) == 2:
            if not self.finishedReplacing:
                self.nvim.err_write("Can only run one replace at a time!\n")
                return
            elif args[0] == args[1]:
                self.nvim.err_write("You can't replace with the same value!\n")
                return
            else:
                self.mutex.acquire()
                self.readyToReplace = False
                self.mutex.release()

        with open(self.searchCacheSuggestionFile, 'a+') as wf:
            wf.seek(0)
            if not any(args[0] == l.rstrip() for l in wf.readlines()):
                wf.write(args[0] + '\n')
            if len(args) == 2:
                if not any(args[1] == l.rstrip() for l in wf.readlines()):
                    wf.write(args[1] + '\n')

        start = time.time()

        # Reset these
        self.skipper     = []
        self.files       = []
        self.tempFiles   = []
        self.resultIndex = []
        self.patString   = args[0]
        self.pat         = re.compile(self.patString)
        self.temp        = tempfile.NamedTemporaryFile(mode   = 'w')
        self.folds       = self.nvim.vars[self.foldMarkerKey]
        self.foldsplit   = self.folds.split(',')
        self.fileIndex   = 0
        self.ind         = 0

        # Get me some files
        self.omni_walk()

        for self.fileIndex, fi in enumerate(self.files, 0):
            fi = fi.rstrip()
            if len(args) == 1:
                wroteto = self.find_in_file(fi)
                #  if wroteto:
                    #  self.nvim.command("silent! checktime")
            else:
                self.mutex.acquire()
                self.readyToReplace = True
                self.mutex.release()
                self.repl = args[1]
                self.find_in_file(fi, self.tempFiles[self.ind])

        self.temp.flush()
        os.fsync(self.temp)

        if len(args) == 1:
            self.make_scratch(args[len(args) - 1], 'SER')
        else:
            # These aren't needed but... just in case I decide they are
            #  self.mutex.acquire()
            self.replaceBufWin = self.make_scratch(args[len(args) - 1], 'SERR')
            #  self.mutex.release()

        self.temp.close()

        self.nvim.out_write("Fin {} \n".format(time.time() - start))

    def make_scratch(self, mat, sername):
        prewin = self.nvim.current.window
        self.calls = self.calls + 1
        if sername == "SER":
            self.buflist.append(self.temp.name)
        # TODO make this user option sp, tabedit, e, or vsp maybe qf...?
        self.nvim.command('silent vsp {}'.format(self.temp.name))

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
        self.nvim.command("setlocal ar")
        self.nvim.command('setlocal nonu')

        self.sbuf = SearchBuffer(pbuf, pwin)
        self.dictResults[self.sbuf.buf.number] = self.resultIndex

        if self.readyToReplace:
            self.nvim.command('map <buffer><nowait><cr><cr> :call SirActionTime(line(\".\"), {})<cr>'.format("\"accept\""))
            self.nvim.command('map <buffer><nowait><bs> :call SirActionTime(line(\".\"), {})<cr>'.format("\"toggle_grey\""))
            self.nvim.command('map <buffer><nowait>d :call SirActionTime(line(\".\"), {})<cr>'.format("\"toggle_kill\""))
            #TODO other editing tools!! but what could i add...

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
        self.nvim.out_write("{}\n".format(mat))
        self.nvim.command( 'syntax match SerFind /{}\|{}/'.format(mat , re.escape(mat)))
        self.nvim.command( 'syntax match SerNumber /{}/'.format('^\d*\s*') )
        self.nvim.command( 'syntax match SerFile /{}.*\|{}/'.format(foldsplit[0],foldsplit[1]) )

        self.nvim.current.window = prewin

        return (pbuf,pwin)

    @neovim.function("SirActionTime", sync=True)
    def ser_action_time(self, args):
        nu = args[0]
        fun = args[1]
        for i in self.dictResults[self.sbuf.buf.number]:
            true = i.in_my_range(nu)
            #  self.nvim.out_write("e : {} s : {} nu : {}\n".format(i.end, i.start, nu))
            if true:
                if fun == "toggle_grey" or fun == "toggle_kill":
                    if i.is_nu_start_or_end(nu):
                        greyed = i.toggle_over_ride_for_line(index)
                        if greyed:
                            self.sbuf.buf.add_highlight('SerGreyOut', nu - 1, 0)
                        else:
                            self.sbuf.buf.add_highlight('SerBack', nu - 1, 0)
                            self.sbuf.buf.add_highlight('SerNumber', nu -1 , 0, 10)
                            for tup in i.get_match_start_and_end(index):
                                self.sbuf.buf.add_highlight('SerFind'  , nu -1 , 11 + tup[0], 11 + tup[1])
                    else:
                        index = i.convert_nu_to_index(nu)
                        self.nvim.out_write("{}\n".format(index))
                        if fun == "toggle_grey":
                            greyed = i.toggle_over_ride_for_line(index)
                            if greyed:
                                self.sbuf.buf.add_highlight('SerGreyOut', nu - 1, 0)
                            else:
                                self.sbuf.buf.add_highlight('SerBack', nu - 1, 0)
                                self.sbuf.buf.add_highlight('SerNumber', nu -1 , 0, 10)
                                for tup in i.get_match_start_and_end(index):
                                    self.sbuf.buf.add_highlight('SerFind'  , nu -1 , 11 + tup[0], 11 + tup[1])
                        elif fun == "toggle_kill":
                            killed = i.toggle_kill_for_line(index)
                            if killed:
                                self.sbuf.buf.add_highlight('SerKill', nu - 1, 0)
                            else:
                                self.sbuf.buf.add_highlight('SerBack', nu - 1, 0)
                                self.sbuf.buf.add_highlight('SerNumber', nu -1 , 0, 10)
                                for tup in i.get_match_start_and_end(index):
                                    self.sbuf.buf.add_highlight('SerFind'  , nu -1 , 11 + tup[0], 11 + tup[1])

                elif fun == "vsp" or fun == "tabedit" or fun == "sp" or fun == "e":
                    try:
                        self.nvim.command( "{} {}".format(fun, i.fileName) )
                    except Exception:
                        lol = ""
                elif fun == "accept":
                    self.ser_accept()
                elif fun == "prev":
                #TODO make this a var for user -->(10) also for sp/.../etc
                    prewin = self.nvim.current.window
                    #  key = self.get_p_key(self.sbuf.buf,self.pwin)
                    try:
                        if(key in self.preview):
                            self.nvim.current.window = self.preview[key]
                            self.nvim.command( "{} {}".format('e', i.fileName) )
                        else:
                            self.nvim.command( "10{} {}".format('sp', i.fileName) )
                    except Exception:
                        lol = ""
                    if(key in self.preview):
                        self.preview[key] = self.nvim.current.window

                    self.nvim.current.window = prewin

    def handle_var(self):
        #Keys users can pick
        self.nvim.command('nnoremap <nowait><leader>f :Ser ')
        self.useWhiteListKey              = 'Sir_useWhiteList'
        self.blacklistKey                 = 'Sir_blackList'
        self.whitelistKey                 = 'Sir_whiteList'
        self.tabLengthKey                 = 'Sir_tabLength'
        self.foldMarkerKey                = 'Sir_foldmarker'
        self.wrapKey                      = 'Sir_doWrap'
        self.showRealTimeKey              = 'Sir_realTime'
        self.vars                         = {
                    self.useWhiteListKey     : False,
                    self.wrapKey             : False,
                    self.showRealTimeKey     : True,
                    self.whitelistKey        : self.whitelist,
                    self.blacklistKey        : self.blacklist,
                    self.tabLengthKey        : 4,
                    self.foldMarkerKey       : 'XX|>,<|XX',
                    }

        # TODO Make sure user can set hi
        self.nvim.command('hi SerFind guifg=#000000 guibg=#88cccc gui=bold')
        self.nvim.command('hi SerFile guifg=#ff00ff guibg=none gui=bold')
        self.nvim.command('hi SerNumber guifg=#ffaa00 guibg=none gui=bold')
        self.nvim.command('hi SerGreyOut guifg=#aaaaaa guibg=#111111 gui=none')
        self.nvim.command('hi SerKill guifg=#ff0000 guibg=#111111 gui=none')
        self.nvim.command('exec printf(\"hi SerBack guifg=%s guibg=%s\", synIDattr(hlID(\'Normal\'), \'fg#\'), synIDattr(hlID(\'Normal\'), \'bg#\'))')

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

        blacklist = self.nvim.vars[ self.blacklistKey ]
        #  whitelist = self.nvim.vars[ self.nvim.vars[ self.whitelistKey ] ]

        for root, dirs, files in os.walk(os.getcwd()):
            for name in files:
                path = os.path.join(root,name)
                if ( ".git" in root ):
                    continue
                if ( name.lower().endswith( tuple( blacklist) ) ):
                    continue
                #  if ( not name.endswith( tuple ( whitelist) ) ):
                #      continue
                self.files.append( path )
                #TODO support for winders
                self.tempFiles.append( os.path.join( self.cacheDir, root.replace("/","?")+name ) )

    @neovim.autocmd('VimEnter', pattern='*')
    def on_vimenter(self):
        self.handle_var()

    @neovim.autocmd('BufEnter', pattern='*', eval='&filetype')
    def on_bufenter(self, filetype):
        self.nvim.out_write("{}\n".format(filetype))
        if filetype == 'SER' or filetype == 'SERR':
            self.sbuf.buf = self.nvim.current.buffer
            self.nvim.current.window.options['cursorline'] = False

    @neovim.autocmd('BufWinLeave', pattern='*', eval='&filetype')
    def on_bufwinleave(self, filetype):
        if filetype == 'SERR':
            self.nvim.command("bw {}".format(self.replaceBufWin[0].number))
            self.mutex.acquire()
            self.finishedReplacing = True
            self.readyToReplace = False
            self.mutex.release()
            self.replaceBufWin = ()
            self.nvim.out_write("Fin Replacing!!\n");
        elif filetype == "SER":
            popkey = "?"

class SearchBuffer():
    def __init__(self, buf, win):
        self.buf  = buf
        self.win  = win
        self.prev = None

    def get_key(self, buf, win):
        return "buf{}win{}".format(buf, win)


class Result():
    def __init__(self,start, end, fileIndex, lineNumbers, allMatches, fileName):
        self.start = start
        self.end   = end
        self.fileIndex = fileIndex
        self.fileName = fileName
        self.lineNumbers = lineNumbers
        self.allMatches = allMatches
        self.overRideLineNumbers = []
        self.killLineNumbers = []

    def in_my_range(self, point):
        return point <= self.end and point >= self.start

    def convert_nu_to_index(self, nu):
        return nu - self.start - 2;

    def is_nu_start_or_end(self, nu):
        return nu == self.start or nu == self.end + 1;

    def get_match_start_and_end(self, index):
        return [(m.start(),m.end()) for m in self.allMatches[index]];

    def toggle_over_ride_for_line(self, index):
        linenr = self.lineNumbers[index]
        def remove_values_from_list(the_list, val):
            return [value for value in the_list if value != val]
        if linenr not in self.overRideLineNumbers:
            self.overRideLineNumbers.append(linenr)
            if linenr in self.killLineNumbers:
                self.killLineNumbers = remove_values_from_list(self.killLineNumbers,linenr)
            return True
        else:
            self.overRideLineNumbers = remove_values_from_list(self.overRideLineNumbers,linenr)
            return False

    def toggle_kill_for_line(self, index):
        linenr = self.lineNumbers[index]
        def remove_values_from_list(the_list, val):
            return [value for value in the_list if value != val]
        if linenr not in self.killLineNumbers:
            self.killLineNumbers.append(linenr)
            if linenr in self.overRideLineNumbers:
                self.overRideLineNumbers = remove_values_from_list(self.overRideLineNumbers,linenr)
            return True
        else:
            self.killLineNumbers = remove_values_from_list(self.killLineNumbers,linenr)
            return False

