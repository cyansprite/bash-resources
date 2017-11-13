import neovim;
import re;
import time;
import string;

@neovim.plugin
class HighlightUnmatched(object):

    def __init__(self, nvim):
        self.nvim = nvim;

        self.noComplexComments = True;

        self.high = { "-1" : 'Logical5',
            "-2" : 'Logical4',
            "0" : 'Logical2',
            "1" : 'Logical3',
            "2" : 'Logical1',
            "3" : 'Logical2',
        };

        self.allmatched = [];
        self.nonmatched = [];

        self.defstring = (r'(\()|(\))|(\{)|(\})|(\[)|(\])|')
        # make quotes and singlue quotes work
        self.defstring = (r"'")
        self.defstring = (r'"')

        self.regexstring = ""
        self.regex = None

        self.defgroups = [
            ['\(','\)'],
            ['\[','\]'],
            ['\{','\}'],
        ]
        self.groups = []

        self.ignoreFileTypes = [
            'jinja',
            'help',
            'notes',
            'diff',
            'qf',
            'txt',
            '',
        ]

        self.match = None;
        self.init = False;
        self.gtfo = False;
        self.scoping = False;
        self.locked = False;
        self.lockedi = False;
        self.lastUpdate = 0;
        self.updateInterval = .5;
        self.lasttick = 0;

    @neovim.autocmd('VimEnter', pattern='*', eval='', sync=True)
    def on_vim(self):
        self.alwaysMatchID = self.nvim.new_highlight_source();
        self.unmatchedID   = self.nvim.new_highlight_source();
        self.init = True;

    @neovim.autocmd('VimLeave', pattern='*', eval='', sync=True)
    def exit(self):
        self.gtfo = True;

    @neovim.autocmd('TextChangedI', pattern='*', eval='b:changedtick', sync=False)
    def on_change_i(self,tick):
        if not self.lockedi:
            self.lockedi = True;
            self.single_loop();
        else:
            self.change_happened(tick);

    @neovim.autocmd('TextChanged', pattern='*', eval='b:changedtick', sync=False)
    def on_change(self,tick):
        if not self.locked:
            self.locked = True;
            self.single_loop();
        else:
            self.change_happened(tick);

    def single_loop(self):
        while not self.gtfo:
            mytick = 0;
            # this keeps the connection alive? I don't fuckin know man...
            # but if i remove it, it hangs
            self.nvim.out_write('');
            if (time.time() - self.lastUpdate) > self.updateInterval and mytick < self.lasttick:
                mytick = self.lasttick;
                self.handle_unmatched();
                self.match = None;
                cur = self.nvim.eval("getcurpos()")
                self.get_current_match(cur);

    def change_happened(self,tick):
        self.lasttick = tick;
        self.lastUpdate = time.time();
        self.nvim.current.buffer.clear_highlight(self.unmatchedID, 0, -1);

    @neovim.autocmd('BufWinEnter', pattern='*', eval='&filetype', sync=False)
    def on_enter(self,filetype):
        self.filetype = filetype;

        if self.filetype in self.ignoreFileTypes:
            return

        self.regexstring = ""
        self.regex = None
        self.groups = []

        # True Boundary : (?<=\s)m(?=\s)|^m(?=\s)|(?<=\s)m$|^m$
        if filetype == 'vim':
            self.noComplexComments = True;
            # Vim and it's complicated shit...
            self.groups.append([r'(?<=\s)fu[nction!]*(?=\s)|^fu[nction!]*(?=\s)|(?<=\s)fu[nction!]*$|^fu[nction!]*$' , r'(?<=\s)endf[unction]*(?=\s)|^endf[unction]*(?=\s)|(?<=\s)endf[unction]*$|^endf[unction]*$'] )
            self.groups.append([r'(?<=\s)whi[ile]*(?=\s)|^whi[ile]*(?=\s)|(?<=\s)whi[ile]*$|^whi[ile]*$'             , r'(?<=\s)endwhi[le]*(?=\s)|^endwhi[le]*(?=\s)|(?<=\s)endwhi[le]*$|^endwhi[le]*$']             )
            self.groups.append([r'(?<=\s)for(?=\s)|^for(?=\s)|(?<=\s)for$|^for$'                                     , r'(?<=\s)endfo[r]*(?=\s)|^endfo[r]*(?=\s)|(?<=\s)endfo[r]*$|^endfo[r]*$']                     )
            self.groups.append([r'(?<=\s)if(?=\s)|^if(?=\s)|(?<=\s)if$|^if$'                                         , r'(?<=\s)en[dif]*(?=\s)|^en[dif]*(?=\s)|(?<=\s)en[dif]*$|^en[dif]*$']                         )
            self.groups.append([r'(?<=\s)try(?=\s)|^try(?=\s)|(?<=\s)try$|^try$'                                     , r'(?<=\s)endt[ry]*(?=\s)|^endt[ry]*(?=\s)|(?<=\s)endt[ry]*$|^endt[ry]*$']                     )
            self.groups.append([r'\baug[roup]*\b\s(?!END)\w+'                                                        , r'\bau[group]*(?=\b)\s\bEND\b']                                                               )
            self.comment = r'"|.*map'
        elif filetype == "python":
            self.noComplexComments = True;
            self.comment = '#'
        elif filetype == "c" or filetype == "java" or filetype == "cs" or filetype == "cpp" or filetype == "othersIamtoolazytotyperightnow":
            self.ignoreComplexCommentStart = re.compile('/*');
            self.ignoreComplexCommentEnd = re.compile('*/');
            self.noComplexComments = False;
            self.comment = "//"

        for g in self.groups:
            self.regexstring += "("+g[0] + ")|(" + g[1] + ")" + "|";
        self.regexstring += self.defstring + "|(" + self.comment + ")";
        self.groups += self.defgroups;
        self.regex = re.compile(self.regexstring)
        self.nvim.out_write("{}\n".format(self.regexstring))

        if self.init:
            self.handle_unmatched();

    @neovim.autocmd('CursorHold', pattern='*', eval='getcurpos()', sync=False)
    def on_hold(self,cur):
        self.get_current_match(cur);

    @neovim.autocmd('CursorHoldI', pattern='*', eval='getcurpos()', sync=False)
    def on_hold_i(self,cur):
        self.get_current_match(cur);

    @neovim.autocmd('CursorMoved', pattern='*', eval='getcurpos()', sync=False)
    def on_move(self,cur):
        self.get_current_match(cur);

    @neovim.autocmd('CursorMovedI', pattern='*', eval='getcurpos()', sync=False)
    def on_move_i(self,cur):
        self.get_current_match(cur);

    def handle_unmatched(self):
        if self.filetype in self.ignoreFileTypes:
            return
        self.allmatched = [];
        self.get_unmatched();
        self.lastUpdate = time.time();

    def get_current_match(self,cur):
        if (self.filetype in self.ignoreFileTypes) or (self.match is not None and self.am_i_in_scope(self.match)):
            return;

        self.cur = [cur[1] - 1,cur[2] - 1];
        self.nvim.current.buffer.clear_highlight(self.alwaysMatchID, 0, -1);
        self.match = None;

        for m in self.allmatched:
            self.match = self.am_i_in_scope(m);
            if self.match is not None:
                self.nvim.current.buffer.add_highlight("MatchParen", m[0][0], m[0][1], m[0][1] + m[0][2], self.alwaysMatchID);
                self.nvim.current.buffer.add_highlight("MatchParen", m[1][0], m[1][1], m[1][1] + m[1][2], self.alwaysMatchID);
                break;

    def am_i_in_scope(self,m):
        scope = False;

        if m[0][0] == m[1][0]:
            if self.cur[0] == m[0][0] and self.cur[1] >= m[0][1] and self.cur[1] <= m[1][1] + m[1][2] - 1:
                scope = True;
        else:
            if self.cur[0] == m[0][0]:
                if self.cur[1] >= m[0][1]:
                    scope = True;
            elif self.cur[0] == m[1][0]:
                if self.cur[1] <= m[1][1] + m[1][2] - 1:
                    scope = True;
            elif self.cur[0] >= m[0][0] and self.cur[0] <= m[1][0]:
                scope = True;

        if scope:
            return m;
        else:
            return None;

    def get_unmatched(self):
        line = 0;

        l = len(self.groups);

        ridx = [0] * l;
        lidx = [0] * l;

        lall = [0] * l;
        rall = [0] * l;

        quote = [];
        sinquote = [];

        left  = [];
        right = [];
        for x in range(l):
            left.append([]);
            right.append([]);

        match = [];

        ignoreComplex = False;
        cont = True

        for b in self.nvim.current.buffer:
            col = 0;
            # If there is a programming language that does quotes on more than one line
            # we will need to handle that here...
            ignoreDoub = False;
            ignoreSing = False;
            beenquoted = False;

            for x in self.regex.finditer(b):
                # if not self.noComplexComments and ignoreComplex:
                #     if self.ignoreComplexCommentEnd.search(b) is None:
                #         continue;
                #     else:
                #         ignoreComplex = False;

                # search = self.quote.search(b)

                if x.group() == '"' and not ignoreSing:
                    beenquoted = True;
                    if ignoreDoub:
                        match.append([[line,x.start(), 1], quote.pop(), -2]);
                    else:
                        quote.append([line,x.start(), 1]);
                    ignoreDoub = not ignoreDoub;

                if x.group() == "'" and not ignoreDoub:
                    if ignoreSing:
                        match.append([[line,x.start(), 1], sinquote.pop(), -1]);
                    else:
                        sinquote.append([line,x.start(), 1]);
                    ignoreSing = not ignoreSing;

                if ignoreSing or ignoreDoub:
                    continue;

                # if not self.noComplexComments:
                #     if self.ignoreComplexCommentStart.search(b) is not None:
                #         ignoreComplex = True;
                #         col += 1;
                #         continue;

                # if there is a comment we don't care about the reset
                # however since vim uses quotes for strings AND comments ...
                # I need to make sure that is handled
                if not (self.filetype == 'vim' or beenquoted):
                    if re.match(self.comment ,x.group()):
                        break;

                idx = 0;
                for group in self.groups:
                    if re.match(group[0],(x.group())):
                        lidx[idx] += 1;
                        left[idx].append([line,x.start(), len(x.group())]);
                        if rall[idx] > 0:
                            lall[idx] += 1;
                            rall[idx] -= 1;

                    if re.match(group[1],(x.group())):
                        ridx[idx] += 1;
                        right[idx].append([line,x.start(),len(x.group())]);
                        if lall[idx] > 0:
                            match.append([left[idx].pop(), right[idx].pop(),idx]);
                            lall[idx] -= 1;

                    if ridx[idx] > lidx[idx] + rall[idx]:
                        rall[idx] += 1;
                    if lidx[idx] > ridx[idx] + lall[idx]:
                        lall[idx] += 1;
                    idx += 1;
                col += 1;
            line += 1;

        # Unmatch Highlights
        for x in range(l):
            for l in left[x]:
                self.nvim.current.buffer.add_highlight("Error" , l[0], l[1], l[1] + l[2], self.unmatchedID);
            for r in right[x]:
                self.nvim.current.buffer.add_highlight("Error" , r[0], r[1], r[1] + r[2], self.unmatchedID);

        # Unmatched quotes, i don't know how to fix vim yet...
        for r in sinquote:
            self.nvim.current.buffer.add_highlight("Error" , r[0], r[1], r[1] + 1, self.unmatchedID);
        if self.filetype != "vim":
            for r in quote:
                self.nvim.current.buffer.add_highlight("Error" , r[0], r[1], r[1] + 1, self.unmatchedID);

        # Match highlights ? No Let Syntax take care of this vim-operator-highlight
        # for m in match:
        #     self.nvim.current.buffer.add_highlight(self.high[str(m[2])], m[0][0], m[0][1], m[0][1] + m[0][2], self.unmatchedID);
        #     self.nvim.current.buffer.add_highlight(self.high[str(m[2])], m[1][0], m[1][1], m[1][1] + m[1][2], self.unmatchedID);

        self.allmatched = match;
