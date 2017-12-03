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

function Suspect:enterNewRoom()

  if self.alive then
    for i,corpse in ipairs(self.room.corpses) do
      if not corpse.discovered then
        self.room.visible = true
        love.audio.play(assets.sounds.scream)
        corpse.discovered = true
        game.accusationPanel:suspectDead(corpse)
      end
    end
  end

end