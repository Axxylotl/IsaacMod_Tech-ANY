local mod = RegisterMod("Tech Infinity", 1)
local TECH_INFINITY_ID = Isaac.GetItemIdByName("Tech Infinity")
--declarations
local GIVE = "giveitem c"
local REMOVE = "remove c"
local lastItem = {}
    local id = 0
for j=1, 1000 do
    lastItem[j] = 0
end

local game = Game()

function mod:randTech()
    

    local playercount = game:GetNumPlayers()
    for playerIndex = 0, playercount - 1 do
        local player = Isaac.GetPlayer(playerIndex)
        local itemcount = player:GetCollectibleNum(TECH_INFINITY_ID)

        for  i = 1, itemcount , 1 do
            local rng = player:GetCollectibleRNG(TECH_INFINITY_ID) --initializes the rng with the player's seed

            local rand = rng:RandomInt(5) --generates a random integer between 0-4
            
            if rand == 0 then   --basically a switch statement that chooses a tech item with the random number 
            id = CollectibleType.COLLECTIBLE_TECHNOLOGY
            elseif rand == 1 then 
            id = CollectibleType.COLLECTIBLE_TECHNOLOGY_2
            elseif rand == 2 then 
            id = CollectibleType.COLLECTIBLE_TECH_5
            elseif rand == 3 then 
            id = CollectibleType.COLLECTIBLE_TECH_X
            elseif rand == 4 then 
            id = CollectibleType.COLLECTIBLE_TECHNOLOGY_ZERO
            end 

            if lastItem[i] ~= 0 then 
                Isaac.ExecuteCommand(REMOVE..lastItem[i])
            end
            lastItem[i] = id   --remembers the id of the last given item
            Isaac.ExecuteCommand(GIVE..id) --executes the console command to give isaac the item
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.randTech)