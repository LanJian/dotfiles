local parsers = {
  "bash",
  "c",
  "css",
  "diff",
  "dockerfile",
  "gitcommit",
  "go",
  "graphql",
  "haskell",
  "hcl",
  "html",
  "java",
  "javascript",
  "json",
  "jsonnet",
  "just",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "ruby",
  "rust",
  "scss",
  "svelte",
  "terraform",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local function config()
  require("nvim-treesitter").install(parsers)
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = config,
}
