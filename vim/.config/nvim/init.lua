vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and its plugins

require("lazy").setup("plugins", {
    rocks = { enabled = false },
    change_detection = {
        enabled = true,
        notify = false,
    },
})

require("core.options")
require("core.keymaps")
require("lsp")

-- Highlight configurations
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.cmd([[highlight Normal guibg=none]])
    end,
})
vim.cmd([[highlight Normal guibg=none]])

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = { "XcodebuildBuildFinished", "XcodebuildTestsFinished" },
    callback = function(event)
        if event.data.cancelled then
            return
        end

        if event.data.success then
            require("trouble").close()
        elseif not event.data.failedCount or event.data.failedCount > 0 then
            if next(vim.fn.getqflist()) then
                require("trouble").open("quickfix")
            else
                require("trouble").close()
            end

            require("trouble").refresh()
        end
    end,
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    command = "checktime",
})
