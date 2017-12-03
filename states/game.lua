local GameState = {}

function GameState:enter()

end

function GameState:update(dt)

  Timer.update(dt)

  if game.turnActive then
    if game:isTurnComplete() then

      game.killer:enterNewRoom()
      for i,suspect in ipairs(game.suspects) do
        suspect:enterNewRoom()
      end
      game.player:enterNewRoom()
      game.turnActive = false

    end
  end

  game.accusationPanel:update()

end

function GameState:draw()

  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(assets.images.background, 0, 0)
  
  game.house:draw()

  --Draw the mask
  love.graphics.stencil(function()
    for i,room in ipairs(game.house.rooms) do
      if not room.visible then room:draw() end
    end
  end, 'replace')
  --Set mask mode
  if not game.debug then love.graphics.setStencilTest('less', 1) end
    for i, suspect in ipairs(game.suspects) do
      suspect:draw()
    end
    game.killer:draw()
  love.graphics.setStencilTest()

  game.player:draw()

  love.graphics.draw(assets.images.foreground, 0, 0)

  game.accusationPanel:draw()

end

function GameState:mousepressed(x, y, button)
  
  game.accusationPanel:mousepressed(x, y, button)

end

function GameState:keypressed(key)
  
  game.player:keypressed(key)
  
  if key == 'f1' then
    game.debug = not game.debug
  end

end

return GameState