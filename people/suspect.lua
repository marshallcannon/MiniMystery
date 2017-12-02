require 'people/person'

Suspect = Class{__includes = Person}

function Suspect:init(room)

  Person.init(self, room)

end

function Suspect:moveRandomly()

  local nextRoom = Util.randomTableValue(self.room.connections)
  self:moveToRoom(nextRoom)

end