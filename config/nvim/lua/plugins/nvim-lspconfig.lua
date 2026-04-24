return {
  "neovim/nvim-lspconfig",
  lazy=false,
  config=function()
    -- Make lua_ls work with nvim configs
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })

      vim.lsp.config('ts_ls', {
        settings = {
          typescript = {
            preferences = {
              quoteStyle = "single"
            }
          },
          javascript = {
            preferences = {
              quoteStyle = "single"
            }
          }
        }
      })

      vim.lsp.config('angularls',{
        cmd = {
          "ngserver",
          "--stdio",
          "--tsProbeLocations",
          "/home/hyperview/.nvm/versions/node/v24.14.0/lib/node_modules/typescript/",
          "--ngProbeLocations",
          "/home/hyperview/.nvm/versions/node/v24.14.0/lib/node_modules/@angular/language-server/"
        },
        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
        root_markers = { "angular.json", "project.json" },
      })
    end
  }
