--main
require('LuvKit')


function love.load()
	love.graphics.setBackgroundColor(.4, .4, .8, a)
b1= LuvKit.create('button', 100,100,100, 0,'Button 1')

dl1 = LuvKit.create('droplist', 100, 140, 100, 0, 'Option 1')
dl1:addToList('Option 2', 'Option 3', 'Option 4')

--lst = LuvKit.create('dropdown', 100, 300, 100, 20, {'option 1', 'option2', 'option3'})


slid1 = LuvKit.create('slider', 210, 100+3, 400, 0, 40, 215)
slid1:setRange(20, 80)
slid1:setValue(40)
slid1:setOptions({showVal = false})

slid2 = LuvKit.create('slider', 230, 70, 100)
slid2:setRange(0, 100)
slid2:setValue(40)


chk = LuvKit.create('checkbox', 210, 140+3)
chk:setCheck(true)

slid3 = LuvKit.create('sliders', 100, 300, 400)

slid4 = LuvKit.create('sliders', 100, 330, 100, 40, 60)

end

function love.update(dt)
	LuvKit.update()

end

function love.draw()
	love.graphics.setColor(1,1,1)
	LuvKit.draw()

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
end
