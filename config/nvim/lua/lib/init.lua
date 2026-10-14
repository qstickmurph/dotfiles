local M = {}

function M.in_git_project(project_name, buf_name)
  local buf_path = vim.api.nvim_buf_get_name(buf_name)
  local buf_dir = vim.fs.dirname(buf_path)

  local result = vim.trim(vim.system({ "git", "-C", buf_dir, "rev-parse", "--show-toplevel" }, { text = true }):wait().stdout)
  if vim.v.shell_error ~= 0 or #result == 0 then return false end
  return result == project_name
end

return M
