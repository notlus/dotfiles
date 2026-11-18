-- <C-h/j/k/l> moves between Neovim splits, and at a split edge crosses into the
-- surrounding pane: the herdr CLI (HERDR_PANE_ID), the Herdr app (HC_TERMINAL_ID),
-- or tmux (TMUX).
local tmux_commands = { left = "Left", down = "Down", up = "Up", right = "Right" }

local function is_set(name)
	return vim.env[name] ~= nil and vim.env[name] ~= ""
end

local function cross(dir)
	if is_set("HERDR_PANE_ID") then
		local herdr = is_set("HERDR_BIN_PATH") and vim.env.HERDR_BIN_PATH or "herdr"
		vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
	elseif is_set("HC_TERMINAL_ID") then
		vim.fn.jobstart({ "herdr-app", "do", "pane.go", "--direction", dir })
	elseif is_set("TMUX") then
		pcall(vim.cmd, "TmuxNavigate" .. tmux_commands[dir])
	end
end

local function navigate(wincmd, dir)
	local previous = vim.api.nvim_get_current_win()
	vim.cmd("wincmd " .. wincmd)
	if vim.api.nvim_get_current_win() == previous then
		cross(dir)
	end
end

return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
	config = function()
		local maps = { { "<C-h>", "h", "left" }, { "<C-j>", "j", "down" }, { "<C-k>", "k", "up" }, { "<C-l>", "l", "right" } }
		for _, m in ipairs(maps) do
			vim.keymap.set("n", m[1], function()
				navigate(m[2], m[3])
			end, { silent = true, noremap = true, desc = "Navigate " .. m[3] .. " (vim/herdr)" })
		end
	end,
}
