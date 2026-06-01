return {
  {
    "IrenejMarc/vim-mint",
    ft = { "mint" },
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = {
        "mint",
      },
      config = {
        mint = {
          cmd = { "mint", "tool", "ls" },
          filetypes = { "mint" },
          root_markers = { "mint.json", ".git" },
        },
      },
      formatting = {
        format_on_save = {
          enabled = true,
          ignore_filetypes = { "mint" },
        },
      },
    },
  },
}
