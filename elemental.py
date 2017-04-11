import sys
import re
import shutil
import collections
import neovim
import time
import subprocess
import threading
import os
import tempfile
from subprocess import PIPE
from stat import S_IREAD
from concurrent.futures import ThreadPoolExecutor
import concurrent

@neovim.plugin
class Elemental(object):
    def __init__(self, nvim):
        self.nvim = nvim
        self.temp          = tempfile.TemporaryFile()

        self.gitListKey   = 'elementalGitList'
        self.bundleDirKey = 'elementalBundleDir'
        self.rtn = []

        home = os.path.expanduser("~")
        self.vars={ self.gitListKey   : home + '/.config/nvim/elemental/.cache/git.conf',
                    self.bundleDirKey : home + '/.config/nvim/elemental/'
                  }

    @neovim.function("TestFunction", sync=True)
    def testfunction(self, args):
        return 3

    @neovim.command("ElemInfo", range='', nargs='0')
    def eleminfo(self, args, range):
        win = self.nvim.current.window
        self.nvim.command('pedit %s' % self.temp)
        self.nvim.command('wincmd P')
        linesneeded=3
        self.summonbuf = self.makescratch(win,linesneeded)

        self.summonbuf[0] = "-- - -- Info List -- - -- " + str(len(self.summonbuf))
        self.summonbuf.add_highlight('Title', 0, 0)
        self.summonbuf[1] = "Bundle Dir : " + self.nvim.vars[self.bundleDirKey]
        self.summonbuf[2] = "Git  List  : " + self.nvim.vars[self.gitListKey]


    @neovim.command("ElemGitList", range='', nargs='0')
    def elemgitlist(self, args, range):
        self.nvim.command('pedit %s' % self.nvim.vars[self.gitListKey])
        self.nvim.command('wincmd P')
        self.nvim.command('set ma ma | set ro noro')

    @neovim.command("ElemSummon", range='', nargs='0')
    def elemsummon(self, args, range):
        self.summon(self.nvim.vars[self.gitListKey])

    @neovim.autocmd('VimEnter', pattern='*',sync=True)
    def on_bufenter(self):
        self.handleVar()
        self.bundleDir = self.nvim.vars[self.bundleDirKey]

    def handleVar(self):
        for key in self.vars:
            if ( key in self.nvim.vars ):
                self.nvim.out_write(self.nvim.vars[key] + "\n")
            else:
                self.nvim.vars[key] = self.vars[key]
                self.nvim.out_write(self.nvim.vars[key] + "\n")

    def summon(self,ls):
        win = self.nvim.current.window
        def callme(line):
            subprocess.call(["git", "clone" , "--depth", "1" , "http://github.com/"+line, self.bundleDir+line])

        start = time.clock()
        future = []
        with open(ls, 'r+') as listfile:
            self.gitlines = len(listfile.readlines())
            self.progress = 0
            listfile.seek(0)
            self.summonbuf = self.makescratch(win, self.gitlines + 2)
            self.summonbuf[0] = '{:>20}'.format('-- - -- :: Summon :: -- - --')
            self.summonbuf.add_highlight('Title', 0, 0)
            index = 1
            with ThreadPoolExecutor(max_workers=16) as executor:
                for line in listfile:
                    index = index + 1
                    line=line.rstrip()
                    if ( line[0] == '#' or os.path.exists(self.bundleDir+line)):
                        self.summonbuf[index] = "Nope " + line + " complete "
                        continue
                    f = executor.submit(callme,line)
                    f.line = line
                    f.index = index
                    future.append(f)

        #concurrent.futures.wait(future)
        for f in concurrent.futures.as_completed(future):
            self.summonbuf[f.index] = "Repo " + f.line + " complete " + str(f.result()) 
        #self.nvim.out_write("Summoning Complete!\n")
                        #if( line[0] == '#' ):
                         #   self.summonbuf[index] = "Commented         : " + line
                        #else:
                         #   self.summonbuf[index] = "Already Cloned    : " + line

    def summonprogress(self,line,index,result):
        self.progress += 5
        self.nvim.out_write('{:=<{prog}}{:>{left}}\n'.format('[',']',prog=str(self.progress),left=str(self.gitlines-self.progress+1)))

    def makescratch(self,prewin,linesneeded=0):
        self.nvim.command('pedit %s' % self.temp)
        self.nvim.command('wincmd P')
        pbuf = self.nvim.current.buffer
        pbuf.options['buftype'] =  'nofile'
        pbuf.options['bufhidden'] = 'hide'
        pbuf.options['swapfile'] = False
        pbuf.options['buflisted'] = False
        self.nvim.current.window = prewin

        if ( linesneeded > 0 and len(pbuf) < linesneeded):
            for l in range(0,linesneeded - len(pbuf)):
                pbuf.append('')
        for l in range(0, len(pbuf)):
            pbuf[l] = ''
        return pbuf

##
#import logging
#import subprocess
## to install run `pip install futures` on Python <3.2
#from concurrent.futures import ThreadPoolExecutor as Pool
#
#info = logging.getLogger(__name__).info
#
#def callback(future):
#    if future.exception() is not None:
#        info("got exception: %s" % future.exception())
#    else:
#        info("process returned %d" % future.result())
#
#def main():
#    logging.basicConfig(
#        level=logging.INFO,
#        format=("%(relativeCreated)04d %(process)05d %(threadName)-10s "
#                "%(levelname)-5s %(msg)s"))
#
#    # wait for the process completion asynchronously
#    info("begin waiting")
#    pool = Pool(max_workers=1)
#    f = pool.submit(subprocess.call, "sleep 2; echo done", shell=True)
#    f.add_done_callback(callback)
#    pool.shutdown(wait=False) # no .submit() calls after that point
#    info("continue waiting asynchronously")
#
#if __name__=="__main__":
#    main()
##
#try:
#    bundleDir    = sys.argv[1] #bundle dir
#    scriptCode   = sys.argv[2] #install list name
#    installList  = sys.argv[3] #code of work we shall do
#except IndexError:
#    print "Incorrect paramaters"
#    sys.exit(-1)
#
#ANNIH=-1 #delete bundle dir and everything in it
#
##if we get this code we are just blowing everything away then leaving
#if ( int(scriptCode) == ANNIH ) :
#    print "Annihilating :: ", bundleDir
#
#    try:
#        shutil.rmtree(bundleDir)
#    except OSError:
#        print "Unsuccesfull, dir doesn't"
#    else:
#        print "Sucessful annihilation"
#
#    sys.exit(0)
#
##Make sure we have our bundleDir
#if not os.path.exists(bundleDir):
#    os.makedirs(bundleDir)
#
#def parseFile():
#    #Open install list
#    with open(installList, 'r+') as listfile:
#        for line in listfile:
#            if ( int(scriptCode) == ASSIM ):
#                assimilate(line)
#
#def assimilate(line):
#    line=line.rstrip()
#    if ( line[0] == '#' ):
#        print "Ignoring   : ", line
#    else:
#        if ( os.path.exists(bundleDir+line) ):
#            print "WEEP EXIST : ", line
#        else:
#            print "NOP        : ", line
#
#def decimate(line):
#    print 'D:',line
#
#def educate(line):
#    print 'E:',line
#
#def regenerate(line):
#    print 'R:',line
#
#def accumalate(line):
#    print 'AC:',line
#
#EDUCA=0 #generate help tags
#ASSIM=1 #install git list
#DECIM=2 #delete hit list
#REGEN=3 #pull from git list
#ACCUM=4 #find all bundles that are not a part of git list if .git, or to local list if not
#
#parseFile()
