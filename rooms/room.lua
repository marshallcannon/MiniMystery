Room = Class{}

function Room:init(x, y, connections)

  self.x = x or 0
  self.y = y or 0
  self.width = 100
  self.height = 100
  self.color = {love.math.random(50, 100), love.math.random(50, 100), love.math.random(50, 100)}
  self.connections = {}
  self.people = {}
  self.corpses = {}
  self.visible = true

end

function Room:update(dt)

end

function Room:draw()

  if self.width and self.height then
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  end

  if not self.visible then
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  end

end

function Room:getStandingPosition()

  return love.math.random(self.x + 10, self.x + self.width - 50), self.y + self.height - 40

end

function Room:addPerson(person)
  table.insert(self.people, person)
  return self.people
end

function Room:removePerson(person)
  for i,occupant in ipairs(self.people) do
    if occupant == person then
      table.remove(self.people, i)
      return true
    end
  end
  return false
end