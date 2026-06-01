return {
  {
    "AstroNvim/astrocore",
    opts = {
      filetypes = { extension = { cr = "crystal" } },
    },
  },
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
}
