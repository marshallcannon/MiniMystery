Vector = require 'libraries/hump/vector'
Class = require 'libraries/hump/class'
Timer = require 'libraries/hump/timer'
GameState = require 'libraries/hump/gamestate'
Moody = require 'libraries/moody'
Util = require 'libraries/util'
Config = require 'config'
require 'people/suspect'
require 'people/player'
require 'people/killer'

game = {}
game.house = require 'house'
game.suspects = {}

game.debug = false

function love.load()

  game.player = Player(game.house:randomRoom())
  game.killer = Killer(game.house:randomRoom())
  for i=1, 8 do
    table.insert(game.suspects, Suspect(game.house:randomRoom()))
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
  game.killer:draw()
  game.player:draw()

end

function love.keypressed(key)
  game.player:keypressed(key)
end