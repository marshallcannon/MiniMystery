require 'people/person'

Suspect = Class{__includes = Person}

function Suspect:init(room)

  Person.init(self, room)

end

function Suspect:nextTurn()

  if self.alive then
    self:moveRandomly()
  end

end

function Suspect:moveRandomly()

  local nextRoom = Util.randomTableValue(self.room.connections)
  self:moveToRoom(nextRoom)

end