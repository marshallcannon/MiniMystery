local GameOverState = {}

function GameOverState:init()

  self.victoryText = love.graphics.newText(assets.fonts.big, 'Good show ol\' chap!')
  self.defeatText = love.graphics.newText(assets.fonts.big, 'Very disappointing\n      detective!')
  self.scoreText = love.graphics.newText(assets.fonts.medium, '')
  self.againText = love.graphics.newText(assets.fonts.medium, 'Again?')
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
  love.graphics.setColor(50, 50, 50, 200)
  love.graphics.rectangle('fill', self.graphicsAnchor.x-self.victoryText:getWidth()/2+200, self.graphicsAnchor.y-self.victoryText:getHeight()/2+50, 620, 200)
  love.graphics.setColor(255, 255, 255, 255)
  if game.victory then
    love.graphics.draw(self.victoryText, self.graphicsAnchor.x-self.victoryText:getWidth()/2+200, self.graphicsAnchor.y-self.victoryText:getHeight()/2+75)
    self.scoreText:set('Only ' .. game.accusationPanel:getScore() .. ' deaths!')
    love.graphics.draw(self.scoreText, self.graphicsAnchor.x-self.scoreText:getWidth()/2+200, self.graphicsAnchor.y-self.scoreText:getHeight()/2+150)
  else
    love.graphics.draw(self.defeatText, self.graphicsAnchor.x-self.defeatText:getWidth()/2+200, self.graphicsAnchor.y-self.defeatText:getHeight()/2+100)
  end
  love.graphics.setColor(200, 200, 200)
  love.graphics.rectangle('fill', self.graphicsAnchor.x+100, self.graphicsAnchor.y+220, 200, 75)
  love.graphics.setColor(0, 0, 0)
  love.graphics.draw(self.againText, self.graphicsAnchor.x+200-self.againText:getWidth()/2, self.graphicsAnchor.y+220)
  
end

function GameOverState:mousepressed(x, y, button)

  if button == 1 then
    if x >= self.graphicsAnchor.x+100 and x <= self.graphicsAnchor.x+300 then
      game:restart()
      State:pop()
    end
  end

end

function GameOverState:leave()
  
  Timer.tween(0.5, self.graphicsAnchor, {y = -250}, 'in-out-quad')

end

return GameOverState