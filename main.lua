----Welcome to the "main.lua" file! Here is where all the magic happens, everything from functions to callbacks are done here.
--Startup
local mod = RegisterMod("Too many D6s! (Fix)", 1)
local game = Game()
local rng = RNG()
local seeds = game:GetSeeds()

mod.Items = {
    GoldenItem = Isaac.GetItemIdByName("Golden D6"),
	CrookedItem = Isaac.GetItemIdByName("Crooked D6"),
	DollarItem = Isaac.GetItemIdByName("Dollar Cube"),
	GlassItem = Isaac.GetItemIdByName("Glass D6"),
}

local function onStart()
    local startSeed = seeds:GetStartSeed()
    rng:SetSeed(startSeed, 35)
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onStart)

function mod:UseItem(item, _, player, UseFlags, Slot, _)
	if UseFlags & UseFlag.USE_OWNED == UseFlag.USE_OWNED then
		--Golden D6
		if item == mod.Items.GoldenItem then
			player:AnimateCollectible(mod.Items.GoldenItem, "UseItem")
			for i, entity in ipairs(Isaac.GetRoomEntities()) do
				if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then

					player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, 0, -1, 0)
					item = Isaac.GetItemConfig():GetCollectible(entity.SubType)

					player:AddBrokenHearts(2)

					while item.Quality < 3 do
						player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, UseFlag.USE_NOANIM, -1, 0)
						player:AnimateCollectible(mod.Items.GoldenItem, "UseItem")
						item = Isaac.GetItemConfig():GetCollectible(entity.SubType)
					end
				end
			end
        end
		--Crooked D6
		if item == mod.Items.CrookedItem then
			player:AnimateCollectible(mod.Items.CrookedItem, "UseItem")

			local roll = rng:RandomInt(2)
			print(roll)

			if roll == 0 then
				for i, entity in ipairs(Isaac.GetRoomEntities()) do
					if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
						player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, 0, -1, 0)
						player:UseActiveItem(CollectibleType.COLLECTIBLE_DIPLOPIA, 0, -1, 0)
					end
				end
			elseif roll == 1 then
				for i, entity in ipairs(Isaac.GetRoomEntities()) do
					if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
						entity:Remove()
					end
				end
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_DICE_SHARD, player.Position, Vector(0,0), nil)
			end
        end
		--Dollar Cube
		if item == mod.Items.DollarItem then
			player:AnimateCollectible(mod.Items.DollarItem, "UseItem")

			for i, entity in ipairs(Isaac.GetRoomEntities()) do
				if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_DOLLAR, entity.Position, Vector(0,0), nil)
					entity:Remove()
				end
			end
        end
		--Glass D6
		if item == mod.Items.GlassItem then
			player:AnimateCollectible(mod.Items.GlassItem, "UseItem")

			local roll = rng:RandomInt(2)
			print(roll)

			if roll == 0 then
				for i, entity in ipairs(Isaac.GetRoomEntities()) do
					if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
						player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, 0, -1, 0)
					end
				end
			elseif roll == 1 then
				player:TakeDamage(2, 0, EntityRef(player), 0)
			end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseItem)

include("item-descriptions.lua")