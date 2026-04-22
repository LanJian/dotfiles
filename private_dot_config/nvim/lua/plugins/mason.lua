local ensure_installed = {
  "bashls",
  "gopls",
  "graphql",
  "jsonls",
  "lua_ls",
  "basedpyright",
  "rust_analyzer",
  "taplo",
  "terraformls",
  "ts_ls",
}

return {
  "mason-org/mason-lspconfig.nvim",
  opts = { ensure_installed = ensure_installed },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
