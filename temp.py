import glob
import sys
import os
import subprocess
import threading
import re
import time
from concurrent.futures import ThreadPoolExecutor
import concurrent

gitblacklist = []
def main(term):
    start = time.time()
    threads = []
    blacklist          = ('.pdf','.safariextz','.idx','.store','.ap_','.webm','.aar', '.gif','.pack','.sym','.keystream','.values','.shada','.tzo','.DB','.sqlite','.ttf','.dex', '.bin', '.dat', '.tar', '.gz' , '.properties', '.json' , '.xml', '.so' , 'R.java', '.class', '.jar' , '.png' , '.jpg' , 'R.txt', '.pyc' , '.sir')
    gitignore = []
    cache = os.path.join(os.path.expanduser('~'), '.cachin')

    class findThread (threading.Thread):
        def __init__(self, fileline, pat):
            threading.Thread.__init__(self)
            self.fileline = fileline
            self.pat = pat

        def run(self):
            findinfile(self.fileline,self.pat)

    def findinfile(fileLine, pat):
        try:
            with open(fileLine, 'r') as curFile, open(cache, 'w') as cacheFile:
                linenr = 0
                for curLine in curFile.readlines():
                    linenr = linenr + 1
                    #column = 0
                    #colList = []
                    #while(True):
                    #    column = curLine.rstrip().find(pat,column+1)
                    #    if column is -1:
                    #        break
                    #    else:
                    #        colList.append(column)
                    #print "{}".format(colList)

                    match = pat.finditer(curLine)
                    for m in match:
                        print("{} in {}".format(m,cacheFile.name))
                        cacheFile.write('{}'.format(m))
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
        except IOError as err:
            print("Err : {}\n".format(err))
            return None

    pat = re.compile(term)
    #pat=term
    debugPrefix = '------------------------------'
    index  = 1
    for root, dirs, files in os.walk(os.getcwd()):
        dirs[:] = [d for d in dirs if not d.startswith('.git')]
        for fileLine in files:
            #if(fileLine.startswith('.') ):
             #   continue
            if ( fileLine.endswith( blacklist ) ):
                continue
            fullfile = os.path.join(root,fileLine)
            print(fullfile)
            fileLine = os.path.join(root,fullfile)
            #thread = findThread(fileLine,pat)
            #thread.start()
            #threads.append(thread)

    for x in threads:
        x.join()

    print("All done {}".format(time.time() - start))

def find():
    def exe(fullfile):
        rtn = subprocess.call(['git','check-ignore','-q',fullfile])

    gitdir = []
    for root, dirs, files in os.walk(os.getcwd()):
        for d in dirs:
            d = os.path.join(root,d)
            for entry in os.scandir(d):
                if entry.name == '.git':
                   gitdir.append(d)

if __name__ == "__main__":
    find()
    #main('sir')
