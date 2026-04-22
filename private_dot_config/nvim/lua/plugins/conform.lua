local opts = {
  formatters_by_ft = {
    python = { "ruff_format" },
    rust = { "rustfmt" },
    markdown = { "rumdl" },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_format = "fallback",
  },
}

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = opts,
}
