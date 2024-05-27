return {
  -- Comment/uncomment with gc
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  -- maximizes and restores current window
  {
    "szw/vim-maximizer",
  },
  -- tmux & split window navitation
  {
    "christoomey/vim-tmux-navigator",
  },
  -- Add nvim-nio
  {
    "nvim-neotest/nvim-nio",
  },
  -- which-key.nvim for keybinding hints
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },
  { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
  {
    -- Git integration
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    -- Visual multi
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  },
}
