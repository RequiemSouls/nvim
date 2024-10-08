vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local ks = vim.keymap.set
ks('n', "<leader>d", vim.cmd.Ex, {desc = "open dir"})
