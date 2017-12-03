SuspectButton = Class{}

function SuspectButton:init(suspect)

  self.x = 0
  self.y = 50
  self.width = 25
  self.height = 40
  self.suspect = suspect
  self.color = suspect.color
  self.isAlive = true
  self.selected = false
  self.symbol = 0

end

function SuspectButton:update()

  local mouseX, mouseY = love.mouse:getPosition()
  self.selected = false
  if mouseX >= self.x-self.width/2 and mouseX <= self.x+self.width/2 then
    if mouseY >= self.y-self.height/2 and mouseY <= self.y+self.height/2 then
      self.selected = true
    end
  end

end

function SuspectButton:draw(opacity)

  if self.isAlive then

    love.graphics.setColor(255, 255, 255, opacity)
    love.graphics.draw(self.suspect.image, self.x-20, self.y-self.height/2)

    --Draw symbol
    if self.symbol == 0 then
      love.graphics.setColor(0, 0, 0, 0)
    elseif self.symbol == 1 then
      love.graphics.setColor(79, 226, 94, opacity)
    elseif self.symbol == 2 then
      love.graphics.setColor(255, 255, 66, opacity)
    elseif self.symbol == 3 then
      love.graphics.setColor(249, 42, 42, opacity)
    end
    love.graphics.circle('fill', self.x, self.y-25, 5)

    --Selection rectangle
    if self.selected then
      love.graphics.setColor(255, 255, 255, opacity)
      love.graphics.rectangle('line', self.x-self.width/2, self.y-self.height/2, self.width, self.height)
    end

  else

    love.graphics.setShader(game.desaturate)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.suspect.image, self.x-20, self.y-self.height/2)
    love.graphics.setShader()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(assets.images.skull, self.x-7, self.y-32)

  end

end

function SuspectButton:click(button)

  if button == 1 then
    if self.isAlive then
      game:accuse(self.suspect)
    end
  elseif button == 2 then
    if self.symbol < 3 then
      self.symbol = self.symbol + 1
    else
      self.symbol = 0
    end
  end

end