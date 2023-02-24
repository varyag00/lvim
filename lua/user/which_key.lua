-- -- Use which-key to add extra bindings with the leader-key prefix
-- TODO: consider adding window management keybindings
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }

lvim.builtin.which_key.mappings["<Tab>"] = { "za", "Toggle fold" }
lvim.builtin.which_key.mappings["<S-Tab>"] = { "zi", "Toggle all folds" }

lvim.builtin.which_key.mappings["i"] = {
	name = "+Codi",
	a = { "<cmd>let g:codi#virtual_text = 0 | Codi<cr>", "Activate" },
	d = { "<cmd>Codi! | let g:codi#virtual_text = 0 <cr>", "Deactivate" },
	-- immediately disable inline codi
	i = { "<cmd>Codi!<cr> | <cmd>CodiSelect<cr>", "New Interpreter" },
}
-- NOTE: lazygit seems like a solid CLI tool; nice when magit is unavailable
lvim.builtin.which_key.mappings["g"]["G"] = lvim.builtin.which_key.mappings["g"]["g"]
lvim.builtin.which_key.mappings["g"]["g"] = { ":Neogit<cr>", "Magit status" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["T"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

-- buffer management
-- already set
-- lvim.builtin.which_key.mappings["bn"] = {
--   ":bnext<cr>", "next"
-- }
-- TODO: test if these are even needed
lvim.builtin.which_key.mappings["bp"] = {
	":bprev<cr>",
	"Previous",
}
lvim.builtin.which_key.mappings["bk"] = {
	":bd<cr>",
	"Kill",
}
lvim.builtin.which_key.mappings["bd"] = {
	":bd<cr>",
	"Kill",
}
-- persistent sessions
lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- ranger
lvim.builtin.which_key.mappings["R"] = { "<cmd>RnvimrToggle<CR>", "Open Ranger" }

lvim.builtin.which_key.mappings["M"] = { "<cmd>messages<CR>", "View messages" }

-- TODO: move to lsp options
lvim.builtin.which_key.mappings["l"]["o"] = { "<cmd>SymbolsOutline<CR>", "Symbols outline" }

-- themes
-- FIX: these get overwritten on buffer save (config reload)
lvim.builtin.which_key["L"]["L"] = { "<cmd>Catppuccin latte<CR>", "Light theme" }
lvim.builtin.which_key["L"]["D"] = { "<cmd>Catppuccin frappe<CR>", "Dark theme" }
