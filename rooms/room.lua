Room = Class{}

function Room:init(x, y, connections)

  self.x = x or 0
  self.y = y or 0
  self.width = 100
  self.height = 100
  self.color = {love.math.random(15, 50), love.math.random(15, 50), love.math.random(15, 50)}
  self.connections = {}

end

function Room:update(dt)

end

function Room:draw()

  if self.width and self.height then
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  end

end

function Room:getStandingPosition()

  return love.math.random(self.x + 10, self.x + self.width - 50), self.y + self.height - 40

end