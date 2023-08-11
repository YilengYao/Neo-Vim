vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps
-- <CR> means enter key 
keymap.set("n", "<leader>h", "_") -- space + h will move cursor to beginning of first whitespace of the line
keymap.set("n", "<leader>l", "$") -- space + l will move cursor to end of line

-- -- press space + n + h will clear search
keymap.set("n", "<leader>/", ":nohl<CR>")

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
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- space + s + m maximizes the split window or restore to original size
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
keymap.set("n", "<leader>gff", "<cmd>Telescope git_files<cr>") -- find files with in git directory
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commit for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file of diff preview ["gs" for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- nvim- dap
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", "<leader>ba", '<cmd>Telescope dap list_breakpoints<cr>')
require("which-key").register({
  v = {
   name = "test",
  },
}, {prefix = "<leader>"})

keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>")
keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>")
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", "<leader>di", function() require"dap.ui.widgets".hover() end)
keymap.set("n", "<leader>d?", function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
keymap.set("n", "<leader>df", '<cmd>Telescope dap frames<cr>')
keymap.set("n", "<leader>dh", '<cmd>Telescope dap commands<cr>')
require("which-key").register({
 d = {
   name = "debug",
 },
}, {prefix = "<leader>"})
