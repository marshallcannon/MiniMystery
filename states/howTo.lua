local HowToState = {}

function HowToState:enter(from)
  self.from = from
end

function HowToState:update(dt)
  Timer.update(dt)
end

function HowToState:draw()

  --Draw Menu
  self.from:draw()

  --Draw How To
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(assets.images.howTo, 0, 0)

end

function HowToState:mousepressed(x, y, button)

  if button == 1 then
    State.pop()
  end

end

function HowToState:keypressed(key)

  State.pop()

end

return HowToState