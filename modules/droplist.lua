local droplist = {}
droplist.__index = droplist

function droplist.new(x, y, w, h, placeHolder)
	local self = setmetatable({}, droplist)
	self.x = x
	self.y = y
	self.w = math.max(w, 30)
	self.h = math.max(h, LuvKit.font:getHeight())
	self.hover = false
	self.visible = true
	self.active = true
	self.placeHolder = placeHolder or ''
	self.zindex = #LuvKit._registry
	self.open = false
	self.list = {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"}
	self.options = {
		bgColor = {0.5, 0.5, 0.5},
		fgColor = {0, 0, 0},
		outlineColor = {0, 0, 0},
		hbgColor = {0.7, 0.7, 0.7},
		hfgColor = {0, 0, 0},
		houtlineColor = {1, 1, 1},
		clickColor = {.8, .8, .8},
		outline = true,
		radius = 0,
	}
	self.callback = nil
	return self
end

function droplist:update(dt)
	if LuvKit.collision(self.x, self.y, self.w, self.h + (self.open and #self.list*self.h or 0), love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hover = true
	else
		self.hover = false
		self.open = false
	end
	return self.hover
end

function droplist:draw()
	if self.visible then
		if self.hover then
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.houtlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h + (self.open and #self.list*self.h or 0), self.options.radius)
			end
			love.graphics.setLineWidth(1)
			love.graphics.setColor(self.options.hbgColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
			love.graphics.setColor(self.options.hbgColor)
			love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			if love.mouse.isDown(1) and LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
				love.graphics.setColor(self.options.clickColor)
				love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setColor(self.options.hfgColor)
			love.graphics.printf(self.placeHolder, LuvKit.font, self.x, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w, 'center')

			
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
			love.graphics.printf(self.placeHolder, LuvKit.font, self.x, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w, 'center')

		end
		love.graphics.printf((self.open and "▲") or "▼", LuvKit.font, self.x+5, self.y+self.h/2-LuvKit.font:getHeight()/2-1, self.w-10, 'right')
		if self.open then
			love.graphics.setColor(self.options.outlineColor)
			--love.graphics.rectangle('line', self.x, self.y+self.h, self.w, self.h*2, self.options.radius)
			for k, v in ipairs(self.list) do
				if LuvKit.collision(self.x, self.y+k*self.h, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
					love.graphics.setColor(self.options.hbgColor)
					if love.mouse.isDown(1) then
						love.graphics.setColor(self.options.clickColor)
						love.graphics.rectangle('fill', self.x, self.y+k*self.h, self.w, self.h, self.options.radius)
					end
				else
					love.graphics.setColor(self.options.bgColor)
				end

				love.graphics.rectangle('fill', self.x, (self.y+k*self.h), self.w, self.h)
				love.graphics.setColor(0, 0, 0)
				love.graphics.printf(v, LuvKit.font, self.x, (self.y+k*self.h)+self.h/2-LuvKit.font:getHeight()/2, self.w, 'center')
			end
		end
	end
	love.graphics.setColor(1,1,1)
end

function droplist:mousepressed(x, y, b)

end

function droplist:mousereleased(x, y, b)
	if LuvKit.collision(self.x, self.y, self.w, self.h, x, y, 1, 1) and self.hover and self.active then
		self.open = not self.open
	end
	for k, v in ipairs(self.list) do
		if LuvKit.collision(self.x, self.y+k*self.h, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
			self.placeHolder = v
			self.open = not self.open
		end
	end
end
-----------------------------------------------------------------
function droplist:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function droplist:setPos(x, y) 		self.x = x;self.y = y end
function droplist:setX(x)				self.x = x end
function droplist:setY(y)				self.y = y end
function droplist:setWidth(w)			self.w = w end
function droplist:setHeight(h)		self.h = h end
function droplist:setActive(bool)		self.active = bool end
function droplist:setVisible(bool) 	self.visible = bool end
function droplist:setZindex(n) 		self.zindex = n end
function droplist:setCallback(foo) 	self.callback = foo end
function droplist:setList(tab)		self.list = tab end
function droplist:addToList(val)	table.insert(self.list, val) end
function droplist:rmInList(key)		table.remove(self.list, key) end

function droplist:getPos() 		return self.x, self.y end
function droplist:getX() 			return self.x end
function droplist:getY() 			return self.y end
function droplist:getWidth() 		return self.w end
function droplist:getHeight() 	return self.h end
function droplist:getOptions() 	return self.options end
function droplist:getActive() 	return self.active end
function droplist:getVisible() 	return self.visible end
function droplist:getHover() 		return self.hover end
function droplist:getZindex() 	return self.zindex end

function droplist:destroy() 		LuvKit.destroy(self) end

return droplist