vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.keymap.set({ "n", "v" }, "<S-ScrollWheelUp>", "zh", { desc = "Scroll left" })
vim.keymap.set({ "n", "v" }, "<S-ScrollWheelDown>", "zl", { desc = "Scroll right" })
