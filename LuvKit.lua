LuvKit = {}
LuvKit._registry = setmetatable({}, { __mode = "v" })
LuvKit.modules = {}
LuvKit.modules.button = require('modules.button')
LuvKit.modules.checkBox = require('modules.checkBox')
LuvKit.modules.sliders = require('modules.sliders')
LuvKit.modules.dropdown =require('modules.dropdown')
LuvKit.modules.context_menu = require('modules.context_menu')
LuvKit.modules.textInput = require('modules.textInput')
LuvKit.font = love.graphics.newFont()


function LuvKit.create(element, ...)
	local temp = LuvKit.modules[element].new(...)
	table.insert(LuvKit._registry, temp)
	return temp
end

function LuvKit.update(dt)
	table.sort(LuvKit._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)
	local hovered_found = false
	for _, v in ipairs(LuvKit._registry) do
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

function LuvKit.draw()
	function LuvKit.draw()
	table.sort(LuvKit._registry, function(a, b)
		return (a.zindex or 0) < (b.zindex or 0)
	end)

	for k, v in ipairs(LuvKit._registry) do
		v:draw()
	end
end

end

function LuvKit.mousepressed(x, y, b)
	table.sort(LuvKit._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)

	for k, v in ipairs(LuvKit._registry) do
		local clicked = v:mousepressed(x, y, b)
		if clicked then break end
	end
end

function LuvKit.mousereleased(x, y, b)
	table.sort(LuvKit._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)

	for k, v in ipairs(LuvKit._registry) do
		local released = v:mousereleased(x, y, b)
		if released then break end
	end
end

function LuvKit.keypressed(key)
    for _, v in ipairs(LuvKit._registry) do
        if v.keypressed then
            v:keypressed(key)
        end
    end
end

function LuvKit.destroy(element)
	for i = #LuvKit._registry, 1, -1 do
		if LuvKit._registry[i] == element then
			table.remove(LuvKit._registry, i)
			for k in pairs(element) do
				element[k] = nil
			end
			setmetatable(element, nil)
			break
		end
	end
end

function LuvKit.collision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function LuvKit.clamp(low, n, high) return math.min(math.max(low, n), high) end