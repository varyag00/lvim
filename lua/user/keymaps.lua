-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- add your own keymapping
-- NOTE: nice references:
-- https://gitlab.com/lostneophyte/dotfiles/-/blob/main/lvim/.config/lvim/lua/user/bindings.lua
-- https://github.com/ChristianChiarulli/lvim/blob/master/lua/user/keymaps.lua
-- https://github.com/abzcoding/lvim/blob/main/lua/user/keybindings.lua

lvim.leader = "space"

-- folding
lvim.keys.normal_mode["<Tab>"] = "<cmd>normal za<cr>"
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>normal zi<cr>"

-- C-s to save in any mode
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.normal_mode["<A-w>"] = "<cmd>BufferKill<cr>"
lvim.keys.insert_mode["<A-w>"] = "<cmd>BufferKill<cr>"

lvim.keys.insert_mode = {
	["jk"] = "<Esc>",
	["jj"] = "<Esc>",
}

-- navigate between buffers with alt
lvim.keys.normal_mode["<A-h>"] = ":bprev<cr>"
lvim.keys.normal_mode["<A-l>"] = ":bnext<cr>"
lvim.keys.normal_mode["<A-1>"] = ":buffer 1<cr>"
lvim.keys.normal_mode["<A-2>"] = ":buffer 2<cr>"
lvim.keys.normal_mode["<A-3>"] = ":buffer 3<cr>"
lvim.keys.normal_mode["<A-4>"] = ":buffer 4<cr>"
lvim.keys.normal_mode["<A-5>"] = ":buffer 5<cr>"

-- unbind annoying line move on alt. Typically nil works, but in this case false seems to be needed
lvim.keys.normal_mode["<M-j>"] = false
lvim.keys.insert_mode["<M-j>"] = false
lvim.keys.normal_mode["<M-k>"] = false
lvim.keys.insert_mode["<M-k>"] = false

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- FIX: comment using on <C-/>. Doesn't work
-- lvim.keys.normal_mode["<C-/>"] = "<Plug>(comment_toggle_linewise)"
-- lvim.keys.normal_mode["<C-/>"] = lvim.lsp.buffer_mappings.normal_mode['']
-- lvim.keys.visual_mode["<C-/>"] = lvim.keys.visual_mode["gc"]
