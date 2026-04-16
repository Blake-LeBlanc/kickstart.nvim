-- https://github.com/LazyVim/LazyVim/discussions/3669#discussioncomment-14654271
local function CleanShaDaTmp()
  local shada_dir = vim.fn.stdpath 'data' .. '\\shada'
  local pattern = shada_dir .. '\\main.shada.tmp.*'

  for _, file in ipairs(vim.fn.glob(pattern, false, true)) do
    os.remove(file)
  end
end

vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = CleanShaDaTmp,
})
