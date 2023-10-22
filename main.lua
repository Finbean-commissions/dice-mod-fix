----Welcome to the "main.lua" file! Here is where all the magic happens, everything from functions to callbacks are done here.
--Startup
local mod = RegisterMod("Too many D6s! (Fix)", 1)
local game = Game()
local rng = RNG()
local seed = game:GetSeeds():GetStartSeed()

mod.Items = {
    GoldenItem = Isaac.GetItemIdByName("Golden D6"),
	CrookedItem = Isaac.GetItemIdByName("Crooked D6"),
}

function mod:UseItem(item, _, player, UseFlags, Slot, _)
	if UseFlags & UseFlag.USE_OWNED == UseFlag.USE_OWNED then
		--Golden D6
		if item == mod.Items.GoldenItem then
			player:AnimateCollectible(mod.Items.GoldenItem, "UseItem")
			for i, entity in ipairs(Isaac.GetRoomEntities()) do
				if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then

					player:UseItem(CollectibleType.COLLECTIBLE_D6, 0, -1, 0)
					item = Isaac.GetItemConfig():GetCollectible(entity.SubType)

					player:AddBrokenHearts(2)

					while item.Quality < 3 do
						player:UseItem(CollectibleType.COLLECTIBLE_D6, UseFlag.USE_NOANIM, -1, 0)
						player:AnimateCollectible(mod.Items.GoldenItem, "UseItem")
						item = Isaac.GetItemConfig():GetCollectible(entity.SubType)
					end
				end
			end
        end
		--Crooked D6
		if item == mod.Items.GoldenItem then
			player:AnimateCollectible(mod.Items.GoldenItem, "UseItem")

			rng:SetSeed(seed, 35)
        	local roll = rng:RandomFloat(1)

			if roll == 0 then
				for i, entity in ipairs(Isaac.GetRoomEntities()) do
					if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then

					end
				end
			end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseItem)

include("item-descriptions.lua")