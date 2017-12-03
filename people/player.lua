require 'people/person'

Player = Class{__includes = Person}

function Player:init(room)

  Person.init(self, room, assets.images.player)
  self.color = {255, 255, 255, 255}
  self.inputOn = true

end

function Player:keypressed(key)

  if self.inputOn then
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

end

function Player:moveToRoom(nextRoom)

  if not game.started then
    game:startGame()
  end

  --Move all suspects
  for i, suspect in ipairs(game.suspects) do
    suspect:nextTurn()
  end
  game.killer:nextTurn()
  Person.moveToRoom(self, nextRoom)
  self.inputOn = false
  game.turnActive = true
  
  --Room visibility
  game.house:allRoomsInvisible()
  self.oldRoom.visible = true
  nextRoom.visible = true

end

function Player:enterNewRoom()

  for i,corpse in ipairs(self.room.corpses) do
    if not corpse.discovered then
      self.room.visible = true
      love.audio.play(assets.sounds.scream)
      corpse.discovered = true
      game.accusationPanel:suspectDead(corpse)
    end
  end

  self.oldRoom.visible = false
  self.inputOn = true

end