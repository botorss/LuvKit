local textbox = {}
textbox.__index = textbox

function textbox.new(x, y, w, placeHolder)
	local self = setmetatable({}, textbox)
	self.x = x
	self.y = y
	self.w = math.max(w, LuvKit.defaultW)
	self.h = LuvKit.defaultH
	self.hover = false
	self.visible = true
	self.maxInput = math.floor((self.w-10) / LuvKit.font:getWidth('O'))
	self.active = true
	self.txt = txt or ''
	self.textInputActif = false
	self.timer = 0
	self.placeHolder = placeHolder or 'Placeholder'
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
		textboxBackColor = LuvKit.defaultOptions.textboxBackColor,
		txtColor = {1, 1, 1},
		activColor = {1, 0, 0},
		placeHolderColor = {.4, .4, .4},
		cursorColor = {.7, .7, .7}
	}
	self.callback = nil
	return self
end

function textbox:update(dt)
	self.timer = self.timer + dt*5
	if LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1) then
		self.hover = true
	else
		self.hover = false
	end
	return self.hover
end

function textbox:draw()
	if self.visible then
		if self.textInputActif then
			love.graphics.setLineWidth(4)
			love.graphics.setColor(self.options.activColor)
			love.graphics.rectangle('line', self.x-2, self.y-2, self.w+4, self.h+4, self.options.radius)
			love.graphics.setLineWidth(1)
		end
		if self.hover then
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.houtlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)
			love.graphics.setColor(self.options.textboxBackColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
		else
			if self.options.outline then
				love.graphics.setLineWidth(2)
				love.graphics.setColor(self.options.outlineColor)
				love.graphics.rectangle('line', self.x, self.y, self.w, self.h, self.options.radius)
			end
			love.graphics.setLineWidth(1)
			love.graphics.setColor(self.options.textboxBackColor)
			love.graphics.rectangle('fill', self.x, self.y, self.w, self.h, self.options.radius)
		end
	end
	
	if #self.txt == 0 and self.textInputActif == false then
		love.graphics.setColor(self.options.placeHolderColor)
		love.graphics.printf(self.placeHolder, LuvKit.font, self.x+5, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w-10, 'left')
	end

	if self.textInputActif then
		if math.floor(self.timer) % 2 == 0 then
			love.graphics.setColor(self.options.cursorColor)
			love.graphics.printf('|', LuvKit.font, self.x+LuvKit.font:getWidth(self.txt)+2, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w, 'left')
		end
	end

	love.graphics.setColor(self.options.txtColor)
	love.graphics.printf(self.txt, LuvKit.font, self.x+5, self.y+self.h/2-LuvKit.font:getHeight()/2, self.w-10, 'left')
	love.graphics.setColor(1,1,1)
end

function textbox:mousepressed(x, y, b)
	self.textInputActif = false
end

function textbox:mousereleased(x, y, b)
	if LuvKit.collision(self.x, self.y, self.w, self.h, x, y, 1, 1) and self.hover and self.active then
		self.textInputActif = true
		self.timer = 0
	end
end

function textbox:keypressed(key)
	self.timer = 0
	if self.active and self.textInputActif then
		if key == 'return' then
			self.textInputActif = false
		elseif key == 'backspace' then
			local byteoffset = utf8.offset(self.txt, -1)
			if byteoffset then
				-- Utiliser string.sub avec l'offset pour enlever le dernier caractère
				self.txt = string.sub(self.txt, 1, byteoffset - 1)
			end
		end
	end
end

function textbox:textinput(text)
	if self.active and self.textInputActif then
		if #self.txt < self.maxInput then
			self.txt = self.txt..text
		end
	end
end
-----------------------------------------------------------------
function textbox:setOptions(tab)
	for k, v in pairs(tab) do
		if self.options[k] then
			self.options[k] = v
		end
	end
end

function textbox:setPos(x, y) 		self.x = x;self.y = y end
function textbox:setX(x)				self.x = x end
function textbox:setY(y)				self.y = y end
function textbox:setWidth(w)			self.w = w end
function textbox:setHeight(h)		self.h = h end
function textbox:setActive(bool)		self.active = bool end
function textbox:setVisible(bool) 	self.visible = bool end
function textbox:setZindex(n) 		self.zindex = n end
function textbox:setCallback(foo) 	self.callback = foo end
function textbox:setText(text)		self.txt = text end

function textbox:getPos() 		return self.x, self.y end
function textbox:getX() 			return self.x end
function textbox:getY() 			return self.y end
function textbox:getWidth() 		return self.w end
function textbox:getHeight() 	return self.h end
function textbox:getOptions() 	return self.options end
function textbox:getActive() 	return self.active end
function textbox:getVisible() 	return self.visible end
function textbox:getHover() 		return self.hover end
function textbox:getZindex() 	return self.zindex end
function textbox:getText()		return self.txt end

function textbox:destroy() 		LuvKit.destroy(self) end

return textbox