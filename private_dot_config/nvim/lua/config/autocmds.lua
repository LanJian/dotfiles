local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Per-filetype colorcolumn
local cc_group = augroup("jackhxs_color_column_overrides", { clear = true })

local cc_overrides = {
  rust = "100",
  python = "88",
  terraform = "100",
  ruby = "100",
  java = "100",
}

for ft, cc in pairs(cc_overrides) do
  autocmd("FileType", {
    group = cc_group,
    pattern = ft,
    callback = function()
      vim.opt_local.colorcolumn = cc
    end,
  })
end

-- Text files: set textwidth
autocmd("FileType", {
  group = augroup("jackhxs_text_file", { clear = true }),
  pattern = "text",
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

-- Restore cursor to last known position
autocmd("BufReadPost", {
  group = augroup("jackhxs_restore_cursor", { clear = true }),
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Gopass: disable swap/backup/undo for security
autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("jackhxs_gopass", { clear = true }),
  pattern = "/dev/shm/gopass.*",
  callback = function()
    vim.opt_local.swapfile = false
    vim.opt_local.backup = false
    vim.opt_local.undofile = false
  end,
})

-- Dockerfile.* → set filetype
autocmd("BufEnter", {
  group = augroup("jackhxs_dockerfile", { clear = true }),
  pattern = "Dockerfile.*",
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

-- Remove trailing whitespaces
autocmd("BufWritePre", {
  group = augroup("jackhxs_trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- LSP configs
autocmd("LspAttach", {
  group = augroup("jackhxs_lsp_keymaps", { clear = true }),
  callback = function(ev)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("n", "gd", function() require("telescope.builtin").lsp_definitions() end, "Go to definition")
    map("n", "gy", function() require("telescope.builtin").lsp_type_definitions() end, "Go to type definition")
    map("n", "gi", function() require("telescope.builtin").lsp_implementations() end, "Go to implementation")
    map("n", "gr", function() require("telescope.builtin").lsp_references() end, "Go to references")
    map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover documentation")
    map("n", "<leader>rn", function() vim.lsp.buf.rename() end, "Rename symbol")
    map({ "n", "x" }, "<leader>f", function() vim.lsp.buf.format() end, "Format")
    map({ "n", "x" }, "<leader>a", function() vim.lsp.buf.code_action() end, "Code action")
    map("n", "<leader>ac", function() vim.lsp.buf.code_action() end, "Code action (buffer)")
    map("n", "<leader>cl", function() vim.lsp.codelens.run() end, "Code lens")
    map("n", "[g", function() vim.diagnostic.goto_prev() end, "Previous diagnostic")
    map("n", "]g", function() vim.diagnostic.goto_next() end, "Next diagnostic")
  end,
})

autocmd("LspAttach", {
  group = augroup("jackhxs_lsp_doc_highlight", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_clients({ bufnr = ev.buf })[1]
    if client and client:supports_method("textDocument/documentHighlight") then
      local hl_group = augroup("LspHighlight_" .. ev.buf, { clear = true })
      autocmd("CursorHold", {
        group = hl_group,
        buffer = ev.buf,
        callback = function() vim.lsp.buf.document_highlight() end,
      })
      autocmd("CursorMoved", {
        group = hl_group,
        buffer = ev.buf,
        callback = function() vim.lsp.buf.clear_references() end,
      })
    end
  end,
})
