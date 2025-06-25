--sliders

slider = {}
slider.__index = slider

function slider.new(x, y, w, h, txt)
	local self = setmetatable({}, slider)
	self.x = x
	self.y = y
	self.w = w or 50
	self.h = h or 8
	self.txt = txt or ''
	self.color = {.5, .5, .5}
	self.zindex = #LuvKit._registry
	self.cursor_w = .1*self.w
	self.cursor_h = 1.5*self.h
	self.cursor_x = self.x + self.w/2-self.cursor_w/2
	self.cursor_y = self.y - .5*(self.cursor_h -self.h/2)
	
	

	self.options = {
		bgColor = {0.15, 0.15, 0.15},
		fgColor = {0.1, 0.1, 0.1},
		outlineColor = {0, 0, 0},
		hbgColor = {0.7, 0.7, 0.7},
		hfgColor = {0.5, 0.5, 0.5},
		houtlineColor = {1, 1, 1},
		clickColor = {.8, .8, .8},
		outline = true,
		radius = 2,
	}
	self.callback = nil
	return self
end
function slider:update(dt)
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hover = true

	else
		self.hover = false
	end

	if LuvKit.collision(self.cursor_x, self.cursor_y, self.cursor_w, self.cursor_h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.cursor_hover = true

	else
		self.cursor_hover = false
	end

	if self.isClicked then
		self.cursor_x= LuvKit.clamp(self.x,love.mouse.getX(),self.x+self.w-self.cursor_w)
	end



	return self.hover
end

function slider:draw()

--course slider
	if self.hover ==false then
		love.graphics.setColor(self.options.bgColor)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h,self.options.radius, self.options.radius)
		-- body

-- curseur

		love.graphics.setColor(self.options.fgColor)
		love.graphics.rectangle('fill', self.cursor_x, self.cursor_y, self.cursor_w, self.cursor_h,self.options.radius, self.options.radius)

-- survol avec mise en évidence
	elseif self.hover then

		love.graphics.setColor(self.options.hbgColor)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h,self.options.radius, self.options.radius)
		-- body

-- curseur
		--if self.cursor_hover then
			love.graphics.setColor(self.options.clickColor)
			love.graphics.rectangle('fill', self.cursor_x, self.cursor_y, self.cursor_w, self.cursor_h,self.options.radius, self.options.radius)	
		--end
	end
	love.graphics.setColor(1,1,1)
end

function slider:mousepressed(x, y, button)
    if button == 1 and self.cursor_hover then
      
       self.isClicked = true
      
    end

end

function slider:mousereleased(x,y, button)
	self.isClicked=false
end


function slider:setOnClick(callback)
    self.onClick = callback
end

function slider:getValue()
    return (self.cursor_x - self.x) / self.w
end

return slider