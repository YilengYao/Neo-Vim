-- import nvim-visual-multi plugin safely
local vim_multi_status, vim_multi = pcall(require, "vim-visual-multi")
if not vim_multi_status then
	return
end

vim_multi.setup()
