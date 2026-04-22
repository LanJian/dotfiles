vim.g.undotree_SetFocusWhenToggle = 1

local keys = {
  { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
}

return {
  "mbbill/undotree",
  keys = keys,
}
