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
    "AstroNvim/astrolsp",
    opts = {
      servers = {
        "ameba",
      },
      config = {
        ameba = {
          cmd = { "ameba-ls" },
          filetypes = { "crystal" },
          root_markers = { "shard.yml", ".ameba.yml", ".git" },
          settings = {},
        },
      },
    },
  },
}
