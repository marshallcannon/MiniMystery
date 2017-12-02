Person = Class{}

function Person:init(room)

  self.room = room
  self.x, self.y = self.room:getStandingPosition()
  self.width = 40
  self.height = 40
  self.color = {love.math.random(10, 245), love.math.random(10, 245), love.math.random(10, 245)}
  self.speed = 100

end

function Person:update(dt)

end

function Person:draw()

  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

end

function Person:moveToRoom(nextRoom)

  local goToX, goToY = nextRoom:getStandingPosition()
  local distance = Util.distance(self.x, self.y, goToX, goToY)
  local time = distance/self.speed
  Timer.tween(time, self, {x = goToX, y = goToY}, 'linear')
  self.room = nextRoom

end