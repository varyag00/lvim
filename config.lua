-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
-- vim.opt.colorcolumn = "88"
vim.opt.colorcolumn = "99999"
vim.opt.shell = "/usr/bin/zsh"
vim.opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- FIX: these are not respected, perhaps due to foldexpr func
vim.opt.foldlevelstart = 99

-- general
lvim.log.level = "warn"
-- NOTE: <SPC-b-W> to prevent formatting
lvim.format_on_save = {
	enabled = true,
	-- pattern = "*.lua",
	timeout = 1000,
}

-- NOTE: To change theme settings, try :colorscheme <tab> or SPC-s-p

-- lvim.colorscheme = "catppuccin-latte" -- light
-- lvim.colorscheme = "catppuccin-frappe" -- medium
lvim.colorscheme = "catppuccin-macchiato" -- dark
-- lvim.colorscheme = "catppuccin-mocha" -- darkest
-- lvim.colorscheme = "tokyonight"
-- TODO: unused flag, see https://github.com/abzcoding/lvim#theme
lvim.builtin.time_based_themes = false

-- lvim.builtin.lualine.style = "lua"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- TODO: move to LSP mod
lvim.builtin.dap.active = true -- (default: false)

-- NOTE: dashboard options
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- FIX: broken as of 03/15/2023
-- added dashboard options
-- table.insert {
--   -- icons: https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/icons.lua
--   -- lvim.builtin.alpha.dashboard.section.buttons.val,
--   list = lvim.builtin.alpha.dashboard.section.button,
--   -- NOTE: how to make this two letters (i.e. "Sl"; the obvious doesn't work)
--   value = { "l", lvim.icons.ui.History .. "  Restore Last Session", "<cmd>lua require('persistence').load()<cr>" }
-- }

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- NOTE: Feature flags
----------------------

lvim.builtin.legendary = { active = true }
lvim.builtin.dressing = { active = true }
lvim.builtin.cheat = { active = true }
-- experimental UI replacement; not really interested atm
lvim.builtin.noice = { active = false }
lvim.builtin.task_runner = "async_tasks"
lvim.builtin.test_runner = { active = true, runner = "neotest" }

lvim.builtin.treesitter.ignore_install = { "haskell" }

-- TEST: try
-- reload("user.autocommands")
require("user.autocommands").config()

reload("user.keymaps")
reload("user.which_key")
require("user.plugins").config()
-- reload("user.autocommands")

-- NOTE: plugin-specific options

if lvim.builtin.legendary.active then
	-- lvim.builtin.which_key.mappings["C"] =
	-- 	{ "<cmd>lua require('legendary').find('commands')<cr>", " Command Palette" }
	lvim.keys.normal_mode["<C-P>"] = "<cmd>lua require('legendary').find('commands')<cr>"
	lvim.keys.normal_mode["<A-x>"] = "<cmd>lua require('legendary').find()<cr>"
end
-- NOTE: do I even use this? If not, delete
if lvim.builtin.cheat.active then
	lvim.builtin.which_key.mappings["?"] = { "<cmd>Cheat<CR>", " Cheat.sh" }
end

if lvim.builtin.task_runner == "async_tasks" then
	lvim.builtin.which_key.mappings["m"] = {
		name = " Make",
		f = { "<cmd>AsyncTask file-build<cr>", "File" },
		p = { "<cmd>AsyncTask project-build<cr>", "Project" },
		e = { "<cmd>AsyncTaskEdit<cr>", "Edit" },
		l = { "<cmd>AsyncTaskList<cr>", "List" },
	}
	lvim.builtin.which_key.mappings["r"] = {
		name = " Run",
		f = { "<cmd>AsyncTask file-run<cr>", "File" },
		p = { "<cmd>AsyncTask project-run<cr>", "Project" },
	}
	-- -- note sure if this if worth enabling since I have no configuration for it
	-- else
	--     lvim.builtin.which_key.mappings["m"] = "Make"
	--     lvim.builtin.which_key.mappings["r"] = "Run"
	--     require("user.autocommands").make_run()
end

if lvim.builtin.test_runner.active then
	if lvim.builtin.test_runner.runner == "neotest" then
		lvim.builtin.which_key.mappings["t"] = {
			name = "ﭧ Test",
			f = {
				"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), env=require('user.ntest').get_env()})<cr>",
				"File",
			},
			o = { "<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>", "Output" },
			r = { "<cmd>lua require('neotest').run.run({env=require('user.ntest').get_env()})<cr>", "Run" },
			a = { "<cmd>lua require('user.ntest').run_all()<cr>", "Run All" },
			c = { "<cmd>lua require('user.ntest').cancel()<cr>", "Cancel" },
			R = { "<cmd>lua require('user.ntest').run_file_sync()<cr>", "Run Async" },
			s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
			n = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", "jump to next failed" },
			p = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", "jump to previous failed" },
			d = { "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", "Dap Run" },
			x = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
			w = { "<cmd>lua require('neotest').watch.watch()<cr>", "Watch" },
		}
	end
end

-- TODO: create lsp module(s)

-- TODO: debug adapter falls under LSP mod

-- NOTE: START go DAP
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
	return
end

dapgo.setup()
-- NOTE: END go DAP

-- NOTE: START go LSP

-- TODO: uncomment this line
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
	on_attach = function(client, bufnr)
		require("lvim.lsp").common_on_attach(client, bufnr)
		local _, _ = pcall(vim.lsp.codelens.refresh)
		local map = function(mode, lhs, rhs, desc)
			if desc then
				desc = desc
			end

			vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
		end
		map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
		map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
		map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
		map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
		map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
		map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
		map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
		map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
		map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
	end,
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
	settings = {
		gopls = {
			usePlaceholders = true,
			gofumpt = true,
			codelenses = {
				generate = false,
				gc_details = true,
				test = true,
				tidy = true,
			},
		},
	},
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
	return
end

gopher.setup({
	commands = {
		go = "go",
		gomodifytags = "gomodifytags",
		gotests = "gotests",
		impl = "impl",
		iferr = "iferr",
	},
})

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
lvim.lsp.diagnostics.virtual_text = false
-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "bashls", "shellcheck" })
-- -- check the lspconfig documentation for a list of all possible options
-- local opts = {
-- 	filetypes = { "sh", "zsh", "bash" },
-- }
-- -- NOTE: make zsh use same LS as bash and sh
-- require("lvim.lsp.manager").setup("bashls", opts)
-- require("lvim.lsp.manager").setup("shellcheck", opts)

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
})

vim.filetype.add({
	extension = {
		zsh = "zsh",
	},
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "bashls" })

-- local lsp_manager = require("lvim.lsp.manager") -- NOTE: already defined above; uncomment when refactored to file
lsp_manager.setup("bashls", {
	-- NOTE: make zsh use same LS as bash and sh
	filetypes = { "sh", "zsh", "bash" },
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
})

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{ command = "black", filetypes = { "python" } },
	{ command = "goimports", filetypes = { "go" } },
	{ command = "gofumpt", filetypes = { "go" } },
	{ command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
	{
		command = "prettier",
		-- extra_args = { "--print-width", "100" },
		-- filetypes = { "typescript", "typescriptreact" },
		filetypes = { "markdown", "md" },
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
		filetypes = { "sh", "zsh", "bash" },
	},
	{
		command = "codespell",
		filetypes = { "javascript", "python", "go" },
	},
})

-- NOTE: END GO LSP SETUP

reload("user.telescope")

-- NOTE:
-- frecency (and its dep sqlite), if installed incorrectly, breaks legendary if installed
