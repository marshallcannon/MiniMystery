require 'accusationPanel/suspectButton'

local AccusationPanel = {}

AccusationPanel.opacity = 0
AccusationPanel.width = 600
AccusationPanel.potentialSuspects = {}


function AccusationPanel:draw()

  love.graphics.setColor(85, 60, 91, self.opacity)
  love.graphics.rectangle('fill', 100, 0, 600, 100)

  --Draw all living
  for i,suspectButton in ipairs(self.potentialSuspects) do
    suspectButton:draw(self.opacity)
  end

end

function AccusationPanel:addAll()

  for i,suspect in ipairs(game.suspects) do
    table.insert(self.potentialSuspects, SuspectButton(suspect))
  end
  table.insert(self.potentialSuspects, SuspectButton(game.killer))

  self.potentialSuspects = Util.shuffleArray(self.potentialSuspects)

end

function AccusationPanel:sortSuspectButtons()

  for i, suspectButton in ipairs(self.potentialSuspects) do
    suspectButton.x = 100 + i*(self.width/(#self.potentialSuspects+1))
  end

end

function AccusationPanel:suspectDead(suspect)

  for i,suspectButton in pairs(self.potentialSuspects) do
    if suspectButton.suspect == suspect then
      suspectButton.isAlive = false
    end
  end

end

function AccusationPanel:mousepressed(x, y, button)

  if button == 1 then
    for i, suspectButton in ipairs(self.potentialSuspects) do
      if x >= suspectButton.x - suspectButton.width/2 and x <= suspectButton.x + suspectButton.width/2 then
        if y >= suspectButton.y - suspectButton.height/2 and y <= suspectButton.y + suspectButton.height/2 then
          suspectButton:click()
        end
      end
    end
  end

end

return AccusationPanel