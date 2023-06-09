local description = ""
local runes = 0

function get_description(blocks)
  for _, block in ipairs(blocks) do
    if block.t == 'Para' then
      description = pandoc.utils.stringify(block)
      break
    end
  end

  for _, block in ipairs(blocks) do
    if block.t == 'Para' then
      local s = pandoc.utils.stringify(block)
      s,_ = s:gsub("[0-9a-zA-Z-]+","a")
      s,_ = s:gsub("[ \t\r\n]+","")

      runes = runes + utf8.len(s)
    end
  end

  return nil
end

return {{
  Blocks = get_description,
  Meta = function (meta)
    meta.description = description
    meta.runes = string.format("%0.1f", runes/1000)
    meta.read_time = string.format("%0.1f", runes/400)
    local envs = pandoc.system.environment()
    for k,v in pairs(envs) do
      if meta[k] == nil then
        meta[k] = v
      end
    end
    return meta
  end,
  Image = function (img)
    img.attributes.loading = "lazy"
    return img
  end,
  Link = function (link)
    local t = link.target
    if t:sub(1,4) ~= "http" and t:sub(-3) == ".md" then
      link.target = t:sub(1,-3).."html"
    end
    if #link.content == 0 then
      link.content = pandoc.List:new({pandoc.Str(link.target)})
    end
    return link
  end,
}}
