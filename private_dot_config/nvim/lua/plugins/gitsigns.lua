local opts = {
  signs = {
    add    = {text = '┃'},
    change = {text = '┃'},
    changedelete = {text = '┅'},
  },
  signcolumn = true,
}

return {
  "lewis6991/gitsigns.nvim",
  opts = opts,
}
