import neovim
import thread
import os

@neovim.plugin
class Sarry(object):
    def __init__(self, nvim):
        self.nvim = nvim
        self.files = []
        self.dirs = []
        self.filesFile = os.path.join(os.path.expanduser('~'), '.config/nvim/rplugin/python/.cache/filefile.file')

    @neovim.function("TestFunction", sync=True)
    def testfunction(self, args):
        return 3

#scratchy
#            self.nvim.command("vsplit "+ wf.name)
#            pbuf = self.nvim.current.buffer
#            pbuf.options['bufhidden'] = 'hide'
#            pbuf.options['buftype'] = 'nofile'
#            pbuf.options['buflisted'] = False
#            pbuf.options['swapfile'] = False
#            self.nvim.command("setl nonumber | setl nofoldenable | setl foldcolumn=0")
#
    def find(self):
        with open(self.filesFile, 'r') as f:
            for i,line in f:
    def walk(self):
        with open(self.filesFile , 'w+') as wf:
            for root, dirs, files in os.walk(os.getcwd()):
                for name in files:
                    if ( name.endswith( ( '.dat', '.tar', '.gz' , '.properties', '.json' , '.xml', '.so' , 'R.java', '.class', '.jar' , '.png' , '.jpg' , 'R.txt' ) ) ):
                        continue
                    newfile=os.path.join(root,name)
                    self.files.append(newfile)
                    wf.write(newfile +"\n")

    @neovim.autocmd('VimEnter', pattern='*')
    def on_bufenter(self):
        self.walk()
