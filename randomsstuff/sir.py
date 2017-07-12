import neovim
import thread
import re
import os
from stat import S_ISREG
import time
import tempfile


@neovim.plugin
class Sir(object):#sirsirsirsirs-ir-sir-sir

    def __init__(self, nvim):
        self.nvim = nvim

        self.cachedFiles = []
        self.cacheDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.sircache' )
        self.filesFile          = os.path.join(self.cacheDir, 'filefile.sir')
        self.searchCacheSuggestionFile    = os.path.join(self.cacheDir, 'sirSuggest.sir')
        self.blacklist          = ('.pdf','.safariextz','.idx','.store','.ap_','.webm','.aar', '.gif','.pack','.sym','.keystream','.values','.shada','.tzo','.DB','.sqlite','.ttf','.dex', '.bin', '.dat', '.tar', '.gz' , '.properties', '.json' , '.xml', '.so' , 'R.java', '.class', '.jar' , '.png' , '.jpg' , 'R.txt', '.pyc' , '.sir')
        self.whitelist          = ()
        self.nvim.command('nnoremap <nowait><leader>f :Sir')
        self.fileCached         = False
        self.buflist            = []

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
                    self.foldMarkerKey       : '|>,<|',
                    }
        if not os.path.exists(self.cacheDir):
            os.makedirs(self.cacheDir)

    @neovim.command("Sir", range='', nargs='1', complete='custom,SirSuggestSearch')
    def sir(self,args,range):
        start = time.time()
        pat = re.compile(args[0])
        title ='SIR {} : {}'.format(self.calls, args[0]) 
        pboth = self.makescratch(self.nvim.current.window, title)
        pbuf = pboth[0]
        pwin = pboth[1]
        pbuf[0] = title
        pbuf.add_highlight('Title',0, 0)
        index = 1
        debugPrefix = ''
        pbuf.append("{} Starting".format(debugPrefix))

        def cacheSearch():
            with open(self.searchCacheSuggestionFile, 'a+') as wf:
                wf.seek(0)
                if not any(args[0] == l.rstrip() for l in wf.readlines()):
                    wf.write(args[0] + '\n')

        def findinfile(fileLine):
            try:
                with open(fileLine, 'r') as curFile:
                    for linenr,line in enumerate(curFile.readlines(), 1):
                        matches = filter(lambda true:true, (match for match in pat.finditer(line)))
                        if( len( matches ) > 0 ):
                            yield (linenr,line, ( matches ) )
            except IOError as err:
                print("Err : {}\n".format(err))

        def processFile(fileLine,index):
            fileLine = fileLine.rstrip()
            index = index + 0
            start = index
            pbuf[1] = '{}Scanning file : {}'.format(debugPrefix,fileLine)
            folds = self.nvim.vars[self.foldMarkerKey].split(',')


            gen = findinfile(fileLine)

            for linenr,line,match in gen:
                if start == index:
                    index += 1
                    pbuf.append('{}{:>2}{}'.format(folds[0],'',fileLine))
                    pbuf.add_highlight('Directory', index, 0 )
                index += 1
                pbuf.append('{:>{tab}}{}: {}'.format('',linenr,line.rstrip(),tab=self.nvim.vars[self.tabLengthKey]))
                pbuf.add_highlight('Number', index , self.nvim.vars[self.tabLengthKey], len(str(linenr)) + 1 + self.nvim.vars[self.tabLengthKey] )
                for m in match:
                    offset = len(str(linenr)) + self.nvim.vars[self.tabLengthKey] + 2
                    pbuf.add_highlight('SirFind', index , m.start() + offset , m.end() + offset )

            if start != index:
                index += 1
                pbuf.append('{}{:>2}{}'.format(folds[1],'',fileLine))
                pbuf.add_highlight('Directory', index, 0 )
            return index

        with open(self.filesFile, 'r') as fileFile:
            if( self.fileCached ):
                for fileLine in fileFile.readlines():
                    index = processFile(fileLine,index)
            else:
                self.omniwalk(processFile,index)

        pbuf[1] = '{}Finish in : {}'.format(debugPrefix,time.time() - start)
        pbuf.add_highlight('DiffAdd', 1, 0 )
        self.nvim.out_write("Fin {} \n".format(time.time() - start))

    @neovim.command("SirRecacheFile", range='', nargs='0')
    def recache(self,args,range):
        self.fileCached = False
        self.nvim.async_call(self.omniwalk)

    def makescratch(self,prewin,title,linesneeded=0):
        self.calls = self.calls + 1
        self.buflist.append(title)
        self.nvim.command('silent vsplit {}'.format(title))
        pbuf = self.nvim.current.buffer
        pwin = self.nvim.current.window
        pbuf.options['buftype']                        = 'nofile'
        pbuf.options['bufhidden']                      = 'hide'
        pbuf.options['buflisted']                      = False
        pbuf.options['swapfile']                       = False
        pbuf.options['buflisted']                      = False
        pwin.options['foldmarker'] = self.nvim.vars[self.foldMarkerKey]
        pwin.options['foldmethod'] = 'marker'
        pwin.options['wrap']       = self.nvim.vars[self.wrapKey]
        self.nvim.command('map <buffer><nowait><cr> :echom \"WEEP\"<cr>'.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-v> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-t> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-s> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait>u :echom \"WEEP\"<cr> '.format(pbuf.number))

        self.nvim.current.window = prewin

        if ( linesneeded > 0 and len(pbuf) < linesneeded):
            for l in range(0, len(pbuf)):
                pbuf[l] = ''

        return (pbuf,pwin)

    def handleVar(self):
        #self.nvim.options['tabstop']
        self.nvim.command('hi SirFind guifg=#000000 guibg=#88cccc gui=bold')
        for key in self.vars:
            if ( not key in self.nvim.vars ):
                self.nvim.vars[key] = self.vars[key]



    @neovim.function("SirReopenSuggest", sync=True)
    def sirReopenSuggest(self,args):
        return "\n".join(str(s) for s in self.buflist)

    @neovim.command("SirReopen", range='', nargs='1', complete='custom,SirReopenSuggest')
    def reopenSir(self,args,range):
        self.nvim.command('vsplit {}'.format(args[0]))

    @neovim.function("SirSuggestSearch", sync=True)
    def sirSuggestSearch(self, args):
        if not os.path.exists(self.searchCacheSuggestionFile):
            return ''
        with open(self.searchCacheSuggestionFile, 'r') as sf:
            return "".join(str(s) for s in sf.readlines())

    def filefilewalk(self):
        start = time.time()
        with open(self.filesFile , 'w+') as wf:
            self.omniwalk(wforindex=wf)
        self.nvim.out_write("Fin {} \n".format(time.time() - start))
        self.fileCached = True

    def omniwalk(self,func=None,wforindex=None):
        start = time.time()
        for root, dirs, files in os.walk(os.getcwd()):
            for name in files:
                path = os.path.join(root,name)
                try:
                    mode = os.stat(path).st_mode
                except OSError as err:
                    self.nvim.out_write('{}\n'.format(err))
                    continue

                if( not S_ISREG(mode) ) :
                    continue
                elif ( not self.nvim.vars[self.useWhiteListKey]):
                    if ( name.endswith( tuple(self.nvim.vars[self.blacklistKey] ) ) ):
                        continue
                else:
                    if ( not name.endswith( tuple (self.nvim.vars[self.whitelistKey] ) ) ):
                        continue
                if wforindex is int:
                    wforindex = func(path,wforindex)
                else:
                    wforindex.write("{}\n".format(path))
        self.nvim.out_write("Fin {} \n".format(time.time() - start))

    @neovim.autocmd('VimEnter', pattern='*')
    def on_vimenter(self):
        self.handleVar()
        self.nvim.async_call(self.filefilewalk)


