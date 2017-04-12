import neovim
import thread
import os

@neovim.plugin
class Sarry(object):
    def __init__(self, nvim):
        self.nvim = nvim
        self.filesFile = os.path.join(os.path.expanduser('~'), '.config/nvim/rplugin/python/.cache/filefile.file')
        self.calls = 0

    def makescratch(self,prewin,linesneeded=0,tempfile="SAR"):
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
#        self.nvim.command('mapclear <buffer={}>'.format(pbuf.number))

        if ( linesneeded > 0 and len(pbuf) < linesneeded):
            for l in range(0, len(pbuf)):
                pbuf[l] = ''

        return pbuf

    @neovim.command("S", range='', nargs='*')
    def sarry(self,args,range):
        pbuf = self.makescratch(self.nvim.current.window, 1000)
        index = 0
        with open(self.filesFile, 'r') as fileFile:
            for fileLine in fileFile.readlines():
                titled = False
                with open(fileLine.rstrip(), 'r') as curFile:
                    linenr = 0
                    for curLine in curFile.readlines():
                        linenr = linenr + 1
                        x = curLine.rstrip().find(args[0])
                        if ( x is not -1 ):
                            if ( not titled ):
                                titled = True
                                pbuf.append("{}".format(curFile.name))
                                pbuf.add_highlight('Directory',index + 1, 0)
                                self.nvim.out_write(curFile.name+"\n")
                                index = index + 1
                            pbuf.append("{}: {}".format(str(linenr),curLine.rstrip()))
                            pbuf.add_highlight('String',index + 1, 2 + x + len(str(linenr)), 2 + len(str(linenr)) + x + len(args[0]))
                            pbuf.add_highlight('Number', index + 1, 0 , len(str(linenr)))
                            index = index + 1

#scratchy
#            self.nvim.command("vsplit "+ wf.name)
#            pbuf = self.nvim.current.buffer
#            pbuf.options['bufhidden'] = 'hide'
#            pbuf.options['buftype'] = 'nofile'
#            pbuf.options['buflisted'] = False
#            pbuf.options['swapfile'] = False
#            self.nvim.command("setl nonumber | setl nofoldenable | setl foldcolumn=0")
#
    #def find(self):
    #    with open(self.filesFile, 'r') as f:
    #        for i,line in f:
    def walk(self):
        with open(self.filesFile , 'w+') as wf:
            for root, dirs, files in os.walk(os.getcwd()):
                for name in files:
                    if ( name.endswith( ( '.dat', '.tar', '.gz' , '.properties', '.json' , '.xml', '.so' , 'R.java', '.class', '.jar' , '.png' , '.jpg' , 'R.txt', '.pyc' ) ) ):
                        continue
                    newfile=os.path.join(root,name)
                    wf.write(newfile +"\n")

    @neovim.autocmd('VimEnter', pattern='*')
    def on_bufenter(self):
        self.nvim.async_call(self.walk)
