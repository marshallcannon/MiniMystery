Person = Class{}

function Person:init(room)

  self.room = room
  self.room:addPerson(self)
  self.x, self.y = self.room:getStandingPosition()
  self.width = 40
  self.height = 40
  self.color = {love.math.random(10, 245), love.math.random(10, 245), love.math.random(10, 245)}
  self.speed = 100
  self.alive = true

end

function Person:update(dt)

end

function Person:draw()

  if self.alive then
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  else
    love.graphics.setColor({255, 0, 0})
    love.graphics.rectangle('fill', self.x, self.y+self.height/2, self.width, self.height/2)
  end

end

function Person:nextTurn()

end

function Person:moveToRoom(nextRoom)

  local goToX, goToY = nextRoom:getStandingPosition()
  local distance = Util.distance(self.x, self.y, goToX, goToY)
  local time = distance/self.speed
  Timer.tween(time, self, {x = goToX, y = goToY}, 'linear', function() self:enterNewRoom() end)
  self.room:removePerson(self)
  self.room = nextRoom
  self.room:addPerson(self)

end

function Person:enterNewRoom()

end

function Person:kill()

  self.alive = false
  self.room:removePerson(self)

end