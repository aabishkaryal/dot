return {
	-- Run via `uv run` (ephemeral tool, not tied to any project venv) so it
	-- doesn't need to be separately installed/kept up to date on $PATH.
	cmd = { "uv", "run", "--with", "ruff", "ruff", "server" },
	init_options = {
		settings = {
			configurationPreference = "filesystemFirst"
		}
	}
}
