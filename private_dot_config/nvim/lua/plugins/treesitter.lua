require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "ruby", "rust", "python", "yaml" },

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },
}
