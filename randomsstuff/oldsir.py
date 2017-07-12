import neovim
import thread
import os
import time
from concurrent.futures import ThreadPoolExecutor
import concurrent

@neovim.plugin
class Sir(object):
    def __init__(self, nvim):
        self.nvim = nvim
        self.cacheDir = os.path.join(os.path.expanduser('~'),'.local/share/nvim/.sircache' )
        self.filesFile          = os.path.join(self.cacheDir, 'filefile.sir')
        self.searchCacheFile    = os.path.join(self.cacheDir, 'sarrysearch.sir')
        self.filesFileKey       = 'Sir_filesFile'
        self.searchCacheFileKey = 'Sir_searchCacheFile'
        self.cacheDirKey        = 'Sir_cacheDir'
        self.calls              = 0
        self.vars               = {
                    self.filesFileKey       : self.filesFile,
                    self.searchCacheFileKey : self.searchCacheFile,
                    self.cacheDirKey        : self.cacheDir }
        if not os.path.exists(self.cacheDir):
            os.makedirs(self.cacheDir)

    def makescratch(self,prewin,linesneeded=0,tempfile="SIR"):
        self.calls = self.calls + 1
        self.nvim.command('silent vsplit %s' % (tempfile + " "+str(self.calls)))
        pbuf = self.nvim.current.buffer
        pbuf.options['buftype']       = 'nofile'
        pbuf.options['bufhidden']     = 'hide'
        pbuf.options['buflisted']     = False
        pbuf.options['swapfile']      = False
        pbuf.options['buflisted']     = False
        self.nvim.command('map <buffer><nowait><cr> :echom \"WEEP\"<cr>'.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-v> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-t> :echom \"WEEP\"<cr> '.format(pbuf.number))
        self.nvim.command('map <buffer><nowait><c-s> :echom \"WEEP\"<cr> '.format(pbuf.number))

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

    @neovim.command("SirSearch", range='', nargs='1', complete='custom,SirSuggestSearch')
    def sarry(self,args,range):
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
                        column = curLine.rstrip().find(args[0])
                        if column is not -1:
                            rtnlinelist.append(curLine.rstrip())
                            rtnlinenrlist.append(linenr)
                            rtncolumnlist.append(column)
                return zip(rtnlinelist,rtnlinenrlist,rtncolumnlist)
            except IOError as err:
                print("Err : {}\n".format(err))
                return None

        with ThreadPoolExecutor(max_workers=16) as executor:
            futures = []
            futures.append(executor.submit(cacheSearch))

            pbuf = self.makescratch(self.nvim.current.window, 1000)
            pbuf[0] = 'SIR {}'.format(self.calls)
            index  = 0
            pbuf.add_highlight('Title',index, 0)
            with open(self.filesFile, 'r') as fileFile:
                for fileLine in fileFile.readlines():
                    fileLine = fileLine.rstrip()
                    futures.append(executor.submit(findinfile,fileLine))
                    futures[len(futures)-1].fileLine=fileLine

            #file close
            for fut in concurrent.futures.as_completed(futures):
                if fut.result() is not None:
                    pbuf.append("{}".format(fut.fileLine))
                    pbuf.add_highlight('Title', index + 1, 0 )
                    index = index + 1
                    for curLine,linenr,column in fut.result():
                        pbuf.append("{}: {}".format(str(linenr),curLine.rstrip()))
                        pbuf.add_highlight('SirFind',index + 1, 2 + column + len(str(linenr)), 2 + len(str(linenr)) + column + len(args[0]))
                        pbuf.add_highlight('Number', index + 1, 0 , len(str(linenr)))
                        index = index + 1
                    pbuf.append("{}".format('--------'))
                    pbuf.add_highlight('NonText', index + 1, 0 )
                    index = index + 1
        #threadpoolclose
        self.nvim.out_write('Finished in : {}\n'.format(time.time() - start))

    def walk(self):
        with open(self.filesFile , 'w+') as wf:
            for root, dirs, files in os.walk(os.getcwd()):
                for name in files:
                    if ( name.endswith( ( '.dat', '.tar', '.gz' , '.properties', '.json' , '.xml', '.so' , 'R.java', '.class', '.jar' , '.png' , '.jpg' , 'R.txt', '.pyc' , '.sir') ) ):
                        continue
                    newfile=os.path.join(root,name)
                    wf.write(newfile +"\n")

    @neovim.autocmd('VimEnter', pattern='*')
    def on_bufenter(self):
        self.handleVar()
        self.nvim.async_call(self.walk)
