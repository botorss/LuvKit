--main
require('LuvKit')


function love.load()
b1= LuvKit.create('button', 100,130,100,20,'Button 1')

dl1 = LuvKit.create('droplist', 100, 200, 100, 20, 'List 1')

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

	if button ==2  then
		--myMenu:show()
	end

	--t1:mousepressed(x,y,button)
end

function love.mousereleased(x, y, button)

	LuvKit.mousereleased(x,y,button)
	--LuvKit.mousereleased()
end

function love.keypressed(key)
	--t1:keypressed(key)
	LuvKit.keypressed(key)
end

function test()
love.graphics.print('test', 10,10, r, sx, sy, ox, oy, kx, ky)
end

function love.textinput(text)
t2:textinput(text)

end
