-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- add your own keymapping
-- NOTE: nice references:
-- https://gitlab.com/lostneophyte/dotfiles/-/blob/main/lvim/.config/lvim/lua/user/bindings.lua
-- https://github.com/ChristianChiarulli/lvim/blob/master/lua/user/keymaps.lua
-- https://github.com/abzcoding/lvim/blob/main/lua/user/keybindings.lua

lvim.leader = "space"

-- folding
-- FIX: breaks <C-i>, see https://github.com/neovim/neovim/issues/5916
--  lvim.keys.normal_mode["<Tab>"] = "<cmd>normal za<cr>"
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>normal za<cr>"
lvim.keys.normal_mode["<C-Tab>"] = "<cmd>normal zi<cr>"

-- non-standard, but consistent with my obsidian setup
lvim.keys.normal_mode["zo"] = "<cmd>normal za<cr>"

-- C-backspace (i.e. C-H in alacritty) to delete word
lvim.keys.insert_mode["<C-H>"] = "<cmd>normal dB<cr>"
-- delete word forward because why not
lvim.keys.insert_mode["<C-L>"] = "<cmd>normal dW<cr>"

-- C-s to save in any mode
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.normal_mode["<A-w>"] = "<cmd>BufferKill<cr>"
lvim.keys.insert_mode["<A-w>"] = "<cmd>BufferKill<cr>"
lvim.keys.insert_mode["<C-W>"] = "<cmd>BufferKill<cr>"

lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.insert_mode["jj"] = "<Esc>"

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

-- NOTE: vscode config QoL changes
-- NOTE: no way to bind C-S-O differently from C-O in nvim/vim so I'm only doing these for insert mode, but check out this post for a method that uses terminal chars
-- https://old.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
lvim.keys.insert_mode["<C-E>"] = "<cmd>Telescope find_files<cr>"
lvim.keys.insert_mode["<C-O>"] = "<cmd>SymbolsOutline<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- TODO: navigate windows with C-num
-- lvim.keys.normal_mode["<C-1>"] = ""

-- FIX: comment using on <C-/>. Doesn't work
-- lvim.keys.normal_mode["<C-/>"] = "<Plug>(comment_toggle_linewise)"
-- lvim.keys.normal_mode["<C-/>"] = lvim.lsp.buffer_mappings.normal_mode['']
-- lvim.keys.visual_mode["<C-/>"] = lvim.keys.visual_mode["gc"]
