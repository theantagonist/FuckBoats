function love.load()
   live = 1
   backgroundImage = love.graphics.newImage("bitmaps/background.png")
   ship1 = love.graphics.newImage("bitmaps/sail.png")		
   ship2 = love.graphics.newImage("bitmaps/police.png")
   bang = love.graphics.newImage("bitmaps/explosion.png")
   flamingo = love.graphics.newImage("bitmaps/flamingotest.png")
   flamingo_corpse = love.graphics.newImage("bitmaps/flamingo_crash.png")
   gore = love.graphics.newImage("bitmaps/gore.png")
   splash = love.graphics.newImage("bitmaps/splash.png")
   local p =love.sound.newSoundData("sounds/ambient/background.wav")
   love.audio.newSource(p, "static"):play()
   --not the finished background image, but that seemed to be missing
   z = 1
   ship = 2 
   boatx = 639
   birdx = 400
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
   
   -- ye boat code
   love.graphics.setColor(255, 255, 255)
   boatx, xboat, yboat = position(boatx, 1, z, 0.75)
   if ship == 1 then
      love.graphics.draw(ship1, xboat, yboat)
      l = 240
   else if ship == 2 then
         love.graphics.draw(ship2, xboat, yboat)
         l = 500
         z = 9
        end
   end
   
   
   

   
   --fucking bird code... probabably
   if live == 1 then
      love.graphics.setColor( 255, 255, 255 )
      birdx, xbird, ybird = position(birdx, 0, 1, 2)
      love.graphics.draw(flamingo, xbird, ybird)

   else
      love.graphics.setColor( 255, 255, 255)
      love.graphics.draw(flamingo_corpse, xbird, ybird)
      xbird = xbird - 2
      ybird = ybird + birdDy/10
      birdDy = birdDy + 1

      if ybird >= 425 then
         local v = 0
         
         print(string.format("%d %d\n", xbird, xboat)) 
         if xbird - xboat < l and xbird -xboat > 0 then
            print(string.format("Yes\n"))
            local boom = love.sound.newSoundData("sounds/impact/impact_explosion.wav")
            love.audio.newSource(boom, "static"):play()
            love.graphics.setColor( 255, 255, 255, 255 )
            love.graphics.draw(bang, xboat-200, yboat-300)
            love.graphics.draw(bang, xboat-200, yboat-300)
            boatx = 639
         else
            for v = 1, 40 do 
               love.graphics.setColor( 255, 255, 255, 255 )
               love.graphics.draw(splash, xbird, ybird - v)
            end

            local noise = love.sound.newSoundData("sounds/impact/impact_splash.wav")
            love.audio.newSource(noise, "static"):play()
         end
         live = 1
         birdDy = 0
         ybird = 100
         xbird = 0
         birdx = 400
         --love.audio.setVolume(1)

         
      end
   end

   love.graphics.setColor(0, 0, 0, 150) --This shits just crosshair code
   -- love.graphics.setLine(2, "smooth") --completely unecessary
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
         for t = 1, 20 do
            love.graphics.setColor(255, 255, 255, 80)
            -- love.graphics.setLine(20, "smooth")
            love.audio.newSource(noise1, "static"):play()
            love.graphics.line( x1, y1+2, x, y)
            love.graphics.line( x1, y1-2, x, y)
            love.graphics.setColor(255, 255, 255, 255)
            -- love.graphics.setLine(2, "smooth")
            love.graphics.line( x1, y1, x, y)
            love.graphics.setColor(255, 255, 255, 80)
            love.graphics.circle("fill", x1, y1, 11, 140)
            love.graphics.setColor(230, 255, 230, 90)
            love.graphics.circle("fill", x1-2, y1+2, 6, 5)
            love.graphics.setColor(255, 0, 0, 140)
            love.graphics.circle("fill", x1-4, y1+4, 4, 50)
         end
         if (xbird+10 - x1)/(110 + 5 * ybird - y1) > (x-x1)/(y-y1) -epsilon and (xbird + 10- x1)/(ybird - y1) < (x- x1)/(y - y1) + epsilon then
            local noise = love.sound.newSoundData("sounds/impact/impact_messy.wav")
            love.audio.newSource(noise, "static"):play()
            live = 0

            local s = 0
            for s = 1, 40 do 
               love.graphics.setColor( 255, 255, 255, 255 )
               love.graphics.draw(gore, xbird, ybird)	
            end
         end
      end 

   end
   love.graphics.draw(flamingo, 0, 0)
end
function position(x, y, z, s)
   thingx = x -1*s
   x = (x % 640)*s
   y = 90 + 100 * y + 10 * z + 5 * math.sin(x/(9 + s))
   return thingx, x, y
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

require("AnAL")
function love.load()
	live = 1
	backgroundImage = love.graphics.newImage("bitmaps/background.png")
	ship1 = love.graphics.newImage("bitmaps/sail.png")		
	ship2 = love.graphics.newImage("bitmaps/police.png")
	ship3 = love.graphics.newImage("bitmaps/ship.png")
	kaboom = love.graphics.newImage("bitmaps/explosion01.png")
	bird1 = love.graphics.newImage("bitmaps/eagle.png")
	bird1_corpse = love.graphics.newImage("bitmaps/eagle_crash.png")
	bird2 = love.graphics.newImage("bitmaps/flamingotest.png")
	bird2_corpse = love.graphics.newImage("bitmaps/flamingo_crash.png")
	bird4 = love.graphics.newImage("bitmaps/albatross.png")
	bird4_corpse = love.graphics.newImage("bitmaps/albatross_crash.png")
	gore = love.graphics.newImage("bitmaps/gore.png")
	splash = love.graphics.newImage("bitmaps/splash.png")
	local p =love.sound.newSoundData("sounds/ambient/background.wav")
	love.audio.newSource(p, "static"):play()
	bang = newAnimation(kaboom, 96, 96, 0.1, 0)

	--not the finished background image, but that seemed to be missing
	z = 1
	ship = 2
	bird = 1
	xbird = 639
	boatx = 639
	birdx = 400
	birdy = 100
	birdDy = 0
	health = 3

end

function love.draw()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.draw(backgroundImage, 0, 0)
	love.mouse.setVisible(invisible)
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	local r = 10
	
	-- ye boat code
	love.graphics.setColor(255, 255, 255)
	boatx, xboat, yboat = position(boatx, 1, z, 0.75)
		if ship == 1 then
			love.graphics.draw(ship1, xboat, yboat)
			l = 240
		else if ship == 2 then
			love.graphics.draw(ship2, xboat, yboat)
			l = 500
			z = 9
			health = 9
			else if ship == 3 then
				love.graphics.setColor(255, 255, 255)
				love.graphics.draw(ship3, xboat, yboat)
				l = 500
				z = -3
				health = 12
		end
	end


end			
		
		

	
	--fucking bird code... probabably
	if live == 1 then
		love.graphics.setColor( 255, 255, 255 )
		birdx, xbird, ybird = position(birdx, 0, 1, 2)
		if bird == 1 then
			love.graphics.draw(bird1, xbird, ybird)
		elseif bird == 2 then
			love.graphics.draw(bird2, xbird, ybird)

		elseif bird == 4 then 
			love.graphics.draw(bird4, xbird, ybird)
		end
	
	else
		love.graphics.setColor( 255, 255, 255)
		
		if bird == 1 then
			love.graphics.draw(bird1_corpse, xbird, ybird)
			
		elseif bird == 2 then
			love.graphics.draw(bird2_corpse, xbird, ybird)

		elseif bird == 4 then 
			love.graphics.draw(bird4_corpse, xbird, ybird)
			
		end
			xbird = xbird - 2
			ybird = ybird + birdDy/10
			birdDy = birdDy + 1


		if ybird >= 425 then
			local v = 0
			
			print(string.format("%d %d %d\n", xbird, xboat, health)) 
			if xbird - xboat < l and xbird -xboat > 0 then
				print(string.format("Yes\n"))
				local boom = love.sound.newSoundData("sounds/impact/impact_explosion.wav")
				health = health - 1
				love.audio.newSource(boom, "static"):play()
				love.graphics.setColor( 255, 255, 255, 255 )
				bang:draw(xboat-200, yboat-300)
				
			if health > 1 then
				boatx = 639
			
			end
			else
				for v = 1, 40 do 
					love.graphics.setColor( 255, 255, 255, 255 )
					love.graphics.draw(splash, xbird, ybird - v)
				end

				local noise = love.sound.newSoundData("sounds/impact/impact_splash.wav")
				love.audio.newSource(noise, "static"):play()
			end
			live = 1
		 	birdDy = 0
			ybird = 100
			xbird = 0
			birdx = 400
			--love.audio.setVolume(1)

			
		end
	end

	love.graphics.setColor(0, 0, 0, 150) --This shits just crosshair code
	--love.graphics.setLine(2, "smooth") --completely unecessary
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
			for t = 1, 20 do
			love.graphics.setColor(255, 255, 255, 80)
			--love.graphics.setLine(20, "smooth")
			love.audio.newSource(noise1, "static"):play()
			love.graphics.line( x1, y1+2, x, y)
			love.graphics.line( x1, y1-2, x, y)
			love.graphics.setColor(255, 255, 255, 255)
			--love.graphics.setLine(2, "smooth")
			love.graphics.line( x1, y1, x, y)
			love.graphics.setColor(255, 255, 255, 80)
			love.graphics.circle("fill", x1, y1, 11, 140)
			love.graphics.setColor(230, 255, 230, 90)
			love.graphics.circle("fill", x1-2, y1+2, 6, 5)
			love.graphics.setColor(255, 0, 0, 140)
			love.graphics.circle("fill", x1-4, y1+4, 4, 50)
		end
			if (xbird+10 - x1)/(110 + 5 * ybird - y1) > (x-x1)/(y-y1) -epsilon and (xbird + 10- x1)/(ybird - y1) < (x- x1)/(y - y1) + epsilon then
				local noise = love.sound.newSoundData("sounds/impact/impact_messy.wav")
				love.audio.newSource(noise, "static"):play()
				if bird == 1 then
					local patriotism = love.sound.newSoundData("sounds/bird/eagle.wav")
					love.audio.newSource(patriotism, "static"):play()
		
 
				elseif bird == 4 then
					local albatross = love.sound.newSoundData("sounds/bird/albatross.mp3")
					love.audio.newSource(albatross, "static"):play()
				end
			end
				live = 0

				local s = 0
				for s = 1, 40 do 
				love.graphics.setColor( 255, 255, 255, 255 )
				love.graphics.draw(gore, xbird, ybird)	
			end
		end
	end 
bang:update(dt)
end

function position(x, y, z, s)
thingx = x -1*s
x = (x % 640)*s
y = 90 + 100 * y + 10 * z + 5 * math.sin(x/(9 + s))
return thingx, x, y
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
