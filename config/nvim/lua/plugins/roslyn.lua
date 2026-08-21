return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "csproj", "sln", "slnx" },
  opts = {
    filewatching = "off", -- was "auto"; roslyn.nvim README recommends "roslyn" or "off" for large solutions
  },
  config = function(_, opts)
    vim.lsp.config("roslyn", {
      settings = {
        ["csharp|background_analysis"] = {
          dotnet_analyzer_diagnostics_scope = "openFiles",
          dotnet_compiler_diagnostics_scope = "openFiles",
        },
        ["csharp|completion"] = {
          dotnet_show_completion_items_from_unimported_namespaces = true,
          dotnet_show_name_completion_suggestions = true,
        },
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
        },
        ["csharp|formatting"] = {
          dotnet_organize_imports_on_format = true,
        },
      },
      on_attach = function(_, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
    })
    require("roslyn").setup(opts)
  end,
}
