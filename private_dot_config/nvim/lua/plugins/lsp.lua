local servers = {
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = true,
          implementations = { enable = true },
          references = {
            adt = { enable = true },
            enumVariant = { enable = true },
            method = { enable = true },
            trait = { enable = true },
          },
        },
        highlightRelated = {
          breakPoints = { enable = true },
          exitPoints = { enable = true },
          references = { enable = true },
        },
      },
    },
  },
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = { useLibraryCodeForTypes = true },
      },
    },
  },
  ts_ls = {},
  jsonls = {},
  bashls = {},
  taplo = {},
  gopls = {},
  terraformls = {},
  graphql = {},
}

local function config()
  vim.diagnostic.config({
    virtual_text = {
      prefix = " ◇◈◆  ",
      source = "if_many",
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "🮉",
        [vim.diagnostic.severity.WARN] = "🮉",
        [vim.diagnostic.severity.HINT] = "🮉",
        [vim.diagnostic.severity.INFO] = "🮉",
      },
    },
    float = { border = "rounded" },
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  for server, settings in pairs(servers) do
    vim.lsp.config(server, vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, settings))
  end
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = config,
}
