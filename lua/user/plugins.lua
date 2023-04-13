-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>

-- NOTE: using config function instead of reload("user.plugins") to allow for more complex configuration (without projects)
local M = {}
M.config = function()
	lvim.plugins = {
		{
			"folke/trouble.nvim",
			cmd = "TroubleToggle",
		},

		-- neat, but I prefer hop (i.e. sneak)
		-- {
		--   "ggandor/lightspeed.nvim",
		--   event = "BufRead",
		-- },
		--

		{
			"phaazon/hop.nvim",
			event = "BufRead",
			config = function()
				require("hop").setup()
				vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
				vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
			end,
		},

		-- magit
		{
			"TimUntersberger/neogit",
			config = function()
				require("neogit").setup({ use_magit_keybindings = true })
			end,
		},

		-- themes
		{
			"catppuccin/nvim",
			name = "catppuccin",
			-- NOTE: can be used for time-based themes
			config = function()
				require("catppuccin").setup({
					flavour = "latte",
					-- term_colors = true,
				})
			end,
		},
		{ "Rigellute/shades-of-purple.vim" },

		-- tree-like view for symbols
		{
			"simrat39/symbols-outline.nvim",
			config = function()
				require("symbols-outline").setup()
			end,
		},

		-- highlight TODO comments, adds:
		-- TODO: foo
		-- HACK: bar
		-- NOTE: bas
		-- FIX: do
		-- WARNING: re
		-- PERF: mi
		{
			"folke/todo-comments.nvim",
			event = "BufRead",
			config = function()
				require("todo-comments").setup({
					highlight = {
						multiline = false,
						-- lua pattern to match the next multiline from the start of the matched keyword
						-- TODO: start multiline line with something like :- or ---
						--- multiline_pattern = ":-",
					},
				})
			end,
		},

		-- highlight colours in the given formats
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = true, -- CSS hsl() and hsla() functions
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				})
			end,
		},

		-- persistent sessions
		{
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			-- module = "persistence", // TODO broken?
			lazy = true,
			config = function()
				require("persistence").setup({
					dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
					options = { "buffers", "curdir", "tabpages", "winsize" },
				})
			end,
		},

		-- function signature on typing
		{
			"ray-x/lsp_signature.nvim",
			event = "BufRead",
			config = function()
				require("lsp_signature").on_attach()
			end,
		},

		-- TabNine completions
		-- {
		-- 	"tzachar/cmp-tabnine",
		-- 	build = "./install.sh",
		-- 	dependencies = "hrsh7th/nvim-cmp",
		-- 	event = "InsertEnter",
		-- },

		{
			"romgrk/nvim-treesitter-context",
			config = function()
				require("treesitter-context").setup({
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					throttle = true, -- Throttles plugin updates (may improve performance)
					max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
					patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
						-- For all filetypes
						-- Note that setting an entry here replaces all other patterns for this entry.
						-- By setting the 'default' entry below, you can control which nodes you want to
						-- appear in the context window.
						default = {
							"class",
							"function",
							"method",
						},
					},
				})
			end,
		},

		-- ranger integration
		-- great guide: https://linuxconfig.org/introduction-to-ranger-file-manager
		{
			"kevinhwang91/rnvimr",
			cmd = "RnvimrToggle",
			config = function()
				vim.g.rnvimr_draw_border = 1
				vim.g.rnvimr_pick_enable = 1
				vim.g.rnvimr_bw_enable = 1
			end,
		},
		-- {
		-- 	"kkharji/sqlite.lua",
		-- 	-- lazy = true,
		-- },
		-- {
		-- 	"nvim-telescope/telescope-frecency.nvim", -- TODO: fix, read docs
		-- 	-- config = function()
		-- 	-- 	require("kkharji/sqlite.lua")
		-- 	-- end,
		-- },

		{
			"metakirby5/codi.vim",
			cmd = "Codi",
		},

		-- vscode-like commmand palette
		{
			"mrjones2014/legendary.nvim",
			config = function()
				require("user.legendary").config()
			end,
			enabled = lvim.builtin.legendary.active,
		},

		{
			"stevearc/dressing.nvim",
			lazy = true,
			config = function()
				require("user.dress").config()
			end,
			enabled = lvim.builtin.dressing.active,
			event = "BufWinEnter",
		},

		-- TODO: do I even use this?
		{
			"RishabhRD/nvim-cheat.sh",
			dependencies = "RishabhRD/popfix",
			config = function()
				vim.g.cheat_default_window_layout = "vertical_split"
			end,
			lazy = true,
			cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
			keys = "<leader>?",
			enabled = lvim.builtin.cheat.active,
		},

		{
			"kevinhwang91/nvim-bqf",
			event = { "BufRead", "BufNew" },
			config = function()
				require("bqf").setup({
					auto_enable = true,
					preview = {
						win_height = 12,
						win_vheight = 12,
						delay_syntax = 80,
						border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
					},
					func_map = {
						vsplit = "",
						ptogglemode = "z,",
						stoggleup = "",
					},
					filter = {
						fzf = {
							action_for = { ["ctrl-s"] = "split" },
							extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
						},
					},
				})
			end,
		},

		{
			"rmagatti/goto-preview",
			config = function()
				require("goto-preview").setup({
					width = 120, -- Width of the floating window
					height = 25, -- Height of the floating window
					default_mappings = false, -- Bind default mappings
					debug = false, -- Print debug information
					opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
					post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
					-- You can use "default_mappings = true" setup option
					-- Or explicitly set keybindings
					-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
					-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
					-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
				})
			end,
		},

		-- wakatime.com to see dev stats
		{
			"wakatime/vim-wakatime",
		},

		-- tasks for nvim
		{
			"skywind3000/asynctasks.vim",
			dependencies = {
				{ "skywind3000/asyncrun.vim" },
			},
			init = function()
				vim.cmd([[
          let g:asyncrun_open = 8
          let g:asynctask_template = '~/.config/lvim/task_template.ini'
          let g:asynctasks_extra_config = ['~/.config/lvim/tasks.ini']
        ]])
			end,
			event = { "BufRead", "BufNew" },
			enabled = lvim.builtin.task_runner == "async_tasks",
		},

		-- testing
		-- { "nvim-neotest/neotest-plenary" },
		-- { "nvim-neotest/neotest-go", event = { "BufEnter *.go" } },
		-- { "nvim-neotest/neotest-python", event = { "BufEnter *.py" } },
		-- -- { "rouge8/neotest-rust", event = { "BufEnter *.rs" } },
		-- {
		-- 	"nvim-neotest/neotest",
		-- 	dependencies = {
		-- 		{ "nvim-neotest/neotest-plenary" },
		-- 	},
		-- 	config = function()
		-- 		require("user.ntest").config()
		-- 	end,
		-- 	event = { "BufReadPost", "BufNew" },
		-- 	enabled = (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "neotest"),
		-- },

		-- go dap adapter
		{ "leoluz/nvim-dap-go" },

		-- gopher - go development tools
		{ "olexsmir/gopher.nvim" },

		{
			"petertriho/nvim-scrollbar",
			-- event = "BufEnter",
			config = function()
				require("scrollbar").setup({
					handlers = {
						gitsigns = true, -- Requires gitsigns
						excluded_filetypes = {
							"prompt",
							"TelescopePrompt",
							"noice",
							"NvimTree",
							"neo-tree",
						},
					},
				})
			end,
		},

		{

			"Exafunction/codeium.vim",
			config = function()
				vim.keymap.set("i", "<M-l>", function()
					return vim.fn["codeium#Accept"]()
				end, { expr = true })
				vim.keymap.set("i", "<M-i>", function()
					return vim.fn["codeium#CycleCompletions"](1)
				end, { expr = true })
				vim.keymap.set("i", "<M-o>", function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end, { expr = true })
				vim.keymap.set("i", "<M-h>", function()
					return vim.fn["codeium#Clear"]()
				end, { expr = true })
			end,
		},
	}
end

return M
