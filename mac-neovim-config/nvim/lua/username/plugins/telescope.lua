-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- import telescope
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    mappings = {
     i = {
      ["<C-p>"] = actions.move_selection_previous, -- Ctrl + p to move to previous result
      ["<C-n>"] = actions.move_selection_next, -- Ctrl + n to move to next result
      ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- Ctrl + q send selected to quickfixlist
     }
    }
  }
})

telescope.load_extension("fzf")
