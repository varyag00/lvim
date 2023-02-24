-- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>

lvim.autocommands = {
	-- use bash treesitter settings for zsh
	{
		"FileType",
		{
			pattern = "zsh",
			callback = function()
				-- let treesitter use bash highlight for zsh files as well
				require("nvim-treesitter.highlight").attach(0, "bash")
			end,
		},
	},
	-- line wrap on json files
	{
		"BufEnter", -- see `:h autocmd-events`
		{ -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
			pattern = { "*.json", "*.jsonc" }, -- see `:h autocmd-events`
			command = "setlocal wrap",
		},
	},
	{
		"TextYankPost",
		{
			group = "_general_settings",
			pattern = "*",
			desc = "Highlight text on yank",
			callback = function()
				require("vim.highlight").on_yank({ higroup = "Search", timeout = 40 })
			end,
		},
	},
	-- NOTE: doesn't work, and probably not needed
	-- {
	-- 	{ "BufReadPost", "FileReadPost" },
	-- 	{
	-- 		pattern = "*",
	-- 		command = "normal zR",
	-- 	},
	-- },
	-- {
	-- 	"VimEnter", -- TODO: there's gotta be a better autocmd. This requires using :e to enter file
	-- 	{
	-- 		command = "lua require('persistence').load({last = true})",
	-- 		desc = "Restore last session, if it exists",
	-- 	},
	-- },
}
