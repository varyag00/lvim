local M = {}
local function default_commands() end

M.config = function()
	local status_ok, legend = pcall(require, "legendary")
	if not status_ok then
		return
	end

	legend.setup({
		select_prompt = function(kind)
			if kind == "legendary.items" then
				return " Legendary "
			end

			-- NOTE: Added this condition because sometimes kind is nil :shrug:
			if kind == nil or kind == "" then
				return " Legendary "
			end

			if kind ~= nil and kind ~= "" then
				-- Convert kind to Title Case (e.g. legendary.keymaps => Legendary Keymaps)
				return " " .. string.gsub(" " .. kind:gsub("%.", " "), "%W%l", string.upper):sub(2) .. " "
			end
		end,
		commands = {
			{ ":Telescope live_grep", description = "Find Text ( live grep )" },
		},

		sort = { frecency = false },
		-- NOTE: disable frecency sorting until it is fixed
	})
end

return M
