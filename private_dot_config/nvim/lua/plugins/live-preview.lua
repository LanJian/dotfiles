local keys = {
  { "<leader>mp", "<cmd>LivePreview start<cr>", desc = "Start markdown preview" },
}

return {
  "brianhuster/live-preview.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  ft = "markdown",
  cmd = "LivePreview",
  keys = keys,
}
