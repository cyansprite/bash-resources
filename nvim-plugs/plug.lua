-- init

-- plugins
function _G.setup()
    require("nvim-tree").setup {
        disable_netrw = true,
        hijack_netrw = true,
        view = {
            number = true,
            relativenumber = true,
            },
        filters = {
            custom = { ".git" },
        },
    }
end
local status, err = pcall(_G.setup)
if not status then
    print ("setup raised an error")
end
-- TODO make a lua file
require('git-conflict').setup()

function _G.symbol_line()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
  local ok, line = pcall(vim.api.nvim_buf_get_var, bufnr, 'coc_symbol_line')
  return ok and '%#CocSymbolLine# ' .. line or ''
end

vim.api.nvim_create_autocmd(
    { 'CursorHold', 'WinEnter', 'BufWinEnter' },
    {
    group = vim.api.nvim_create_augroup("coc_symbol_line", {}),
    callback = function()
      if vim.b.coc_symbol_line and vim.bo.buftype == '' then
        if vim.opt_local.winbar:get() == '' then
          vim.opt_local.winbar = '%!v:lua.symbol_line()'
        end
      else
        vim.opt_local.winbar = ''
      end
    end
    }
)

require("bufferline").setup{}
require("deardiary.config").journals = {
    {
        path = "~/journal",
        frequencies = {"daily", "weekly", "monthly", "yearly"},
    },
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { "gitcommit", "diff" },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- No, it's, so, slow
-- require'nvim-treesitter.configs'.setup {
--   indent = {
--     enable = true
--   }
-- }

-- require'nvim-treesitter.configs'.setup {
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = "<space>i",
--       node_incremental = "grn",
--       scope_incremental = "grc",
--       node_decremental = "grm",
--     },
--   },
-- }

require('treesitter-context').setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
vim.keymap.set("n", "[x", function()
  require("treesitter-context").go_to_context()
end, { silent = true })

-- https://github.com/neoclide/coc.nvim/wiki/Nvim-notifications-integration
local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end

require("notify").setup({
  background_colour = "#00000000",
})

vim.notify = require("notify")
function coc_notify(msg, level)
  local notify_opts = { title = "LSP Message", timeout = 500 }
  vim.notify(msg, level, notify_opts)
end

