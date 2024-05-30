local color = "red"
local kantoLocations = {{31.06, 5.72}, {27.87, 3.58}, {19.89, 1.62}, {21.66, -2.10}, {30.23, -4.42}, {34.62, -5.52}, {39.78, -11.15}, {41.39, 0.07}}
local chipY = 2
local hasGameStarted = false
local battleManager = "de7152"

function deal()

  self.shuffle()

  local currentLocations = kantoLocations
  for i=1, #currentLocations do
   local param = {}
   param.origin = {currentLocations[i][1], chipY, currentLocations[i][2]}
   param.direction = {0,-1,0}
   param.type = 1
   param.max_distance = 1
   param.debug = false
   hits = Physics.cast(param)
   if(#hits == 0) then
     if self.getQuantity() > 0 then
       local param2 = {}
       param2.position = param.origin
       local object = self.takeObject(param2)
       object.setRotation({180,0,0})
     end
   end
  end
end

function battle()

  local params = {
    pokeballGUID = self.getGUID()
  }

  local battleManager = getObjectFromGUID(battleManager)
  local sentToArena = battleManager.call("sendToArenaTrainer", params)

  if sentToArena then
    self.editButton({
        index=2, label="Recall", click_function="recall",
        function_owner=self, tooltip="Recall Pokémon",
    })
  end
end

function recall()
  local params = {pokeballGUID = self.getGUID()}

  local battleManager = getObjectFromGUID(battleManager)
  battleManager.call("recallTrainer", params)

  Global.call("PlayRouteMusic",{})

  self.editButton({
    index=2, label="Battle", click_function="battle",
    function_owner=self, tooltip="Send a " .. color .. " Pokémon to the arena.",
  })
end

 function collect()
   local currentLocations = kantoLocations
   for i=1, #currentLocations do
     local param = {}
     param.origin = {currentLocations[i][1], chipY, currentLocations[i][2]}
     param.direction = {0,-1,0}
     param.type = 1
     param.max_distance = 1
     param.debug = false
     hits = Physics.cast(param)
     if #hits ~= 0 then
       local obj = getObjectFromGUID(hits[1].hit_object.guid)
       if obj.tag == "Tile" then
         self.putObject(obj)
       end
     end
   end
 end

 function begin()
   hasGameStarted = true
   createButtons()
   deal()
 end

 function onSave()
    local data_to_save = {gameStarted=hasGameStarted}
    saved_data = JSON.encode(data_to_save)
    --saved_data = "" --Remove -- at start & save to clear save data
    return saved_data
end

-- Runs when game is loaded
function onLoad(saved_data)
    -- Loads the tracking for if the game has started yet
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        hasGameStarted = loaded_data.gameStarted
        createButtons()
    end
end

function createButtons()
  if hasGameStarted then
    self.createButton({ --Apply settings button
        label="Deal", click_function="deal",
        function_owner=self, tooltip="Click to deal " .. color .. " pokemon chips to the unoccupied " .. color .." spaces.",
        position={0,-1,1.5}, rotation={0,0,0}, height=440, width=1400, font_size=200,
    })
    self.createButton({ --Apply settings button
        label="Collect", click_function="collect",
        function_owner=self, tooltip="Click to return the " .. color .. " chips to the " .. color .. " pokeball.",
        position={0,-1,2.5}, rotation={0,0,0}, height=440, width=1400, font_size=200,
    })
    self.createButton({ --Apply settings button
        label="Battle", click_function="battle",
        function_owner=self, tooltip="Send a " .. color .. " Pokémon to the arena.",
        position={0,-1,3.5}, rotation={0,0,0}, height=440, width=1400, font_size=200,
    })
  end
end