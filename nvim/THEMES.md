# Theme decision

Compared catppuccin-mocha, tokyonight-*, kanagawa, rose-pine, gruvbox-material,
everforest, nightfox/terafox, plus Vim built-ins (koehler, slate, industry,
zaibatsu, retrobox) for Zig/Go work.

Findings:
- Modern "soft" themes (catppuccin, rose-pine, terafox) under-distinguish syntax
  — e.g. in Zig, `pub`/`fn`/`main`/`void` all rendered the same color.
- Older Vim built-ins (koehler, slate, industry, zaibatsu, retrobox) distinguish
  syntax well but have broken/unstyled UI chrome (tabline, sidebar separators)
  since they predate modern plugin ecosystems, and have no coordinated
  kitty/tmux ports.

## Winner: tokyonight-night

Good syntax distinction + near-complete UI chrome, and has first-class,
actively maintained kitty + tmux ports from the same author, so all three tools
(kitty, tmux, neovim) can share one coordinated palette.

**Tab bar fix:** the only issue was the active tab background using a raw,
saturated accent color. Root cause was a stale custom `highlights` override in
`lua/user/bufferline.lua` (from old LunarVim boilerplate) hardwiring the active
tab to `TabLineSel` and a legacy LSP highlight group. Removed the override so
bufferline derives its highlights natively from tokyonight, which pulls the
active-tab background from `Normal` instead.
