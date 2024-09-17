
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local sn = ls.snippet_node
local d = ls.dynamic_node
vim.keymap.set({ "i", "s"}, "<A-k>", function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<A-j>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

local get_file_name = function()
  return vim.fn.expand("%:t:r")
end

local extract_left = function(args)
  -- Simply return the argument passed (args[1][1]) without modifications
  return sn(nil, { t(args[1][1]) })
end
ls.add_snippets("typescriptreact", {
  s("fc", {
    t("import { FC } from 'react'"),
    t({ "", "type " }),
    -- Dynamic node to get the file name for the props
    d(1, function() return sn(nil, { t(get_file_name()) }) end),
    t({"Props = {", "\t"}),
    i(2, "name: string"), -- Insert node for further customization
    i(0),
    t({ "", "}" }),
    t({ "", "const " }),
    -- Function node to dynamically get the file name for the component
    f(function() return get_file_name() end),
    t(": FC<"),
    -- Function node to dynamically get the file name for the props
    f(function() return get_file_name() end),
    t("Props> = ({"),
    -- Dynamic node to extract the left side of a 'left:right' string
    f(extract_left, { 2 }),  -- Pass the second insert node (i(2)) as an argument
    t("}) => {"),
    t({"", "\treturn ("}),
    i(3, "<div></div>"),
    t({ ")", "", "}" })
  })
})
