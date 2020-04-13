function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

return {
  {
    Str = function (elem)
			linktext = string.match(elem.text, "%[%[(.+)%]%]") 
			if linktext then
				linktext = split(linktext, "|")
				newlink = linktext[1] .. ".html"
				linkname = linktext[1]
				if table.getn(linktext) < 2 then
					linkname = linktext[2]
				end
				return pandoc.Link(linkname, newlink)
			elseif string.match(elem.text, ":.+:") then
				tag = string.sub(elem.text, 2, -2)
				return pandoc.Emph(tag)
      else
        return elem
      end
    end
  }
}
