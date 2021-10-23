local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS

GLOBAL.STRINGS.NAMES.KURIKARA = "Kurikara"
GLOBAL.STRINGS.RECIPE_DESC.KURIKARA = "The most powerful of demon swords."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KURIKARA = {	
	"The most powerful of demon swords.", 
}

PrefabFiles = {
	"kurikara",
	"kurikarafire",
}

local assets={
	
	Asset("ATLAS", "images/inventoryimages/kurikara.xml"),
    Asset("IMAGE", "images/inventoryimages/kurikara.tex")
	
}



local function load()
local kurikara = GLOBAL.Recipe( "kurikara", {Ingredient("flint", 1)},  RECIPETABS.WAR, {SCIENCE=0} )
kurikara.atlas = "images/inventoryimages/kurikara.xml"   
	   
	TheSim:LoadPrefabs({"kurikara"})
	local kurikara = GLOBAL.GetRecipe("kurikara")
	end
	   
AddGamePostInit(load)
