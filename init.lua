vim.wo.number=true
vim.wo.relativenumber = true


local function is_plugin_installed(name)
	--gets Neovim data directory: `~/.local/share/nvim`
	--`..` is concatenation, similar to + in javascript
	local plugin_path = vim.fn.stdpath("data") .. "/plugged/" .. name
	return vim.fn.isdirectory(plugin_path) == 1
end

local plug_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"
if vim.fn.filereadable(plug_path) == 0 then
	print("vim-plug not found Installling...")
	vim.fn.system({
		"curl", "-fLo", plug_path, "--create-dirs",
		"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"		
		
	})
	print("vim-plug installed")

	vim.cmd("PlugInstall --sync")
	local home_dir = vim.fn.expand("~")
	local restart_script = home_dir .. "/restart_nvim.sh"
	vim.fn.system(restart_script)


vim.cmd [[
	call plug#begin('~/.local/share/nvim/plugged')
	Plug 'preservim/nerdtree'
	call plug#end()
	]]

		vim.cmd("PlugInstall --sync")
		vim.cmd("qa!")
		local home_dir = vim.fn.expand("~")
		local restart_script = home_dir .. "/restart_nvim.sh"
		vim.fn.system(restart_script)

else
	if not is_plugin_installed("nerdtree") then 

vim.cmd [[
	call plug#begin('~/.local/share/nvim/plugged')
	Plug 'preservim/nerdtree'
	call plug#end()
	]]
		vim.cmd("PlugInstall --sync")
		vim.cmd("qa!")
		local home_dir = vim.fn.expand("~")
		local restart_script = home_dir .. "/restart_nvim.sh"
		vim.fn.system(restart_script)
		print(restart_script)
	end
end

local function parse_and_install()
    local config = vim.fn.stdpath('config')
    local plugin_file = config .. '/plugincfg'

    local file = io.open(plugin_file, "r")
    if not file then
        print("[Error]: Couldn't locate file `/plugincfg`, creating it...")
        file = io.open(plugin_file, "w")
        file:write("[command/toinstall]\n[preservim/nerdtree]\n[junegunn/fzf.vim]\n")
        file:close()
        print("plugincfg created with default plugins")
    else
        file:close()
    end

    file = io.open(plugin_file, "r")
    local plugins_list = file:read("*all")
    file:close()

    local plugins = {}
    for plugin in plugins_list:gmatch("%[([^%]]+)%]") do
        table.insert(plugins, plugin)
    end

    local install_command = table.remove(plugins, 1)

    if install_command and install_command ~= "command/toinstall" then
        vim.cmd(install_command)
    else
        print("Warn: No valid install command in plugincfg.")
    end

    local plugin_to_install = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"
    if vim.fn.filereadable(plugin_to_install) == 0 then
        print("vim-plug not found! Installing...")
        vim.fn.system({
            "curl", "-fLo", plugin_to_install, "--create-dirs",
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        })
        print("vim-plug installed! Restart Neovim and rerun the script.")
        return
    end

    vim.cmd("call plug#begin('~/.local/share/nvim/plugged')")

    for _, plugin in ipairs(plugins) do
        vim.cmd("Plug '" .. plugin .. "'")
        print("Installing " .. plugin)
    end

    vim.cmd("call plug#end()")

    vim.cmd("silent! PlugInstall --sync | q!")

    for _, plugin in ipairs(plugins) do
        local plugin_path = vim.fn.stdpath("data") .. "/plugged/" .. plugin:match(".*/(.*)")
        local plugin_installed = vim.fn.isdirectory(plugin_path) == 1
        if not plugin_installed then
            print("[!] " .. plugin .. " not found!")
        end
    end
end

-- UI Configurations
vim.opt.termguicolors = true
vim.cmd.colorscheme("moonfly")
vim.opt.guifont = "Font Space Mono:h14"
vim.wo.cursorline = true

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>f", ":lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":lua require('fzf-lua').git_files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '(', '()<Esc>i', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '{', '{}<Esc>i', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '[', '[]<Esc>i', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '"', '""<Esc>i', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', "'", "''<Esc>i", { noremap = true, silent = true})
--Delete (for Debug)
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.defer_fn(function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
        end, 1) 
    end
})

parse_and_install()
