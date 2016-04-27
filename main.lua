local anim8 = require('anim8')
local player

function love.load()
  local spritesheet = love.graphics.newImage('moonman.png');
  local g = anim8.newGrid(32, 32, spritesheet:getWidth(), spritesheet:getHeight())

  player = {
    spritesheet = spritesheet,
    x = 200,
    y = 200,
    speed = 200,
    animations = {
      up = anim8.newAnimation(g('2-3',1), 0.1),
      down = anim8.newAnimation(g('2-3',3), 0.1),
      left = anim8.newAnimation(g('2-3',2), 0.1),
      right =  anim8.newAnimation(g('2-3',4), 0.1),
      up_stand = anim8.newAnimation(g(1,1),0.1),
      down_stand = anim8.newAnimation(g(1,3),0.1),
      left_stand = anim8.newAnimation(g(1,2),0.1),
      right_stand = anim8.newAnimation(g(1,4),0.1)
    }
  }
  player.animation = player.animations.down_stand -- player starts looking down
end

function love.update(dt)
  if love.keyboard.isDown("up") and player.y > 0 then 
    player.y = player.y - player.speed * dt
    player.animation = player.animations.up
  elseif love.keyboard.isDown("down") then
    if player.y < (love.graphics.getHeight() - 35) then
      player.y = player.y + player.speed * dt
      player.animation = player.animations.down
    end
  elseif love.keyboard.isDown("left") and player.x > 0 then 
    player.x = player.x - player.speed * dt
    player.animation = player.animations.left
  elseif love.keyboard.isDown("right") then
    if player.x < (love.graphics.getWidth() - 32) then
      player.x = player.x + player.speed * dt
      player.animation = player.animations.right
    end
  end
  player.animation:update(dt)
end

function love.draw()
  player.animation:draw(player.spritesheet, player.x, player.y)
end

function love.keypressed(key) 
   if love.keyboard.isDown("escape") then
     love.event.quit("quit")
    end
end

function love.keyreleased(key)
  if key == 'up' then
    player.animation = player.animations.up_stand
  end
  if key == 'down' then
    player.animation = player.animations.down_stand
  end
  if key == 'left' then
    player.animation = player.animations.left_stand
  end
  if key == 'right' then
    player.animation = player.animations.right_stand
  end
end