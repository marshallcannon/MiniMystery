require 'people/person'
require 'people/suspect'

Killer = Class{__includes = {Person, Suspect} }

function Killer:init(room)

  Suspect.init(self, room)
  self.color = {0, 0, 0}

end

function Killer:attack(victim)

  victim:kill()

end

function Killer:nextTurn()
  self:moveRandomly()
end

function Killer:enterNewRoom()
  
  print('Should I kill?')
  --If the player isn't here
  if game.player.room ~= self.room then
    --If we're alone with our victim
    if #self.room.people == 2 then
      --Chance to kill
      if love.math.random(1, Config.killRate) == 1 then
        --Attack!
        for i,person in ipairs(self.room.people) do
          if person ~= self then self:attack(person) end
        end
      end
    else
      print('Wrong number of people in room: '.. #self.room.people)
    end
  else
    print('The player is here')
  end

end