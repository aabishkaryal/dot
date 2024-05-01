local status_ok, ibl = pcall(require, 'ibl')
if not status_ok then
	return
end

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}
ibl.setup {
	indent = {
		char = '|'
	},
	scope = {
		highlight = highlight
	}
}
