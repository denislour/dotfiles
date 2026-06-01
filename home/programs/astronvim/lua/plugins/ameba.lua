local severity_map = {
  Error = vim.diagnostic.severity.ERROR,
  Warning = vim.diagnostic.severity.WARN,
  Convention = vim.diagnostic.severity.HINT,
}

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
      local lint = require("lint")
      lint.linters.ameba = {
        cmd = "ameba",
        stdin = false,
        append_fname = true,
        args = { "--format", "json" },
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded.sources or not decoded.sources[1] then
            return diagnostics
          end
          for _, issue in ipairs(decoded.sources[1].issues) do
            table.insert(diagnostics, {
              source = "ameba",
              code = issue.rule_name,
              lnum = issue.location.line - 1,
              col = issue.location.column - 1,
              end_col = issue.end_location and type(issue.end_location.column) == "number" and issue.end_location.column or nil,
              end_lnum = issue.end_location and type(issue.end_location.line) == "number" and issue.end_location.line - 1 or nil,
              message = issue.message,
              severity = severity_map[issue.severity] or vim.diagnostic.severity.INFO,
            })
          end
          return diagnostics
        end,
      }
      lint.linters_by_ft.crystal = { "ameba" }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
