return {
  {
    "AstroNvim/astrocore",
    opts = {
      filetypes = { extension = { cr = "crystal" } },
    },
  },
  {
    "vim-crystal/vim-crystal",
    ft = { "crystal" },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft.crystal = { "ameba" }
    end,
  },
}
