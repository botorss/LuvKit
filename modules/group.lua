local group = {}
group.__index = group

function group.new(x, y, w, h, txt)
	local self = setmetatable({}, group)
	self.x = x
	self.y = y
	self.w = math.max(w, LuvKit.defaultW)
	self.h = math.max(h, LuvKit.defaultH)
	self.hover = false
	self.visible = true
	self.active = true
	self.elements = {}
	self.dElements = {}
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
		groupColor = LuvKit.defaultOptions.groupColor,
		gridColor = {.27, .27, .27},
		showGrid = false
	}
	self.callback = nil
	return self
end

function group:update(dt)
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		if LuvKit.hold == false then
			self.hover = true
		end
	else
		self.hover = false
	end
	return self.hover
end

function group:draw()
	if self.visible then
		if self.hover then
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.outlineColor)
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
		love.graphics.setColor(self.options.groupColor)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
		love.graphics.setScissor(self.x, self.y, self.w, self.h)
		if self.options.showGrid then
			local coef = LuvKit.defaultH/2
			love.graphics.setColor(self.options.gridColor)
			love.graphics.setLineStyle("rough")
			for x = 0, math.ceil(self.w/coef) do
				for y = 0, math.ceil(self.h/coef) do
					love.graphics.line(self.x+x*coef, self.y, self.x+x*coef, self.y+self.h)
					love.graphics.line(self.x, self.y+y*coef, self.x+self.w, self.y+y*coef)
				end
			end
		end
		love.graphics.setLineStyle("smooth")
		love.graphics.setScissor()
	end
	
	love.graphics.setColor(1,1,1)
end

function group:mousepressed(x, y, b)
end

function group:mousereleased(x, y, b)

end
-----------------------------------------------------------------
function group:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function group:setPos(x, y)
	self.x = x
	self.y = y 
	for k, v in pairs(self.elements) do
		v:setPos(self.x + self.dElements[k].dx, self.y + self.dElements[k].dy)
	end
end
function group:setX(x)				self:setPos(x, self.y) end
function group:setY(y)				self:setPos(self.x, y) end
function group:setWidth(w)			self.w = w end
function group:setHeight(h)		self.h = h end
function group:setActive(bool)		
	self.active = bool 
	for k, v in pairs(self.elements) do
		v:setActive(bool)
	end
end
function group:setVisible(bool) 	
	self.visible = bool 
	for k, v in pairs(self.elements) do
		v:setVisible(bool)
	end
end
function group:setZindex(n) 		self.zindex = n end
function group:setCallback(foo) 	self.callback = foo end
function group:setValue(text)		self.txt = text end
function group:setTextAlign(align)	self.alignMode = align end

function group:addElement(name, ...) 
	self.elements[name] = LuvKit.create(...)
	self.dElements[name] = {dx = self.elements[name].x, dy = self.elements[name].y} 
	self:setPos(self.x, self.y)
end

function group:getPos() 		return self.x, self.y end
function group:getX() 			return self.x end
function group:getY() 			return self.y end
function group:getWidth() 		return self.w end
function group:getHeight() 	return self.h end
function group:getOptions() 	return self.options end
function group:getActive() 	return self.active end
function group:getVisible() 	return self.visible end
function group:getHover() 		return self.hover end
function group:getZindex() 	return self.zindex end
function group:getValue()		return self.txt end
function group:getTextAlign()	return self.alignMode end

function group:destroy() 		LuvKit.destroy(self) end

return group