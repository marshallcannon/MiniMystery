Person = Class{}

function Person:init(room, image)

  self.room = room
  self.oldRoom = nil
  self.room:addPerson(self)
  self.x, self.y = self.room:getStandingPosition()
  self.width = 40
  self.height = 40
  self.color = {love.math.random(10, 245), love.math.random(10, 245), love.math.random(10, 245)}
  self.speed = 100
  self.alive = true
  self.discovered = false
  self.moveComplete = true

  self.image = image
  --Randomize appearance
  if not self.image then
    self.appearance = {love.math.random(#assets.images.bodies), love.math.random(#assets.images.skin), love.math.random(#assets.images.faces)}
    self.image = love.graphics.newCanvas(40, 40)
    love.graphics.setCanvas(self.image)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(assets.images.bodySheet, assets.images.bodies[self.appearance[1]], 0, 0)
    love.graphics.draw(assets.images.skinSheet, assets.images.skin[self.appearance[2]], 0, 0)
    love.graphics.draw(assets.images.faceSheet, assets.images.faces[self.appearance[3]], 0, 0)
    love.graphics.setCanvas()
  end

end

function Person:update(dt)

end

function Person:draw()

  love.graphics.setColor(255, 255, 255, 255)
  if self.alive then
    love.graphics.draw(self.image, self.x, self.y)
  else
    love.graphics.draw(self.image, self.x, self.y+47, -1.5708)
  end

end

function Person:nextTurn()

end

function Person:moveToRoom(nextRoom)

  self.moveComplete = false
  local goToX, goToY = nextRoom:getStandingPosition()
  local distance = Util.distance(self.x, self.y, goToX, goToY)
  local time = distance/self.speed
  Timer.tween(Config.moveTime, self, {x = goToX, y = goToY}, 'linear', function() self.moveComplete = true end)
  self.room:removePerson(self)
  self.oldRoom = self.room
  self.room = nextRoom
  self.room:addPerson(self)

end

function Person:enterNewRoom()

end

function Person:kill()

  self.alive = false
  self.room:removePerson(self)
  table.insert(self.room.corpses, self)
  table.insert(game.corpses, self)

end