local log = require("testflea.logs")
local defaults = require("testflea.defaults")
local commands = require("testflea.commands")
local M = {}

-- Main function
function M.setup(user_opts)
    local opts = defaults.apply(user_opts)
    log.setup(opts)

    log.info("Setup")
    log.dump(opts, 'OPTS:')

    local function jump_to_test_file()
      commands.jump_to_test_file(opts)
    end

    vim.keymap.set("n", "<leader>ft", jump_to_test_file, { noremap = true, silent = true })
    vim.api.nvim_create_user_command("JumpTestFile", jump_to_test_file, {})
end

return M
