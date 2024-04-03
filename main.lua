local mod = RegisterMod("Tech Infinity", 1)
local TECH_INFINITY_ID = Isaac.GetItemIdByName("Tech Infinity")
--declarations
local GIVE = "giveitem c"
local REMOVE = "remove c"
local lastItem = 0

local game = Game()

function mod:randTech()
    if lastItem ~= 0 then   --checks if there is a last item and removes it if that is the case
        Isaac.ExecuteCommand(REMOVE..lastItem)
    end
    local playercount = game:GetNumPlayers()

    for playerIndex = 0, playercount - 1 do
        local player = Isaac.GetPlayer(playerIndex)
        local itemcount = player:GetCollectibleNum(TECH_INFINITY_ID)

        if itemcount > 0 then
            local rng = player:GetCollectibleRNG(TECH_INFINITY_ID) --initializes the rng with the player's seed
            local id = 1

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

            lastItem = id   --remembers the id of the last given item
            Isaac.ExecuteCommand(GIVE..id) --executes the console command to give isaac the item
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.randTech)