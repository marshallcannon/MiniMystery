require 'rooms/room'

local House = {}


function House:update()

end

function House:draw()

  for i, room in ipairs(self.rooms) do
    room:draw()
  end

end

function House:makeRooms()

  --Load rooms
  self.foyer = require 'rooms/foyer'
  self.kitchen = require 'rooms/kitchen'
  self.basement = require 'rooms/basement'
  self.pantry = require 'rooms/pantry'
  self.diningRoom = require 'rooms/diningRoom'
  self.library = require 'rooms/library'
  self.closet = require 'rooms/closet'
  self.hallway = require 'rooms/hallway'
  self.bedroom = require 'rooms/bedroom'
  self.balcony = require 'rooms/balcony'

  --Link rooms
  self.foyer.connections = {left = self.kitchen, up = self.library, down = self.basement}
  self.kitchen.connections = {up = self.pantry, right = self.foyer}
  self.basement.connections = {up = self.foyer}
  self.pantry.connections = {right = self.diningRoom, down = self.kitchen}
  self.diningRoom.connections = {left = self.pantry, up = self.hallway, right = self.library}
  self.library.connections = {left = self.diningRoom, right = self.balcony, down = self.foyer}
  self.closet.connections = {right = self.hallway}
  self.hallway.connections = {left = self.closet, right = self.bedroom, down = self.diningRoom}
  self.bedroom.connections = {left = self.hallway, right = self.balcony}
  self.balcony.connections = {left = self.library}

  --Add rooms to table
  local rooms = {}
    table.insert(rooms, self.foyer)
    table.insert(rooms, self.basement)
    table.insert(rooms, self.kitchen)
    table.insert(rooms, self.pantry)
    table.insert(rooms, self.diningRoom)
    table.insert(rooms, self.library)
    table.insert(rooms, self.closet)
    table.insert(rooms, self.hallway)
    table.insert(rooms, self.bedroom)
    table.insert(rooms, self.balcony)
  return rooms

end
House.rooms = House:makeRooms()

function House:randomRoom()
  return self.rooms[love.math.random(#self.rooms)]
end

function House:allRoomsInvisible()

  for i,room in ipairs(self.rooms) do
    room.visible = false
  end

end

function House:allRoomsVisible()

  for i,room in ipairs(self.rooms) do
    room.visible = true
  end

end

function House:resetRoomNumbers()

  for i,room in ipairs(self.rooms) do
    room.incomingPeople = 0
  end

end

return House