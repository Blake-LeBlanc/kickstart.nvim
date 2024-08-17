-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function is_windows()
  return package.config:sub(1, 1) == '\\'
end

local function get_fzf_build_command()
  if is_windows() then
    return nil
  else
    return './install --all'
  end
end

local fzf_dir = is_windows() and vim.fn.expand '~\\fzf' or vim.fn.expand '~/.fzf'
local fzf_executable_path = is_windows()
    and 'C:\\Users\\blake.leblanc\\AppData\\Local\\Microsoft\\WinGet\\Packages\\junegunn.fzf_Microsoft.Winget.Source_8wekyb3d8bbwe\\fzf.exe'
  or 'fzf'

return {
  {
    'folke/tokyonight.nvim',
  },
  {
    'mcchrish/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
  },
  {
    'robertmeta/nofrils',
  },
  {
    'rktjmp/lush.nvim',
  },
  {
    'ggandor/leap.nvim',
    config = function()
      -- require('leap').create_default_mappings()
      -- NOTE: Whenever I used the above, not only did it cause nvim to complain about a clash with
      -- mini.surround, it also did not work. Normal mode `s` would still act as vim's default
      -- replace-like thingymajig. Only got it to work by by explicitly defining the mappings here.
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
    end,
  },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup {
        auto_load = true,
        close_on_bdelete = true,
        syntax = true,
        theme = 'light',
        update_on_change = true,
        app = 'webview',
        filetype = { 'markdown' },
        throttle_at = 20000,
        throttle_time = 'auto',
      }
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
  {
    'markonm/traces.vim',
  },
  {
    'wellle/targets.vim',
  },
  {
    'windwp/nvim-autopairs',
  },
  {
    'mhinz/vim-startify',
  },
  -- {
  --   'echasnovski/mini.map',
  --   version = '*',
  --   config = function()
  --     require('mini.map').setup {
  --       -- Highlight integrations (none by default)
  --       integrations = nil,
  --       symbols = {
  --         -- Encode symbols. See `:h MiniMap.config` for specification and
  --         -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
  --         -- Default: solid blocks with 3x2 resolution.
  --         encode = nil,
  --         scroll_line = '█',
  --         scroll_view = '┃',
  --       },
  --       window = {
  --         -- Whether window is focusable in normal way (with `wincmd` or mouse)
  --         focusable = false,
  --         side = 'right',
  --         show_integration_count = true,
  --         width = 10,
  --         winblend = 25,
  --         zindex = 10,
  --       },
  --     }
  --   end,
  -- },
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup {
        opts = {
          vim.keymap.set('n', '-', '<CMD>lua MiniFiles.open()<CR>'),
        },
        -- Customization of shown content
        content = {
          -- Predicate for which file system entries to show
          filter = nil,
          -- What prefix to show to the left of file system entry
          prefix = nil,
          -- In which order to show file system entries
          sort = nil,
        },

        -- Module mappings created only inside explorer.
        -- Use `''` (empty string) to not create one.
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L',
          -- go_out      = 'h',
          go_out = '-',
          go_out_plus = 'H',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },

        -- General options
        options = {
          -- Whether to delete permanently or move into module-specific trash
          permanent_delete = false,
          -- Whether to use for editing directories
          use_as_default_explorer = true,
        },

        -- Customization of explorer windows
        windows = {
          -- Maximum number of windows to show side by side
          max_number = math.huge,
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of focused window
          width_focus = 50,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 50,
        },
      }
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
  },
  -- NOTE: While the below *should* cause a post-install hook to fire in Lazy.nvim to update the fzf
  -- binary, it may not work. If after install, you're running into weird errors after calling, say,
  -- `:History`, try manually updating the binary with `:call fzf#install()`
  {
    'junegunn/fzf',
    dir = '~/.fzf',
    build = './install --all',
    -- dir = fzf_dir,
    -- build = get_fzf_build_command(),
  },
  {
    'junegunn/fzf.vim',
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true,

    -- config = function()
    --   require('toggleterm').setup{(
    --     -- defaults
    --   )}
    -- end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    'sindrets/diffview.nvim',
    opts = {},
  },
  -- {
  --   'isakbm/gitgraph.nvim',
  --   opts = {
  --     symbols = {
  --       merge_commit = 'M',
  --       commit = '*',
  --     },
  --     format = {
  --       timestamp = '%H:%M:%S %d-%m-%Y',
  --       fields = {
  --         'hash',
  --         'timestamp',
  --         'author',
  --         'branch_name',
  --         'tag',
  --       },
  --     },
  --     hooks = {
  --       on_select_commit = function(commit)
  --         vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
  --         vim.cmd('DiffviewOpen ' .. commit.hash .. '^!')
  --       end,
  --       on_select_range_commit = function(from, to)
  --         vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
  --         vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
  --       end,
  --     },
  --   },
  --   keys = {
  --     {
  --       '<leader>gl',
  --       function()
  --         require('gitgraph').draw({}, { all = true, max_count = 5000 })
  --       end,
  --       desc = 'GitGraph - Draw',
  --     },
  --   },
  -- },
  -- {
  --   'Isrothy/neominimap.nvim',
  --   enabled = true,
  --   lazy = false,
  --   init = function()
  --     vim.opt.wrap = false -- Recommended
  --     vim.opt.sidescrolloff = 36 -- It's recommended to set a large value
  --     ---@type Neominimap.UserConfig
  --     vim.g.neominimap = {
  --       auto_enable = true,
  --     }
  --   end,
  -- },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          -- theme = "material",
          -- theme = 'onelight',
          theme = 'powerline',
          -- theme = 'base16',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          -- How to disable  text coloring for diff and diagnostics? `colored = false`
          lualine_b = {
            'branch',
            -- "diff",
            -- "diagnostics"
            diff,
            diagnostics,
          },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
}
