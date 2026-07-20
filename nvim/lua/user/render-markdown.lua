local status_ok, render_markdown = pcall(require, 'render-markdown')
if not status_ok then
  print('render-markdown not found')
  return
end

render_markdown.setup {
  enabled = false, -- start plain; toggle with <leader>tm
}
