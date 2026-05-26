vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = { extends = "›", precedes = "‹" }
vim.keymap.set({ "n", "v" }, "<S-ScrollWheelUp>", "<ScrollWheelLeft>", { desc = "Scroll left" })
vim.keymap.set({ "n", "v" }, "<S-2-ScrollWheelUp>", "<2-ScrollWheelLeft>", { desc = "Scroll left x2" })
vim.keymap.set({ "n", "v" }, "<S-3-ScrollWheelUp>", "<3-ScrollWheelLeft>", { desc = "Scroll left x3" })
vim.keymap.set({ "n", "v" }, "<S-4-ScrollWheelUp>", "<4-ScrollWheelLeft>", { desc = "Scroll left x4" })
vim.keymap.set({ "n", "v" }, "<S-ScrollWheelDown>", "<ScrollWheelRight>", { desc = "Scroll right" })
vim.keymap.set({ "n", "v" }, "<S-2-ScrollWheelDown>", "<2-ScrollWheelRight>", { desc = "Scroll right x2" })
vim.keymap.set({ "n", "v" }, "<S-3-ScrollWheelDown>", "<3-ScrollWheelRight>", { desc = "Scroll right x3" })
vim.keymap.set({ "n", "v" }, "<S-4-ScrollWheelDown>", "<4-ScrollWheelRight>", { desc = "Scroll right x4" })

local group = vim.api.nvim_create_augroup("XTSHIFTESCAPE", { clear = true })
io.write("\x1b[>1s")
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  pattern = "*",
  callback = function() io.write("\x1b[>0s") end,
})
