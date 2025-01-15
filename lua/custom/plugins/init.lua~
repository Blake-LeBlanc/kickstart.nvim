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
  -- {
  --   'folke/tokyonight.nvim',
  -- },
  -- {
  --   'mcchrish/zenbones.nvim',
  --   dependencies = { 'rktjmp/lush.nvim' },
  -- },
  {
    'robertmeta/nofrils',
  },
  -- {
  --   'rktjmp/lush.nvim',
  -- },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
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
    event = 'VeryLazy',
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
  -- {
  --   'mhinz/vim-startify',
  -- },
  -- {
  --   'goolord/alpha-nvim',
  --   -- dependencies = { 'echasnovski/mini.icons' },
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     local startify = require 'alpha.themes.startify'
  --     -- available: devicons, mini, default is mini
  --     -- if provider not loaded and enabled is true, it will try to use another provider
  --     startify.file_icons.provider = 'devicons'
  --     require('alpha').setup(startify.config)
  --   end,
  -- },
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
    event = 'VeryLazy',
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
  -- {
  --   'junegunn/fzf',
  --   dir = '~/.fzf',
  --   build = './install --all',
  --   -- dir = fzf_dir,
  --   -- build = get_fzf_build_command(),
  -- },
  -- {
  --   'junegunn/fzf.vim',
  -- },
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      defaults = {
        git_icons = false,
        file_icons = false,
        color_icons = false,
      },
      keymap = {
        builtin = { true, ['<Esc>'] = 'hide' },
      },
      winopts = {
        preview = {
          hidden = true,
        },
        fullscreen = true,
      },
    },
  },
  -- {
  --   'akinsho/toggleterm.nvim',
  --   version = '*',
  --   config = true,
  --
  --   -- config = function()
  --   --   require('toggleterm').setup{(
  --   --     -- defaults
  --   --   )}
  --   -- end,
  -- },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    opts = {},
  },
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
            'neo-tree',
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
            'diff',
            'diagnostics',
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
  -- {
  --   'nvim-telescope/telescope-file-browser.nvim',
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-lua/plenary.nvim',
  --   },
  -- },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- defaults
      }
    end,
  },
  -- {
  --   'nvim-telesecope/telescope-frecency.nvim',
  --   config = function()
  --     require('telescope').load_extension 'frecency'
  --   end,
  -- },

  {
    'kdheepak/lazygit.nvim',
    -- lazy = true,
    event = 'VeryLazy',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'folke/zen-mode.nvim',
    event = 'VeryLazy',
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
    },
  },
  -- {
  --   'neo451/feed.nvim',
  --   dependencies = {
  --     'neo451/treedoc.nvim',
  --     'stevearc/conform.nvim',
  --     'j-hui/fidget.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   opts = {
  --     feeds = {
  --       {
  --         -- FIXME: What should the "key" be for the link?
  --         xmlUrl = 'https://neovim.io/news.xml',
  --         name = 'neovim',
  --         tags = { 'tech', 'vim', 'news' }, -- a simple url pasted here is also fine
  --         --
  --         -- FIXME: Also trying to include as a "simple url pasted here"...
  --         -- 'https://neovim.io/news.xml',
  --       },
  --     },
  --   },
  -- },
  -- {
  -- NOTE: Seems to interfere with the quality of macro recordings when specific keypresses are
  -- involved
  --   'bullets-vim/bullets.vim',
  --   -- opts = {},
  --   config = function()
  --     require('bullets').setup()
  --   end,
  -- },
  -- {
  --   'sphamba/smear-cursor.nvim',
  --   opts = {
  --     legacy_computing_symbols_support = false,
  --     -- cursor_color = '#09FDFF',
  --     cursor_color = '#2C3336',
  --   },
  -- },
  -- {
  --   'karb94/neoscroll.nvim',
  --   opts = {
  --     -- easing = 'quadratic',
  --     -- easing = 'sine',
  --     -- easing = 'quartic',
  --     easing = 'quintic',
  --   },
  -- },
  -- {
  --   'brenoprata10/nvim-highlight-colors',
  --   opts = {},
  -- },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    event = 'VeryLazy',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    -- config = function()
    --   require('nvim-tree').setup {}
    -- end,
    opts = {
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = true,
            modified = true,
            hidden = true,
          },
        },
      },
    },
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    -- keys = {
    --   {
    --     '<leader>y',
    --     '<cmd>Yazi<cr>',
    --     desc = 'Open yazi at the current file',
    --   },
    --   {
    --     '<leader>cw',
    --     '<cmd>Yazi cwd<cr>',
    --     desc = "Open the file manager in nvim's working directory",
    --   },
    --   {
    --     -- NOTE: this requires a version of yazi that includes
    --     -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
    --     -- '<c-up>',
    --     -- '<cmd>Yazi toggle<cr>',
    --     -- desc = 'Resume the last yazi session',
    --   },
    -- },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
      floating_window_scaling_factor = 1.0,
    },
  },
}
