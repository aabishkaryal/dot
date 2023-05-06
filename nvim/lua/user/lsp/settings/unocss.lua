local util = require("lspconfig.util")

return {
	root_dir = function(fname)
		return util.root_pattern("unocss.config.js", "unocss.config.ts",
			"uno.config.js", "uno.config.ts")(fname)
	end,
}
