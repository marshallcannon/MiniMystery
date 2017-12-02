require 'people/person'

Player = Class{__includes = Person}

function Player:init(room)

  Person.init(self, room)
  self.color = {255, 255, 255, 255}

end

function Player:keypressed(key)

  if key == 'a' or key == 'left' then
    if self.room.connections.left then
      self:moveToRoom(self.room.connections.left)
    end
  elseif key == 'w' or key == 'up' then
    if self.room.connections.up then
      self:moveToRoom(self.room.connections.up)
    end
  elseif key == 'd' or key == 'right' then
    if self.room.connections.right then
      self:moveToRoom(self.room.connections.right)
    end
  elseif key == 's' or key == 'down' then
    if self.room.connections.down then
      self:moveToRoom(self.room.connections.down)
    end
  end

end

function Player:moveToRoom(nextRoom)

  --Move all suspects
  for i, suspect in ipairs(game.suspects) do
    suspect:nextTurn()
  end
  game.killer:nextTurn()
  Person.moveToRoom(self, nextRoom)

end