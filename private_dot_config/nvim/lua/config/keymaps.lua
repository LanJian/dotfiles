local map = vim.keymap.set

-- Navigation
map("n", "<C-h>", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "<C-l>", "<cmd>bn<cr>", { desc = "Next buffer" })
map("", "<C-K>", "<C-W>k", { desc = "Window up" })
map("", "<C-J>", "<C-W>j", { desc = "Window down" })

-- Semicolon as colon
map("n", ";", ":", { desc = "Command mode" })

-- Disable arrow keys
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Increment / decrement
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })

-- Toggle invisible characters
map("n", "<leader>i", "<cmd>set list!<cr>", { desc = "Toggle listchars" })

-- Insert date
map("n", "<F5>", '"=strftime("%Y-%m-%d")<CR>P', { desc = "Insert date" })
map("i", "<F5>", '<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "Insert date" })

-- Formatting
map("", "Q", "gq", { desc = "Format with gq" })
map("n", "<leader>=", "gg=G<C-o>", { desc = "Re-indent file" })

-- Custom commands
vim.api.nvim_create_user_command("DiffOrig", function()
  vim.cmd("vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis")
end, { desc = "Diff buffer against saved file" })

vim.api.nvim_create_user_command("Bufferonly", function()
  vim.cmd("%bd|e#|bd#")
end, { desc = "Close all buffers except current" })
