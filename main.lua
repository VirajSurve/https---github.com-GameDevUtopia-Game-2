require "dependencies"
require "bullets"
require "player"
require "enemies"
math.randomseed(os.time())

function love.load()
  bullets_instance = bullets()
  push:setupScreen(window_virtualwidth, window_virtualheight, window_width, window_height, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
  love.graphics.setDefaultFilter('nearest', 'nearest')
  --player:init()
  background = love.graphics.newImage("spritesheets/back.png")
end

function sqci(r,e)
  local circleDistanceX = math.abs(r.x - e.x - e.width / 2)
  local circleDistanceY = math.abs(r.y - e.y - e.width / 2)
  local cornerDistanceSq = (circleDistanceX - e.width / 2) ^ 2 +
   (circleDistanceY - e.width / 2) ^ 2
  return circleDistanceX <= (e.width / 2) or circleDistanceY <= (e.width / 2) or cornerDistanceSq <= (r.rad ^ 2)
end

function math.dist(x1,y1,x2,y2) 
  return ((x2-x1)^2+(y2-y1)^2)^0.5 
end

function collisions(t,u)
      return math.abs(t.rad-u.rad)<=math.dist(t.x,t.y,u.x,u.y) and 
      math.dist(t.x,t.y,u.x,u.y)<=math.abs(t.rad+u.rad) 
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  bullets_instance:update(dt)  -- Call update on the bullets instance
  player:update(dt)
  bullets:update(dt)
  enemies:update(dt)
  for k,v in pairs(all_enemies) do
    for j,q in pairs(all_bullets) do 
      if collisions(v,q) then
        table.remove(all_bullets,j)
        table.remove(all_enemies,k)
        player.score=player.score+100
      end
    end
  end
  for k,v in pairs(all_enemies) do
    for j,q in pairs(all_bullets) do
      if sqci(v,player) then
          table.remove(all_enemies,k)
          table.remove(player)
          table.remove(all_bullets,k)
      end
    end
  end    
end

function love.draw()
  -- Draw the background
  love.graphics.draw(background, 0, 0)
  push:start()
  bullets_instance:draw()  -- Call draw on the bullets instance
    player:draw()
    bullets:draw()
    enemies:draw()

  push:finish()

end
