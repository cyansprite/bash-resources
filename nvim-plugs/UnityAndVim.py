import os
import re
import neovim

@neovim.plugin
class UnityAndVim(object):
    def __init__(self, nvim):
        self.nvim      = nvim
        self.csfile    = ""
        self.csprojDir = ""
        self.files     = []
        self.ready     = False

    def find_csharp_assembly(self):
        name = "Assembly-CSharp.csproj"
        for root, dirs, files in os.walk(".", topdown=False):
            if name in files:
                self.csfile = os.path.join(root, name)
                self.csprojDir = root
                return True
        self.csfile = "Failed"
        return False

    def find_csharp_files(self):
        with open(self.csfile, 'r') as csf:
            for line in csf:
                if line.strip().startswith("<Compile"):
                    self.files.append(self.regexC.findall(line)[0])

    @neovim.autocmd('VimEnter', sync=False)
    def on_vimenter(self):
        self.regexC = re.compile('\"(.+?)\"')
        if self.find_csharp_assembly():
            self.find_csharp_files()

    @neovim.command("PrintCSharpFiles", nargs='0', sync=True)
    def print_csharp_files(self, range):
        if self.files:
            self.nvim.out_write(os.getcwd() + "\n")
            for x in self.files:
                self.nvim.out_write(x + "\n")
        else:
            if self.csfile == "Failed":
                self.nvim.out_write("Assembly-CSharp.csproj file not found\n")
            else:
                self.nvim.out_write("Cs file still processing\n")
