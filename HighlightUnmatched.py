import neovim;
import re;
import time;
import string;

@neovim.plugin
class HighlightUnmatched(object):

    def __init__(self, nvim):
        self.nvim = nvim;
        self.init = False;

        # user options...
        self.updateInInsert = False;
        self.ignoreFileTypes = ['jinja', 'help', 'notes', 'diff', 'qf', 'txt', '']
        self.lighters = []
        self.currentlighter = None;

    @neovim.autocmd('VimEnter', pattern='*', eval='&filetype', sync=True)
    def on_vim(self, filetype):
        self.alwaysMatchID = self.nvim.new_highlight_source();
        self.unmatchedID   = self.nvim.new_highlight_source();
        self.init = True;
        self.nvim.async_call(lambda:[self.entrance(filetype)]);

    @neovim.autocmd('VimLeave', pattern='*', eval='', sync=True)
    def exit(self):
        for l in self.lighters:
            l.go_the_fuck_away()

    @neovim.autocmd('InsertLeave', pattern='*', eval='b:changedtick', sync=False)
    def on_leave(self,tick):
        if self.currentlighter is not None:
            if not self.updateInInsert:
                self.currentlighter.update(tick);

    @neovim.autocmd('TextChangedI', pattern='*', eval='b:changedtick', sync=False)
    def on_change_i(self,tick):
        if self.currentlighter is not None:
            if self.updateInInsert:
                self.currentlighter.update(tick);

    @neovim.autocmd('TextChanged', pattern='*', eval='b:changedtick', sync=False)
    def on_change(self,tick):
        if self.currentlighter is not None:
            for l in self.lighters:
                self.currentlighter.update(tick);

    @neovim.autocmd('BufEnter', pattern='*', eval='&filetype', sync=True)
    def on_buf_enter(self,filetype):
        self.nvim.async_call(lambda:[self.entrance(filetype)]);

    def entrance(self,filetype):
        if filetype in self.ignoreFileTypes:
            return

        hl = None;
        for l in self.lighters:
            if l.filetype == filetype:
                hl = l;
                break;

        if self.init:
            if hl is None:
                hl = Highlighter(self.nvim, filetype, self.init, self.alwaysMatchID, self.unmatchedID);
                self.lighters.append(hl);
            else:
                hl.reset_tick();

        self.currentlighter = hl;

    @neovim.autocmd('CursorHold', pattern='*', eval='getcurpos()', sync=False)
    def on_hold(self,cur):
        if self.currentlighter is not None:
            self.currentlighter.current(cur);

    @neovim.autocmd('CursorHoldI', pattern='*', eval='getcurpos()', sync=False)
    def on_hold_i(self,cur):
        if self.currentlighter is not None:
            self.currentlighter.current(cur);

    @neovim.autocmd('CursorMoved', pattern='*', eval='getcurpos()', sync=False)
    def on_move(self,cur):
        if self.currentlighter is not None:
            self.currentlighter.current(cur);

    @neovim.autocmd('CursorMovedI', pattern='*', eval='getcurpos()', sync=False)
    def on_move_i(self,cur):
        if self.currentlighter is not None:
            self.currentlighter.current(cur);

class Highlighter():
    def __init__(self,nvim,filetype,init,alwaysMatchID, unmatchedID):
        self.nvim = nvim;
        self.alwaysMatchID = alwaysMatchID;
        self.unmatchedID = unmatchedID;

        self.regexstring = (r"(')|")

        self.noComplexComments = True;
        self.allmatched = [];

        self.gtfo        = False;
        self.scoping     = False;
        self.locked      = False;
        self.lastUpdate  = 0;
        self.lasttick    = 0;
        self.currentTick = -1;
        self.updateInterval = .15;
        self.lastfile    = "";
        self.filetype    = filetype;
        self.buffer      = self.nvim.current.buffer;
        self.comment = False;
        self.commentIsDoubQuote = False;
        self.commentIsSingQuote = False;

        self.regex = None
        self.groups = [
            ['\(','\)'],
            ['\[','\]'],
            ['\{','\}'],
        ]

        # True Boundary : (?<=\s)m(?=\s)|^m(?=\s)|(?<=\s)m$|^m$
        if filetype == 'vim':
            self.groups.append([r'(?<=\s)fu[nction!]*(?=\s)|^fu[nction!]*(?=\s)|(?<=\s)fu[nction!]*$|^fu[nction!]*$' , r'(?<=\s)endf[unction]*(?=\s)|^endf[unction]*(?=\s)|(?<=\s)endf[unction]*$|^endf[unction]*$'] )
            self.groups.append([r'(?<=\s)whi[ile]*(?=\s)|^whi[ile]*(?=\s)|(?<=\s)whi[ile]*$|^whi[ile]*$'             , r'(?<=\s)endwhi[le]*(?=\s)|^endwhi[le]*(?=\s)|(?<=\s)endwhi[le]*$|^endwhi[le]*$']             )
            self.groups.append([r'(?<=\s)for(?=\s)|^for(?=\s)|(?<=\s)for$|^for$'                                     , r'(?<=\s)endfo[r]*(?=\s)|^endfo[r]*(?=\s)|(?<=\s)endfo[r]*$|^endfo[r]*$']                     )
            self.groups.append([r'(?<=\s)if(?=\s)|^if(?=\s)|(?<=\s)if$|^if$'                                         , r'(?<=\s)en[dif]*(?=\s)|^en[dif]*(?=\s)|(?<=\s)en[dif]*$|^en[dif]*$']                         )
            self.groups.append([r'(?<=\s)try(?=\s)|^try(?=\s)|(?<=\s)try$|^try$'                                     , r'(?<=\s)endt[ry]*(?=\s)|^endt[ry]*(?=\s)|(?<=\s)endt[ry]*$|^endt[ry]*$']                     )
            self.groups.append([r'\baug[roup]*\b\s(?!END)\w+'                                                        , r'\bau[group]*(?=\b)\s\bEND\b']                                                               )
            self.commentIsDoubQuote = True;
        elif filetype == "python" or filetype == "sh" or filetype == "perl":
            self.comment = '#'
        elif filetype == 'ruby':
            start = r'=begin'
            end = r'=end'
            self.ignoreComplexCommentStart = re.compile(start);
            self.ignoreComplexCommentEnd = re.compile(end);
            self.noComplexComments = False;
            self.comment = '#'
        elif filetype == 'html' or filetype == 'xhtml' or filetype == 'xml':
            start = r'<!--'
            end = r'-->'
            self.ignoreComplexCommentStart = re.compile(start);
            self.ignoreComplexCommentEnd = re.compile(end);
            self.noComplexComments = False;
        elif filetype == 'python':
            start = r'"""'
            end = r'"""'
            self.ignoreComplexCommentStart = re.compile(start);
            self.ignoreComplexCommentEnd = re.compile(end);
            self.noComplexComments = False;
            self.comment = '#'
        elif filetype == "c" or filetype == "java" or filetype == "cs" or filetype == "cpp" or filetype == "php" or filetype =='swift':
            start = r'/\*'
            end = r'\*/'
            self.ignoreComplexCommentStart = re.compile(start);
            self.ignoreComplexCommentEnd = re.compile(end);
            self.noComplexComments = False;
            self.comment = "//"
            if filetype == 'php':
                self.comment += r'|#'
        elif filetype == "javascript":
            self.comment = '//'
        elif filetype == 'ada' or filetype == 'sql':
            self.comment = '--'
        elif filetype == 'matlab':
            self.comment = '%'
            start = r'%{'
            end = r'%}'
            self.ignoreComplexCommentStart = re.compile(start);
            self.ignoreComplexCommentEnd = re.compile(end);
        elif filetype == 'basic':
            self.comment = '(?<=\s)REM(?=\s)|^REM(?=\s)|(?<=\s)REM$|^REM$'
        elif filetype == 'vb':
            self.commentIsSingQuote = True;
        elif filetype == 'lua':
            start = r'--[['
            end = r'--]]'
            self.ignoreComplexCommentStart = re.compile(start);
            self.ignoreComplexCommentEnd = re.compile(end);
            self.noComplexComments = False;
            self.comment = "--"

        # The order of these actually matter, quite a lot in fact.
        if not self.noComplexComments:
            self.regexstring += "(" + start + ")" + "|(" + end + ")|"
        self.regexstring += (r'(")|')
        if self.comment:
            self.regexstring += "(" + self.comment + ")|";
        for g in self.groups:
            self.regexstring += "("+g[0] + ")|(" + g[1] + ")|";

        self.regex = re.compile(self.regexstring)

        if init:
            self.handle_unmatched();
            self.get_current_match(self.nvim.eval("getcurpos()"))

    def go_the_fuck_away(self):
        self.gtfo = True;

    def my_filetype(self):
        return self.filetype;

    def reset_tick(self):
        self.currentTick = -1;
        self.lasttick = 0;
        self.buffer.clear_highlight(self.alwaysMatchID, 0 -1);
        self.buffer = self.nvim.current.buffer;
        self.handle_unmatched();
        self.get_current_match(self.nvim.eval("getcurpos()"));

    def current(self,cur):
        self.get_current_match(cur);

    def change(self,tick):
        self.lasttick = tick;
        self.lastUpdate = time.time();
        self.buffer.clear_highlight(self.unmatchedID, 0, -1);

    def update(self,tick):
        if not self.locked:
            self.locked = True;
            self.single_loop();
        else:
            self.change(tick);

    def single_loop(self):
        while not self.gtfo:
            self.nvim.out_write('');
            if (time.time() - self.lastUpdate) > self.updateInterval and self.currentTick < self.lasttick:
                self.currentTick = self.lasttick;
                self.buffer.clear_highlight(self.unmatchedID, 0, -1);
                self.handle_unmatched();
                self.get_current_match(self.nvim.eval("getcurpos()"));

    def handle_unmatched(self):
        self.allmatched = [];
        self.get_unmatched(self.buffer);
        self.lastUpdate = time.time();

    def get_current_match(self,cur):
        self.cur = [cur[1] - 1,cur[2] - 1];
        self.buffer.clear_highlight(self.alwaysMatchID, 0, -1);
        self.match = None;

        for m in self.allmatched:
            self.match = self.am_i_in_scope(m);
            if self.match is not None:
                self.buffer.add_highlight("MatchParen", m[0][0], m[0][1], m[0][1] + m[0][2], self.alwaysMatchID);
                self.buffer.add_highlight("MatchParen", m[1][0], m[1][1], m[1][1] + m[1][2], self.alwaysMatchID);
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

    def get_unmatched(self,buffer):
        line = 0;

        l = len(self.groups);

        ridx = [0] * l;
        lidx = [0] * l;

        lall = [0] * l;
        rall = [0] * l;

        quote = [];
        sinquote = [];
        complexCom = [];

        left  = [];
        right = [];
        for x in range(l):
            left.append([]);
            right.append([]);

        match = [];

        ignoreComplex = False;
        ignoreDoub = False;
        cont = True
        badQuoteCount = 0;

        for b in buffer:
            col = 0;
            # If there is a programming language that does quotes on more than one line
            # we will need to handle that here...
            if self.commentIsDoubQuote and ignoreDoub:
                # If we get an exception it means the buffer changed while looping
                # therefore, we just return because we will get a new update.
                # only ever reproduced by rapidly doing ddu
                try:
                    if quote[badQuoteCount][1] != 0 and re.match(r"\s", buffer[quote[badQuoteCount][0]][quote[badQuoteCount][1] - 1]) is None:
                        badQuoteCount += 1;
                    else:
                        quote.pop();
                except:
                    return;
            if self.commentIsSingQuote and ignoreDoub:
                # If we get an exception it means the buffer changed while looping
                # therefore, we just return because we will get a new update.
                # only ever reproduced by rapidly doing ddu
                try:
                    if quote[badQuoteCount][1] != 0 and re.match(r"\s", buffer[quote[badQuoteCount][0]][quote[badQuoteCount][1] - 1]) is None:
                        badQuoteCount += 1;
                    else:
                        quote.pop();
                except:
                    return;
            ignoreDoub = False;
            ignoreSing = False;

            for x in self.regex.finditer(b):
                if not self.noComplexComments and ignoreComplex:
                    if not re.match(self.ignoreComplexCommentEnd,(x.group())):
                        continue;
                    else:
                        match.append([complexCom.pop(), [line,x.start(),len(x.group())]])
                        ignoreComplex = False;
                        continue;

                # quick hack to get it working... double quotes won't be recognized.
                if x.group() == '"' and not ignoreSing:
                    if ignoreDoub:
                        match.append([[line,x.start(), 1], quote.pop()]);
                    else:
                        quote.append([line,x.start(), 1]);
                    ignoreDoub = not ignoreDoub;

                if x.group() == "'" and not ignoreDoub:
                    if ignoreSing:
                        match.append([[line,x.start(), 1], sinquote.pop()]);
                    else:
                        sinquote.append([line,x.start(), 1]);
                    ignoreSing = not ignoreSing;

                if ignoreSing or ignoreDoub:
                    continue;

                # if not (self.filetype == 'vim' or beenquoted):
                if self.comment and re.match(self.comment ,x.group()):
                    break;


                if not self.noComplexComments:
                    if re.match(self.ignoreComplexCommentStart,(x.group())):
                        ignoreComplex = True;
                        complexCom.append([line,x.start(),len(x.group())])
                        continue;

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
                            match.append([left[idx].pop(), right[idx].pop()]);
                            lall[idx] -= 1;

                    if ridx[idx] > lidx[idx] + rall[idx]:
                        rall[idx] += 1;
                    if lidx[idx] > ridx[idx] + lall[idx]:
                        lall[idx] += 1;
                    idx += 1;
            line += 1;

        # Unmatch Highlights
        for x in range(l):
            for l in left[x]:
                self.buffer.add_highlight("Error" , l[0], l[1], l[1] + l[2], self.unmatchedID);
            for r in right[x]:
                self.buffer.add_highlight("Error" , r[0], r[1], r[1] + r[2], self.unmatchedID);

        # Unmatched quotes
        for r in sinquote:
            self.buffer.add_highlight("Error" , r[0], r[1], r[1] + r[2], self.unmatchedID);
        for r in quote:
            self.buffer.add_highlight("Error" , r[0], r[1], r[1] + r[2], self.unmatchedID);
        for r in complexCom:
            self.buffer.add_highlight("Error" , r[0], r[1], r[1] + r[2], self.unmatchedID);

        self.allmatched = match;
