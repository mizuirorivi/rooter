local Log = require("usermod.mynotify").new("ROOTER", vim.log.levels.INFO)
local bst = require("lib.bst")

---@module usermod.rooter.config
local config = require("usermod.rooter.config")
---@module usermod.rooter.utils
local utils = require("usermod.rooter.utils")

local M = {}

M.rootmap = {}
M.rooter_pattern = {'.git/','Makefile','_darcs','.bzr','.svn','node_modules','CMakeLists.txt','.root'}
M.isautosave = true
M.savefile = '~/.rooter'

---@return table
function M:new()
  rooter = rooter or {}
  self.__index = self
  return setmetatable(rooter,self)
end
---@return string
function M:FindClosedRoot()
  local root = vim.fn.expand('%:p:h')
  Log:onlysave(root)

  while root ~= '' do
    Log:onlysave(root)
    for _, pattern in ipairs(self.rooter_pattern) do
      if pattern:sub(-1) == '/' then
        if vim.fn.isdirectory(root .. '/' .. pattern) == 1 then
          return root
        end
      end
      if vim.fn.findfile(pattern, root .. '/') ~= '' then
        return root
      end
    end
    if root == '/' then 
      break
    end
    
    root = vim.fn.fnamemodify(root, ':h')
  end
  return ''
end
---@param path string
function addRoot(opts)
  if opts.path == nil then
    return
  end
  local entry = {
    path = opts.path,
  }
  if self.rootmap then
    table.insert(M.rootmap, entry)
  end
end
local function setup_global_mappings()
  local mapping = config.addrootmapping
  if mapping then
    if mapping then
      utils.key_map('n',mapping,"")
    
    end 
  end
end
local function setup_commands()
  local command = api.nvim_create_user_command
  command('AddRoot',addRoot,{path = self.FindClosedRoot})
end
function M.setup(user_prefs)
  if user_perefs == nil then
    Log:onlysave("[!] No user preferences found")
  end
  local conf = config.set(user_prefs)
  setup_commands()
end
return M

