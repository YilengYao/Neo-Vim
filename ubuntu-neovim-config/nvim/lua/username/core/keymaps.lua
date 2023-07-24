vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymapsi
-- <CR> means enter
-- -- press j + k exits insert mode
keymap.set("i", "jk", "<ESC>")

-- -- press space + n + h will clear search
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- -- normal mode press x key will delete single character and not copy to register
keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>") -- space + + will increment number
keymap.set("n", "<leader>-", "<C-x>") -- space + - will decrement number

keymap.set("n", "<leader>sv", "<C-w>v") -- split windows vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split windows horizonatally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window


keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
 
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go toprevious tab

----------------------
-- Plugin Keybinds
-- -------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CCR>") -- space + s + m maximizes the split window or restore to original size

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- space + e opens up the nvim tree explorer
-- once we are in nvim-tree we can create new file with a

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commit for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file of diff preview ["gs" for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
