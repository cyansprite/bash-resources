import neovim;
import re;

@neovim.plugin
class HighlightUnmatched(object):

    def __init__(self, nvim):
        self.nvim = nvim; 

        self.paraL = re.compile('\(')
        self.paraR = re.compile('\)')

        self.bracetL = re.compile('\[')
        self.bracetR = re.compile('\]')

        self.braceL = re.compile('\{')
        self.braceR = re.compile('\}')

        self.quote = re.compile('"')
        self.sinquote = re.compile("'")

        self.ignoreComment = re.compile("#")
        self.allmatched = []
        self.regexes = [
            [self.paraL  , self.paraR],
            [self.bracetL, self.bracetR],
            [self.braceL , self.braceR]
        ]

        self.init = False;
        self.scoping = False;
        self.locked = False;

    @neovim.autocmd('VimEnter', pattern='*', eval='', sync=True)
    def on_vim(self):
        self.alwaysMatchID = self.nvim.new_highlight_source();
        self.unmatchedID   = self.nvim.new_highlight_source();
        self.init = True;


    @neovim.autocmd('TextChangedI', pattern='*', eval='', sync=False)
    def on_change_i(self):
        self.get_all_unmatched();

    @neovim.autocmd('TextChanged', pattern='*', eval='', sync=False)
    def on_change(self):
        self.get_all_unmatched();

    @neovim.autocmd('BufWinEnter', pattern='*', eval='', sync=False)
    def on_enter(self):
        if self.init:
            self.get_all_unmatched();

    @neovim.autocmd('CursorHold', pattern='*', eval='getcurpos()', sync=False)
    def on_hold(self,cur):
        self.get_all_unmatched();
        self.cur = [cur[1],cur[2]];
        self.get_current_match();

    @neovim.autocmd('CursorHoldI', pattern='*', eval='getcurpos()', sync=False)
    def on_hold_i(self,cur):
        self.get_all_unmatched();
        self.cur = [cur[1],cur[2]];
        self.get_current_match();

    @neovim.autocmd('CursorMoved', pattern='*', eval='getcurpos()', sync=False)
    def on_move(self,cur):
        self.cur = [cur[1],cur[2]];
        self.get_current_match();

    @neovim.autocmd('CursorMovedI', pattern='*', eval='getcurpos()', sync=False)
    def on_move_i(self,cur):
        self.cur = [cur[1],cur[2]];
        self.get_current_match();

    def get_all_unmatched(self):
        if not self.locked:
            self.locked = True
            self.allmatched = []
            self.nvim.current.buffer.clear_highlight(self.unmatchedID, 0, -1);
            self.get_unmatched();
            self.locked = False

    def get_current_match(self):
        if not self.scoping:
            self.cur[0] -= 1;
            self.cur[1] -= 1;
            self.scoping = True;
            self.nvim.current.buffer.clear_highlight(self.alwaysMatchID, 0, -1);
            scope = False;
            for m in self.allmatched:
                if m[0][0] == m[1][0]:
                    if self.cur[0] == m[0][0] and self.cur[0] <= m[1][0] and self.cur[1] <= m[1][1]:
                        scope = True;
                else:
                    if self.cur[0] == m[0][0]:
                        if self.cur[1] >= m[0][1]:
                            scope = True;
                            break;
                    elif self.cur[0] == m[1][0]:
                        if self.cur[1] <= m[1][1]:
                            scope = True;
                            break;
                    elif self.cur[0] >= m[0][0] and self.cur[0] <= m[1][0]:
                        scope = True;
                        break;
            if scope:
                self.nvim.current.buffer.add_highlight("MatchParen", m[0][0], m[0][1], m[0][1] + 1, self.alwaysMatchID);
                self.nvim.current.buffer.add_highlight("MatchParen", m[1][0], m[1][1], m[1][1] + 1, self.alwaysMatchID);
            self.scoping = False;

    def get_unmatched(self):
        line = 0;

        l = len(self.regexes)

        ridx = [0] * l;
        lidx = [0] * l;

        lall = [0] * l;
        rall = [0] * l;

        left  = [[]] * l;
        right = [[]] * l;

        match = [];

        ignoreDoub = False;
        ignoreSing = False;

        for b in self.nvim.current.buffer:
            col = 0;
            for c in b:
                if self.quote.match(c) is not None and not ignoreSing:
                    ignoreDoub = not ignoreDoub;
                if self.sinquote.match(c) is not None and not ignoreDoub:
                    ignoreSing = not ignoreSing;

                if ignoreSing or ignoreDoub:
                    col += 1;
                    continue;

                if self.ignoreComment.match(c) is not None:
                    break;

                idx = 0;
                for r in self.regexes:
                    x = r[0].match(c)
                    if x is not None:
                        lidx[idx] += 1;
                        left[idx].append([line,col])
                        if rall[idx] > 0:
                            lall[idx] += 1;
                            rall[idx] -= 1;
                    x = r[1].match(c)
                    if x is not None:
                        ridx[idx] += 1;
                        right[idx].append([line,col])
                        if lall[idx] > 0:
                            self.nvim.out_write(c + "\n")
                            match.append([left[idx].pop(), right[idx].pop()])
                            lall[idx] -= 1;

                    if ridx[idx] > lidx[idx] + rall[idx]:
                        rall[idx] += 1;
                    if lidx[idx] > ridx[idx] + lall[idx]:
                        lall[idx] += 1;
                    idx += 1;
                col += 1;
            line += 1;

        # Color looping
        modx = 0;
        modl = 6;

        # # Match highlights
        for m in match:
            self.nvim.current.buffer.add_highlight("logical" + str(modx % modl), m[0][0], m[0][1], m[0][1] + 1, self.unmatchedID);
            self.nvim.current.buffer.add_highlight("logical" + str(modx % modl), m[1][0], m[1][1], m[1][1] + 1, self.unmatchedID);
            modx += 1;

        # Unmatch Highlights
        for x in range(l):
            for l in left[x]:
                self.nvim.current.buffer.add_highlight("Error" , l[0], l[1], l[1] + 1, self.unmatchedID);
            for r in right[x]:
                self.nvim.current.buffer.add_highlight("Error" , r[0], r[1], r[1] + 1, self.unmatchedID);

        self.allmatched = match
