local M = {}

function M.in_git_project(project_name)
  local result = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")
  if vim.v.shell_error ~= 0 or #result == 0 then return false end
  return vim.fn.fnamemodify(result[1], ":t") == project_name
end

return M
