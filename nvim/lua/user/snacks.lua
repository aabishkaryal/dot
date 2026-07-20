require("snacks").setup({
  explorer = { enabled = true },
  picker = { enabled = true }, -- explorer depends on picker
  bigfile = { enabled = true },
  scratch = { enabled = true },
  -- Everything else left off: telescope covers picking, indent-blankline covers
  -- indent guides, vim-illuminate covers word highlighting, vim-bbye covers
  -- buffer deletion. Enable more snacks modules here later if wanted.
})
