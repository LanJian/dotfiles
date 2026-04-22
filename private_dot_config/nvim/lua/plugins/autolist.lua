local opts = {
  cycle = { "-", "*", "1.", "a.", "I." }
}

local function config()
  require("autolist").setup(opts)

  local key_opts = { buffer = true }
  vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>", key_opts)
  vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>", key_opts)
  vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>", key_opts)
  vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", key_opts)
  vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", key_opts)
  vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", key_opts)
  vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", key_opts)
  vim.keymap.set("n", "<C-r>", "<C-r><cmd>AutolistRecalculate<cr>", key_opts)
  vim.keymap.set("n", "<leader>l", require("autolist").cycle_next_dr, { buffer = true, expr = true })
  vim.keymap.set("n", "<leader>L", require("autolist").cycle_prev_dr, { buffer = true, expr = true })
  vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>", key_opts)
  vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>", key_opts)
  vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>", key_opts)
  vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>", key_opts)
end

return {
  "gaoDean/autolist.nvim",
  ft = {
    "markdown",
    "text",
    "tex",
    "plaintex",
    "norg",
  },
  config = config,
}
