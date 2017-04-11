import neovim
import thread
import os

@neovim.plugin
class Sarry(object):
    def __init__(self, nvim):
        self.nvim = nvim
        self.filesFile = os.path.join(os.path.expanduser('~'), '.config/nvim/rplugin/python/.cache/filefile.file')

    def makescratch(self,prewin,linesneeded=0,tempfile="weep"):
        self.nvim.command('silent pedit %s' % tempfile)
        self.nvim.command('silent wincmd P')
        pbuf = self.nvim.current.buffer
        pbuf.options['buftype'] =  'nofile'
        pbuf.options['bufhidden'] = 'hide'
        pbuf.options['swapfile'] = False
        pbuf.options['buflisted'] = False
        self.nvim.current.window = prewin

        if ( linesneeded > 0 and len(pbuf) < linesneeded):
            for l in range(0, len(pbuf)):
                pbuf[l] = ''

        return pbuf

    @neovim.command("Sarry", range='', nargs='*')
    def sarry(self,args,range):
        pbuf = self.makescratch(self.nvim.current.window, 1000)
        index = 0
        with open(self.filesFile, 'r') as fileFile:
            for fileLine in fileFile.readlines():
                titled = False
                with open(fileLine.rstrip(), 'r') as curFile:
                    for curLine in curFile.readlines():
                        x = curLine.rstrip().find(args[0])
                        if ( x is not -1 ):
                            if ( not titled ):
                                titled = True
                                pbuf.append("".format(curFile.name))
                                self.nvim.out_write(curFile.name+"\n")
                            pbuf.append("{}".format(curLine.strip()))
                            pbuf.add_highlight('ErrorMsg', index - 0, x - len(args[0]) - 1, x + len(args[0]))
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
