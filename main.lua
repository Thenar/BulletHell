require('Player')

debug = true
state = false
love.keyboard.setKeyRepeat( enable )


function love.load(arg)
	p=Player:new(100,600)
end

function love.update(dt)
	if love.keyboard.isScancodeDown('escape') then
		love.event.push('quit')
	end
	
	if love.keyboard.isScancodeDown('x') then
		state=true
	else
		state=false
	end
	
	p:move(dt)
	p:shoot(dt)
	p:update(dt)
	
end


function love.draw(dt)
	p:draw()
	if state then
		--love.graphics.print(p:getDebug(),200,200)
		p:getDebug()
	end
end


