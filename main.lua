local mod = RegisterMod("Tech Infinity", 1)
local TECH_INFINITY_ID = Isaac.GetItemIdByName("Tech Infinity")
local GIVE = "giveitem c"
local REMOVE = "remove c"
local lastItem = 0
local game = Game()

function mod:randTech()
    if lastItem ~= 0 then
        Isaac.ExecuteCommand(REMOVE..lastItem)
    end
    local playercount = game:GetNumPlayers()

    for playerIndex = 0, playercount - 1 do
        local player = Isaac.GetPlayer(playerIndex)
        local itemcount = player:GetCollectibleNum(TECH_INFINITY_ID)

        if itemcount > 0 then
            local rng = player:GetCollectibleRNG(TECH_INFINITY_ID)
            local id = 1

            local rand = rng:RandomInt(5)
            
            if rand == 0 then
            id = 68
            elseif rand == 1 then 
            id = 152
            elseif rand == 2 then 
            id = 244
            elseif rand == 3 then 
            id = 395
            elseif rand == 4 then 
            id = 524
            end 

            lastItem = id
            Isaac.ExecuteCommand(GIVE..id)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.randTech)