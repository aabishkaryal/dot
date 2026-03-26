return {
	settings = {
		pylsp = {
			plugins = {
				flake8 = { enabled = true, maxLineLength = 120 },
				jedi_completion = { fuzzy = true },
				pylint = { enabled = false },
				pycodestyle = { maxLineLength = 120 }
			}
		}
	}
}
