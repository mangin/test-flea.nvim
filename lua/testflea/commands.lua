local log = require("testflea.logs")
local fs = require("testflea.fs")
local M = {}
log.info("Test frong is inited")

-- Main function
function M.jump_to_test_file(opts)
  local tests_directory = opts.tests_directory
  local src_directory = opts.src_directory
  local test_prefix = opts.test_prefix
  -- 1. Get current file path
  -- example /root/project/src/main.py
  local current_file = vim.fn.expand("%:p")
  log.info(string.format("Current file: %s", current_file))

  -- 2. Find project root
  -- example /root/project/src/main.py
  local root = fs.get_project_root()
  log.info(string.format("Project root: %s", root))

  -- 3. Find relative path of the file in the project
  -- file /root/project/src/main.py
  -- root /root/project
  -- example main.py
  -- we need to move on len(root) + slash + the first_symbol after
  local relative_path_to_src_file_from_project = string.sub(current_file, #root + 2)
  log.info(string.format("Relative path to src file from project: %s", relative_path_to_src_file_from_project))
  local src_file_name = fs.get_filename(current_file)
  log.info(string.format("Src file name: %s", src_file_name))
  local relative_path_to_directory_of_src_file_from_project = string.sub(
    relative_path_to_src_file_from_project,
    0,
    string.len(relative_path_to_src_file_from_project) - (string.len(src_file_name) + 1)
  )
  log.info(string.format("Relative path to directory of src file from project: %s", relative_path_to_directory_of_src_file_from_project))
  local relative_path_to_directory_of_src_file_from_src_directory = string.sub(
    relative_path_to_directory_of_src_file_from_project,
    string.len(src_directory) + 2
  )
  log.info(string.format("Relative path to directory of src file from src directory: %s", relative_path_to_directory_of_src_file_from_src_directory))
  local relative_path_to_directory_of_test_from_tests_directory = relative_path_to_directory_of_src_file_from_src_directory
  log.info(string.format("Relative path to directory of test from  tests directory: %s", relative_path_to_directory_of_test_from_tests_directory))

  local relative_path_to_directory_of_test_from_project = tests_directory .. '/' .. relative_path_to_directory_of_test_from_tests_directory
  log.info(string.format("Relative path to directory of test from  project: %s", relative_path_to_directory_of_test_from_project))

  local test_file_name = test_prefix .. src_file_name
  log.info(string.format("Test file name: %s", test_file_name))
  local relative_path_to_test_file_from_project = relative_path_to_directory_of_test_from_project .. '/' .. test_file_name
  log.info(string.format("Relative path to test file from project: %s", relative_path_to_src_file_from_project))
  local path_to_test_file = root .. '/' .. relative_path_to_test_file_from_project
  log.info(string.format("Path to test file: %s", path_to_test_file))

  log.info(string.format("New path: %s", path_to_test_file))

  if not fs.file_exists(path_to_test_file) then
    local answer = vim.fn.input(string.format("File %s test does not exist. Create it? (y/n): ", relative_path_to_test_file_from_project))
    vim.cmd("echo ''")
    if answer:lower() == "y" then
      log.info(string.format("Create file path: %s", path_to_test_file))
      fs.ensure_file(path_to_test_file)
    else
      log.info(string.format("Stop"))
      return
    end
  end


  -- 4. Open it
  vim.cmd("edit " .. vim.fn.fnameescape(path_to_test_file))
end

return M
