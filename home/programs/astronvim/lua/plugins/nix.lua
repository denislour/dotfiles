return {
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = {
        "nixd",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        nix = { "statix", "deadnix" },
      },
    },
  },
}
