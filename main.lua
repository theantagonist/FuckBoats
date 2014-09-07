function collide(a, b, coll)
   boat.body:setGravityScale(5)
end

function reset_boat()
   boat.hits = 0
   boat.image = boat_imgs[math.random(#boat_imgs)]
   local w, h = boat.image:getWidth(), boat.image:getHeight()

   boat.shape = love.physics.newRectangleShape(w, h)
   boat.body = love.physics.newBody(world, width, waterline, "dynamic")

   boat.body:setMass(20)
   boat.body:setGravityScale(0)

   boat.fixture = love.physics.newFixture(boat.body, boat.shape)
end

function reset_bird()
   bird.idx = math.random(#bird_imgs)
   bird.image = bird_imgs[bird.idx][1]
   local w, h = bird.image:getWidth(), bird.image:getHeight()

   bird.body = love.physics.newBody(world, 0, 0, "dynamic")
   bird.body:setX(width)
   bird.body:setY(airline)
   bird.shape = love.physics.newCircleShape(w < h and w or h)
   -- bird.shape = love.physics.newRectangleShape(w, h / 2)

   bird.body:setMass(10)
   bird.body:setGravityScale(0)

   bird.fixture = love.physics.newFixture(bird.body, bird.shape)
end

function love.load()
   love.physics.setMeter(70)
   world = love.physics.newWorld(0, 680, true)
   world:setCallbacks(collide, nil, nil, nil)
   backgroundImage = love.graphics.newImage("bitmaps/background.png")

   width = backgroundImage:getWidth()
   height = backgroundImage:getHeight()
   love.window.setMode(width, height)

   math.randomseed(os.time())
   waterline = 400
   airline = 80

   boat_imgs = {
      love.graphics.newImage("bitmaps/ship.png"),
      love.graphics.newImage("bitmaps/police.png"),
      love.graphics.newImage("bitmaps/sail.png"),
   }

   bird_imgs = {
      {
         love.graphics.newImage("bitmaps/flamingotest.png"), 
         love.graphics.newImage("bitmaps/flamingo_crash.png"), 
      }
   }

   boat = {}
   reset_boat()

   bird = {}
   reset_bird()

   local squak = love.audio.newSource("sounds/ambient/background.wav")
   squak:setLooping(true)
   squak:play()
end

function love.mousepressed(x, y, button)
   if button == "l" then
      bird.image = bird_imgs[bird.idx][2]
      bird.body:applyForce(0, 680)
      bird.body:setGravityScale(1)
   end
end

function love.update(dt)
   world:update(dt)
end

function draw_cursor()
   local x, y = love.mouse.getX(), love.mouse.getY()

   love.mouse.setVisible(invisible)
   love.graphics.setColor(0, 0, 0, 0x7f)
   love.graphics.circle("line", x, y, 10, 100)
   love.graphics.line(x + 12, y, x - 12, y)
   love.graphics.line(x, y + 12, x, y - 12)
end

function draw_boat()
   local bounce = 800 * (math.random(3) - 2)
   local x, y = boat.body:getX(), boat.body:getY()
   local w, h = boat.image:getWidth(), boat.image:getHeight()
   x = x - w / 2
   y = y - h / 2

   if x + w / 2 < -50 or y - h / 2 > height + 50 then
      reset_boat()
      reset_bird()
   end
   if y > waterline then
      bounce = -1000
   elseif y + boat.image:getHeight() < waterline then
      bounce = 1000
   end

   boat.body:applyLinearImpulse(-2, 0)
   boat.body:applyForce(0, bounce)
   love.graphics.draw(boat.image, x, y)
   -- love.graphics.polygon("line", boat.body:getWorldPoints(boat.shape:getPoints()))
end

function draw_bird()
   local bounce = 800 * (math.random(3) - 2)
   local x, y = bird.body:getX(), bird.body:getY()
   local w, h = bird.image:getWidth(), bird.image:getHeight()
   x = x - w / 2
   y = y - h / 2

   if x + bird.image:getWidth() < -50 or y > height + 50 then
      reset_bird()
   end

   bird.body:applyLinearImpulse(-3, 0)
   -- bird.body:applyForce(0, bounce)
   love.graphics.draw(bird.image, x, y)
   -- love.graphics.circle("line", bird.body:getX(),bird.body:getY(), bird.shape:getRadius(), 20)
end

function love.draw()
   love.graphics.setColor(0xff, 0xff, 0xff)
   love.graphics.draw(backgroundImage, 0, 0)

   draw_boat()
   draw_bird()
   draw_cursor()
end
