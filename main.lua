--main
require('LuvKit')


function love.load()
	love.graphics.setBackgroundColor(.4, .4, .8, a)
	b1= LuvKit.create('button', 100,100,100, 0,'Button 1')

	dl1 = LuvKit.create('droplist', 100, 140, 100, 0, 'Option 1')
	dl1:addToList('Option 2', 'Option 3', 'Option 4')
	dl1:setActive(true)

	slid1 = LuvKit.create('slider', 210, 100+3, 400, 0, 40, 215)
	slid1:setRange(20, 80)
	slid1:setValue(40)
	slid1:setOptions({showVal = false})
	slid1:setActive(false)

	slid2 = LuvKit.create('slider', 230, 70, 100)
	slid2:setRange(0, 100)
	slid2:setValue(40)


	chk = LuvKit.create('checkbox', 210, 140+3)
	chk:setCheck(true)

	txtbox1 = LuvKit.create('textbox', 230, 140, 200, 'Text...')

	lbl = LuvKit.create("label", 230, 170, 60, 0, "Test label")


	grp = LuvKit.create("group", 300, 300, 210, 18*8)
	grp:addElement("bgrp1", "button", LuvKit.u(1), LuvKit.u(1), 50, 0, "Bgrp 1")
	grp.elements.bgrp1:setCallback(function() print('click') end)

	grp:addElement("sbgrp1", "slider", LuvKit.u(1), LuvKit.u(4)+3, 150)
end

function love.update(dt)
	LuvKit.update(dt)

end

function love.draw()
	love.graphics.setColor(1,1,1)
	LuvKit.draw()
	grp:draw()

end

function love.mousepressed(x, y, button)
	LuvKit.mousepressed(x,y,button)
end

function love.mousereleased(x, y, button)
	LuvKit.mousereleased(x,y,button)
end

function love.keypressed(key)
	LuvKit.keypressed(key)
end

function love.mousemoved(x, y, dx, dy)
	LuvKit.mousemoved(x, y, dx, dy)
end

function love.textinput(text)
	LuvKit.textinput(text)
end
