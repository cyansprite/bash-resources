# !/usr/bin/python3
import os
import fnmatch
import re
import sys
from subprocess import Popen, PIPE

class Gitch():
    def __init__(self):
        # TODO setup user vars
        self.bases = ['C:\\Users\\bcoffman'];

        # TODO dont look inside of .git folders...
        self.excludes = ['AppData', '.local', '.fzf', '.cargo', '.nuget', 'node_modules', 'bin', '.hyper_plugins', '.multirust', '.rustup', '.vscode']

        self.gitRepos = [];
        self.get_paths();

    def get_paths(self):
        for b in self.bases:
            for root, dirs, files in os.walk(b):
                dirs[:] = [d for d in dirs if not d in self.excludes];

                for d in dirs:
                    if d == ".git":
                        self.gitRepos.append(root);

    def run_git_command(self, gitList):
        orig = os.getcwd()
        for rep in self.gitRepos:
            os.chdir(rep)
            notPrinted = True;
            with Popen(gitList, stdout=PIPE, universal_newlines=True) as process:
                for line in process.stdout:
                    if notPrinted:
                        print('>>>   ' + rep)
                        notPrinted = False;
                    sys.stdout.write(line)
        os.chdir(orig)

    def clean(self, wet = False):
        if not wet:
            x.run_git_command(['git', 'clean', '-fd', '--dry-run'])
        else:
            x.run_git_command(['git', 'clean', '-fd'])

    def build_clean(self, wet = False):
        if not wet:
            x.run_git_command(['git', 'clean', '-Xfd', '--dry-run'])
        else:
            x.run_git_command(['git', 'clean', '-Xfd'])

    def fetch(self, wet = False):
        if not wet:
            x.run_git_command(['git', 'fetch', '-a', '--dry-run'])
        else:
            x.run_git_command(['git', 'fetch', '-a'])

    def status(self):
        x.run_git_command(['git', 'status', '--porcelain'])

    def diff(self):
        x.run_git_command(['git', 'diff', '--stat'])

    def project_list(self):
        for x in self.gitRepos:
            print(x)

x = Gitch()
# x.clean(True)
# x.diff()
# x.project_list()
x.fetch(True)
x.status()
