enemies = class{}
local timer = 0
local enemy_image = love.graphics.newImage('spritesheets/shipBeige_manned.png') -- Load the PNG image

function create_enemies()
  local enemy={}
  enemy.path = math.random(100, window_virtualheight/2)
  enemy.rad = 15
  enemy.x =  window_virtualwidth/2  + enemy.path * math.cos(theta)
  enemy.y = window_virtualheight/2  + enemy.path * math.sin(theta)
  enemy.speed = 300
  enemy.theta = math.random(0, 360)
  enemy.time = 0
  return enemy
end

all_enemies = {}

function enemies:update(dt)
  timer = timer + dt
  if(timer > 3) then
    table.insert(all_enemies, create_enemies())
    timer = 0
  end

  for k,v in pairs(all_enemies) do
      v.x =  window_virtualwidth/2  + v.path * math.cos(v.theta)
      v.y = window_virtualheight/2  + v.path * math.sin(v.theta)
      v.theta = v.theta + 1*dt
      if(v.theta >= 360) then
          v.theta = 0
      end
      if(v.time>15) then
          table.remove(all_enemies, k)
      end
      v.time = v.time + dt
  end
end

function enemies:draw() 
  for k,v in pairs(all_enemies) do
      -- Draw the PNG image instead of a circle
      love.graphics.draw(enemy_image, v.x, v.y,0,0.5,0.5)
  end
end
