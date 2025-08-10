utf8 = require("utf8")
love.keyboard.setKeyRepeat(true)

LuvKit = {}
LuvKit._registry = setmetatable({}, { __mode = "v" })
LuvKit.modules = {}
LuvKit.modules.button = require('modules.button')
LuvKit.modules.droplist = require('modules.droplist')
LuvKit.modules.checkbox = require('modules.checkbox')
LuvKit.modules.sliders = require('modules.sliders')
LuvKit.modules.slider = require('modules.slider')
LuvKit.modules.dropdown =require('modules.dropdown')
LuvKit.modules.context_menu = require('modules.context_menu')
LuvKit.modules.textInput = require('modules.textInput')
LuvKit.modules.textbox = require('modules.textbox')
LuvKit.modules.label = require('modules.label')
LuvKit.modules.group = require('modules.group')
LuvKit.font = love.graphics.newFont('DejaVuSansMono-ASCII-Triangles.ttf')
LuvKit.defaultH = 18
LuvKit.defaultW = 18
LuvKit.gridU = LuvKit.defaultH/2
utf8 = require("utf8")
LuvKit.defaultOptions = {
	bgColor = {0.5, 0.5, 0.5},
	fgColor = {0, 0, 0},
	outlineColor = {0, 0, 0},
	hbgColor = {0.7, 0.7, 0.7},
	hfgColor = {0, 0, 0},
	houtlineColor = {1, 1, 1},
	clickColor = {.8, .8, .8},
	outline = true,
	radius = 0,
	sliderBackColor = {.3, .3, .3},
	cursorColor = {1, 0, 0},
	textboxBackColor = {.1, .1, .1},
	groupColor = {.4, .4, .4}
}

function LuvKit.u(n) return LuvKit.gridU*n end

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
		if v.active == false then
			love.graphics.setColor(0, 0, 0, .5)
			love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
			love.graphics.setColor(1, 0, 0, .5)
			love.graphics.line(v.x, v.y, v.x+v.w, v.y+v.h)
			love.graphics.line(v.x, v.y+v.h, v.x+v.w, v.y)
		end
	end
end

end

function LuvKit.mousepressed(x, y, b)
	table.sort(LuvKit._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)

	for k, v in ipairs(LuvKit._registry) do
		if v.active == true then
			if v.visible == true then
				local clicked = v:mousepressed(x, y, b)
				if clicked then break end
			end
		end
	end
end

function LuvKit.mousereleased(x, y, b)
	table.sort(LuvKit._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)

	for k, v in ipairs(LuvKit._registry) do
		if v.active == true then
			if v.visible == true then
				local released = v:mousereleased(x, y, b)
				if released then break end
			end
		end
	end
end

function LuvKit.mousemoved(x, y, dx, dy)
	table.sort(LuvKit._registry, function(a, b)
		return (a.zindex or 0) > (b.zindex or 0)
	end)

	for k, v in ipairs(LuvKit._registry) do
		if v.active == true then
			if v.visible == true then
				if v.mousemoved then
					local moved = v:mousemoved(x, y, dx, dy)
					if moved then break end
				end
			end
		end
	end
end

function LuvKit.keypressed(key)
    for _, v in ipairs(LuvKit._registry) do
    	if v.active then
    		if v.visible == true then
		        if v.keypressed then
		            v:keypressed(key)
		        end
		    end
	    end
    end
end

function LuvKit.textinput(text)
	for _, v in ipairs(LuvKit._registry) do
		if v.active then
			if v.visible == true then
		        if v.textinput then
		            v:textinput(text)
		        end
		    end
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