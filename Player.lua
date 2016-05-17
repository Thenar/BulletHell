Player = {
	x=0, y=0, sprite = nil, --pozycja i sprite
	speed_x =0, speed_y=0, acc =0, speed_max=200, --ruch
	shoot_timer_max=10, shoot_timer_curr=0, --zmiennie do strzelania
	bulletSprite = nil, bullets = {} --tablica pociskow i ich sprite
}


function Player:new(cordx, cordy) --konstruktor
	local obj = {}
	setmetatable(obj, self)
	self.__index = self
	
	obj.x=cordx
	obj.y=cordy
	
	obj.speed_x =0
	obj.speed_y=0
	obj.acc =9.81
	obj.speed_max=6.5
	
	
	obj.shoot_timer_max=0.05
	obj.shoot_timer_curr=0
	obj.bullets = {}
	obj.bulletSprite = love.graphics.newImage("assets/Full Coinss.png")
	obj.foo = love.graphics.newQuad(0,0,31,31,250,31)
	obj.sprite = love.graphics.newImage("assets/turtle2.png")
	
	obj.win_width, obj.win_height, obj.flags = love.window.getMode()
	obj.flags = nil
	
	return obj
end

function Player:getDebug()
	love.graphics.print(self.y,200,200)
end
function Player:getX()
	return self.x
end
function Player:getY()
	return self.y
end
function Player:getSprite()
	return self.sprite
end
function Player:draw()
	
	love.graphics.draw(self.sprite, self.x, self.y)
	
	for i, bullet in ipairs(self.bullets) do
		love.graphics.draw(bullet.img, self.foo, bullet.x, bullet.y)
	end
	
end
function Player:update(dt)
	for i, bullet in ipairs(self.bullets) do
		
		bullet.x = bullet.x + bullet.acc_x * bullet.bullet_speed_hor * dt
		bullet.y = bullet.y - (bullet.acc_y+1) * bullet.bullet_speed_up * dt
		
		if bullet.y < 0 then -- remove bullets when they pass off the screen
		table.remove(self.bullets, i)
		end
		
	end
end
function Player:shoot(dt)
	if self.shoot_timer_curr <= 0 and love.keyboard.isScancodeDown('space') then

		newBullet = {
		x = self.x + (self.sprite:getWidth()/2), y = self.y, img = self.bulletSprite,
		acc_x =self.speed_x*8 , acc_y = 0.5, bullet_speed_up = 400, bullet_speed_hor = 2}

		table.insert(self.bullets, newBullet)
		self.shoot_timer_curr = self.shoot_timer_max
	else
		self.shoot_timer_curr = self.shoot_timer_curr - (0.8*dt)
	end
end
function Player:move(dt)

	--przyspieszanie
	if love.keyboard.isDown('a') then
		self.speed_x = self.speed_x - self.acc * dt
	end
	if love.keyboard.isDown('d') then
		self.speed_x = self.speed_x + self.acc * dt
	end	
	if love.keyboard.isDown('s') then
		self.speed_y = self.speed_y + self.acc * dt
	end	
	if love.keyboard.isDown('w') then
		self.speed_y = self.speed_y - self.acc * dt
	end

	--zwalnianie
	if not love.keyboard.isDown('a') and self.speed_x <= 0 then
		self.speed_x = self.speed_x + self.acc * dt
	end
	if not love.keyboard.isDown('d') and self.speed_x >= 0 then
		self.speed_x = self.speed_x - self.acc * dt		
	end	
	if not love.keyboard.isDown('s') and self.speed_y >= 0 then
		self.speed_y = self.speed_y - self.acc * dt
	end	
	if not love.keyboard.isDown('w') and self.speed_y <= 0 then
		self.speed_y = self.speed_y + self.acc * dt
	end
	
	--usuwanie resztek predkosci
	if self.speed_x <= 0.15 and self.speed_x >= -0.15 and not love.keyboard.isDown('a') and not love.keyboard.isDown('d') then
		self.speed_x=0
	end
	if self.speed_y <= 0.15 and self.speed_y >= -0.15 and not love.keyboard.isDown('s') and not love.keyboard.isDown('w') then
		self.speed_y =0
	end
	
	--kontrola max predkosci
	if self.speed_x > self.speed_max then
		self.speed_x = self.speed_max
	end
	if self.speed_x < -self.speed_max then
		self.speed_x = -self.speed_max
	end	
	if self.speed_y < -self.speed_max then
		self.speed_y = -self.speed_max
	end	
	if self.speed_y > self.speed_max then
		self.speed_y = self.speed_max
	end
	
	--bouncy collision
	if self.x <0 then
		self.speed_x = self.speed_x * -1 + 0.2
	end
	if self.x + self.sprite:getWidth() > self.win_width then
		self.speed_x = self.speed_x * -1 - 0.2
	end
	if self.y < -self.sprite:getHeight()/2 then
		self.speed_y = self.speed_y * -1 + 0.2
	end
	if self.y + self.sprite:getHeight() > self.win_height then
		self.speed_y = self.speed_y * -1 - 0.2
	end
	
	--przesuniecie
	self.x = self.x + self.speed_x
	self.y = self.y + self.speed_y

end
