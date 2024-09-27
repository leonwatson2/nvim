vim.g.mapleader = " "

-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Leaves Insert Mode"})
vim.keymap.set("i", "jk", function()
	vim.cmd("stopinsert")
end, { desc = "Leave Insert Mode and Organize Imports with TSTools" })
vim.keymap.set("n", "<leader>ef", function()

  vim.cmd("w")

  vim.cmd("!npx eslint --fix %")

  vim.cmd("edit")
end, { desc = "Fix with ESLint and Reload", noremap = true, silent = true })

-- window navigations
vim.keymap.set("n", "wy", "<C-w>h", { noremap = true, silent = false, desc = "Move to left window" })
vim.keymap.set("n", "wj", "<C-w>j", { noremap = true, silent = true, desc = "Move to window below" })
vim.keymap.set("n", "wk", "<C-w>k", { noremap = true, silent = true, desc = "Move to window above" })
vim.keymap.set("n", "wl", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })
vim.keymap.set("n", "<Leader>tt", "<C-w>t", { noremap = true, silent = true, desc = "Move to top window" })
vim.keymap.set("n", "<Leader>pp", "<C-w>p", { noremap = true, silent = true, desc = "Switch to previous window" })
vim.keymap.set("n", "<Leader>ww", "<C-w>w", { noremap = true, silent = true, desc = "Switch to next window" })

-- Copy current line up (Alt-J) or down (Alt-K)
vim.keymap.set("n", "<A-K>", ":m-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
vim.keymap.set("n", "<A-J>", ":m+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-S-Down>", ":m+1<CR>==", { noremap = true, silent = true, desc = "Move line down with Shift" })
vim.keymap.set("n", "<A-S-Up>", ":m-2<CR>==", { noremap = true, silent = true, desc = "Move line up with Shift" })

-- terminal exit commands
vim.keymap.set("t", "<C-d>", [[<C-\><C-n>]], { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set("t", "<ESC>", [[<C-d>]], { noremap = true, desc = "Exit terminal" })

-- copy paste commands
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-e>", '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })

-- search
vim.keymap.set("n", "<Leader>/", ":noh<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })

-- saving
vim.keymap.set("n", "<C-Z>", ":w<CR>", { noremap = true, silent = false, desc = "Save file" })

-- info
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover info" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>kd", vim.lsp.buf.type_definition, { desc = "Show type definition" })

-- Editing
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>rw", "viw\"p", { noremap = true, silent = true, desc = "Replace word with default register" })

-- buffer navigations
vim.keymap.set("n", "w", "<nop>", { desc = "Disable default 'w' key action" })

-- source the init.lua file
vim.keymap.set("n", "<Leader>so", ":%so<CR>", { noremap = true, silent = true, desc = "Source init.lua" })

-- Emmet
vim.g.user_emmet_settings = {
	javascript = {
		extends = "jsx",
	},
	typescript = {
		extends = "tsx",
	},
}
-- lsp
vim.keymap.set("n", "<leader>ls", function()
	-- List of language servers to check and start
	local servers = {
		{ name = "tsserver", command = "LspStart tsserver" },
		{ name = "typescript-tools", command = "LspStart typescript-tools" },
		{ name = "tailwindcss", command = "LspStart tailwindcss" },
	}

	-- Get the currently active LSP clients
	local clients = vim.lsp.get_active_clients()
	local active_servers = {}

	-- Check which servers are active
	for _, client in ipairs(clients) do
		active_servers[client.name] = true
	end

	-- Start servers if they are not active
	for _, server in ipairs(servers) do
		if not active_servers[server.name] then
			vim.cmd(server.command)
			print(server.name .. " started")
		else
			print(server.name .. " is already running")
		end
	end
end, { noremap = true, silent = true, desc = "Start LSP servers if not running" })

-- Toggle Copilot
local function toggle_copilot()
	local copilot_status = vim.g.copilot_enabled or false
	if copilot_status then
		vim.g.copilot_enabled = false
		print("Copilot Disabled")
	else
		vim.g.copilot_enabled = true
		print("Copilot Enabled")
	end
end

-- Keybinding to toggle Copilot
vim.keymap.set("n", "<leader>cop", toggle_copilot, { noremap = true, silent = true, desc = "Toggle Copilot" })
