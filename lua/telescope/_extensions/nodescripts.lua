local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local entry_maker = function(entry)
  local name, cmd = string.match(entry, '"([^"]+)":%s?"([^"]+)"')
  return {
    value = entry,
    display = name,
    ordinal = name,
    name = name,
    cmd = cmd,
  }
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local attach_mappings = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local cmd = table.concat({ 'AsyncRun', '-mode=term', '-pos=right', '-listed=0', '-cols=60', 'npm run '..selection.name  }, ' ')
    vim.cmd(cmd)
  end)
  return true
end

local script_finder = finders.new_oneshot_job (
  {'jq', '.scripts', 'package.json'},
  { entry_maker = entry_maker }
)

local node_scripts = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Scripts",
    finder = script_finder,
    sorter = conf.generic_sorter(opts),
    attach_mappings = attach_mappings,
  }):find()
end

return require('telescope').register_extension {
  exports = {
    pick = node_scripts
  }
}
