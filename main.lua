--main
require('LuvKit')


function love.load()
s1= LuvKit.create('sliders',100,100,100,15)
b1= LuvKit.create('button', 100,130,100,20,'test')
b1:setCallback(test() )
d1 = LuvKit.create("dropdown", 100, 160, 100, 20, {"Option 1", "Option 2", "Option 3"})
myMenu = LuvKit.create("context_menu", 100, 100, 160, {
    { label = "Afficher Bonjour", type = "action", callback = function() print("Hello !") end },
    { label = "Changer une variable", type = "input", callback = function(text) print("Entrée :", text) end }
})


--s1= slider.new(100,100,70,20)
end

function love.update(dt)
	LuvKit.update()


--s1:update()
end

function love.draw()
	love.graphics.setColor(1,1,1)
	LuvKit.draw()
	
--s1:draw()
end

function love.mousepressed(x, y, button)
	-- body
	LuvKit.mousepressed(x,y,button)

	if button ==2  then
		myMenu:show()
	end
end

function love.mousereleased(x, y, button)

	LuvKit.mousereleased(x,y,button)
end

function test()
love.graphics.print('test', 10,10, r, sx, sy, ox, oy, kx, ky)
end