local log = require("testflea.logs")

local M = {}

local function split(str, sep)
  local result = {}
  for part in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(result, part)
  end
  return result
end

function M.get_filename(path)
  local parts = split(path, '/')
  return parts[#parts]
end

function M.file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

function M.dir_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

function M.get_project_root()
  log.info("Trying to find project root")
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 and clients[1].config.root_dir then
    log.info(string.format("Found project root using LSP(%s). LSP clients count: %d", clients[1].name, #clients))
    return clients[1].config.root_dir
  end

  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" then
    log.info("Found project root using GIT")
    return git_root
  end

  log.info("Found project root using current working directory")
  return vim.fn.getcwd()
end

function M.mkdir_recursive(dir)
  if dir == "" then return end
  if vim.loop.fs_stat(dir) then return end

  local parent = dir:match("(.*/)[^/]+/?$")
  M.mkdir_recursive(parent)
  vim.loop.fs_mkdir(dir, 493) -- 493 = 0755 in decimal 
end

function M.ensure_file(path)
  local dir = path:match("(.*/)")
  if dir then M.mkdir_recursive(dir) end

  local fd = vim.loop.fs_open(path, "w", 420) -- 420 = 0o644
  if fd then vim.loop.fs_close(fd) end
end

return M
