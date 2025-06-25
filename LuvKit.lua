libuton = {}
libuton._registry = setmetatable({}, { __mode = "v" })
libuton.modules = {}
libuton.modules.button = require('libuton.modules.button')
libuton.font = love.graphics.newFont()


function libuton.create(element, ...)
	local temp = libuton.modules[element].new(...)
	table.insert(libuton._registry, temp)
	return temp
end

function libuton.update(dt)
	table.sort(libuton._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)
	local hovered_found = false
	for _, v in ipairs(libuton._registry) do
		local is_hovering = false
		if not hovered_found and v.update then
			is_hovering = v:update(dt)
			if is_hovering then
				hovered_found = true
			end
		end
		if not is_hovering then
			v.hover = false
		end
	end
end

function libuton.draw()
	function libuton.draw()
	table.sort(libuton._registry, function(a, b)
		return (a.zindex or 0) < (b.zindex or 0)
	end)

	for k, v in ipairs(libuton._registry) do
		v:draw()
	end
end

end

function libuton.mousepressed(x, y, b)
	table.sort(libuton._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)

	for k, v in ipairs(libuton._registry) do
		local clicked = v:mousepressed(x, y, b)
		if clicked then break end
	end
end

function libuton.mousereleased(x, y, b)
	table.sort(libuton._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)

	for k, v in ipairs(libuton._registry) do
		local released = v:mousereleased(x, y, b)
		if released then break end
	end
end

function libuton.destroy(element)
	for i = #libuton._registry, 1, -1 do
		if libuton._registry[i] == element then
			table.remove(libuton._registry, i)
			for k in pairs(element) do
				element[k] = nil
			end
			setmetatable(element, nil)
			break
		end
	end
end

function libuton.collision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end