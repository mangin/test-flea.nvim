local M = {}

M.debug = false

local logfile = vim.fn.stdpath("cache") .. "/testfile.log"

function M.setup(opts)
  M.debug = opts and opts.debug or false
end

function M.info(msg)
  if not M.debug then
    return
  end

  local f = io.open(logfile, "a")
  if f then
    f:write("[INFO] " .. msg .. "\n")
    f:close()
  end
end

function M.dump(obj, label)
  if not M.debug then
    return
  end

  M.info((label or "dump") .. ": " .. vim.inspect(obj))
end

return M
