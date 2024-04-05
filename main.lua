local mod = RegisterMod("Tech Infinity", 1)
local TECH_INFINITY_ID = Isaac.GetItemIdByName("Tech Infinity")
--declarations
local GIVE = "giveitem c"
local REMOVE = "remove c"
local lastItem = {}

local techItems = {     --array of all the tech items
    CollectibleType.COLLECTIBLE_TECHNOLOGY, 
    CollectibleType.COLLECTIBLE_TECHNOLOGY_2, 
    CollectibleType.COLLECTIBLE_TECH_5, 
    CollectibleType.COLLECTIBLE_TECH_X, 
    CollectibleType.COLLECTIBLE_TECHNOLOGY_ZERO,
}

local id = 0

for j=1, 100 do     --sets the size of the lastItem array to 100 (should make this adaptive but don't know how yet)
    lastItem[j] = 0
end

local game = Game()


function mod:randTech() --main function, which has most of the logic for the item inside it (gives issac a random item from a list)
    

    local playercount = game:GetNumPlayers() --Determines the amount of players for coop or jacob and esau
    for playerIndex = 0, playercount - 1 do --iterates through the item logic for each individual player
        local player = Isaac.GetPlayer(playerIndex)
        local itemcount = player:GetCollectibleNum(TECH_INFINITY_ID) --Gets the amount of Tech Infinities per player

        for  i = 1, itemcount , 1 do --checks if the player has the item and gives a random tech item for each instance of Tech Infinity the player posseses
            local rng = player:GetCollectibleRNG(TECH_INFINITY_ID) --initializes the rng with the player's seed

            local rand = rng:RandomInt(#techItems) + 1--generates a random integer between 0 and the array length of techitems and incerases it by one to match the index of techitems
            id = techItems[rand]
            
            if lastItem[i] ~= 0 then        --deletes the old items from the last floor
                Isaac.ExecuteCommand(REMOVE..lastItem[i])
            end

            lastItem[i] = id   --remembers the id of the last given item
            Isaac.ExecuteCommand(GIVE..id) --executes the console command to give isaac the random item
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.randTech) --the item only does something when the player changes floor (currently missing instance for when player picks up the item)
