-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- format on save
vim.cmd([[
  augroup FormatOnSave
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format()
  augroup END
]])
