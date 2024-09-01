require 'custom.plugins.dashboard_list'
math.randomseed(os.time())

local dash_count = #Dashboards
local dash = Dashboards[1]
if dash_count > 1 then
  local random_index = math.random(1, dash_count)
  dash = Dashboards[random_index]
end
local config = {
  theme = 'doom',
  config = {
    header = dash, --your header
    center = {
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Find File           ',
        desc_hl = 'String',
        keymap = 'SPC f f',
        key = 'f',
        key_hl = 'Number',
        key_format = ' %s', -- remove default surrounding `[]`
        action = "lua require('telescope.builtin').find_files()",
      },
      {
        icon = ' ',
        desc = 'Grep',
        keymap = 'SPC f g',
        key = 'g',
        key_format = ' %s', -- remove default surrounding `[]`
        action = "lua require('telescope.builtin').live_grep()",
      },
      {
        icon = ' ',
        desc = 'File Explorer',
        keymap = 'SPC p v',
        key = 'e',
        key_format = ' %s', -- remove default surrounding `[]`
        action = 'lua vim.cmd.Neotree()',
      },
      {
        icon = ' ',
        desc = "Help, i'm stuck",
        keymap = ':q',
        key = 'q',
        key_format = ' %s', -- remove default surrounding `[]`
        action = 'q',
      },
    },
    footer = {}, --your footer
  },
}

return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup(config)
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
