function BlockQuote(el)
  if #el.content >= 1 and el.content[1].t == "Para" then
    local full_text = pandoc.utils.stringify(el.content[1])
    local ctype, ctitle = string.match(full_text, "^%[%!([a-zA-Z]+)%]%s*(.*)")
    
    if ctype then
      ctype = string.lower(ctype)
      
      -- We will remove the first paragraph entirely, assuming it contains ONLY the [!type] Title
      local div_content = {}
      for i = 2, #el.content do
        table.insert(div_content, el.content[i])
      end
      
      -- Create the Div
      local div = pandoc.Div(div_content, pandoc.Attr("", {"callout", "callout-" .. ctype}))
      if ctitle and ctitle ~= "" then
        div.attributes["title"] = ctitle
      end
      
      return div
    end
  end
end
