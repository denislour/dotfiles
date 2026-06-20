return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(server)
        return server ~= "elixirls"
      end, opts.ensure_installed)
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = {
        "elixirls",
      },
      config = {
        elixirls = {
          cmd = { "elixir-ls" },
        },
      },
    },
  },
}
