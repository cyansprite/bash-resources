import os
import re
import neovim

################################################################################
################################################################################

@neovim.plugin
class UnityAndVim(object):
    def __init__(self, nvim):
        self.nvim              = nvim
        self.files             = []
        self.ready             = False
        self.refresh           = False
        self.currentShowBuffer = None

        # TODO make this a var users can set...
        self.rootDir   = "Assets/Scripts/"

        self.debug             = False

################################################################################

    def find_csharp_files(self):
        tablevel = 0
        for root, dirs, files in os.walk(self.rootDir, topdown=True):
            for f in files:
                if f.endswith("cs"):
                    self.files.append(os.path.join(root,f))

        if self.debug:
            self.nvim.out_write("Ready\n")

        self.ready = True
        if self.debug:
            self.nvim.out_write(str(self.files) + "\n")
        self.nvim.command("command! CSharpFiles call fzf#run(fzf#wrap( {'source': "+str(self.files)+", 'options' : '--multi'}))")

################################################################################

    @neovim.autocmd('VimEnter', sync=False)
    def on_vimenter(self):
        for f in [f for f in os.listdir('.') if os.path.isfile(f)]:
            if f.endswith("sln"):
                self.find_csharp_files()
                break

################################################################################

    @neovim.command("PrintCSharpFiles", nargs='0', sync=True)
    def print_csharp_files(self, range):
        if self.refresh:
            self.find_csharp_files()

        if self.files:
            for x in self.files:
                if self.debug:
                    self.nvim.out_write(str(x) + "\n")

################################################################################

    @neovim.command("ShowCSharpFiles", nargs='0', sync=True)
    def show_csharp_files(self, range):
        if self.refresh:
            self.find_csharp_files()

        if self.files:
            self.nvim.command('exec printf("vertical topleft %dnew", &columns / 5)')
            self.currentShowBuffer = self.nvim.current.buffer
            if self.debug:
                self.nvim.out_write("{} \n".format(self.currentShowBuffer))

            lines = []
            lines[:] = self.lines[:]

            self.currentShowBuffer[:] = lines[:]

################################################################################
################################################################################
