local keys = {
  { "<leader>dv", "<cmd>DiffviewOpen<cr>",          desc = "Open diffview" },
  { "<leader>dc", "<cmd>DiffviewClose<cr>",         desc = "Close diffview" },
  { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
}

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = keys,
  opts = {},
}
