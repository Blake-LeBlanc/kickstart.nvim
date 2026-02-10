-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- local function is_windows()
--   return package.config:sub(1, 1) == '\\'
-- end
--
-- local function get_fzf_build_command()
--   if is_windows() then
--     return nil
--   else
--     return './install --all'
--   end
-- end
--
-- local fzf_dir = is_windows() and vim.fn.expand '~\\fzf' or vim.fn.expand '~/.fzf'
-- local fzf_executable_path = is_windows()
--     and 'C:\\Users\\blake.leblanc\\AppData\\Local\\Microsoft\\WinGet\\Packages\\junegunn.fzf_Microsoft.Winget.Source_8wekyb3d8bbwe\\fzf.exe'
--   or 'fzf'

-- custom commands for nvim-tree.lua{{{
-- https://github.com/nvim-tree/nvim-tree.lua/discussions/1896#discussioncomment-6828472
-- NOTE: Can't seem to get this to work properly... The problem I seem to be running into is that
-- the keymapping is part of my options.lua file, while the underlying functions this command is
-- trying to execute resides here, in the init.lua file. Let me try setting up the keymap here, just
-- got to find something that's not currently in use... Okay, so that seems to work, it calls the
-- function! However! It errors out, saying it doesn't know what the `api` call is about...
local sort_by_name = true
local function sort_by_natural(nodes)
  local function sorter(left, right)
    if left.type ~= 'directory' and right.type == 'directory' then
      return false
    elseif left.type == 'directory' and right.type ~= 'directory' then
      return true
    end
    left = left.name:lower()
    right = right.name:lower()

    if left == right then
      return false
    end

    for i = 1, math.max(string.len(left), string.len(right)), 1 do
      local l = string.sub(left, i, -1)
      local r = string.sub(right, i, -1)

      if type(tonumber(string.sub(l, 1, 1))) == 'number' and type(tonumber(string.sub(r, 1, 1))) == 'number' then
        local l_number = tonumber(string.match(l, '^[0-9]+'))
        local r_number = tonumber(string.match(r, '^[0-9]+'))

        if l_number ~= r_number then
          return l_number < r_number
        end
      elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
        return l < r
      end
    end
  end

  if sort_by_name then
    table.sort(nodes, sorter)
  else
    return 'modification_time'
  end
end

local cycle_sort = function()
  sort_by_name = not sort_by_name
  api.tree.reload()
  if sort_by_name then
    vim.notify 'Sorting by name'
  else
    vim.notify 'Sorting by modification time'
  end
end

-- }}}

return {
  -- colorschemes{{{
  -- {
  --   'folke/tokyonight.nvim',
  -- },
  {
    'mcchrish/zenbones.nvim',
    event = 'VeryLazy',
    dependencies = { 'rktjmp/lush.nvim' },
  },
  {
    'robertmeta/nofrils',
  },
  -- {
  --   'pbrisbin/vim-colors-off',
  -- },
  -- {
  --   'jaredgorski/fogbell.vim',
  -- },
  -- {
  --   'pgdouyon/vim-yin-yang',
  -- },
  -- {
  --   'cideM/yui',
  -- },
  -- {
  --   'vim-scripts/zenesque.vim',
  -- },
  -- }}}
  -- { 'rktjmp/lush.nvim',{{{
  -- },}}}
  -- { 'ggandor/leap.nvim',{{{
  --   config = function()
  --     require('leap').create_default_mappings()
  --     -- NOTE: Whenever I used the above, not only did it cause nvim to complain about a clash with
  --     -- mini.surround, it also did not work. Normal mode `s` would still act as vim's default
  --     -- replace-like thingymajig. Only got it to work by by explicitly defining the mappings here.
  --     vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
  --     vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
  --     vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
  --   end,
  -- },}}}
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          -- enabled = true,
        },
      },
    },
  -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
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
    event = 'VeryLazy',
    -- opts = {},
  },
  {
    -- The main reason I use this is because it allows for bi-directional searching near cursor position
    'wellle/targets.vim',
    event = 'VeryLazy',
    -- opts = {},
  },
  -- { 'windwp/nvim-autopairs',{{{
  --   event = 'InsertEnter',
  --   config = true,
  --   opts = {
  --     -- defaults
  --   },
  -- },}}}
  -- { 'mhinz/vim-startify' },
  -- { 'goolord/alpha-nvim',{{{
  --   -- dependencies = { 'echasnovski/mini.icons' },
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     local startify = require 'alpha.themes.startify'
  --     -- available: devicons, mini, default is mini
  --     -- if provider not loaded and enabled is true, it will try to use another provider
  --     startify.file_icons.provider = 'devicons'
  --     require('alpha').setup(startify.config)
  --   end,
  -- },}}}
  -- { 'echasnovski/mini.map',{{{
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
  -- },}}}
  {
    'echasnovski/mini.files',
    event = 'VeryLazy',
    version = '*',
    opts = {
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
        go_in_plus = '<CR>', --default L
        go_out = 'h',
        go_out_plus = 'H',
        reset = '<BS>',
        reveal_cwd = '@',
        show_help = 'g?',
        synchronize = 'w', --default =
        trim_left = '<',
        trim_right = '>',
      },

      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = false,
        -- Whether to use for editing directories
        use_as_default_explorer = true,
      },

      windows = {
        max_number = math.huge,
        preview = true,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 50,
      },
    },
    keys = {
      vim.keymap.set('n', '-', '<CMD>lua MiniFiles.open()<CR>'),
    },
    config = function(_, opts)
      -- taken from:
      -- https://www.reddit.com/r/neovim/comments/1bceiw2/oilnvim_vs_minifiles/kuhmdp9/
      require('mini.files').setup(opts)

      local show_dotfiles = true

      local filter_show = function(fs_entry)
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end

      local gio_open = function()
        local fs_entry = require('mini.files').get_fs_entry()
        vim.notify(vim.inspect(fs_entry))
        vim.fn.system(string.format("gio open '%s'", fs_entry.path))
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require('mini.files').refresh { content = { filter = new_filter } }
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
          vim.keymap.set('n', '-', require('mini.files').close, { buffer = buf_id })
          vim.keymap.set('n', 'o', gio_open, { buffer = buf_id })
        end,
      })
    end,
  },
  {
    'nvim-mini/mini.comment',
    version = false,
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gc',

        -- Toggle comment on current line
        comment_line = 'gcc',

        -- Toggle comment on visual selection
        comment_visual = 'gc',

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = 'gc',
      },
    },
  },
  {
    'nvim-mini/mini.surround',
    version = false,
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = '<leader>sa', -- Add surrounding in Normal and Visual modes
        delete = '<leader>sd', -- Delete surrounding
        find = '<leader>sf', -- Find surrounding (to the right)
        find_left = '<leader>sF', -- Find surrounding (to the left)
        highlight = '<leader>sh', -- Highlight surrounding
        replace = '<leader>sr', -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },

      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = 'cover',

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    },
  },
  {
    'nvim-mini/mini.ai',
    version = false,
    opts = {},
  },
  {
    'norcalli/nvim-colorizer.lua',
    opts = {},
  },
  -- { 'junegunn/fzf',{{{
  -- NOTE: While the below *should* cause a post-install hook to fire in Lazy.nvim to update the fzf
  -- binary, it may not work. If after install, you're running into weird errors after calling, say,
  -- `:History`, try manually updating the binary with `:call fzf#install()`
  --   dir = '~/.fzf',
  --   build = './install --all',
  --   -- dir = fzf_dir,
  --   -- build = get_fzf_build_command(),
  -- },}}}
  -- { 'junegunn/fzf.vim',{{{
  -- },}}}
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
        fullscreen = true,
        preview = {
          hidden = true,
        },
      },
      files = {
        no_ignore = true,
      },
      grep = {
        rg_opts = '--column --line-number --no-heading --color=always --smart-case -g "!*.*~" -g "!*.swp"',
      },
    },
  },
  -- { 'akinsho/toggleterm.nvim',{{{
  --   version = '*',
  --   config = true,
  --
  --   -- config = function()
  --   --   require('toggleterm').setup{(
  --   --     -- defaults
  --   --   )}
  --   -- end,
  -- },}}}
  -- { 'numToStr/Comment.nvim',{{{
  --   opts = {},
  -- },}}}
  -- { 'sindrets/diffview.nvim',{{{
  -- -- NOTE: Seems to be a pretty cool plugin for side by side diff views. Though, honestly, now that
  -- --     I'm familiar with the default vim diff viewer, I don't really see too much of a point right
  -- --     now. That, and it doesn't seem to play well with the nofrils colorscheme, the color banding
  -- --     is not present
  --   event = 'VeryLazy',
  --   opts = {},
  -- },}}}
  {
    'nvim-lualine/lualine.nvim',
    opts = {
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
          'NvimTree',
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
    },
  },
  -- { 'isakbm/gitgraph.nvim',{{{
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
  -- },}}}
  -- { 'Isrothy/neominimap.nvim',{{{
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
  -- },}}}
  -- { 'nvim-telescope/telescope-file-browser.nvim',{{{
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-lua/plenary.nvim',
  --   },
  -- },}}}
  -- { 'kylechui/nvim-surround',{{{
  --   version = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   event = 'VeryLazy',
  --   config = function()
  --     require('nvim-surround').setup {
  --       -- defaults
  --     }
  --   end,
  -- },}}}
  -- { 'nvim-telesecope/telescope-frecency.nvim',{{{
  --   config = function()
  --     require('telescope').load_extension 'frecency'
  --   end,
  -- },}}}
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
  -- { 'folke/zen-mode.nvim',{{{
  --   event = 'VeryLazy',
  --   opts = {
  --     window = {
  --       backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
  --       -- height and width can be:
  --       -- * an absolute number of cells when > 1
  --       -- * a percentage of the width / height of the editor when <= 1
  --       -- * a function that returns the width or the height
  --       width = 120, -- width of the Zen window
  --       height = 1, -- height of the Zen window
  --       -- by default, no options are changed for the Zen window
  --       -- uncomment any of the options below, or add other vim.wo options you want to apply
  --       options = {
  --         -- signcolumn = "no", -- disable signcolumn
  --         -- number = false, -- disable number column
  --         -- relativenumber = false, -- disable relative numbers
  --         -- cursorline = false, -- disable cursorline
  --         -- cursorcolumn = false, -- disable cursor column
  --         -- foldcolumn = "0", -- disable fold column
  --         -- list = false, -- disable whitespace characters
  --       },
  --     },
  --     on_open = function()
  --       vim.cmd 'TWEnable'
  --     end,
  --     on_close = function()
  --       vim.cmd 'TWDisable'
  --     end,
  --   },
  -- },}}}
  -- { 'neo451/feed.nvim',{{{
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
  -- },}}}
  -- { 'bullets-vim/bullets.vim',{{{
  --   -- NOTE: Seems to interfere with the quality of macro recordings when specific keypresses are
  --   -- involved
  --   -- NOTE: Can't seem to get it to work with the "usual" approaches, had to resort to vim.g
  --   -- opts = {},
  --   -- config = function()
  --   --   require('bullets').setup()
  --   -- end,
  --   init = function()
  --     vim.g.bullets_enabled_file_types = {
  --       'markdown',
  --       'text',
  --       'gitcommit',
  --     }
  --   end,
  -- },}}}
  -- { 'sphamba/smear-cursor.nvim',{{{
  --   opts = {
  --     legacy_computing_symbols_support = false,
  --     -- cursor_color = '#09FDFF',
  --     cursor_color = '#2C3336',
  --   },
  -- },}}}
  -- { 'karb94/neoscroll.nvim',{{{
  --   opts = {
  --     -- easing = 'quadratic',
  --     -- easing = 'sine',
  --     -- easing = 'quartic',
  --     easing = 'quintic',
  --   },
  -- },}}}
  -- { 'brenoprata10/nvim-highlight-colors',{{{
  --   opts = {},
  -- },}}}
  -- { 'nvim-tree/nvim-tree.lua',{{{
  --   -- NOTE: Per author, do not lazyload. Due to how plugin works, nothing would be gained anyway.
  --   -- See https://github.com/nvim-tree/nvim-tree.lua/discussions/2298
  --   version = '*',
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   -- config = function()
  --   --   require('nvim-tree').setup {}
  --   -- end,
  --   opts = {
  --     renderer = {
  --       icons = {
  --         show = {
  --           file = false,
  --           folder = false,
  --           folder_arrow = true,
  --           git = true,
  --           modified = true,
  --           hidden = true,
  --         },
  --       },
  --     },
  --     sort_by = sort_by_natural,
  --     -- vim.keymap.set('n', '<leader>/', cycle_sort),
  --   },
  -- },}}}
  -- { 'mikavilpas/yazi.nvim',{{{
  --   event = 'VeryLazy',
  --   opts = {
  --     -- if you want to open yazi instead of netrw, see below for more info
  --     open_for_directories = false,
  --     keymaps = {
  --       show_help = '<f1>',
  --     },
  --     floating_window_scaling_factor = 1.0,
  --   },
  -- },}}}
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { -- Example mapping to toggle outline
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {
      -- Your setup opts here
    },
  },
  -- { 'joshuadanpeterson/typewriter',{{{
  --   config = function()
  --     require('typewriter').setup {
  --       enable_with_zen_mode = true,
  --       enable_with_true_zen = true,
  --       keep_cursor_position = true,
  --       enable_notifications = false,
  --       enable_horizontal_scroll = false,
  --       start_enabled = false,
  --     }
  --   end,
  --   opts = {},
  -- },}}}
  -- { 'nvzone/typr',{{{
  --   dependencies = 'nvzone/volt',
  --   opts = {},
  --   cmd = { 'Typr', 'TyprStats' },
  -- },}}}
  -- { 'alex-popov-tech/store.nvim',{{{
  --   dependencies = {
  --     'OXY2DEV/markview.nvim',
  --   },
  --   config = function()
  --     require('store').setup {
  --       -- Window dimensions (percentages or absolute)
  --       width = 0.8,
  --       height = 0.8,
  --
  --       -- Layout proportions (must sum to 1.0)
  --       proportions = {
  --         list = 0.3, -- 30% for repository list
  --         preview = 0.7, -- 70% for preview pane
  --       },
  --
  --       -- Modal appearance
  --       modal = {
  --         border = 'rounded', -- Border style
  --         zindex = 50, -- Z-index for modal windows
  --       },
  --
  --       -- Keybindings
  --       keybindings = {
  --         help = '?', -- Show help
  --         close = 'q', -- Close modal
  --         filter = 'f', -- Open filter input
  --         refresh = 'r', -- Refresh data
  --         open = '<cr>', -- Open selected repository
  --         switch_focus = '<tab>', -- Switch focus between panes
  --       },
  --
  --       -- Behavior
  --       preview_debounce = 150, -- ms delay for preview updates
  --       cache_duration = 24 * 60 * 60, -- 24 hours in seconds
  --       logging = 'off', -- Levels: off, error, warn, log, debug
  --     }
  --   end,
  --   cmd = 'Store',
  --   opts = {},
  -- },}}}
  -- {
  --   'rachartier/tiny-inline-diagnostic.nvim',
  --   event = 'VeryLazy',
  --   priority = 1000,
  --   opts = {},
  -- },
  -- {
  --   'neovim/nvim-lspconfig',
  --   opts = { diagnostics = { virtual_text = false } },
  -- },
  -- {
  --   'saxon1964/neovim-tips',
  --   version = '*', -- Only update on tagged releases
  --   lazy = false, -- Load on startup (recommended for daily tip feature)
  --   dependencies = {
  --     'MunifTanjim/nui.nvim',
  --     -- OPTIONAL: Choose your preferred markdown renderer (or omit for raw markdown)
  --     -- 'MeanderingProgrammer/render-markdown.nvim', -- Clean rendering
  --     -- "OXY2DEV/markview.nvim", -- Rich rendering with advanced features
  --   },
  --   opts = {
  --     -- OPTIONAL: Location of user defined tips (default value shown below)
  --     user_file = vim.fn.stdpath 'config' .. '/neovim_tips/user_tips.md',
  --     -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
  --     user_tip_prefix = '[User] ',
  --     -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
  --     warn_on_conflicts = true,
  --     -- OPTIONAL: Daily tip mode (default: 1)
  --     -- 0 = off, 1 = once per day, 2 = every startup
  --     daily_tip = 1,
  --     -- OPTIONAL: Bookmark symbol (default: "🌟 ")
  --     bookmark_symbol = '🌟 ',
  --   },
  --   init = function()
  --     -- OPTIONAL: Change to your liking or drop completely
  --     -- The plugin does not provide default key mappings, only commands
  --     local map = vim.keymap.set
  --     map('n', '<leader>nto', ':NeovimTips<CR>', { desc = 'Neovim tips', noremap = true, silent = true })
  --     map('n', '<leader>nte', ':NeovimTipsEdit<CR>', { desc = 'Edit your Neovim tips', noremap = true, silent = true })
  --     map('n', '<leader>nta', ':NeovimTipsAdd<CR>', { desc = 'Add your Neovim tip', noremap = true, silent = true })
  --     map('n', '<leader>nth', ':help neovim-tips<CR>', { desc = 'Neovim tips help', noremap = true, silent = true })
  --     map('n', '<leader>ntr', ':NeovimTipsRandom<CR>', { desc = 'Show random tip', noremap = true, silent = true })
  --     map('n', '<leader>ntp', ':NeovimTipsPdf<CR>', { desc = 'Open Neovim tips PDF', noremap = true, silent = true })
  --   end,
  -- },
  {
    'airblade/vim-rooter',
    -- opts = {},
    -- config = function()
    --   require('vim-rooter').setup {}
    -- end,
  },
  {
    'yetone/avante.nvim',
    -- per https://github.com/yetone/avante.nvim/discussions/687
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = 'ollama',
      use_absolute_path = true,
      providers = {
        ---@type AvanteProvider
        ollama = {
          ['local'] = true,
          endpoint = os.getenv 'OLLAMA_ENDPOINT',
          model = 'qwen3-coder:latest',
          -- parse_curl_args = function(opts, code_opts)
          --   return {
          --     url = opts.endpoint .. '/chat/completions',
          --     headers = {
          --       ['Accept'] = 'application/json',
          --       ['Content-Type'] = 'application/json',
          --       ['x-api-key'] = 'ollama',
          --     },
          --     body = {
          --       model = opts.model,
          --       messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
          --       max_tokens = 2048,
          --       stream = true,
          --     },
          --   }
          -- end,
          -- parse_response_data = function(data_stream, event_state, opts)
          --   require('avante.providers').openai.parse_response(data_stream, event_state, opts)
          -- end,
        },
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = 'co',
          theirs = 'ct',
          all_theirs = 'ca',
          both = 'cb',
          cursor = 'cc',
          next = ']x',
          prev = '[x',
        },
        suggestion = {
          accept = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
        jump = {
          next = ']]',
          prev = '[[',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
      },
      hints = { enabled = true },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = 'right', -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = 'center', -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = 'DiffText',
          incoming = 'DiffAdd',
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = 'copen',
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- build = 'make BUILD_FROM_SOURCE=true',
    build = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false', -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    keys = {
      {
        '<leader>aa',
        function()
          require('avante.api').ask()
        end,
        desc = 'avante: ask',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ar',
        function()
          require('avante.api').refresh()
        end,
        desc = 'avante: refresh',
      },
      {
        '<leader>ae',
        function()
          require('avante.api').edit()
        end,
        desc = 'avante: edit',
        mode = 'v',
      },
    },
  },
}
