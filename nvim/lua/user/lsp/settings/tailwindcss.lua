local util = require("lspconfig.util")

return {
	root_dir = function(fname)
		return util.root_pattern("tailwind.config.js", "tailwind.config.ts",
			"postcss.config.js", "postcss.config.ts")(
			fname)
	end,
}
