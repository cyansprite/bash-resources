import os
import shutil
import re
import subprocess
import tempfile
import time
from stat import S_ISREG
import neovim

@neovim.plugin
class Ser(object):#sirsirsirsirs-ir-ser-ser
    def __init__(self, nvim):
        self.nvim = nvim

        self.cachedFiles = []
        self.cacheDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.sircache' )
        self.backupDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.serbackup' )
        self.cacheReplaceDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.serReplaceUp' )
        self.filesFile          = os.path.join(self.cacheDir, 'filefile.ser')
        self.searchCacheSuggestionFile    = os.path.join(self.cacheDir, 'sirSuggest.ser')

        # needs to be lowercase
        self.blacklist  = (
                '.pdf','.safariextz','.idx','.store','.ap_','.webm','.aar',
                '.gif','.pack','.sym','.keystream','.values','.shada','.tzo','.db','.sqlite','.ttf','.dex',
                '.bin', '.dat', '.tar', '.gz' , '.properties', '.json' ,
                '.xml', '.so' , 'r.java', '.class', '.jar' , '.png' , '.jpg' ,
                'r.txt', '.pyc' , '.ser', 'tags', '.taghl', '.fls', '.ppt', '.tif', '.bmp', '.exe', '.dcx', '.ico', '.dll', '.apk',
                'gpath', '.png', '=', '.rawproto', '.svn-base', '.pnm', '.eot', '.zip', '.gitignore'

        )

        self.whitelist          = ()
        self.nvim.command('nnoremap <nowait><leader>f :Ser ')
        self.fileCached         = False
        self.buflist            = []
        self.files = []
        self.tempFiles = []
        self.skipper = []
        self.preview = ()

        #Keys users can pick
        self.filesFileKey        = 'Sir_filesFile'
        self.searchCacheSuggestionFileKey  = 'Sir_searchCacheSuggestionFile'
        self.cacheDirKey         = 'Sir_cacheDir'
        self.debugOutKey         = 'Sir_debugOut'
        self.useWhiteListKey     = 'Sir_useWhiteList'
        self.blacklistKey        = 'Sir_blackList'
        self.whitelistKey        = 'Sir_whiteList'
        self.ignoreHiddenDirKey  = 'Sir_ignoreHiddenDir'
        self.ignoreHiddenFileKey = 'Sir_ignoreHiddenFile'
        self.tabLengthKey        = 'Sir_tabLength'
        self.foldMarkerKey       = 'Sir_foldmarker'
        self.wrapKey             = 'Sir_doWrap'
        self.realTimeKey         = 'Sir_realTime'
        self.calls               = 0
        self.vars                = {
                    self.filesFileKey        : self.filesFile,
                    self.searchCacheSuggestionFileKey  : self.searchCacheSuggestionFile,
                    self.cacheDirKey         : self.cacheDir,
                    self.debugOutKey         : True,
                    self.useWhiteListKey     : False,
                    self.ignoreHiddenDirKey  : True,
                    self.ignoreHiddenFileKey : False,
                    self.wrapKey             : False,
                    self.realTimeKey         : True,
                    self.whitelistKey        : self.whitelist,
                    self.blacklistKey        : self.blacklist,
                    self.tabLengthKey        : 4,
                    self.foldMarkerKey       : 'XX|>,<|XX',
                    }
        if not os.path.exists(self.cacheDir):
            os.makedirs(self.cacheDir)
        if not os.path.exists(self.backupDir):
            os.makedirs(self.backupDir)
        if not os.path.exists(self.cacheReplaceDir):
            os.makedirs(self.cacheReplaceDir)

        #TODO might need a mutex here...
        self.readyToReplace=False
        self.finishedReplacing = True
        self.replaceBufWin = ()

        self.resultIndex = []

# I SHOULD fix these stupid if statements... they're fucked up FIXME
    # And using foldsplit and a result instead of a list? hacky bro..very hacky
# TODO add context/before/after
    def find_in_file(self,fileLine, pat, foldsplit, temp, ind, fileIndex, repl = "", tempcache = None, selfpat = ""):
        if tempcache is not None:
            cacheFile = open(tempcache, "w")
            if temp is not None:
                self.finishedReplacing=False
                self.pat = selfpat
                self.repl = re.compile(repl)

        with open(fileLine, 'r+') as curFile:
            titled = False
            wroteto = False
            lastind = ind
            lineNumbers = []
            allMatches = []

            try:
                for linenr,line in enumerate(curFile.readlines(), 1):
                    matches = list(filter(lambda true:true, (match for match in pat.finditer(line))))
                    if repl is not "":
                        if temp is None:
                            if linenr in foldsplit.overRideLineNumbers:
                                #  self.nvim.out_write("Linenr to modify! {}\n".format( linenr ))
                                line = pat.sub(repl, line)
                            elif linenr in foldsplit.killLineNumbers:
                                line = ""
                        else:
                            line = pat.sub(repl, line)
                        if tempcache is not None:
                            cacheFile.write(line)
                        else:
                            curFile.write(line)
                    if( len( matches ) > 0 ):
                        lineNumbers.append(linenr)
                        allMatches.append(matches)
                        ind += 1
                        if temp is not None:
                            if not titled:
                                temp.write(foldsplit[0] + curFile.name + "\n")
                                wroteto = True
                                titled = True
                            temp.write("{:<10} {}".format(linenr, line))
                if temp is not None:
                    if wroteto:
                        temp.write(foldsplit[1] + "\n")
                        temp.write("\n")
                        self.resultIndex.append( Result( lastind, ind + 1, fileIndex, lineNumbers, allMatches, curFile.name) )
                        self.skipper.append ( False )
                        ind += 3
                    else:
                        self.skipper.append ( True )

                if tempcache is not None:
                    cacheFile.flush()
                    cacheFile.close()
                return ind
            except UnicodeDecodeError:
                lol = ""

    @neovim.command("SerAcceptReplace", sync=True)
    def ser_accept(self):
        if not self.readyToReplace:
            self.nvim.err_write("You should probably run Ser find replace first!\n")
            return
        start = time.time()
        for result in self.resultIndex:
            if not self.skipper[result.fileIndex]:
                fi = self.tempFiles[result.fileIndex].rstrip()
                if result.overRideLineNumbers or result.killLineNumbers:
                    temper = os.path.join( self.cacheReplaceDir, fi.replace("/","?" ))
                    shutil.copyfile(fi, temper)
                    self.find_in_file(fi, self.repl, result, None, 0, 0, self.pat, temper)
                    fi = temper
                shutil.copyfile(self.files[result.fileIndex], os.path.join( self.backupDir, self.files[result.fileIndex].replace("/","?" )))
                os.replace(fi, self.files[result.fileIndex])
        self.nvim.out_write("Fin Accept{} : If you replaced in an open buffer you should reload them (hint: run argdo e)!\n".format(time.time() - start))
        self.readyToReplace=False
        self.finishedReplacing=True
        prewin = self.nvim.current.window
        self.nvim.current.window = self.replaceBufWin[1]
        self.nvim.command("q!")

    @neovim.command("Ser", range='', nargs='+', complete='custom,SirSuggestSearch')
    def ser(self,args,range):
        def cache_search():
            with open(self.searchCacheSuggestionFile, 'a+') as wf:
                wf.seek(0)
                if not any(args[0] == l.rstrip() for l in wf.readlines()):
                    wf.write(args[0] + '\n')

        cache_search()

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
                self.readyToReplace = False

        self.skipper = []
        start = time.time()
        selfpat = args[0]
        pat = re.compile(args[0])
        temp = tempfile.NamedTemporaryFile(mode='w')
        folds = self.nvim.vars[self.foldMarkerKey]
        foldsplit = folds.split(',')



        self.omni_walk()
        temps = []
        indexIndex = 1

        for ind, fi in enumerate(self.files, 0):
            fi = fi.rstrip()
            if len(args) == 1:
                indexIndex = self.find_in_file(fi, pat, foldsplit, temp, indexIndex, ind)
            else:
                self.readyToReplace=True
                indexIndex = self.find_in_file(fi, pat, foldsplit, temp, indexIndex, ind, args[1], self.tempFiles[ind], selfpat)

        temp.flush()
        os.fsync(temp)

        if len(args) == 1:
            self.make_scratch( self.nvim.current.window, temp.name , args[len(args) - 1], folds)
        else:
            self.replaceBufWin = self.make_scratch( self.nvim.current.window, temp.name , args[len(args) - 1], folds)
        temp.close()

        self.nvim.out_write("Fin {} \n".format(time.time() - start))

#TODO diff between replace and search
    def make_scratch(self,prewin,title,mat,folds,linesneeded=0):
        self.calls = self.calls + 1
        self.buflist.append(title)
#TODO make this user option sp, tabedit, e, or vsp
        self.nvim.command('silent vsp {}'.format(title))
        pbuf = self.nvim.current.buffer
        pwin = self.nvim.current.window
        pbuf.options['buftype']    = 'nofile'
        pbuf.options['filetype']   = "SER"
        pbuf.options['bufhidden']  = 'hide'
        pbuf.options['buflisted']  = False
        pbuf.options['modifiable'] = False
        pbuf.options['undolevels'] = -1
        pbuf.options['swapfile']   = False
        pbuf.options['buflisted']  = False
        pwin.options['foldmarker'] = folds
        pwin.options['foldlevel'] = 0
        pwin.options['foldlevel'] = 1
        pwin.options['foldmethod'] = 'marker'
        pwin.options['wrap']       = self.nvim.vars[self.wrapKey]

        if self.readyToReplace:
            self.nvim.command('map <buffer><nowait><cr> :call SirActionTime(line(\".\"), {})<cr>'.format("\"accept\""))
            self.nvim.command('map <buffer><nowait><bs> :call SirActionTime(line(\".\"), {})<cr>'.format("\"toggle_grey\""))
            self.nvim.command('map <buffer><nowait>d :call SirActionTime(line(\".\"), {})<cr>'.format("\"toggle_kill\""))
            #TODO other editing tools!! but what could i add...

        self.nvim.command('map <buffer><nowait>e :call SirActionTime(line(\".\"), {})<cr>'.format("\"e\""))
        #TODO Make silent versions of these! ?? be easy...
        self.nvim.command('map <buffer><nowait>v :call SirActionTime(line(\".\"), {})<cr>'.format("\"vsp\""))
        self.nvim.command('map <buffer><nowait>t :call SirActionTime(line(\".\"), {})<cr>'.format("\"tabedit\""))
        self.nvim.command('map <buffer><nowait>s :call SirActionTime(line(\".\"), {})<cr>'.format("\"sp\""))
        self.nvim.command('map <buffer><nowait>p :call SirActionTime(line(\".\"), {})<cr>'.format("\"prev\""))
        self.nvim.command('map <buffer><nowait>o :call SirActionTime(line(\".\"), {})<cr>'.format("\"upprev\""))

        foldsplit = self.nvim.vars[self.foldMarkerKey].split(',')
        mat = mat
        self.nvim.out_write("{}\n".format(mat))
        self.nvim.command( 'syntax match SerFind /{}\|{}/'.format(mat , re.escape(mat)))
        self.nvim.command( 'syntax match SerNumber /{}/'.format('^\d*\s*') )
        self.nvim.command( 'syntax match SerFile /{}.*\|{}/'.format(foldsplit[0],foldsplit[1]) )
        self.nvim.command( 'setlocal nonu' )
        self.nvim.current.window = prewin

        if ( linesneeded > 0 and len(pbuf) < linesneeded):
            for l in range(0, len(pbuf)):
                pbuf[l] = ''

        return (pbuf,pwin)

    @neovim.function("SirActionTime", sync=True)
    def ser_action_time(self, args):
        nu = args[0]
        fun = args[1]
        for i in self.resultIndex:
            true = i.in_my_range(nu)
            #  self.nvim.out_write("e : {} s : {} nu : {}\n".format(i.end, i.start, nu))
            if true:
                if fun == "toggle_grey" or fun == "toggle_kill":
                    if i.is_nu_start_or_end(nu):
                        lol = ""
                        #  self.skipper[i.fileIndex] = not self.skipper[i.fileIndex]
                        #  self.nvim.out_write("e : {} nu : {}\n".format(i.end, nu))
                    else:
                        index = i.convert_nu_to_index(nu)
                        #  self.nvim.out_write("{}\n".format(index))
                        if fun == "toggle_grey":
                            greyed = i.toggle_over_ride_for_line(index)
                            if greyed:
                                self.pbuf.add_highlight('SerGreyOut', nu - 1, 0)
                            else:
                                self.pbuf.add_highlight('SerBack', nu - 1, 0)
                                self.pbuf.add_highlight('SerNumber', nu -1 , 0, 10)
                                for tup in i.get_match_start_and_end(index):
                                    self.pbuf.add_highlight('SerFind'  , nu -1 , 11 + tup[0], 11 + tup[1])
                        elif fun == "toggle_kill":
                            killed = i.toggle_kill_for_line(index)
                            if killed:
                                self.pbuf.add_highlight('SerKill', nu - 1, 0)
                            else:
                                self.pbuf.add_highlight('SerBack', nu - 1, 0)
                                self.pbuf.add_highlight('SerNumber', nu -1 , 0, 10)
                                for tup in i.get_match_start_and_end(index):
                                    self.pbuf.add_highlight('SerFind'  , nu -1 , 11 + tup[0], 11 + tup[1])

                elif fun == "vsp" or fun == "tabedit" or fun == "sp" or fun == "e":
                    try:
                        self.nvim.command( "{} {}".format(fun, i.fileName) )
                    except Exception:
                        lol = ""
                elif fun == "accept":
                    self.ser_accept()
                elif fun == "prev":
                #TODO make this a var for user
                    prewin = self.nvim.current.window
                    try:
                        self.nvim.command( "10{} {}".format('sp', i.fileName) )
                    except Exception:
                        lol = ""
                    self.preview = (self.nvim.current.buffer, self.nvim.current.window)
                    self.nvim.current.window = prewin
                elif fun == "upprev":
                    prewin = self.nvim.current.window
                    self.nvim.current.window = self.preview[1]
                    try:
                        self.nvim.command( "{} {}".format('e', i.fileName) )
                    except Exception:
                        lol = ""
                    self.nvim.current.window = prewin

    def handle_var(self):
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
        self.files = []
        self.tempFiles = []

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
        #  self.nvim.out_write("{}\n".format(filetype))
        if filetype == 'SER':
            self.pbuf = self.nvim.current.buffer

    #  @neovim.autocmd('BufWinLeave', pattern='*', eval='&filetype')
    #  def on_bufenter(self, filetype):
    #      if filetype == 'SER':
    #          self.nvim.command("bw {}".format(self.replaceBufWin[0]))
    #          self.finishedReplacing = True

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
        return nu - self.start - 1;

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

