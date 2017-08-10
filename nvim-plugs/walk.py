import os

def my_walk(ignoreStart, ignoreExts, ignoreDirs):
    for dirpath, dirnames, filenames in os.walk(os.getcwd()):

        dirnames[:] = [
                dn for dn in dirnames
                if not ( dn.startswith(tuple(ignoreStart)) or dn in ignoreDirs )
        ]

        filenames[:] = [
                fn for fn in filenames
                if not ( fn.startswith(tuple(ignoreStart)) or fn.endswith(tuple(ignoreExts)) )
        ]

        yield dirpath, dirnames, filenames

for dirpath, dirnames, filenames in my_walk(["."], [".png", ".ico"], ["bin", "dist", "node_modules", "test"]):
    for fn in filenames:
        print(os.path.join(dirpath, fn))
