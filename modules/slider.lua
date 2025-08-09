local slider = {}
slider.__index = slider

function slider.new(x, y, w, h, min, max)
	local self = setmetatable({}, slider)
	self.x = x
	self.y = y
	self.w = math.max(w or 0, 100)
	self.h = math.max(h or 0, math.floor(LuvKit.defaultH/3)*2)
	self.slidPos = 0
	self.hover = false
	self.visible = true
	self.active = true
	self.min = min or 0
	self.max = max or 100
	self.value = self.min
	self.clickX = 0
	self.clickY = 0
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
		sliderBackColor = LuvKit.defaultOptions.sliderBackColor,
		cursorColor = LuvKit.defaultOptions.cursorColor,
		showVal = true
	}
	return self
end

function slider:update(dt)
	
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) or self.hold then
		self.hover = true
	else
		self.hover = false
	end
	self.value = math.floor(self.min + (self.slidPos/self.w) * (self.max-self.min))
	return self.hover
end

function slider:draw()
	if self.visible then
		love.graphics.setColor(0, 1, 0, .3)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
		if self.hover then
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.houtlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)
			love.graphics.setColor(self.options.sliderBackColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)

			love.graphics.setColor(self.options.hbgColor)
			love.graphics.rectangle('fill', self.x, self.y, self.slidPos, self.h, self.options.radius)

			if love.mouse.isDown(1) then
				love.graphics.setColor(self.options.clickColor)
				love.graphics.rectangle('fill', self.x, self.y, self.slidPos, self.h, self.options.radius)
			end
			love.graphics.setColor(1, 0, 0)
			love.graphics.rectangle('line', self.x+self.slidPos, self.y+2, 0, self.h-4)
			if self.options.showVal then
				love.graphics.setColor(self.options.hfgColor)
				love.graphics.printf(self.value, LuvKit.font, self.x, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w, 'center')
			end
		else
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.outlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)
			love.graphics.setColor(self.options.sliderBackColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
			love.graphics.setColor(self.options.bgColor)
			love.graphics.rectangle('fill', self.x, self.y, self.slidPos, self.h, self.options.radius)
			love.graphics.setColor(self.options.cursorColor)
			love.graphics.rectangle('line', self.x+self.slidPos, self.y+2, 0, self.h-4)
			if self.options.showVal then
				love.graphics.setColor(self.options.fgColor)
				love.graphics.printf(self.value, LuvKit.font, self.x, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w, 'center')
			end
		end
	end
	love.graphics.setColor(1,1,1)
end

function slider:mousepressed(x, y, b)
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hold = true
		love.mouse.setX(self.x+self.slidPos)
	end
end

function slider:mousereleased(x, y, b)
	self.hold = false
end

function slider:mousemoved(x, y, dx, dy, istouch)
	if self.active and self.hold then
		self.slidPos = LuvKit.clamp(0, x - self.x, self.w)
	end
end
-----------------------------------------------------------------
function slider:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function slider:setPos(x, y) 		self.x = x;self.y = y end
function slider:setX(x)				self.x = x end
function slider:setY(y)				self.y = y end
function slider:setWidth(w)			self.w = w end
function slider:setHeight(h)		self.h = h end
function slider:setRange(min, max)	self.min = min;self.max = max end
function slider:setMin(min) 		self.min = min end
function slider:setMax(max) 		self.max = max end
function slider:setValue(val)		self.slidPos = (val - self.min) / (self.max - self.min) * self.w;self.value = val end
function slider:setActive(bool)		self.active = bool end
function slider:setVisible(bool) 	self.visible = bool end
function slider:setZindex(n) 		self.zindex = n end

function slider:getPos() 		return self.x, self.y end
function slider:getX() 			return self.x end
function slider:getY() 			return self.y end
function slider:getWidth() 		return self.w end
function slider:getHeight() 	return self.h end
function slider:getRange()		return self.min, self.max end
function slider:getMin() 		return self.min end
function slider:getMax() 		return self.max end
function slider:getValue()		return self.value end
function slider:getOptions() 	return self.options end
function slider:getActive() 	return self.active end
function slider:getVisible() 	return self.visible end
function slider:getHover() 		return self.hover end
function slider:getZindex() 	return self.zindex end

function slider:destroy() 		LuvKit.destroy(self) end

return slider