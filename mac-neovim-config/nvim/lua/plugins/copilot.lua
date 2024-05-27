return {
  {
    "github/copilot.vim",
    config = function()
      -- Keybindings for copilot
      vim.api.nvim_set_keymap("i", "<C-y>", "copilot#Accept('<CR>')", { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-j>", "copilot#Next()", { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Prev()", { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-d>", "copilot#Dismiss()", { silent = true, expr = true })
    end,
  },
}
