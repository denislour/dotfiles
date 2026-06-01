return {
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = {
        "ameba",
      },
      config = {
        ameba = {
          cmd = { "ameba-ls" },
          filetypes = { "crystal" },
          root_dir = require("lspconfig.util").root_pattern("shard.yml", ".git", ".ameba.yml"),
          settings = {},
        },
      },
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      features = {
        treesitter = {
          ensure_installed = { "crystal" },
        },
      },
    },
  },
}
