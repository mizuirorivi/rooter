local M = {}

---@param str string|nil
---@return boolean
function M.str_is_empty(str) return str == nil or str == "" end

-- Key mapping function
---@param mod string | string[]
---@param lhs string | string[]
---@param rhs string | function
---@param opts table?
function M.key_map(mod, lhs, rhs, opts)
  if type(lhs) == "string" then
    vim.keymap.set(mod, lhs, rhs, opts)
  elseif type(lhs) == "table" then
    for _, key in pairs(lhs) do
      vim.keymap.set(mod, key, rhs, opts)
    end
  end
end

return M
