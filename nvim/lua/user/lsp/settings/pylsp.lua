return {
	-- Run pylsp through `uv run`, so it always resolves the *current
	-- project's* venv/deps (matches nearest pyproject.toml/uv.lock in the
	-- root dir) instead of whatever "python" happens to be on $PATH, and
	-- pylsp itself doesn't need to be pip-installed into every project venv.
	cmd = { "uv", "run", "--with", "python-lsp-server[all]", "pylsp" },
	settings = {
		pylsp = {
			plugins = {
				-- linting/formatting is handled by the ruff LSP instead
				flake8 = { enabled = false },
				pycodestyle = { enabled = false },
				pylint = { enabled = false },
				pyflakes = { enabled = false },
				jedi_completion = { fuzzy = true },
			}
		}
	}
}
