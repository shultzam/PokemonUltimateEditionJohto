local rocketButtonPos = {-7.1, 0, 10.6}

local gymData = nil
local pokemonData = nil
local rocketData = {}
local rocketPokemonData = {}
local silphCoGUID = "19db0d"
local battleManager = "de7152"

function onSave()
end

function onLoad(saved_data)
  rocketData = Global.call("GetGymDataByGUID", {guid="559fc4"})
  rocketPokemonData = {}
  for i=1, #rocketData.pokemon do
    local newPokemon = {}
    setNewPokemon(newPokemon, rocketData.pokemon[i])
    table.insert(rocketPokemonData, newPokemon)
  end

  self.createButton({ --Apply settings button
      label="+", click_function="battleRocket",
      function_owner=self, tooltip="Start Team Rocket Battle",
      position= rocketButtonPos, rotation={0, 0, 0}, height=800, width=800, font_size=20000
  })
end

function battleRocket()
  local params = {
    trainerName = rocketData.trainerName,
    trainerGUID = rocketData.guid,
    gymGUID = silphCoGUID,
    isGymLeader = true,
    pokemon = rocketPokemonData
  }

  local battleManager = getObjectFromGUID(battleManager)
  local sentToArena = battleManager.call("sendToArenaGym", params)

  if sentToArena then
    self.editButton({
        index=1, label="-", click_function="recallRocket",
        function_owner=self, tooltip="Recall Team Rocket"
    })
  end
end

function recallRocket()
  local params = {gymGUID = silphCoGUID}

  local battleManager = getObjectFromGUID(battleManager)
  battleManager.call("recallGym", params)

  Global.call("PlayRouteMusic",{})

  self.editButton({ --Apply settings button
      index=1, label="+", click_function="battleRocket",
      function_owner=self, tooltip="Start Team Rocket Battle"
  })
end

function setLeaderGUID(params)

  --print("setting gym leader guid")
  --print(params[1])
  leaderGUID = params[1]
  gymData = Global.call("GetGymDataByGUID", {guid=leaderGUID})

  pokemonData = {}
  for i=1, #gymData.pokemon do
    local newPokemon = {}
    setNewPokemon(newPokemon, gymData.pokemon[i])
    table.insert(pokemonData, newPokemon)
  end
end

function setNewPokemon(data, newPokemonData)

  data.name = newPokemonData.name
  data.types = copyTable(newPokemonData.types)
  data.baseLevel = newPokemonData.level
  data.effects = {}

  data.moves = copyTable(newPokemonData.moves)
  local movesData = {}
  for i=1, #data.moves do
    moveData = copyTable(Global.call("GetMoveDataByName", data.moves[i]))
    moveData.status = DEFAULT
    moveData.isTM = false
    table.insert(movesData, moveData)
  end
  data.movesData = movesData
end


function copyTable (original)
    local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = copyTable(v)
		end
		copy[k] = v
	end
	return copy
end