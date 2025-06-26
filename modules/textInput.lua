-- text input

textInput = {}

textInput.__index = textInput

backgroundColor = {.4,.4,.4}
backgroundColor_Highlighted = {.7,.7,.7}
outlineColor = {.9,.9,.9}

function textInput:new(x,y,w,label)

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
end

function textInput:draw()

love.graphics.setColor(backgroundColor)
love.graphics.rectangle('fill',self.x, self.y, self.w, self.h)
love.graphics.setColor(outlineColor)
love.graphics.rectangle('line',self.x, self.y, self.w, self.h)

	-- body
end

function textInput:update()
	if textInput.collision(self.x, self.y, self.w, self.h, love.mouse.getX(),love.mouse.getY(),1,1) then 

		self.hover = true
	else
		self.hover = false 
	end
	-- body
end

function textInput.mousepressed(x,y, button)

	if self.hover and button==1 then
		self.inputActive = true
	-- body
	else self.hover = false 
	end

	if not self.hover and button==1 then
		self.inputActive = false
end

function textInput.collision(x1,y1,w1,h1,x2,y2,w2,h2)
	  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function textInput:textinput(text)

	if self.inputActive then

		self.text = self.text..text
	-- body
end

function textInput:callback()

	return self.text 
end
	
