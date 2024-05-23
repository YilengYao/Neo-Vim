local status, copilot_chat = pcall(require, "CopilotChat")
if not status then
	return
end

copilot_chat.setup({
	debug = true, -- Enable debugging
	-- See Configuration section for rest
})

-- Define keybindings
local opts = { noremap = true, silent = true }

-- Code related commands (normal mode)
vim.api.nvim_set_keymap(
	"n",
	"<leader>cce",
	"<cmd>CopilotChatExplain<cr>",
	{ desc = "CopilotChat - Explain code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>cct",
	"<cmd>CopilotChatTests<cr>",
	{ desc = "CopilotChat - Generate tests", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccr",
	"<cmd>CopilotChatReview<cr>",
	{ desc = "CopilotChat - Review code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccR",
	"<cmd>CopilotChatRefactor<cr>",
	{ desc = "CopilotChat - Refactor code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccf",
	"<cmd>CopilotChatFixCode<cr>",
	{ desc = "CopilotChat - Fix code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccd",
	"<cmd>CopilotChatDocumentation<cr>",
	{ desc = "CopilotChat - Add documentation for code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>cca",
	"<cmd>CopilotChatSwaggerApiDocs<cr>",
	{ desc = "CopilotChat - Add Swagger API documentation", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccA",
	"<cmd>CopilotChatSwaggerJsDocs<cr>",
	{ desc = "CopilotChat - Add Swagger API with Js Documentation", noremap = true, silent = true }
)

-- Code related commands (visual mode)
vim.api.nvim_set_keymap(
	"x",
	"<leader>cce",
	":CopilotChatExplain<cr>",
	{ desc = "CopilotChat - Explain code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>cct",
	":CopilotChatTests<cr>",
	{ desc = "CopilotChat - Generate tests", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccr",
	":CopilotChatReview<cr>",
	{ desc = "CopilotChat - Review code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccR",
	":CopilotChatRefactor<cr>",
	{ desc = "CopilotChat - Refactor code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccf",
	":CopilotChatFixCode<cr>",
	{ desc = "CopilotChat - Fix code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccd",
	":CopilotChatDocumentation<cr>",
	{ desc = "CopilotChat - Add documentation for code", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>cca",
	":CopilotChatSwaggerApiDocs<cr>",
	{ desc = "CopilotChat - Add Swagger API documentation", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccA",
	":CopilotChatSwaggerJsDocs<cr>",
	{ desc = "CopilotChat - Add Swagger API with Js Documentation", noremap = true, silent = true }
)

-- Text related commands (normal mode)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccs",
	"<cmd>CopilotChatSummarize<cr>",
	{ desc = "CopilotChat - Summarize text", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccS",
	"<cmd>CopilotChatSpelling<cr>",
	{ desc = "CopilotChat - Correct spelling", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccw",
	"<cmd>CopilotChatWording<cr>",
	{ desc = "CopilotChat - Improve wording", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccc",
	"<cmd>CopilotChatConcise<cr>",
	{ desc = "CopilotChat - Make text concise", noremap = true, silent = true }
)

-- Text related commands (visual mode)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccs",
	":CopilotChatSummarize<cr>",
	{ desc = "CopilotChat - Summarize text", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccS",
	":CopilotChatSpelling<cr>",
	{ desc = "CopilotChat - Correct spelling", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccw",
	":CopilotChatWording<cr>",
	{ desc = "CopilotChat - Improve wording", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccc",
	":CopilotChatConcise<cr>",
	{ desc = "CopilotChat - Make text concise", noremap = true, silent = true }
)

-- Chat with Copilot in visual mode
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccv",
	":CopilotChatVisual<cr>",
	{ desc = "CopilotChat - Open in vertical split", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccx",
	":CopilotChatInPlace<cr>",
	{ desc = "CopilotChat - Run in-place code", noremap = true, silent = true }
)

-- Custom input for CopilotChat
vim.api.nvim_set_keymap(
	"n",
	"<leader>cci",
	":lua AskCopilot()<cr>",
	{ desc = "CopilotChat - Ask input", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>cci",
	":lua AskCopilotVisual()<cr>",
	{ desc = "CopilotChat - Ask input (visual)", noremap = true, silent = true }
)

-- Define the AskCopilot function
function AskCopilot()
	local input = vim.fn.input("Ask Copilot: ")
	if input ~= "" then
		vim.cmd("CopilotChat " .. input)
	end
end

-- Define the AskCopilotVisual function
function AskCopilotVisual()
	local input = vim.fn.input("Ask Copilot: ")
	if input ~= "" then
		vim.cmd("'<,'>CopilotChat " .. input)
	end
end

-- Debug
vim.api.nvim_set_keymap(
	"n",
	"<leader>ccD",
	"<cmd>CopilotChatDebugInfo<cr>",
	{ desc = "CopilotChat - Debug Info", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<leader>ccD",
	":CopilotChatDebugInfo<cr>",
	{ desc = "CopilotChat - Debug Info", noremap = true, silent = true }
)
