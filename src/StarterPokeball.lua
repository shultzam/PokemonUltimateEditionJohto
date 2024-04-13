local pokeballs = {"ec1e4b", "9c4411", "c988ea", "2cf16d", "986cb5", "f66036", "e46f90" }
local evoPokeballs = {"757125", "6fd4a0", "23f409", "caf1c8", "35376b"}
local gyms = {"20bcd5", "ec01e5", "f2f4fe", "d8dc51", "22cc88", "b564fd", "c4bd30", "c9dd73" }

local gen1Pokeballs = {"681d76", "d7d981", "818525", "30391b", "758036", "bb73fd", "78fdbb" }
local gen1EvoPokeballs = {"e9d043", "7de53d", "f30baf", "ceb9a5", "5293ec"}
local gen1LeadersArr = {"1adc9d", "8b26e1", "3ddf5f"}

local gen2Pokeballs = {"d87f03", "2fd969", "2c76f4", "710bab", "521e8b", "9f4fb9", "f5d806" }
local gen2EvoPokeballs = {"c6e80b", "d86df8", "f59319", "538c67", "6f201a"}
local gen2LeadersArr = {"d6be18", "c3650f", "ec20b2"}

local gen3Pokeballs = {"e05c61", "b3ede1", "80c3c3", "5ded3e", "4f4570", "ee7d71", "feea6b" }
local gen3EvoPokeballs = {"31b1ec", "9b3ecb", "613cb1", "1b49a8", "8d3dfb"}
local gen3LeadersArr = {"797253", "61d7e4", "2a9746"}

local gen4Pokeballs = {"be7627", "8079e7", "49e675", "f7a234", "fadfc3", "a63903", "9f5985" }
local gen4EvoPokeballs = {"cccfb4", "e15056", "24a5c8", "a7d340", "bfb915"}

local customPokeballs = {"a927cf", "acd90d", "63bb92", "88b157", "8aaeef", "915bb4", "47780a" }
local customEvoPokeballs = {"95fee8", "8a1c9a", "7f2cd7", "0d33b3", "8faab4"}
local customLeadersArr = {"ab33b9", "f6be1f", "be2f56"}

function onLoad()
    self.createButton({ --Apply settings button
    label="Settings", click_function="settings",
    function_owner=self, tooltip="Setup Game",
    position={15.2,-0.1,-41.2}, rotation={0,0,0}, height=600, width=2000, font_size=300,
  })
end

function beginSetup2(params)
    -- tokens
    if params.selectedGens[1] then
        setupPokeballs(gen1Pokeballs, pokeballs)
        setupPokeballs(gen1EvoPokeballs, evoPokeballs)
    end
    
    if params.selectedGens[2] then
        setupPokeballs(gen2Pokeballs, pokeballs)
        setupPokeballs(gen2EvoPokeballs, evoPokeballs)
    end
    
    if params.selectedGens[3] then
        setupPokeballs(gen3Pokeballs, pokeballs)
        setupPokeballs(gen3EvoPokeballs, evoPokeballs)
    end

    if params.selectedGens[4] then
        setupPokeballs(gen4Pokeballs, pokeballs)
        setupPokeballs(gen4EvoPokeballs, evoPokeballs)
    end

    if params.customGen then
        setupPokeballs(customPokeballs, pokeballs)
        setupPokeballs(customEvoPokeballs, evoPokeballs)
    end
    
    local blueRack = getObjectFromGUID("b366ea")
    local greenRack = getObjectFromGUID("517511")
    local orangeRack = getObjectFromGUID("341ead")
    local purpleRack = getObjectFromGUID("a990ef")
    local redRack = getObjectFromGUID("06c308")
    local yellowRack = getObjectFromGUID("fc9c59")
    local reversiChip = getObjectFromGUID("97021e")
    
    local genParams = {
        genOne = params.selectedGens[1],
        genTwo = params.selectedGens[2],
        genThree = params.selectedGens[3],
        genFour = params.selectedGens[4],
    }
    
    blueRack.call("setGen", genParams)
    greenRack.call("setGen", genParams)
    orangeRack.call("setGen", genParams)
    purpleRack.call("setGen", genParams)
    redRack.call("setGen", genParams)
    yellowRack.call("setGen", genParams)
    
     -- delete Saves on starting
     local tmpelite4Gym = getObjectFromGUID("a0f650")
     local tmprivalGym = getObjectFromGUID("c970ca")
     tmpelite4Gym.call("deleteSave")
     tmprivalGym.call("deleteSave")
     -- gyms
    if params.leadersGen == 1 then
        setupGyms(gen1LeadersArr)
    elseif params.leadersGen == 2 then
        setupGyms(gen2LeadersArr)
    elseif params.leadersGen == 3 then
        setupGyms(gen3LeadersArr)
    elseif params.leadersGen == 0 then
        setupGyms(customLeadersArr)
    elseif params.leadersGen == -1 then -- random leaders
        
        local gen
        local gymPokeballs = {gen1LeadersArr[1], gen2LeadersArr[1], gen3LeadersArr[1]}
        for i = 1, 8 do
            gen = math.random(1,#gymPokeballs)
            local gymsPokeball = getObjectFromGUID(gymPokeballs[gen])
            local gym = getObjectFromGUID(gyms[i])
            local cardIndex = 8-i
            local leader = gymsPokeball.takeObject({index=cardIndex})
            gym.putObject(leader)
            gym.call("setLeaderGUID", {leader.guid})
        end
        
        local eliteFourPokeballs = {gen1LeadersArr[2], gen2LeadersArr[2], gen3LeadersArr[2]}
        local elite4Gym = getObjectFromGUID("a0f650")
        for i = 1, 4 do
            gen = math.random(1,#eliteFourPokeballs)
            local elite4Pokeball = getObjectFromGUID(eliteFourPokeballs[math.random(1,#eliteFourPokeballs)])
            elite4Pokeball.shuffle()
            local leader = elite4Pokeball.takeObject({})
            elite4Gym.putObject(leader)
            elite4Gym.call("setLeaderGUID", {leader.guid})
        end
        
        local rivalPokeballs = {gen1LeadersArr[3], gen2LeadersArr[3], gen3LeadersArr[3]}
        local rivalGym = getObjectFromGUID("c970ca")
        gen = math.random(1,#rivalPokeballs)
        local rivalPokeball = getObjectFromGUID(rivalPokeballs[math.random(1,#rivalPokeballs)])
        rivalPokeball.shuffle()
        local leader = rivalPokeball.takeObject({})
        rivalGym.putObject(leader)
        rivalGym.call("setLeaderGUID", {leader.guid})
    end
    
    self.removeButton(0)
    
    if params.randomStarters then
        
        Wait.condition(onSetupFinished, function() return not self.spawning and not self.loading_custom end)
        
    else
        self.createButton({ --Apply settings button
        label="Start Game", click_function="start",
        function_owner=self, tooltip="Click to start game. Only click this when every player has a starter Pokémon.",
        position={15.2,-0.1,-41.2}, rotation={0,0,0}, height=600, width=2000, font_size=300,
    })
end
end

function onSetupFinished()
    print('Ready!')
    
    self.shuffle()
    self.deal(1)
    start()
end

-- Moves tokens from one group of Pokeballs to another group of Pokeballs
function setupPokeballs( pokeballArr, targetPokeballArr )
    
    for i = 1, #pokeballArr do
        local pokeball = getObjectFromGUID(pokeballArr[i])
        local targetPokeball = getObjectFromGUID(targetPokeballArr[i])
        for j = 1, #pokeball.getObjects() do
            targetPokeball.putObject(pokeball.takeObject({}))
        end
    end
end

-- Moves gym leader cards into respective gyms
function setupGyms( leadersArr )
    
    local leader
    local gymsPokeball = getObjectFromGUID(leadersArr[1])
    for i = 1, 8  do
        local gym = getObjectFromGUID(gyms[i])
        leader = gymsPokeball.takeObject({})
        gym.putObject(leader)
        gym.call("setLeaderGUID", {leader.guid})
    end
    
    local elite4Gym = getObjectFromGUID("a0f650")
    local elite4Pokeball = getObjectFromGUID(leadersArr[2])
    for i = 1, #elite4Pokeball.getObjects() do
        leader = elite4Pokeball.takeObject({})
        elite4Gym.putObject(leader)
        elite4Gym.call("setLeaderGUID", {leader.guid})
    end
    
    local rivalGym = getObjectFromGUID("c970ca")
    local rivalPokeball = getObjectFromGUID(leadersArr[3])
    for i = 1, #rivalPokeball.getObjects() do
        leader = rivalPokeball.takeObject({})
        rivalGym.putObject(leader)
        rivalGym.call("setLeaderGUID", {leader.guid})
    end
    
end


function start()
    
    local pinkPokeball = getObjectFromGUID("9c4411")
    local greenPokeball = getObjectFromGUID("c988ea")
    local bluePokeball = getObjectFromGUID("2cf16d")
    local yellowPokeball = getObjectFromGUID("986cb5")
    local redPokeball = getObjectFromGUID("f66036")
    local legendaryPokeball = getObjectFromGUID("e46f90")
    
    self.removeButton(0)
    
    local itemDeck = getObjectFromGUID("30f8c1")
    local eventDeck = getObjectFromGUID("656d8c")
    local tmDeck = getObjectFromGUID("875e79")
    itemDeck.shuffle()
    eventDeck.shuffle()
    tmDeck.shuffle()
    
    local pinkPokeball = getObjectFromGUID("9c4411")
    -- Move Starter Pokémon to Pink Pokéball
    for _ = 1, #self.getObjects() do
        local starterPokemon = self.takeObject({})
        if starterPokemon.getDescription() == "Starter Only" then
            starterPokemon.destruct()
        else
            pinkPokeball.putObject(starterPokemon)
        end
    end
    
    Global.call("PlayRouteMusic", {})
    
    -- Deal out all pokeballs
    local dealGreen = function() greenPokeball.call("begin") end
    local dealBlue = function() bluePokeball.call("begin") end
    local dealYellow = function() yellowPokeball.call("begin") end
    local dealRed = function() redPokeball.call("begin") end
    local dealLegendary = function() legendaryPokeball.call("begin") end
    local destroy = function() self.destruct() end
    
    pinkPokeball.call("begin")
    Wait.time(dealGreen, 2)
    Wait.time(dealBlue, 4)
    Wait.time(dealYellow, 6)
    Wait.time(dealRed, 8)
    Wait.time(dealLegendary, 10)
    Wait.time(destroy, 10)
end

function settings()
    Global.call("ShowSettingsPopup",{})
end

function hasEnoughCustomLeaders()
    local gymLeadersPokeball = getObjectFromGUID(customLeadersArr[1])
    local gymLeaders = gymLeadersPokeball.getObjects()
    local eliteFourPokeball = getObjectFromGUID(customLeadersArr[2])
    local eliteFour = eliteFourPokeball.getObjects()
    local rivalPokeball = getObjectFromGUID(customLeadersArr[3])
    local rival = rivalPokeball.getObjects()
    
    local enoughCards = (#gymLeaders == 8 and #eliteFour > 0 and #rival > 0)
    if enoughCards == false then
        print("-------------WARNING-------------")
        print("Unable to load Custom Gym Leaders")
        if #gymLeaders != 8 then
            print("8 Gym Leaders Required for Custom Leaders (you have " .. #gymLeaders .. ")")
        end
        if #eliteFour == 0 then
            print("At least 1 Elite Four Required for Custom Leaders")
        end
        if #rival == 0 then
            print("At least 1 Rival Required for Custom Leaders")
        end
    end
    
    return enoughCards
end