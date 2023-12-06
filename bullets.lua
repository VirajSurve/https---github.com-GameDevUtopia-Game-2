bullets = class{}

local timer = 0 
local bullet_image = love.graphics.newImage('spritesheets/laserRed01.png') -- Load the PNG image

function create_bullets()
  local bullet = {}
  bullet.rad = 5
  bullet.speed = 500
  bullet.angle = theta -- Store the angle at which the bullet is fired

  -- Calculate the initial position of the bullet based on player_aim position
  bullet.x = player_aim.x + math.cos(bullet.angle) * player_aim.radius
  bullet.y = player_aim.y + math.sin(bullet.angle) * player_aim.radius

  return bullet
end

all_bullets = {}

function bullets:update(dt)
  timer = timer + dt

  if(love.keyboard.isDown("space")) then
      if(timer > 0.1) then
          table.insert(all_bullets, create_bullets())
          timer = 0
      end
  end

  for k,v in pairs(all_bullets) do
      -- Calculate the trajectory of a tangent line for the bullets' movement
      local tangentAngle = math.atan2(v.y - player_aim.y, v.x - player_aim.x)
      v.x = v.x + v.speed * math.cos(tangentAngle) * dt
      v.y = v.y + v.speed * math.sin(tangentAngle) * dt

      -- Remove bullets that go off-screen
      if(v.x > window_virtualwidth + v.rad or v.x < -v.rad) then
          table.remove(all_bullets, k)
      end
      if(v.y > window_virtualheight + v.rad or v.y < -v.rad) then
          table.remove(all_bullets, k)
      end
  end
end

function bullets:draw()
  for k,v in pairs(all_bullets) do
      -- Draw the PNG image with rotation aligned to the aim direction
      love.graphics.draw(bullet_image, v.x, v.y, v.angle, 1, 1, bullet_image:getWidth()/2, bullet_image:getHeight()/2)
  end
end
