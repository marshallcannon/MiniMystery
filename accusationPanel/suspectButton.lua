SuspectButton = Class{}

function SuspectButton:init(suspect)

  self.x = 0
  self.y = 50
  self.width = 40
  self.height = 40
  self.suspect = suspect
  self.color = suspect.color
  self.isAlive = true

end

function SuspectButton:draw(opacity)

  love.graphics.setColor(self.color[1], self.color[2], self.color[3], opacity)
  love.graphics.rectangle('fill', self.x-self.width/2, self.y-self.height/2, self.width, self.height)

  if not self.isAlive then
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(assets.images.skull, self.x-self.width/2, self.y-self.height/2)
  end

end

function SuspectButton:click()

  if self.isAlive then
    game:accuse(self.suspect)
  end

end