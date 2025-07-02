-- text input

local textInput = {}

textInput.__index = textInput

textInput.backgroundColor = {.4,.4,.4}
textInput.backgroundColor_Highlighted = {.7,.7,.7}
outlineColor = {.9,.9,.9}
textColor = {.85,.85,.85}
textColor_writing = {.2,.2,.2}

function textInput.new(x,y,w,label)

	local self = setmetatable({}, textInput)
		self.x = x
		self.y = y
		self.w = w or 150
		self.h = 25
		self.hover = false
		self.visible = true
		self.inputActive = false
		self.label = label or ''
		self.text = ''
	-- body

	return self
end

function textInput:draw()

	local font = love.graphics.getFont()
	local textHeight = font:getHeight()
	local centerY = self.y + (self.h - textHeight) / 2

	love.graphics.setColor(textInput.backgroundColor)
	love.graphics.rectangle('fill',self.x, self.y, self.w, self.h)

	if self.hover then
		love.graphics.setColor(outlineColor)
		love.graphics.rectangle('line',self.x, self.y, self.w, self.h)
	end
	--love.graphics.print(tostring(self.inputActive))

	if self.inputActive then
		love.graphics.print(tostring(self.inputActive))
	    love.graphics.setColor(textInput.backgroundColor_Highlighted)
	    love.graphics.rectangle('fill',self.x, self.y, self.w, self.h)
	    love.graphics.setColor(textColor_writing)
	    love.graphics.printf(self.text, self.x+3, centerY,self.w,'left')
	    love.graphics.setColor(1,1,1)
	end
	if not self.inputActive and self.text == '' then
		love.graphics.setColor(textColor)
		love.graphics.printf(self.label, self.x+3, centerY,self.w,'left')

	elseif not self.inputActive then
		love.graphics.setColor(textColor)
		love.graphics.printf(self.text, self.x+3, centerY,self.w,'left')
	end


		-- body
end

function textInput:update()
	if textInput.collision(self.x, self.y, self.w, self.h, love.mouse.getX(),love.mouse.getY(),1,1) then 

		self.hover = true
	else
		self.hover = false 
	end
	-- body
	return self.hover
end

function textInput:mousepressed(x,y, button)
	if self.hover and button==1 then
		self.inputActive = not self.inputActive
	-- body
	else self.hover = false 
	end

	if not self.hover and button==1 then
		self.inputActive = false
	end

end

function textInput:mousereleased(x,y,button)


end
function textInput.collision(x1,y1,w1,h1,x2,y2,w2,h2)
	  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function textInput:keypressed(key)

	if key == 'return' and self.inputActive then
		self.inputActive = false
		--textInput:callback()
	end
	if key == 'backspace' and self.inputActive then
			self.text = self.text:sub(1, #self.text-1)
	end
end

function textInput:textinput(text)

	if self.inputActive then

		self.text = self.text..text


	-- body
	end
end

function textInput:callback()

	return self.text 
end

return textInput
	
