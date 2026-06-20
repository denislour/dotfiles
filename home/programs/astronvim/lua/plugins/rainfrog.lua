return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<leader>yr"] = { "<Cmd>terminal rainfrog<CR>", desc = "Open rainfrog (PostgreSQL TUI)" },
        },
      },
    },
  },
}
