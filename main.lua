function reset_boat()
   boat.image = boat_imgs[math.random(#boat_imgs)]
   boat.body = love.physics.newBody(world, 0, 0, "dynamic")
   boat.body:setX(width)
   boat.body:setY(waterline - boat.image:getHeight())
   boat.body:setMass(10)
   boat.body:setGravityScale(0)
   boat.body:applyForce(-50, 0)
end

function love.load()
   love.physics.setMeter(70)
   world = love.physics.newWorld(0, 680, true)
   backgroundImage = love.graphics.newImage("bitmaps/background.png")

   width = backgroundImage:getWidth()
   height = backgroundImage:getHeight()
   love.window.setMode(width, height)

   math.randomseed(os.time())
   waterline = 400

   boat_imgs = {
      love.graphics.newImage("bitmaps/ship.png"),
      love.graphics.newImage("bitmaps/police.png"),
      love.graphics.newImage("bitmaps/sail.png"),
   }

   -- water = {}
   -- water.body = love.physics.newBody(world, 0, waterline, "static")
   -- water.shape = love.physics.newRectangleShape(width, waterline)
   -- water.fixture = love.physics.newFixture(water.body, water.shape)

   boat = {}
   boat.body = love.physics.newBody(world, 0, 0, "dynamic")
   boat.image = boat_imgs[math.random(#boat_imgs)]
   boat.shape = love.physics.newRectangleShape(boat.image:getWidth(), boat.image:getHeight())
   boat.fixture = love.physics.newFixture(boat.body, boat.shape)

   reset_boat()

   local squak = love.audio.newSource("sounds/ambient/background.wav")
   squak:setLooping(true)
   squak:play()
end

function love.mousepressed(x, y, button)
   if button == "l" then
      boat.body:setGravityScale(0.1)
   end
end

function love.update(dt)
   world:update(dt)
end

function draw_cursor()
   local x, y = love.mouse.getX(), love.mouse.getY()

   love.graphics.setColor(0, 0, 0, 0x7f)
   love.graphics.circle("line", x, y, 10, 100)
   love.graphics.line(x + 12, y, x - 12, y)
   love.graphics.line(x, y + 12, x, y - 12)
end

function draw_boat()
   local bounce = 800 * (math.random(3) - 2)
   local x, y = boat.body:getX(), boat.body:getY()

   if y + boat.image:getHeight() < waterline - 10 then
      bounce = 1000
   elseif y + boat.image:getHeight() > waterline + 10 then
      bounce = -1000
   end
   if x + boat.image:getWidth() < -50 then
      reset_boat()
   end

   boat.body:applyLinearImpulse(-3, 0)
   boat.body:applyForce(0, bounce)
   love.graphics.draw(boat.image, x, y)
end

function love.draw()
   love.graphics.setColor(0xff, 0xff, 0xff)
   love.graphics.draw(backgroundImage, 0, 0)
   love.mouse.setVisible(invisible)

   draw_boat()
   draw_cursor()
end
