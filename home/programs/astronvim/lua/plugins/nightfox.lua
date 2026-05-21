return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("carbonfox")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
      vim.api.nvim_set_hl(0, "NeogitStatusHeader", { bg = "none" })
      vim.api.nvim_set_hl(0, "NeogitStatusTitle", { bg = "none" })
      vim.api.nvim_set_hl(0, "NeogitDiffHeader", { bg = "none" })
    end,
  },
}
