return {
    "williamboman/mason.nvim",
    dependencies = {
       "mason-org/mason-lspconfig.nvim",
       "rshkarin/mason-nvim-lint",
       "jay-babu/mason-nvim-dap.nvim",
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          lazy = true,
          ensure_installed = {
            'lua-language-server',
            'vim-language-server',
            'stylua',
            'shellcheck',
            'editorconfig-checker',

            -- Bash
            'bash-language-server',
            'bash-debug-adapter',

            -- Docker
            'docker-compose-language-service',
            'docker-language-server',

            -- Yaml
            'yaml-language-server',
            'yamllint',

            -- Javascript/Typescript
            'typescript-language-server',
            'angular-language-server',
            'eslint_d',
            'prettierd',

            -- HTML/CSS
            'stylelint',

            -- C#
            'roslyn',
            'rzls',
            'sonarlint-language-server',

            -- Java

            -- C/C++
            'clangd',
            'clang-format',

            -- Python

            -- Go

            -- Rust
          },
          auto_update = false,
          run_on_start = true
        },
      },
    },
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry", --roslyn and rzls
      },
    },
}
