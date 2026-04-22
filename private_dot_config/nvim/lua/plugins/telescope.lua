local keys = {
  { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Find files" },
  { "<leader>b", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
  { "<leader>rg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
  { "<space>o", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Document symbols" },
  { "<space>s", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Workspace symbols" },
  { "<space>a", function() require("telescope.builtin").diagnostics() end, desc = "Diagnostics" },
}

local function config()
  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      border = true,
      layout_strategy = "horizontal",
      mappings = {
        i = {
          ["<Esc>"] = actions.close,
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
    },
  })
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
end

return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = keys,
  config = config,
}
