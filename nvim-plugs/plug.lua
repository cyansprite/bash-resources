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
local status, _ = pcall(_G.setup)
if not status then
    print ("setup raised an error")
end
--require('git-conflict').setup()
vim.filetype.add {
  pattern = {
    ['.*.bazelrc'] = 'bazelrc',
  },
}
-- make a list of lsp servers to install
local mason_lspconfig = {
  'lua_ls',
  'ts_ls',
  'eslint',
  'bashls',
  'dockerls',
  'html',
  'jsonls',
  'jsonnet_ls',
  'vimls',
  'yamlls',
  'kotlin_language_server',
  'angularls',
  'yamlls',
  'cssls',
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = mason_lspconfig
}
require('lint').linters_by_ft = {
  javascript = {'eslint'},
  typescript = {'eslint'},
  json = {'jsonlint'},
  lua = {'luacheck'},
  python = {'flake8'},
  sh = {'shellcheck'},
  yaml = {'yamllint'},
  go = {'golangci-lint'},
  rust = {'cargo'},
  html = {'tidy'},
  css = {'stylelint'},
  scss = {'stylelint'},
  sass = {'stylelint'},
  less = {'stylelint'},
  graphql = {'graphql'},
  graphqls = {'graphql'},
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()

--     for _, client in ipairs(vim.lsp.get_clients()) do
--       require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
--     end
  end,
})

-- function _G.symbol_line()
--   local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
--   local ok, line = pcall(vim.api.nvim_buf_get_var, bufnr, 'coc_symbol_line')
--   return ok and '%#CocSymbolLine# ' .. line or ''
-- end

-- vim.api.nvim_create_autocmd(
--     { 'CursorHold', 'WinEnter', 'BufWinEnter' },
--     {
--     group = vim.api.nvim_create_augroup("coc_symbol_line", {}),
--     callback = function()
--       if vim.b.coc_symbol_line and vim.bo.buftype == '' then
--         if vim.opt_local.winbar:get() == '' then
--           vim.opt_local.winbar = '%!v:lua.symbol_line()'
--         end
--       else
--         vim.opt_local.winbar = ''
--       end
--     end
--     }
-- )

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

require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },
  },
}

require'nvim-treesitter.configs'.setup {
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<space>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<space>A"] = "@parameter.inner",
      },
    },
  },
}

require'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
        ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      -- goto_next = {
        -- ["]i"] = "@conditional.outer",
      -- },
      -- goto_previous = {
        -- ["[i"] = "@conditional.outer",
      -- }
    },
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
-- local coc_status_record = {}
--
-- function coc_status_notify(msg, level)
--   local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
--   -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
--   if coc_status_record ~= {} then
--     notify_opts["replace"] = coc_status_record.id
--   end
--   coc_status_record = vim.notify(msg, level, notify_opts)
-- end
--
-- function reset_coc_status_record(window)
--   coc_status_record = {}
-- end
--
-- local coc_diag_record = {}
--
-- function coc_diag_notify(msg, level)
--   local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = reset_coc_diag_record }
--   -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
--   if coc_diag_record ~= {} then
--     notify_opts["replace"] = coc_diag_record.id
--   end
--   coc_diag_record = vim.notify(msg, level, notify_opts)
-- end
--
-- function reset_coc_diag_record(window)
--   coc_diag_record = {}
-- end
--
-- require("notify").setup({
--   background_colour = "#00000000",
-- })
--
-- vim.notify = require("notify")
-- function coc_notify(msg, level)
--   local notify_opts = { title = "LSP Message", timeout = 500 }
--   vim.notify(msg, level, notify_opts)
-- end

-- Set up nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    {
        name = 'buffer',
        option = {
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end
        }
    },
  }),
  window = {
    completion = {
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
    end
  }
})

-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' },
--   }, {
--     { name = 'buffer' },
--   })
-- })
-- require("cmp_git").setup()

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, s in ipairs(mason_lspconfig) do
    require('lspconfig')[s].setup {
        capabilities = capabilities
    }
end

local opts = { noremap=true, silent=true }

local function quickfix()
    vim.lsp.buf.code_action({
        apply = true
    })
end

vim.keymap.set('n', '<space>f', quickfix, opts)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-- npm i --save-dev --legacy-peer-deps typings @angular/language-server @angular/language-service
local path = vim.fn.fnamemodify(vim.cmd('pwd'), ':p')
local project_library_path = path .. "/node_modules/"
local project_library_path_base = path
local ngserver = path .. "/node_modules/@angular/language-server/bin/ngserver"
local cmd = { ngserver, "--stdio", "--tsProbeLocations", project_library_path_base , "--ngProbeLocations", project_library_path }
require'lspconfig'.angularls.setup{
  cmd = cmd,
  on_new_config = function(new_config,_)
    new_config.cmd = cmd
  end,
}

require'lspconfig'.kotlin_language_server.setup{
    autostart = true,
}

vim.diagnostic.config({ virtual_text = false })

-- Default configuration
require("tiny-inline-diagnostic").setup({
    signs = {
        left = "",
        right = "",
        diag = "●",
        arrow = "    ",
        up_arrow = "    ",
        vertical = " │",
        vertical_end = " └",
    },
    hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine", -- Can be a highlight or a hexadecimal color (#RRGGBB)
        mixing_color = "None", -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
    },
    blend = {
        factor = 0.27,
    },
    options = {
        -- Show the source of the diagnostic.
        show_source = true,

        -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
        -- You can increase it if you have performance issues.
        -- Or set it to 0 to have better visuals.
        throttle = 0,

        -- The minimum length of the message, otherwise it will be on a new line.
        softwrap = 15,

        -- If multiple diagnostics are under the cursor, display all of them.
        multiple_diag_under_cursor = true,

        -- Enable diagnostic message on all lines.
        multilines = true,

        -- Show all diagnostics on the cursor line.
        show_all_diags_on_cursorline = true,

        -- Enable diagnostics on Insert mode. You should also se the `throttle` option to 0, as some artefacts may appear.
        enable_on_insert = false,

        overflow = {
            -- Manage the overflow of the message.
            --    - wrap: when the message is too long, it is then displayed on multiple lines.
            --    - none: the message will not be truncated.
            --    - oneline: message will be displayed entirely on one line.
            mode = "wrap",
        },

        -- Format the diagnostic message.
        -- Example:
        -- format = function(diagnostic)
        --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
        -- end,
        format = nil,

        --- Enable it if you want to always have message with `after` characters length.
        break_line = {
            enabled = false,
            after = 30,
        },

        virt_texts = {
            priority = 2048,
        },

        -- Filter by severity.
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },

        -- Overwrite events to attach to a buffer. You should not change it, but if the plugin
        -- does not works in your configuration, you may try to tweak it.
        overwrite_events = nil,
    },
})
local navic = require("nvim-navic")
navic.setup {
    lsp = {
        auto_attach = true,
    },
    highlight = true,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
}
require'lsp-lens'.setup({ })
-- not actually needed but it's interesting
vim.o.mousemoveevent = true
require("eagle").setup()

local wk = require("which-key")
wk.setup{
  triggers = {
    { "<leader>", mode = { "n", "v" } },
    { "<space>", mode = { "n", "v" } },
  }
}

-- Attaches to every FileType mode
require("colorizer").setup()

require("CopilotChat").setup {
  -- See Configuration section for options
}

vim.api.nvim_set_keymap('n', '<space>x', '', {
  noremap = true,
  callback = function()
    vim.cmd('cclose')
    vim.diagnostic.setqflist()
    vim.cmd('copen')
  end
})

----------------------------------------
-- Took this file from normal plugin to add in type support for E,H,W, and N
-- Should ask if the original cares, maybe convert to map, maybe write my own..
-- but don't have it in lua forever here
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

-- note changes From Cfilter to CF, easier to type..
vim.api.nvim_create_user_command('CF', function(__vim9_arg_1)
  Qf_filter(true, __vim9_arg_1.args, (__vim9_arg_1.bang and '!' or ''))
end, {
  bang = true,
  nargs = '+',
  complete = nil,
})

-- note changes From Lfilter to LF, easier to type..
vim.api.nvim_create_user_command('LF', function(__vim9_arg_1)
  Qf_filter(false, __vim9_arg_1.args, (__vim9_arg_1.bang and '!' or ''))
end, {
  bang = true,
  nargs = '+',
  complete = nil,
})

require('fzf-lua').register_ui_select()
require('fzf-lua').setup({'fzf-vim'})
require('fzf-lua').setup({'fzf-native'})
local actions = require "fzf-lua.actions"
require('fzf-lua').setup{
  winopts = {
    fullscreen = true,
    preview = {
      horizontal = 'right:50%',
    }
  },
  fzf_opts = {
    -- for raw args use `fzf_args` instead
    ["--ansi"]           = true,
    ["--info"]           = "inline-right", -- fzf < v0.42 = "inline"
    ["--height"]         = "100%",
    ["--layout"]         = false,
    ["--border"]         = "none",
    ["--highlight-line"] = true,           -- fzf >= v0.53
  },
  files = {
    cmd = vim.env.FZF_DEFAULT_COMMAND,
    header = false
  },
    actions = {
    -- Below are the default actions, setting any value in these tables will override
    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
      files = {
        false,          -- do not inherit from defaults
        -- Pickers inheriting these actions:
        --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
        --   tags, btags, args, buffers, tabs, lines, blines
        -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
        -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
        -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
        ["enter"] = actions.file_edit
    }
  }
}

require("icon-picker").setup({ disable_legacy_commands = true })
vim.keymap.set("n", "<Leader>i", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
require("visual-whitespace").setup()
require("arena").setup()
require('csvview').setup({ view = { display_mode = "border" } })

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "csv",
  callback = function()
    vim.cmd('CsvViewEnable')
  end,
})
require('pqf').setup()
require("ccc").setup()
