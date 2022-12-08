local status, whichKey = pcall(require, "which-key")
if not status then
	return
end

local config = {}

whichKey.setup(config)
