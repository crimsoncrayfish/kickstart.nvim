local dash = {
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[          ▀████▀▄▄              ▄█ ]],
  [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
  [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
  [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
  [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
  [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
  [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
  [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
  [[   █   █  █      ▄▄           ▄▀   ]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
}
function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

if isModuleAvailable 'custom.plugins.dashboard_list' then
  require 'custom.plugins.dashboard_list'
  math.randomseed(os.time())

  local dash_count = #Dashboards

  if dash_count > 1 then
    local random_index = math.random(1, dash_count)
    dash = Dashboards[random_index]
  end
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
        icon = '🔍',
        desc = 'Grep',
        keymap = 'SPC f g',
        key = 'g',
        key_format = ' %s', -- remove default surrounding `[]`
        action = "lua require('telescope.builtin').live_grep()",
      },
      {
        icon = '📁',
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
      {
        icon = ' ',
        desc = 'Terminal',
        keymap = 'SPV t t',
        key = 't',
        key_format = ' %s', -- remove default surrounding `[]`
        action = 'ToggleTerm size=15 direction=horizontal name=dashboard',
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
