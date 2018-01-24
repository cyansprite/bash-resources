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

        self.excludes = ['AppData', '.local', '.fzf', '.\w'] # for dirs and files;
        self.excludes = r'|'.join([fnmatch.translate(x) for x in self.excludes]) or r'$.';

        self.gitRepos = [];
        self.get_paths();


    def get_paths(self):
        for b in self.bases:
            for root, dirs, files in os.walk(b):
                dirs[:] = [d for d in dirs if not re.match(self.excludes, d)];

                for d in dirs:
                    if d == ".git":
                        self.gitRepos.append(root);

    def git_check(self):
        orig = os.getcwd()
        print('------')
        print('status')
        print('------')
        for rep in self.gitRepos:
            os.chdir(rep)
            print(rep)
            with Popen(['git', 'status', '--porcelain'], stdout=PIPE, universal_newlines=True) as process:
                for line in process.stdout:
                    sys.stdout.write(line)

            print('')
        print('------')
        os.chdir(orig)

x = Gitch()
x.git_check()
