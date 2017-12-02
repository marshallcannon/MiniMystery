Vector = require 'libraries/hump/vector'
Class = require 'libraries/hump/class'
Timer = require 'libraries/hump/timer'
GameState = require 'libraries/hump/gamestate'
Moody = require 'libraries/moody'
Util = require 'libraries/util'
require 'people/suspect'
require 'people/player'

game = {}
game.house = require 'house'
game.suspects = {}

function love.load()

  game.player = Player(game.house.foyer)
  for i=1, 9 do 
    local randomRoom = game.house.rooms[love.math.random(#game.house.rooms)]
    table.insert(game.suspects, Suspect(randomRoom))
  end

end

function love.update(dt)

  Timer.update(dt)

end

function love.draw()

  game.house:draw()
  for i, suspect in ipairs(game.suspects) do
    suspect:draw()
  end
  game.player:draw()

end

function love.keypressed(key)
  game.player:keypressed(key)
end