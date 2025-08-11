local checkbox = {}
checkbox.__index = checkbox

function checkbox.new(x, y, w, h)
	local self = setmetatable({}, checkbox)
	self.x = x
	self.y = y
	self.w = (LuvKit.defaultW/3) * 2
	self.h = (LuvKit.defaultH/3) * 2
	self.visible = true
	self.active = true
	self.check = false
	self.zindex = #LuvKit._registry
	self.options = {
		bgColor = LuvKit.defaultOptions.bgColor,
		fgColor = LuvKit.defaultOptions.fgColor,
		outlineColor = LuvKit.defaultOptions.outlineColor,
		hbgColor = LuvKit.defaultOptions.hbgColor,
		hfgColor = LuvKit.defaultOptions.hfgColor,
		houtlineColor = LuvKit.defaultOptions.houtlineColor,
		clickColor = LuvKit.defaultOptions.clickColor,
		outline = LuvKit.defaultOptions.outline,
		radius = LuvKit.defaultOptions.radius,
	}
	return self
end

function checkbox:update(dt)
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		if LuvKit.hold == false then
			self.hover = true
		end
	else
		self.hover = false
	end
	return self.hover
end

function checkbox:draw()
	if self.visible then
		if self.hover then
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.houtlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)
			love.graphics.setColor(self.options.hbgColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
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

			if self.check then
				love.graphics.setColor(self.options.fgColor)
				love.graphics.rectangle('fill', self.x+2, self.y+2, self.w-4, self.h-4, self.options.radius-2, self.options.radius-2)
				love.graphics.rectangle('line', self.x+2, self.y+2, self.w-4, self.h-4, self.options.radius-2, self.options.radius-2)
			end
		end
	end
	love.graphics.setColor(1, 1, 1)
end

function checkbox:mousepressed(x, y, b)

end

function checkbox:mousereleased(x, y, b)
	if LuvKit.collision(self.x, self.y, self.w, self.h, x, y, 1, 1) and self.hover then
		self.check = not self.check
	end
end

function checkbox:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function checkbox:setPos(x, y) 		self.x = x;self.y = y end
function checkbox:setX(x)			self.x = x end
function checkbox:setY(y)			self.y = y end
function checkbox:setActive(bool)	self.active = bool end
function checkbox:setVisible(bool) 	self.visible = bool end
function checkbox:setCheck(bool)	self.check = bool end

function checkbox:getPos() 		return self.x, self.y end
function checkbox:getX() 		return self.x end
function checkbox:getY() 		return self.y end
function checkbox:getOptions() 	return self.options end
function checkbox:getActive() 	return self.active end
function checkbox:getVisible() 	return self.visible end
function checkbox:getHover() 		return self.hover end
function checkbox:getCheck() 		return self.check end

function checkbox:setZindex(n) self.zindex = n end
function checkbox:getZindex() return self.zindex end
function checkbox:destroy() LuvKit.destroy(self) end

return checkbox