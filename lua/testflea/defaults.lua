local M = {}

M.defaults = {
  debug = false,
  tests_directory = "tests",
  src_directory = "src",
  test_prefix = "test_",
}

function M.apply(user_opts)
  return vim.tbl_deep_extend("force", {}, M.defaults, user_opts or {})
end

return M
