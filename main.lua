--main
require('LuvKit')


function love.load()
s1= LuvKit.create('sliders',100,100,100,15)
b1= LuvKit.create('button', 100,130,100,20,'test')
b1:setCallback(test() )
d1 = LuvKit.create("dropdown", 100, 160, 100, 20, {"Option 1", "Option 2", "Option 3"})
--d1.callback = love.graphics.print("Hello !",.5*love.graphics.getWidth(),.5*love.graphics.getHeight())
myMenu = LuvKit.create("context_menu", 100, 220, 220, {
    { label = "Afficher Bonjour", type = "action", callback = function() love.graphics.print("Hello !",.5*love.graphics.getWidth(),.5*love.graphics.getHeight()) end },
    { label = "Changer une variable", type = "input", callback = function(text) print("Entrée :", text) end }
})
t2 = LuvKit.create("textInput",100,190,100,'Champ Texte')

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
