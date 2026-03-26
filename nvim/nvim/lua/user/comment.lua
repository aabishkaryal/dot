local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  print('comment cant be loaded')
  return
end

comment.setup {}
