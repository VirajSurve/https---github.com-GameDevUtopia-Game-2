player = class{}

local player_image = love.graphics.newImage('spritesheets/playerShip3_orange.png') -- Load the PNG image

player = {}
player.width = 50
player.height = 50
player.x = window_virtualwidth/2 - player.width/2
player.y = window_virtualheight/2 - player.height/2
player.speed = 500
player.rotation = 0 -- Add a rotation attribute
player.score=0

player_aim = {}
player_aim.radius = 80
theta = 0
player_aim.x = window_virtualwidth/2 - player.width/2
player_aim.y = window_virtualheight/2 - player.height/2

function player:update(dt)
  theta = theta + 5*dt
  player.rotation = player.rotation + 5*dt -- Update the rotation
  player_aim.x =  window_virtualwidth/2  + player_aim.radius * math.cos(theta)
  player_aim.y = window_virtualheight/2  + player_aim.radius * math.sin(theta)
end

function player:draw()
  -- Draw the rotating PNG image instead of a rectangle
  love.graphics.draw(player_image, player.x, player.y, player.rotation, 1, 1, player.width/2, player.height/2)
  love.graphics.circle("line", player_aim.x, player_aim.y, 10)
  love.graphics.print(player.score,0,0)
end
