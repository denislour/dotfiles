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
    opts = {
      linters_by_ft = {
        crystal = { "ameba" },
      },
    },
  },
}
