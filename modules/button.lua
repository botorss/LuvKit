local button = {}
button.__index = button

function button.new(x, y, w, h, txt)
	local self = setmetatable({}, button)
	self.x = x
	self.y = y
	self.rx = x
	self.ry = y
	self.w = math.max(w, LuvKit.defaultW)
	self.h = math.max(h, LuvKit.defaultH)
	self.hover = false
	self.visible = true
	self.active = true
	self.txt = txt or ''
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
	self.callback = nil
	return self
end

function button:update(dt)
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hover = true
	else
		self.hover = false
	end
	return self.hover
end

function button:draw()
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
			love.graphics.setColor(self.options.hfgColor)
			love.graphics.printf(self.txt, LuvKit.font, self.x, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w, 'center')
			
		else
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.outlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)
			love.graphics.setColor(self.options.bgColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
			love.graphics.setColor(self.options.fgColor)
			love.graphics.printf(self.txt, LuvKit.font, self.x, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w, 'center')
		end
	end
	love.graphics.setColor(1,1,1)
end

function button:mousepressed(x, y, b)
end

function button:mousereleased(x, y, b)
	if LuvKit.collision(self.x, self.y, self.w, self.h, x, y, 1, 1) and self.hover and self.active then
		if self.callback then
			self.callback()
		end
	end
end
-----------------------------------------------------------------
function button:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function button:setPos(x, y) 		self.x = x;self.y = y end
function button:setX(x)				self.x = x end
function button:setY(y)				self.y = y end
function button:setWidth(w)			self.w = w end
function button:setHeight(h)		self.h = h end
function button:setActive(bool)		self.active = bool end
function button:setVisible(bool) 	self.visible = bool end
function button:setZindex(n) 		self.zindex = n end
function button:setCallback(foo) 	self.callback = foo end
function button:setLabel(label)		self.txt = label end

function button:getPos() 		return self.x, self.y end
function button:getX() 			return self.x end
function button:getY() 			return self.y end
function button:getWidth() 		return self.w end
function button:getHeight() 	return self.h end
function button:getOptions() 	return self.options end
function button:getActive() 	return self.active end
function button:getVisible() 	return self.visible end
function button:getHover() 		return self.hover end
function button:getZindex() 	return self.zindex end
function button:getLabel()		return self.txt end

function button:destroy() 		LuvKit.destroy(self) end

return button