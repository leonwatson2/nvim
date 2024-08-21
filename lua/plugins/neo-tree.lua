return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		window = {
			mappings = {

				["none"] = "open_with_window_picker",
				["z"] = "expand_all_nodes",
				["l"] = "toggle_node",
			},
		},
		filesystem = {
			filtered_items = {
				visible = true,
				show_hidden_count = true, -- hidden files can be toggled with shift+h
				hide_dotfiles = false,
				hide_gitignored = false,
				never_show = {},
			},
		},
	},
	config = function()
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>", {})
	end,
}
