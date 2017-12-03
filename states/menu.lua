local MenuState = {}

function MenuState:init()

  self.title = love.graphics.newText(assets.fonts.big, 'Mini Mystery')
  self.beginText = love.graphics.newText(assets.fonts.medium, 'Begin')
  self.howToText = love.graphics.newText(assets.fonts.small, 'How to play')

end

function MenuState:enter(from)
  self.from = from
end

function MenuState:update(dt)
  Timer.update(dt)
end

function MenuState:draw()

  --Draw main game
  self.from:draw()

  --Draw menu
  love.graphics.setColor(0, 0, 0, 180)
  love.graphics.rectangle('fill', 0, 0, 800, 600)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.title, 400-self.title:getWidth()/2, 100)

  love.graphics.setColor(68, 214, 75)
  love.graphics.rectangle('fill', 310, 300, 180, 80)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.beginText, 400-self.beginText:getWidth()/2, 305)
  
  love.graphics.setColor(189, 107, 239)
  love.graphics.rectangle('fill', 310, 400, 180, 60)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.howToText, 400-self.howToText:getWidth()/2, 410)

  love.graphics.print('A game by Marshall Cannon', 5, 540)
  love.graphics.print('Twitter: @marshall_cannon', 5, 560)
  love.graphics.print('Made with Löve! Love2d.org', 5, 580)


end

function MenuState:mousepressed(x, y, button)

  if button == 1 then

    if x >= 310 and x <= 310+180 then
      if y >= 300 and y <= 300+80 then
        State.pop()
      end
    end

    if x >= 310 and x <= 310+180 then
      if y >= 400 and y <= 400+60 then
        State.push(HowToState)
      end
    end

  end

end

return MenuState