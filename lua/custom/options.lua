local opt = vim.opt

opt.autoindent = true
opt.autoread = true
opt.backspace = { 'indent', 'eol', 'start' }
opt.backup = true
opt.breakindent = true
opt.colorcolumn = '+1'
opt.copyindent = true
opt.cursorline = true
opt.foldmethod = 'marker'
opt.gdefault = true
opt.guicursor = ''
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.inccommand = 'split'
opt.laststatus = 2
opt.linebreak = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.matchtime = 1
opt.modeline = false
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.report = 0
opt.scrolloff = 7
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append 'F'
opt.shortmess:remove 'S'
opt.showbreak = '...'
opt.showcmd = true
opt.showmode = false
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smarttab = true
opt.splitright = true
opt.splitbelow = true
opt.startofline = false
opt.statusline = '%<%f %h%m%r%=%-14.(%l,%c%V%) %P'
opt.swapfile = true
opt.tabstop = 2
opt.textwidth = 100
opt.ttimeoutlen = 300
opt.ttyfast = true
opt.updatetime = 250
opt.viewdir = vim.fn.expand '$HOME/vimfiles/view'
opt.wildignore = { '.o', '.obj', '.bak', '.exe' }
opt.wildmenu = true
opt.wildmode = { 'list:longest' }
opt.writebackup = true

-- Autocommands
-- vim.cmd [[
-- augroup remember_folds
--   autocmd!
--   autocmd BufWinLeave * mkview
--   autocmd BufWinEnter * silent! loadview
-- augroup END
-- ]]

vim.cmd [[
  autocmd FileType * set formatoptions=tcrqn1jp
]]

-- Key mappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', '<C-j>', 'gj', opts)
keymap('n', '<C-k>', 'gk', opts)
keymap('n', '<leader>d', ':lcd %:p:h<CR>', opts)
keymap('n', '<leader>D', ':cd %:p:h<CR>', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', 'J', 'mzJ`z', opts)
keymap('n', '{', '{zz', opts)
keymap('n', '}', '}zz', opts)
keymap('n', ']c', ']czz', opts)
keymap('n', '[c', '[czz', opts)
keymap('n', '[q', ':cprev<CR>zz', opts)
keymap('n', ']q', ':cnext<CR>zz', opts)
keymap('n', '[Q', ':cfirst<CR>zz', opts)
keymap('n', ']Q', ':clast<CR>zz', opts)
-- NOTE: Something seems to be hijacking the default n A command, resetting here
keymap('n', 'A', 'A', opts)

-- :FZF related commands
-- keymap('n', '<C-p>', ':GFiles<CR>', opts)
-- keymap('n', '<C-e>', ':FZF<CR>', opts)
-- keymap('n', '<C-s>', ':Rg<SPACE>', opts)
-- keymap('n', '<C-b>', ':Buffers<CR>', opts)
-- keymap('n', '<C-h>', ':History<CR>', opts)

-- :Telescope equivalents of same FZF commands
-- keymap('n', '<C-p>', ':Telescope git_files<CR>', opts)
-- keymap('n', '<C-e>', ':Telescope find_files<CR>', opts)
-- keymap('n', '<C-s>', ':Telescope live_grep<CR>', opts)
-- keymap('n', '<C-b>', ':Telescope buffers<CR>', opts)
-- keymap('n', '<C-h>', ':Telescope oldfiles<CR>', opts)

-- keymap('n', '<leader>fb', ':Telescope file_browser<CR>', opts)
keymap('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', opts)

-- Global variables
vim.g.startify_custom_header = {}

vim.g.fzf_preview_window = {}
vim.g.fzf_force_termguicolors = 1
vim.g.fzf_layout = { window = { width = 0.9, height = 0.9 } }

-- For commands you are not converting here, you can still call vim.cmd
-- vim.cmd [[set shell=powershell]]
-- vim.cmd [[set shellcmdflag=-command]]
-- vim.cmd [[set shellquote=\"]]
-- vim.cmd [[set shellxquote=]]
