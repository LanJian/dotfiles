local function config()
  require("nightfox").setup({
    options = {
      styles = { comments = "italic" },
      modules = { gitsigns = true },
    },
    palettes = {
      nightfox = {
        bg0 = "#18222e",
        bg1 = "#131A24",
        bg2 = "#192330",
        bg3 = "#1e2938",
        bg4 = "#665673",
        fg3 = "#3b4261",
        comment = "#464e59",
      },
    },
    specs = {
      all = {
        git = { add = "#266d6a", changed = "#b366b2" },
      },
    },
  })

  vim.cmd("colorscheme nightfox")

  local hl = vim.api.nvim_set_hl
  hl(0, "IblIndent", { fg = "#15222e" })
  hl(0, "ColorColumn", { bg = "#1e2938" })
  hl(0, "FloatBorder", { fg = "#00adad", italic = true })
  hl(0, "LspInlayHint", { fg = "#4b364d", italic = true, bg = "NONE" })
  hl(0, "LspCodeLens", { fg = "#3d5166" })
  hl(0, "DiagnosticError", { fg = "#c94f6d" })
  hl(0, "DiagnosticWarn", { fg = "#f4a261" })
  hl(0, "DiagnosticHint", { fg = "#15aabf" })
  hl(0, "DiagnosticSignError", { fg = "#c94f6d", italic = true })
  hl(0, "DiagnosticSignWarn", { fg = "#f4a261", italic = true })
  hl(0, "DiagnosticSignHint", { fg = "#15aabf", italic = true })
  hl(0, "DiagnosticVirtualTextError", { fg = "#c94f6d", italic = true })
  hl(0, "DiagnosticVirtualTextWarn", { fg = "#f4a261", italic = true })
  hl(0, "DiagnosticVirtualTextHint", { fg = "#15aabf", italic = true })
end

return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  config = config,
}
