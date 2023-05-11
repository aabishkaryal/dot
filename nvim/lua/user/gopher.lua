local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
	return
end

gopher.setup { commands = {} }
