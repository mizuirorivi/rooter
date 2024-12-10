local M = {}
---@class RooterConfig
---@field rooter_pattern table<string>
---@field isautosave boolean
---@field savefile string
---@field addrootmapping string | string[]

---@type RooterConfig
local config = {
  rooter_pattern = {'.git/','Makefile','_darcs','.bzr','.svn','node_modules','CMakeLists.txt'},
  isautosave = true,
  savefile = '~/.rooter'
}
--- get the full user config or just a specified value
---@param key string?
---@return any
function M.get(key)
  if key then return config[key] end
  return config
end
---@param user_conf RooterConfig
---@return RooterConfig
function M.set(user_conf)
  user_conf = user_conf or {}
  config = vim.tbl_deepextend("force",config,user_conf)
  return config
end
---@return RooterConfig
return setmetatable(M,{
  __index = function(_,k) return config[k] end,
})
