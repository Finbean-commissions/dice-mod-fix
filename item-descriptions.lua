----Welcome to the "item-descriptions.lua" file! This file holds everything to do with the mod's compatibility with External Item Descriptions and Encyclopedia.
--Startup
local mod = RegisterMod("Commission Template - Items (Passive, GoldenItem, Trinket and Card)", 1)

mod.item = {
    GoldenItem = Isaac.GetItemIdByName("Golden D6"),
}

mod.description = {
	GoldenItem = "Upon use, rerolls every pedestal item in the room into a quality 3 or 4 GoldenItem item, but gives the player 2 broken hearts#{{Warning}} May freeze or crash the game if there are alot of item pedestals in the room",
	CrookedItem = "when used, has a 50% chance to reroll every pedestal item in the room and duplicate them, but has a 50% chance to remove every item in the room and spawn a Dice Shard#{{Warning}} May freeze or crash the game if there are alot of item pedestals in the room"
}

--External Item Descriptions documentation found here: https://github.com/wofsauge/External-Item-Descriptions/wiki.
if EID then
	EID:addCollectible(mod.item.GoldenItem, mod.description.GoldenItem)
	EID:addCollectible(mod.item.CrookedItem, mod.description.CrookedItem)
end

--Encyclopedia documentation found here: https://github.com/AgentCucco/encyclopedia-docs/wiki.
if Encyclopedia then
	local Wiki = {
		GoldenItem = {
			{ -- Description
				{str = "description", fsize = 2, clr = 3, halign = 0},
				{str = "Upon use, rerolls every pedestal item in the room into a quality 3 or 4 GoldenItem item, but gives the player 2 broken hearts."},
				{str = "Warning! May freeze or crash the game if there are alot of item pedestals in the room."},
			},
		},
		CrookedItem = {
			{ -- Description
				{str = "description", fsize = 2, clr = 3, halign = 0},
				{str = "when used, has a 50% chance to reroll every pedestal item in the room and duplicate them, but has a 50% chance to remove every item in the room and spawn a Dice Shard."},
				{str = "Warning! May freeze or crash the game if there are alot of item pedestals in the room."},
			},
		},
	}
	Encyclopedia.AddItem({
		ID = mod.item.GoldenItem,
		WikiDesc = Wiki.GoldenItem,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		},
	})
	Encyclopedia.AddItem({
		ID = mod.item.CrookedItem,
		WikiDesc = Wiki.CrookedItem,
		Pools = {
			Encyclopedia.ItemPools.POOL_TREASURE,
			Encyclopedia.ItemPools.POOL_GREED_TREASURE,
		},
	})
end