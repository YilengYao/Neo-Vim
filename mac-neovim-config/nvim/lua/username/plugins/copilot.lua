-- Check if the plugin is installed
local status, copilot = pcall(require, "copilot")
if not status then
	return
end

-- Configure copilot
copilot.setup({
	suggestion = {
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<C-j>",
			next = "<C-n>",
			prev = "<C-p>",
			dismiss = "<C-c>",
		},
	},
	filetypes = {
		markdown = true,
		yaml = true,
		javascript = true,
		typescript = true,
		lua = true,
		python = true,
		go = true,
		rust = true,
		java = true,
		["*"] = false, -- disable for all other filetypes
	},
})

-- Keybindings for copilot
vim.api.nvim_set_keymap("i", "<C-j>", "copilot#Accept('<CR>')", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-n>", "copilot#Next()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-p>", "copilot#Prev()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-c>", "copilot#Dismiss()", { silent = true, expr = true })
