function love.load()
    world = love.physics.newWorld(0, 200, true)

    ball = {}
    ball.b = love.physics.newBody(world, 400,200, "dynamic")
    ball.b:setMass(10)
    ball.s = love.physics.newCircleShape(50)
end

function love.update(dt)
    world:update(dt)
    bd = 1

    if love.keyboard.isDown(" ") then
        a, b, c = math.random(255), math.random(255), math.random(255)
        love.graphics.setBackgroundColor(a, b, c)
    end

    if ball.b:getY() > 500 then 
       ball.b:applyForce(bd * 5000, -15000)
    end
    if ball.b:getX() < 100 then
       bd = 1
       ball.b:applyForce(10000, 0)
    elseif ball.b:getX() > 500 then
       bd = -1
       ball.b:applyForce(-10000, 0)
    end
end

function love.draw()
    love.graphics.circle("line", ball.b:getX(),ball.b:getY(), ball.s:getRadius(), 20)
end


