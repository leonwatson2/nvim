local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local DEFAULT_PEEF_TIME = 3000
local function open_floating_terminal(opts)
  local width = vim.o.columns
  local height = vim.o.lines
  local peek = opts.peek or false
  local padding = 2
  local windowOpts = {
    relative = "editor",
    border = "rounded"
  }

  if opts.size == "large" then
    windowOpts.width = math.floor(width * 0.75)
    windowOpts.height = math.floor(height * 0.75)
    windowOpts.row = math.floor((height - windowOpts.height) / 2)
    windowOpts.col = math.floor((width - windowOpts.width) / 2)
  elseif opts.size == "bottom" then
    windowOpts.width = width - 2 * padding
    windowOpts.height = math.floor(height * 0.20)
    windowOpts.row = height - windowOpts.height - padding
    windowOpts.col = padding
  elseif opts.size == "left" then
    windowOpts.width = math.floor(width * 0.30)
    windowOpts.height = height - 2 * padding
    windowOpts.row = padding
    windowOpts.col = padding
  elseif opts.size == "right" then
    windowOpts.width = math.floor(width * 0.40)
    windowOpts.height = height - 2 * padding
    windowOpts.row = padding
    windowOpts.col = width - windowOpts.width - padding
  else
    vim.notify("Invalid size option", vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  end
  local win = vim.api.nvim_open_win(buf, not peek, windowOpts)

  if peek then
    vim.api.nvim_win_set_option(win, "winblend", 60)
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_hide(win)
      end
    end, opts.peektime)
  else
    vim.api.nvim_win_set_option(win, "winblend", 0)
  end

  if vim.bo[buf].buftype ~= "terminal" then
    vim.fn.termopen(vim.o.shell)
  end
  return { win = win, buf = buf }
end
_G.FloatingTerminal = open_floating_terminal

local function run_terminal_command(cmd)
  if state.floating.buf and vim.api.nvim_buf_is_valid(state.floating.buf) then
    local jobid = vim.b[state.floating.buf].terminal_job_id
    if jobid then
      vim.fn.chansend(jobid, cmd .. "\n")
    else
      print("No Valid terminal to send command.")
    end
  else
    print("No valid buffer.")
  end
end

local function toggle_floating_term(opts)
  if state.floating.win ~= nil and vim.api.nvim_win_is_valid(state.floating.win) then
    if vim.fn.mode() == "t" then
      vim.cmd("stopinsert")
    end
    vim.api.nvim_win_hide(state.floating.win)
    state.floating.win = nil
  else
    if opts.peek then
      print("Peeking for " .. vim.v.count .. " seconds")
    end
    state.floating = open_floating_terminal({ size = opts.size, buf = state.floating.buf, peek = opts.peek or false, peektime =
    vim.v.count > 0 and vim.v.count * 1000 or DEFAULT_PEEF_TIME })
  end
end

-- KEYBINDS
-- Terminal Commands
vim.keymap.set("n", "<leader>tc", function() run_terminal_command("\x03") end,
  { desc = "Stop thing in terminal" })
vim.keymap.set("n", "<leader>tdev", function() run_terminal_command("npm run dev") end,
  { desc = "Run dev command in terminal" })

vim.keymap.set("n", "<leader>tstart", function() run_terminal_command("npm run start") end,
  { desc = "Run start command in terminal" })
vim.keymap.set("n", "<leader>tinstall", function() run_terminal_command("npm i") end,
  { desc = "Run npm i command in terminal" })

-- Opening Floating Terminals
vim.keymap.set("n", "<leader>tL", function() toggle_floating_term({ size = "large" }) end,
  { desc = "Open Large Floating Terminal" })
vim.keymap.set("n", "<leader>tb", function() toggle_floating_term({ size = "bottom" }) end,
  { desc = "Open Bottom Floating Terminal" })
vim.keymap.set("n", "<leader>tl", function() toggle_floating_term({ size = "left" }) end,
  { desc = "Open Left Floating Terminal" })
vim.keymap.set("n", "<leader>tr", function() toggle_floating_term({ size = "right" }) end,
  { desc = "Open Right Floating Terminal" })

vim.keymap.set("t", "<ESC>", function() toggle_floating_term({ size = "left" }) end,
  { desc = "Open Left Floating Terminal" })
-- Peeking Floating Terminals
vim.keymap.set("n", "<leader>tpL", function() toggle_floating_term({ size = "large", peek = true }) end,
  { desc = "Open Large Floating Terminal" })
vim.keymap.set("n", "<leader>tpb", function() toggle_floating_term({ size = "bottom", peek = true }) end,
  { desc = "Open Bottom Floating Terminal" })
vim.keymap.set("n", "<leader>tpl", function() toggle_floating_term({ size = "left", peek = true }) end,
  { desc = "Open Left Floating Terminal" })
vim.keymap.set("n", "<leader>tpr", function() toggle_floating_term({ size = "right", peek = true }) end,
  { desc = "Open Right Floating Terminal" })

return {
  toggle_floating_term = toggle_floating_term,
  run_terminal_command = run_terminal_command,
}
