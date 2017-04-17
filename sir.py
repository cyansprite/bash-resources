import neovim
import thread
import re
import os
import time
import concurrent
from concurrent.futures import ThreadPoolExecutor

@neovim.plugin
class Sir(object):#sirsirsirsirs-ir-sir-sir

    def __init__(self, nvim):
        self.nvim = nvim

        self.cachedFiles = []
        self.cacheDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.sircache' )
        self.filesFile          = os.path.join(self.cacheDir, 'filefile.sir')
        self.searchCacheFile    = os.path.join(self.cacheDir, 'sarrysearch.sir')
        self.blacklist          = ('.pdf','.safariextz','.idx','.store','.ap_','.webm','.aar', '.gif','.pack','.sym','.keystream','.values','.shada','.tzo','.DB','.sqlite','.ttf','.dex', '.bin', '.dat', '.tar', '.gz' , '.properties', '.json' , '.xml', '.so' , 'R.java', '.class', '.jar' , '.png' , '.jpg' , 'R.txt', '.pyc' , '.sir')
        self.whitelist          = ()
        self.nvim.command('nnoremap <nowait><leader>f :Sir')
        self.fileCached         = False

        #Keys users can pick
        self.filesFileKey        = 'Sir_filesFile'
        self.searchCacheFileKey  = 'Sir_searchCacheFile'
        self.cacheDirKey         = 'Sir_cacheDir'
        self.debugOutKey         = 'Sir_debugOut'
        self.useWhiteListKey     = 'Sir_useWhiteList'
        self.blacklistKey        = 'Sir_blackList'
        self.whitelistKey        = 'Sir_whiteList'
        self.ignoreHiddenDirKey  = 'Sir_ignoreHiddenDir'
        self.ignoreHiddenFileKey = 'Sir_ignoreHiddenFile'
        self.calls               = 0
        self.vars                = {
                    self.filesFileKey        : self.filesFile,
                    self.searchCacheFileKey  : self.searchCacheFile,
                    self.cacheDirKey         : self.cacheDir,
                    self.debugOutKey         : True,
                    self.useWhiteListKey     : False,
                    self.ignoreHiddenDirKey  : True,
                    self.ignoreHiddenFileKey : False,
                    self.whitelistKey        : self.whitelist,
                    self.blacklistKey        : self.blacklist
                    }
        if not os.path.exists(self.cacheDir):
            os.makedirs(self.cacheDir)

    @neovim.command("Sir", range='', nargs='1', complete='custom,SirSuggestSearch')
    def sir(self,args,range):
        start = time.time()
        pat = re.compile(args[0])
        pbuf = self.makescratch(self.nvim.current.window, 1000)
        pbuf[0] = 'SIR {}'.format(self.calls)
        pbuf.add_highlight('Title',0, 0)
        index = 1
        debugPrefix = ''
        pbuf.append("{} Starting".format(debugPrefix))

        def cacheSearch():
            with open(self.searchCacheFile, 'a+') as wf:
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


            gen = findinfile(fileLine)

            for linenr,line,match in gen:
                if start == index:
                    index += 1
                    pbuf.append('---')
                    pbuf.add_highlight('NonText', index, 0 )
                    index += 1
                    pbuf.append(fileLine)
                    pbuf.add_highlight('Underlined', index, 0 )
                index += 1
                pbuf.append('{}: {}'.format(linenr,line.rstrip()))
                pbuf.add_highlight('Number', index , 0, len(str(linenr)) + 1 )
                for m in match:
                    offset = len(str(linenr)) + 2
                    pbuf.add_highlight('SirFind', index , m.start() + offset , m.end() + offset )

            if start != index:
                index += 1
                pbuf.append(fileLine)
                pbuf.add_highlight('Underlined', index, 0 )
                index += 1
                pbuf.append('---')
                pbuf.add_highlight('NonText', index, 0 )

            return index

        with open(self.filesFile, 'r') as fileFile:
            if( self.fileCached ):
                for fileLine in fileFile.readlines():
                    index = processFile(fileLine,index)
            else:
                for root, dirs, files in os.walk(os.getcwd()):
                    for name in files:
                        if ( not self.nvim.vars[self.useWhiteListKey]):
                            if ( name.endswith( tuple(self.nvim.vars[self.blacklistKey] ) ) ):
                                continue
                        else:
                            if ( not name.endswith( tuple (self.nvim.vars[self.whitelistKey] ) ) ):
                                continue
                        index = processFile(os.path.join(root,name), index)

        pbuf[1] = '{}Finish in : {}'.format(debugPrefix,time.time() - start)
        pbuf.add_highlight('DiffAdd', 1, 0 )
        self.nvim.out_write("Fin {} \n".format(time.time() - start))

    @neovim.command("SirRecacheFile", range='', nargs='0')
    def recache(self,args,range):
        self.fileCached = False
        self.nvim.async_call(self.walk)

    def makescratch(self,prewin,linesneeded=0,tempfile="SIR"):
        self.calls = self.calls + 1
        self.nvim.command('silent vsplit %s' % (tempfile + " "+str(self.calls)))
        pbuf = self.nvim.current.buffer
        pbuf.options['buftype']                        = 'nofile'
        pbuf.options['bufhidden']                      = 'hide'
        pbuf.options['buflisted']                      = False
        pbuf.options['swapfile']                       = False
        pbuf.options['buflisted']                      = False
        self.nvim.current.window.options['foldmethod'] = 'marker'
        self.nvim.current.window.options['foldmarker'] = '---,---'
        self.nvim.current.window.options['wrap']       = True
        self.nvim.command('map <buffer><nowait><cr> :echom \"WEEP\"<cr>'.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-v> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-t> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-s> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait>u :echom \"WEEP\"<cr> '.format(pbuf.number))

        self.nvim.current.window = prewin

        if ( linesneeded > 0 and len(pbuf) < linesneeded):
            for l in range(0, len(pbuf)):
                pbuf[l] = ''

        return pbuf

    def handleVar(self):
        self.nvim.command('hi SirFind guifg=#000000 guibg=#88cccc gui=bold')
        for key in self.vars:
            if ( not key in self.nvim.vars ):
                self.nvim.vars[key] = self.vars[key]

    @neovim.command("SirReopen", range='', nargs='1', complete='custom,sarry#saropen')
    def reopenSar(self,args,range):
        print "uep"

    @neovim.function("SirSuggestSearch", sync=True)
    def sirSuggestSearch(self, args):
        if not os.path.exists(self.searchCacheFile):
            return ''
        with open(self.searchCacheFile, 'r') as sf:
            return "".join(str(s) for s in sf.readlines())

    def walk(self):
        start = time.time()
        with open(self.filesFile , 'w+') as wf:
            for root, dirs, files in os.walk(os.getcwd()):
                for name in files:
                    if ( not self.nvim.vars[self.useWhiteListKey]):
                        if ( name.endswith( tuple(self.nvim.vars[self.blacklistKey] ) ) ):
                            continue
                    else:
                        if ( not name.endswith( tuple (self.nvim.vars[self.whitelistKey] ) ) ):
                            continue
                    wf.write(os.path.join(root,name) +"\n")
        self.nvim.out_write("Fin {} \n".format(time.time() - start))
        self.fileCached = True

    @neovim.autocmd('VimEnter', pattern='*')
    def on_vimenter(self):
        self.handleVar()
        self.nvim.async_call(self.walk)
