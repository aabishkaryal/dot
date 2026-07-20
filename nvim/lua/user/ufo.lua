local status_ok, ufo = pcall(require, 'ufo')
if not status_ok then
  print('nvim-ufo not found')
  return
end

ufo.setup {
  provider_selector = function(_, _, _)
    return { 'treesitter', 'indent' }
  end,
}
