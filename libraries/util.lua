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

return Util