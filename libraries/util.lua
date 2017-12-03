local Util = {}

function Util.distance(x1, y1, x2, y2)
  return ((x2-x1)^2+(y2-y1)^2)^0.5
end

function Util.randomTableValue(mappedTable)
  local array = {}
  for key, value in pairs(mappedTable) do
    table.insert(array, value)
  end
  return array[love.math.random(1, #array)]
end

function Util.shuffleArray(array)
  size = #array
  for i = size, 1, -1 do
    local rand = love.math.random(size)
    array[i], array[rand] = array[rand], array[i]
  end
  return array
end

return Util