button = {}
button.__index = button

function button.new(x, y, w, h, txt)
	local self = setmetatable({}, button)
	self.x = x
	self.y = y
	self.w = math.max(w, libuton.font:getWidth(txt)+5)
	self.h = math.max(h, libuton.font:getHeight())
	self.txt = txt or ''
	self.color = {.5, .5, .5}
	self.zindex = #libuton._registry
	self.options = {
		bgColor = {0.5, 0.5, 0.5},
		fgColor = {0, 0, 0},
		outlineColor = {0, 0, 0},
		hbgColor = {0.7, 0.7, 0.7},
		hfgColor = {0, 0, 0},
		houtlineColor = {1, 1, 1},
		clickColor = {.8, .8, .8},
		outline = true,
		radius = 4,
	}
	self.callback = nil
	return self
end

function button:update(dt)
	if libuton.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hover = true
	else
		self.hover = false
	end
	return self.hover
end

function button:draw()
	if self.hover then
		if self.options.outline then
			love.graphics.setLineWidth(2)
			love.graphics.setColor(self.options.houtlineColor)
			love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
		end
		love.graphics.setLineWidth(1)
		love.graphics.setColor(self.options.hbgColor)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
		love.graphics.setColor(self.options.hbgColor)
		love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
		if love.mouse.isDown(1) then
			love.graphics.setColor(self.options.clickColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
		end
		love.graphics.setColor(self.options.hfgColor)
		love.graphics.printf(self.txt, libuton.font, self.x, self.y+self.h/2-libuton.font:getHeight()/2, self.w, 'center')
		
	else
		if self.options.outline then
			love.graphics.setLineWidth(2)
			love.graphics.setColor(self.options.outlineColor)
			love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
		end
		love.graphics.setLineWidth(1)
		love.graphics.setColor(self.options.bgColor)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
		love.graphics.setColor(self.options.bgColor)
		love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
		love.graphics.setColor(self.options.fgColor)
		love.graphics.printf(self.txt, libuton.font, self.x, self.y+self.h/2-libuton.font:getHeight()/2, self.w, 'center')
	end
end

function button:mousepressed(x, y, b)

end

function button:mousereleased(x, y, b)
	if libuton.collision(self.x, self.y, self.w, self.h, x, y, 1, 1) and self.hover then
		self.callback()
	end
end

function button:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function button:setZindex(n) self.zindex = n end
function button:getZindex() return self.zindex end
function button:destroy() libuton.destroy(self) end
function button:setCallback(foo) self.callback = foo end

return button