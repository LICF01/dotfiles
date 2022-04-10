local g = vim.g
local o = vim.o -- For the globals options
local w = vim.wo -- For the window local options
local b = vim.bo -- For the buffer local options

--require 'utils'
require("pluginList")
require("plugins.lsp")
require("settings")
require("maps")
require("highlights")
