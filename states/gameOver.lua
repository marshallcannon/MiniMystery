local GameOverState = {}

function GameOverState:init()

  self.victoryText = love.graphics.newText(assets.fonts.big, 'Good show ol\' chap!')
  self.defeatText = love.graphics.newText(assets.fonts.big, 'Very disappointing detective!')
  self.graphicsAnchor = {x = 200, y = -250}

end

function GameOverState:enter(from)
  self.from = from
  Timer.tween(0.5, self.graphicsAnchor, {y = 200}, 'in-out-quad')
end

function GameOverState:update(dt)

  Timer.update(dt)

end

function GameOverState:draw()

  self.from:draw()
  --Darken screen
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, 800, 600)

  --Draw message
  love.graphics.setColor(255, 255, 255, 255)
  if game.victory then
    love.graphics.draw(self.victoryText, self.graphicsAnchor.x-self.victoryText:getWidth()/2+200, self.graphicsAnchor.y-self.victoryText:getHeight()/2+100)
  else
    love.graphics.draw(self.defeatText, self.graphicsAnchor.x-self.defeatText:getWidth()/2+200, self.graphicsAnchor.y-self.defeatText:getHeight()/2+100)
  end
  
end

function GameOverState:leave()
  
  Timer.tween(0.5, self.graphicsAnchor, {y = -250}, 'in-out-quad')

end

return GameOverState