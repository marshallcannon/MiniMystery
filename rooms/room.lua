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
  self.incomingPeople = 0

end

function Room:update(dt)

end

function Room:draw()

  if not self.visible then
    love.graphics.setColor(0, 0, 0, 200)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  end

end

function Room:getStandingPosition()

  local x = self.x+self.incomingPeople*20
  if x > self.x + self.width-30 then x = self.x + self.width-30 end
  local y = self.y + self.height - 40
  self.incomingPeople = self.incomingPeople + 1
  return x, y

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