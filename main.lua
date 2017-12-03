Vector = require 'libraries/hump/vector'
Class = require 'libraries/hump/class'
Timer = require 'libraries/hump/timer'
State = require 'libraries/hump/gamestate'
Moody = require 'libraries/moody'
Util = require 'libraries/util'
Config = require 'config'
require 'people/suspect'
require 'people/player'
require 'people/killer'

MenuState = require 'states/menu'
GameState = require 'states/game'
GameOverState = require 'states/gameOver'

game = {}
game.house = require 'house'
game.suspects = {}
game.corpses = {}
game.accusationPanel = require 'accusationPanel/accusationPanel'

game.turnActive = false
game.victory = false

game.debug = false

function love.load()

  --Load assets
  assets = {}

  --Sounds
  assets.sounds = {}
  assets.sounds.scream = love.audio.newSource('assets/sound/scream.wav')

  --Images
  assets.images = {}
  assets.images.skull = love.graphics.newImage('assets/images/skull.png')
  assets.images.player = love.graphics.newImage('assets/images/player.png')
  assets.images.background = love.graphics.newImage('assets/images/background.png')
  assets.images.foreground = love.graphics.newImage('assets/images/foreground.png')

  --Sprite Sheets
  assets.images.bodySheet = love.graphics.newImage('assets/images/bodies.png')
  assets.images.skinSheet = love.graphics.newImage('assets/images/skin.png')
  assets.images.faceSheet = love.graphics.newImage('assets/images/faces.png')
  assets.images.bodies = {}
  for i=0, assets.images.bodySheet:getWidth()/40-1 do
    table.insert(assets.images.bodies, love.graphics.newQuad(i*40, 0, 40, 40, assets.images.bodySheet:getDimensions()))
  end
  assets.images.skin = {}
  for i=0, assets.images.skinSheet:getWidth()/40-1 do
    table.insert(assets.images.skin, love.graphics.newQuad(i*40, 0, 40, 40, assets.images.skinSheet:getDimensions()))
  end
  assets.images.faces = {}
  for i=0, assets.images.faceSheet:getWidth()/40-1 do
    table.insert(assets.images.faces, love.graphics.newQuad(i*40, 0, 40, 40, assets.images.faceSheet:getDimensions()))
  end

  --Fonts
  assets.fonts = {}
  assets.fonts.big = love.graphics.newFont('assets/fonts/Digory_Doodles_PS.ttf', 40)
  assets.fonts.medium = love.graphics.newFont('assets/fonts/Digory_Doodles_PS.ttf', 30)
  assets.fonts.small = love.graphics.newFont('assets/fonts/Digory_Doodles_PS.ttf', 15)

  --Create People
  game.player = Player(game.house:randomRoom())
  game.killer = Killer(game.house:randomRoom())
  for i=1, Config.numberOfSuspects do
    table.insert(game.suspects, Suspect(game.house:randomRoom()))
  end

  game.started = false

  State.registerEvents()
  State.switch(GameState)

end

function game:startGame()

  game.started = true
  for i,room in ipairs(game.house.rooms) do
    room.visible = false
  end
  game.player.room.visible = true

  game.accusationPanel:addAll()
  game.accusationPanel:sortSuspectButtons()
  Timer.tween(1, game.accusationPanel, {opacity = 255}, 'linear')

end

function game:isTurnComplete()

  for i,suspect in ipairs(self.suspects) do
    if not suspect.moveComplete then return false end
  end
  if not game.killer.moveComplete then return false end
  if not game.player.moveComplete then return false end
  return true

end

function game:accuse(suspect)
  
  if suspect == game.killer then
    game.victory = true
  else
    game.victory = false
  end
  State.push(GameOverState)

end

game.desaturate = love.graphics.newShader( [[
  vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    number average = (pixel.r+pixel.b+pixel.g)/3.0;
    pixel.r = average;
    pixel.g = average;
    pixel.b = average;
    return pixel;
  }
]])