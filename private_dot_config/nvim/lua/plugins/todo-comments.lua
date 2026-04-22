local keys = {
  { "<leader>td", "<cmd>TodoTelescope<cr>",                            desc = "Search TODOs" },
  { "]t",         function() require("todo-comments").jump_next() end, desc = "Next TODO" }, {
  "[t",
  function()
    require(
      "todo-comments").jump_prev()
  end,
  desc = "Previous TODO"
},
}
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  keys = keys,
  opts = {},
}
