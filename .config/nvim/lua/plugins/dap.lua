return {
    "mfussenegger/nvim-dap",
    lazy = true,

    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            config = function()
                local dap = require("dap")
                local dapui = require("dapui")

                dapui.setup()

                dap.listeners.before.attach.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.launch.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated.dapui_config = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited.dapui_config = function()
                    dapui.close()
                end
            end,
        },
    },

    keys = {
        { "<F5>",  function() require("dap").continue() end },
        { "<F10>", function() require("dap").step_over() end },
        { "<F11>", function() require("dap").step_into() end },
        { "<F12>", function() require("dap").step_out() end },
        { "<leader>db", function() require("dap").toggle_breakpoint() end },
    },
    config = function()
        local dap = require("dap")

        dap.adapters.go = {
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}" },
            },
        }

        dap.configurations.go = {
            {
                type = "go",
                name = "Debug Go file",
                request = "launch",
                program = "${file}",
            },
        }

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.rust = {
            {
                name = "Launch Rust binary",
                type = "codelldb",
                request = "launch",
                program = function()
                  return vim.fn.input(
                      "Path to executable: ",
                      vim.fn.getcwd() .. "/target/debug/",
                      "file"
                  )
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
    end,
}
