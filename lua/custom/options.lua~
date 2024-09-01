local opt = vim.opt

opt.foldmethod = 'marker'
opt.viewdir = vim.fn.expand '$HOME/vimfiles/view'
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.textwidth = 100
opt.colorcolumn = '+1'
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.smarttab = true
opt.showbreak = '...'
opt.linebreak = true
opt.modeline = false
opt.autoindent = true
opt.copyindent = true
opt.breakindent = true
opt.startofline = false
opt.matchtime = 1
opt.backspace = { 'indent', 'eol', 'start' }
opt.autoread = true
opt.ttimeoutlen = 10
opt.ttyfast = true
opt.statusline = '%<%f %h%m%r%=%-14.(%l,%c%V%) %P'
opt.laststatus = 2
opt.report = 0
opt.showmode = false
opt.showcmd = true
opt.shortmess:remove 'S'
opt.shortmess:append 'F'
opt.number = true
opt.relativenumber = true
opt.wildmenu = true
opt.wildmode = { 'list:longest' }
opt.wildignore = { '.o', '.obj', '.bak', '.exe' }
opt.backup = true
opt.writebackup = true
opt.swapfile = true

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

-- :FZF related commands
-- keymap('n', '<C-p>', ':GFiles<CR>', opts)
-- keymap('n', '<C-e>', ':FZF<CR>', opts)
-- keymap('n', '<C-s>', ':Rg<SPACE>', opts)
-- keymap('n', '<C-b>', ':Buffers<CR>', opts)
-- keymap('n', '<C-h>', ':History<CR>', opts)

-- :Telescope equivalents of same FZF commands
keymap('n', '<C-p>', ':Telescope git_files<CR>', opts)
keymap('n', '<C-e>', ':Telescope find_files<CR>', opts)
keymap('n', '<C-s>', ':Telescope live_grep', opts)
keymap('n', '<C-b>', ':Telescope buffers<CR>', opts)
keymap('n', '<C-h>', ':Telescope oldfiles<CR>', opts)

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
