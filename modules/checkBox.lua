checkBox = {}
checkBox.__index = checkBox

function checkBox.new(x, y, w, h, txt)
	local self = setmetatable({}, checkBox)
	self.x = x
	self.y = y
	self.w = 16
	self.h = 16
	self.check = false
	self.zindex = #LuvKit._registry
	self.options = {
		bgColor = {0.5, 0.5, 0.5},
		fgColor = {0, 0, 0},
		outlineColor = {0, 0, 0},
		hbgColor = {0.7, 0.7, 0.7},
		hfgColor = {0, 0, 0},
		clickColor = {.8, .8, .8},
		houtlineColor = {1, 1, 1},
		outline = true,
		radius = 4,
	}
	return self
end

function checkBox:update(dt)
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hover = true
	else
		self.hover = false
	end
	return self.hover
end

function checkBox:draw()
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

		if self.check then
			love.graphics.setColor(self.options.fgColor)
			love.graphics.rectangle('fill', self.x+2, self.y+2, self.w-4, self.h-4, self.options.radius-2, self.options.radius-2)
			love.graphics.rectangle('line', self.x+2, self.y+2, self.w-4, self.h-4, self.options.radius-2, self.options.radius-2)
		end
		
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

		if self.check then
			love.graphics.setColor(self.options.fgColor)
			love.graphics.rectangle('fill', self.x+2, self.y+2, self.w-4, self.h-4, self.options.radius-2, self.options.radius-2)
			love.graphics.rectangle('line', self.x+2, self.y+2, self.w-4, self.h-4, self.options.radius-2, self.options.radius-2)
		end
	end
end

function checkBox:mousepressed(x, y, b)

end

function checkBox:mousereleased(x, y, b)
	if LuvKit.collision(self.x, self.y, self.w, self.h, x, y, 1, 1) and self.hover then
		self.check = not self.check
	end
end

function checkBox:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function checkBox:setPos(x, y) self.x = x;self.y = y end
function checkBox:setX(x)	self.x = x end
function checkBox:setY(y)	self.y = y end
function checkBox:setActive(bool)	self.active = bool end
function checkBox:setVisible(bool) self.visible = bool end
function checkBox:getPos() return self.x, self.y end
function checkBox:getX() return self.x end
function checkBox:getY() return self.y end
function checkBox:getOptions() return self.options end
function checkBox:getActive() return self.active end
function checkBox:getVisible() return self.visible end
function checkBox:getHover() return self.hover end
function checkBox:getCheck() return self.check end

function checkBox:setZindex(n) self.zindex = n end
function checkBox:getZindex() return self.zindex end
function checkBox:destroy() LuvKit.destroy(self) end

return checkBox