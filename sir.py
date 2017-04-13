import neovim
import thread
import re
import os
import time
import threading
import concurrent
@neovim.plugin
class Sir(object):#sirsirsirsirs-ir-sir-sir
    # my code here

    def __init__(self, nvim):
        self.nvim = nvim

        self.cachedFiles = []
        self.cacheDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.sircache' )
        self.filesFile          = os.path.join(self.cacheDir, 'filefile.sir')
        self.searchCacheFile    = os.path.join(self.cacheDir, 'sarrysearch.sir')
        self.blacklist          = ('.pdf','.safariextz','.idx','.store','.ap_','.webm','.aar', '.gif','.pack','.sym','.keystream','.values','.shada','.tzo','.DB','.sqlite','.ttf','.dex', '.bin', '.dat', '.tar', '.gz' , '.properties', '.json' , '.xml', '.so' , 'R.java', '.class', '.jar' , '.png' , '.jpg' , 'R.txt', '.pyc' , '.sir')
        self.whitelist          = ()
        self.nvim.command('nnoremap <nowait><leader>f :Sir')

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


    @neovim.command("Sir2", range='', nargs='1', complete='custom,SirSuggestSearch')
    def sir2(self,args,range):
        self.nvim.async_call(self.sirstart,args[0])

    def sirstart(self,term):
        start = time.time()
        def cacheSearch():
            with open(self.searchCacheFile, 'a+') as wf:
                wf.seek(0)
                if not any(term == l.rstrip() for l in wf.readlines()):
                    wf.write(term + '\n')


        def findinfile(fileLine, pat):
            try:
                with open(fileLine, 'r') as curFile:
                    linenr = 0
                    for curLine in curFile.readlines():
                        linenr = linenr + 1
                        match = pat.finditer(curLine)
                        for m in match:
                            self.nvim.out_write('{}\n',m)
                       # column = 0
                       # colList = []
                       # while(True):
                       #     column = curLine.rstrip().find(args[0],column+1)
                       #     if column is -1:
                       #         if len(colList) > 0:
                       #             rtncolumnlist.append(colList)
                       #         break
                       #     else:
                       #         colList.append(column)
                       #         if len(rtnlinelist) == len(rtncolumnlist):
                       #             rtnlinelist.append(curLine.rstrip())
                       #             rtnlinenrlist.append(linenr)

                return zip(rtnlinelist,rtnlinenrlist,rtncolumnlist)
            except IOError as err:
                print("Err : {}\n".format(err))
                return None

        thread.start_new_thread(cacheSearch,())
        pat = re.compile(term)
        pbuf = self.makescratch(self.nvim.current.window, 1000)
        pbuf[0] = 'SIR {}'.format(self.calls)
        pbuf.add_highlight('Title',0, 0)
        debugPrefix = '------------------------------'
        pbuf.append("{} Starting".format(debugPrefix))
        index  = 1
        for root, dirs, files in os.walk(os.getcwd()):
            for fileLine in files:
                if ( not self.nvim.vars[self.useWhiteListKey]):
                    if ( fileLine.endswith( tuple(self.nvim.vars[self.blacklistKey] ) ) ):
                        continue
                else:
                    if ( not fileLine.endswith( tuple (self.nvim.vars[self.whitelistKey] ) ) ):
                        continue
                fileLine = os.path.join(root,fileLine)
                pbuf[1] = '{}Scanning file : {}'.format(debugPrefix,fileLine)
                pbuf.add_highlight('DiffAdd', 1, 0 )
                thread.start_new_thread(findinfile,(fileLine,pat))
                    #futures.append(executor.submit(findinfile,fileLine))
                    #futures[len(futures)-1].fileLine=fileLine

            #file close
            #for fut in concurrent.futures.as_completed(futures):
            #    if fut.result() is not None:
            #        if len(fut.result()) == 0:
            #            continue
            #        foldstart = index
            #        pbuf.append("{}".format(fut.fileLine))
            #        pbuf.add_highlight('Title', index + 1, 0 )
            #        index = index + 1
            #        for curLine,linenr,column in fut.result():
            #            pbuf.append("{}: {}".format(str(linenr),curLine.rstrip()))
            #            for c in column:
            #                self.nvim.out_write('{}\n'.format(c))
            #                pbuf.add_highlight('SirFind',index + 1, c.start() + len(str(linenr)) + 2,c.end() + len(str(linenr)) + 2)
            #            pbuf.add_highlight('Number', index + 1, 0 , len(str(linenr)))
            #            index = index + 1
            #        pbuf.append("{}".format('--------'))
            #        pbuf.add_highlight('NonText', index + 1, 0 )
            #        index = index + 1

        #threadpoolclose
        pbuf[1] = '{}Finished in : {}'.format(debugPrefix,time.time() - start)
        pbuf.add_highlight('DiffAdd', 1, 0 )

    @neovim.command("Sir", range='', nargs='1', complete='custom,SirSuggestSearch')
    def sir(self,args,range):
        start = time.time()
        def cacheSearch():
            with open(self.searchCacheFile, 'a+') as wf:
                wf.seek(0)
                if not any(args[0] == l.rstrip() for l in wf.readlines()):
                    wf.write(args[0] + '\n')

        def findinfile(fileLine):
            rtnlinelist = []
            rtnlinenrlist = []
            rtncolumnlist = []
            try:
                with open(fileLine, 'r') as curFile:
                    linenr = 0
                    for curLine in curFile.readlines():
                        linenr = linenr + 1
                        column = 0
                        colList = []
                        while(True):
                            column = curLine.rstrip().find(args[0],column+1)
                            if column is -1:
                                if len(colList) > 0:
                                    rtncolumnlist.append(colList)
                                break
                            else:
                                colList.append(column)
                                if len(rtnlinelist) == len(rtncolumnlist):
                                    rtnlinelist.append(curLine.rstrip())
                                    rtnlinenrlist.append(linenr)

                return zip(rtnlinelist,rtnlinenrlist,rtncolumnlist)
            except IOError as err:
                print("Err : {}\n".format(err))
                return None

        with ThreadPoolExecutor(max_workers=32) as executor:
            futures = []
            futures.append(executor.submit(cacheSearch))

            pbuf = self.makescratch(self.nvim.current.window, 1000)
            pbuf[0] = 'SIR {}'.format(self.calls)
            pbuf.add_highlight('Title',0, 0)
            debugPrefix = '------------------------------'
            pbuf.append("{} Starting".format(debugPrefix))
            index  = 1
            with open(self.filesFile, 'r') as fileFile:
                for fileLine in fileFile.readlines():
                    fileLine = fileLine.rstrip()
                    pbuf[1] = '{}Scanning file : {}'.format(debugPrefix,fileLine)
                    pbuf.add_highlight('DiffAdd', 1, 0 )
                    futures.append(executor.submit(findinfile,fileLine))
                    futures[len(futures)-1].fileLine=fileLine

            #file close
            for fut in concurrent.futures.as_completed(futures):
                if fut.result() is not None:
                    if len(fut.result()) == 0:
                        continue
                    foldstart = index
                    pbuf.append("{}".format(fut.fileLine))
                    pbuf.add_highlight('Title', index + 1, 0 )
                    index = index + 1
                    for curLine,linenr,column in fut.result():
                        pbuf.append("{}: {}".format(str(linenr),curLine.rstrip()))
                        for c in column:
                            pbuf.add_highlight('SirFind',index + 1, 2 + c + len(str(linenr)), 2 + len(str(linenr)) + c + len(args[0]))
                        pbuf.add_highlight('Number', index + 1, 0 , len(str(linenr)))
                        index = index + 1
                    pbuf.append("{}".format('--------'))
                    pbuf.add_highlight('NonText', index + 1, 0 )
                    index = index + 1

        #threadpoolclose
        pbuf[1] = '{}Finish in : {}'.format(debugPrefix,time.time() - start)
        pbuf.add_highlight('DiffAdd', 1, 0 )

    @neovim.command("SirRecacheFile", range='', nargs='0')
    def recache(self,args,range):
        self.nvim.async_call(self.walk)

    def makescratch(self,prewin,linesneeded=0,tempfile="SIR"):
        self.calls = self.calls + 1
        self.nvim.command('silent vsplit %s' % (tempfile + " "+str(self.calls)))
        pbuf = self.nvim.current.buffer
        pbuf.options['buftype']       = 'nofile'
        pbuf.options['bufhidden']     = 'hide'
        pbuf.options['buflisted']     = False
        pbuf.options['swapfile']      = False
        pbuf.options['buflisted']     = False
        self.nvim.current.window.options['wrap']          = True
        self.nvim.command('map <buffer><nowait><cr> :echom \"WEEP\"<cr>'.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-v> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-t> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-s> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait>u :echom \"WEEP\"<cr> '.format(pbuf.number))

        self.nvim.current.window = prewin
        self.nvim.command('autocmd WinEnter <buffer={}> echom \"WEEP\" '.format(pbuf.number))
        self.nvim.command('autocmd WinLeave <buffer={}> echom \"WEEP\" '.format(pbuf.number))

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

    @neovim.autocmd('VimEnter', pattern='*')
    def on_vimenter(self):
        self.handleVar()
        self.nvim.async_call(self.walk)
