local popup = require 'plenary.popup'

local Win_id

function MyMenu()
  local file = io.open('C:/Dev/projects', 'r')
  local options = {}
  if file then
    for line in file:lines() do
      table.insert(options, line)
    end
  end
  local callback = function(_, sel)
    vim.cmd('cd ' .. sel)
  end
  ShowMenu(options, callback)
end

function ShowMenu(options, callback)
  local height = 20
  local width = 30
  local borderchars = { '-', '|', '-', '|', '╭', '╮', '╯', '╰' }

  Win_id = popup.create(options, {
    title = 'MyProjects',
    highlight = 'MyProjectWindow',
    line = math.floor(((vim.o.lines - height) / 2) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
    callback = callback,
  })
  local bufnr = vim.api.nvim_win_get_buf(Win_id)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc>', '<cmd>lua CloseMenu()<CR>', { silent = false })
  vim.api.nvim_create_autocmd('BufLeave', {
    callback = function()
      -- TODO: this doesnt work. Just breaks the popup
      CloseMenu()
    end,
  })
end

function CloseMenu()
  vim.api.nvim_win_close(Win_id, true)
  Win_id = nil
end
