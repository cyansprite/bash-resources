----------------------------------------
-- Took this file from normal plugin to add in type support for E,H,W, and N
----------------------------------------

local vim9 = require('_vim9script')
local M = {}
local Qf_filter = nil
Qf_filter = function(qf, searchpat, bang)
  qf = vim9.bool(qf)
  local Xgetlist = function() end
  local Xsetlist = function() end
  local cmd = ''
  local firstchar = ''
  local lastchar = ''
  local pat = ''
  local title = ''
  local Cond = function() end
  local items = {}

  if vim9.bool(qf) then
    Xgetlist = function(...)
      return vim.fn['getqflist'](...)
    end
    Xsetlist = function(...)
      return vim.fn['setqflist'](...)
    end
    cmd = ':Cfilter' .. bang
  else
    Xgetlist = function(...)
      return vim9.fn_ref(M, 'getloclist', vim.deepcopy({ 0 }), ...)
    end

    Xsetlist = function(...)
      return vim9.fn_ref(M, 'setloclist', vim.deepcopy({ 0 }), ...)
    end

    cmd = ':Lfilter' .. bang
  end

  firstchar = vim9.index(searchpat, 0)
  lastchar = vim9.slice(searchpat, -1, nil)
  if firstchar == lastchar and (firstchar == '/' or firstchar == '"' or firstchar == "'") then
    pat = vim9.slice(searchpat, 1, -2)
    if pat == '' then
      -- # Use the last search pattern
      pat = vim.fn.getreg('/')
    end
  else
    pat = searchpat
  end

  if pat == '' then
    return
  end

  if bang == '!' then
    Cond = function(_, val)
      return vim9.ops.NotRegexpMatches(val.text, pat)
        and vim9.ops.NotRegexpMatches(vim9.fn.bufname(val.bufnr), pat)
        or val.type == 'E' and vim9.ops.NotRegexpMatches('error', pat)
        or val.type == 'N' and vim9.ops.NotRegexpMatches('normal', pat)
        or val.type == 'H' and vim9.ops.NotRegexpMatches('hint', pat)
        or val.type == 'W' and vim9.ops.NotRegexpMatches('warn', pat)
    end
  else
    Cond = function(_, val)
      return vim9.ops.RegexpMatches(val.text, pat)
        or vim9.ops.RegexpMatches(vim9.fn.bufname(val.bufnr), pat)
        or val.type == 'E' and vim9.ops.RegexpMatches('error', pat)
        or val.type == 'N' and vim9.ops.RegexpMatches('normal', pat)
        or val.type == 'H' and vim9.ops.RegexpMatches('hint', pat)
        or val.type == 'W' and vim9.ops.RegexpMatches('warn', pat)
    end
  end

  items = vim9.fn_mut('filter', { Xgetlist(), Cond }, { replace = 0 })
  title = cmd .. ' /' .. pat .. '/'
  Xsetlist({}, ' ', { ['title'] = title, ['items'] = items })
end

vim.api.nvim_create_user_command('Cfilter', function(__vim9_arg_1)
  Qf_filter(true, __vim9_arg_1.args, (__vim9_arg_1.bang and '!' or ''))
end, {
  bang = true,
  nargs = '+',
  complete = nil,
})

vim.api.nvim_create_user_command('Lfilter', function(__vim9_arg_1)
  Qf_filter(false, __vim9_arg_1.args, (__vim9_arg_1.bang and '!' or ''))
end, {
  bang = true,
  nargs = '+',
  complete = nil,
})

-- # vim: shiftwidth=2 sts=2 expandtab
return M
