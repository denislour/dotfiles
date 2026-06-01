return {
  {
    "vim-crystal/vim-crystal",
    ft = { "crystal" },
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      formatting = {
        format_on_save = {
          enabled = true,
          ignore_filetypes = { "crystal" },
        },
      },
      servers = {
        "liger",
      },
      config = {
        liger = {
          cmd = { "liger" },
          filetypes = { "crystal" },
          root_markers = { "shard.yml", ".git" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft.crystal = { "ameba" }
      lint.linters.ameba.cmd = "ameba"
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
