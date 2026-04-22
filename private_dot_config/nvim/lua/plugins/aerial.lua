local function on_attach(bufnr)
  vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
  vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
end

local opts = {
  on_attach = on_attach,
}

local keys = {
  { "<leader>aa", "<cmd>AerialToggle!<cr>", desc = "Toggle aerial" },
  { "<leader>j", "<cmd>AerialNavToggle<cr>", desc = "Aerial nav" },
  { "<F8>", "<cmd>AerialToggle<cr>", desc = "Toggle code outline" },
}

return {
  "stevearc/aerial.nvim",
  opts = opts,
  keys = keys,
}
