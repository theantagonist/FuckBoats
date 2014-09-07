function love.load()
	live = 1
	bullshit = 0
	backgroundImage = love.graphics.newImage("bitmaps/background.png")
	flamingo = love.graphics.newImage("bitmaps/flamingotest.png")
	flamingo_corpse = love.graphics.newImage("bitmaps/flamingo_crash.png")
	gore = love.graphics.newImage("bitmaps/gore.png")
	splash = love.graphics.newImage("bitmaps/splash.png")
	local p =love.sound.newSoundData("sounds/ambient/background.wav")
		love.audio.newSource(p, "static"):play()
	--not the finished background image, but that seemed to be missing
	
	birdx = 640
	birdy = 100
	birdDy = 0
end

function love.draw()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.draw(backgroundImage, 0, 0)
	love.mouse.setVisible(invisible)
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	local r = 10
	if live == 1 then
		love.graphics.setColor( 255, 255, 255 )
		love.graphics.draw(flamingo, birdx % 640, 100 + 5 * math.sin(birdx/10))
		birdx = birdx-1
	else
		love.graphics.setColor( 255, 255, 255, 255 )
		love.graphics.draw(flamingo_corpse, birdx % 640, birdy)
		birdx = birdx-1
		birdy = birdy + birdDy/10
		birdDy = birdDy + 1

		if birdy >= 425 then
			local v =0
			for v = 1, 40 do 
			love.graphics.setColor( 255, 255, 255, 255 )
			love.graphics.draw(splash, birdx % 640, birdy - v)
			end

			live = 1
		 	birdDy = 0
			birdy = 100
			birdx = 639
			--love.audio.setVolume(1)
			local noise = love.sound.newSoundData("sounds/impact/impact_splash.wav")
			love.audio.newSource(noise, "static"):play()
		end
	end

	love.graphics.setColor(0, 0, 0, 150) --This shits just crosshair code
	love.graphics.setLine(2, "smooth") --completely unecessary
	love.graphics.circle("line", x, y, r, 100)
	love.graphics.line(x + r - 1, y, x - r + 1, y)
	love.graphics.line(x, y + r - 1, x, y - r + 1)

end

function love.update(dt)
function love.mousepressed( x, y, button )
	if button == "l" then
		local x1 = 95
		local y1 = 254
		local epsilon = 0.2
		local noise1 = love.sound.newSoundData("sounds/gun/gunshot_01.wav")
		love.graphics.setColor(255, 255, 255, 80)
		for t = 1, 20 do
		love.graphics.setLine(20, "smooth")
		love.audio.newSource(noise1, "static"):play()
		love.graphics.line( x1, y1+2, x, y)
		love.graphics.line( x1, y1-2, x, y)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setLine(2, "smooth")
		love.graphics.line( x1, y1, x, y)
		love.graphics.setColor(255, 255, 255, 80)
		love.graphics.circle("fill", x1, y1, 11, 140)
		love.graphics.setColor(230, 255, 230, 90)
		love.graphics.circle("fill", x1-2, y1+2, 6, 5)
		love.graphics.setColor(255, 0, 0, 140)
		love.graphics.circle("fill", x1-4, y1+4, 4, 50)
	end
		if ((birdx % 640)+10-x1)/(110 + 5 * math.sin(birdx/10)-y1) > (x-x1)/(y-y1) -epsilon and ((birdx % 640)+10- x1)/(110 + 5 * math.sin(birdx/10) - y1) < (x- x1)/(y - y1) + epsilon then
			local noise = love.sound.newSoundData("sounds/impact/impact_messy.wav")
			love.audio.newSource(noise, "static"):play()
			live = 0

			local s =0
			for s = 1, 40 do 
			love.graphics.setColor( 255, 255, 255, 255 )
			love.graphics.draw(gore, birdx % 640, 100 + 5 * math.sin(birdx/10))	
		end
	end
end
end
love.graphics.draw(flamingo, 0, 0)
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
end

function love.keyreleased( key, unicode )
end



function love.mousereleased( x, y, button )
if button == "l" then
			local noise = love.sound.newSoundData("sounds/gun/gun_shell.wav")
		love.audio.newSource(noise, "static"):play()
	end
end

function love.quit()
end