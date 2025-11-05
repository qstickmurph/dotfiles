return {
  "mfussenegger/nvim-dap",
  recommended = true,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },
  config = function ()
    local dap = require('dap')

    dap.adapters.coreclr = {
      type = 'executable',
      command = '/home/hyperview/.local/share/nvim/mason/bin/netcoredbg',
      args = {'--interpreter=vscode'}
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "test launch",
        request = "launch",
        program = "/home/hyperview/projects/manager/19047-api/tests/LayoutTest/bin/Debug/net9.0/Hyperview.Manager.LayoutTest.dll",
      },
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd(), 'file')
        end,
      },
      {
        type = "coreclr",
        name = "debug test (direct)",
        request = "launch",
        program = function()
          dll = vim.fn.input('Path to test dll: ', vim.fn.getcwd(), 'file')
        end,
        args = function()
          local test_name = vim.fn.input('Test name/filter (empty for all): ')
          if test_name ~= '' then
            return {'--filter', test_name}
          end
          return {}
        end,
      }
    }

    local dapui = require("dapui")
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
}
