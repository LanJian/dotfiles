local keys = {
  { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash jump" },
  { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash treesitter" },
}

local opts = {
  label = {
    rainbow = {
      enabled = true,
      shade = 5,
    }
  }
}

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = keys,
  opts = opts,
}
