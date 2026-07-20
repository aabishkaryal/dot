-- Open the live preview inside cmux instead of the default system browser.
-- Resolve cmux to an absolute path: GUI/embedded nvim may not inherit
-- /opt/homebrew/bin on $PATH, so a bare "cmux" in jobstart can fail silently.
local cmux = vim.fn.exepath("cmux")
if cmux == "" then
  cmux = "/opt/homebrew/bin/cmux"
end
vim.g.mkdp_cmux_bin = cmux

vim.cmd([[
  function! MkdpOpenInCmux(url)
    call jobstart([g:mkdp_cmux_bin, 'open', a:url])
  endfunction
]])

vim.g.mkdp_browserfunc = "MkdpOpenInCmux"
vim.g.mkdp_auto_close = 1
