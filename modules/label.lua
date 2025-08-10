local label = {}
label.__index = label

function label.new(x, y, w, h, txt, alignMode)
	local self = setmetatable({}, label)
	self.x = x
	self.y = y
	self.w = math.max(w or 0, 100)
	self.h = math.max(h or 0, math.floor(LuvKit.defaultH/3)*2)
	self.hover = false
	self.visible = true
	self.active = true
	self.txt = txt or ''
	self.alignMode = alignMode or "center"
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

function label:update(dt)
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hover = true
	else
		self.hover = false
	end
	return self.hover
end

function label:draw()
	if self.visible then
		if self.hover then
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.houtlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)		
		else
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.outlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)
			
		end
		love.graphics.setColor(self.options.bgColor)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
		love.graphics.setColor(self.options.fgColor)
		love.graphics.printf(self.txt, LuvKit.font, self.x+5, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w-10, self.alignMode)
	end
	
	love.graphics.setColor(1,1,1)
end

function label:mousepressed(x, y, b)
end

function label:mousereleased(x, y, b)

end
-----------------------------------------------------------------
function label:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function label:setPos(x, y) 		self.x = x;self.y = y end
function label:setX(x)				self.x = x end
function label:setY(y)				self.y = y end
function label:setWidth(w)			self.w = w end
function label:setHeight(h)		self.h = h end
function label:setActive(bool)		self.active = bool end
function label:setVisible(bool) 	self.visible = bool end
function label:setZindex(n) 		self.zindex = n end
function label:setCallback(foo) 	self.callback = foo end
function label:setValue(text)		self.txt = text end
function label:setTextAlign(align)	self.alignMode = align end

function label:getPos() 		return self.x, self.y end
function label:getX() 			return self.x end
function label:getY() 			return self.y end
function label:getWidth() 		return self.w end
function label:getHeight() 	return self.h end
function label:getOptions() 	return self.options end
function label:getActive() 	return self.active end
function label:getVisible() 	return self.visible end
function label:getHover() 		return self.hover end
function label:getZindex() 	return self.zindex end
function label:getValue()		return self.txt end
function label:getTextAlign()	return self.alignMode end

function label:destroy() 		LuvKit.destroy(self) end

return label