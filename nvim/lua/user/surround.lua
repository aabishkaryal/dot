local status_ok, surround = pcall(require, 'nvim-surround')
if not status_ok then
    return
end

surround.setup({})

-- The 'nvim-surround' plugin enhances text manipulation in Neovim.
-- It simplifies common operations of adding, deleting, and changing surrounding characters or text.
-- Examples:
--
-- 1. Surround a word with parentheses:
--    To change "surround_words" to "(surround_words)", use 'ysiwp)'.
--
-- 2. Add double quotes around a string:
--    To transform "*make strings" to "\"make strings\"", use 'ys$"'. 
--
-- 3. Delete surrounding square brackets:
--    To remove "[delete around me!]" and keep "delete around me!", use 'ds]'.
--
-- 4. Change HTML tags to their content:
--    To convert "<b>HTML tags</b>" to "HTML tags", use 'dst'.
--
-- 5. Change single quotes to double quotes:
--    To modify "'change quotes'" to "\"change quotes\"", use 'cs"''.
--
-- 6. Replace HTML tags with new tags:
--    To switch "<b>or tag types</b>" to "<h1>or tag types</h1>", use 'csth1<CR>'.
--
-- 7. Delete surrounding parentheses:
--    To remove "delete(function calls)" and get "function calls", use 'dsf'.
--
-- For comprehensive usage details, consult ':h nvim-surround.usage' in Neovim.
