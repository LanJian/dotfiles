local keys = {
  { "<leader>gh", "<cmd>GBrowse!<cr>", mode = "n", desc = "Copy GitHub URL" },
  { "<leader>gh", ":GBrowse!<cr>",     mode = "v", desc = "Copy GitHub URL (selection)" },
}

return {
  "tpope/vim-fugitive",
  dependencies = { "tpope/vim-rhubarb" },
  cmd = { "Git", "GBrowse", "Gwrite", "Gdiffsplit" },
  keys = keys,
}
