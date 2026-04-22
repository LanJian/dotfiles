local keys = {
  { "<leader>sj", function() require("treesj").split() end, desc = "Split block" },
  { "<leader>sk", function() require("treesj").join() end,  desc = "Join block" },
}

return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = keys,
  opts = { use_default_keymaps = false },
}
