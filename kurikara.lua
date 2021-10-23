local assets ={
    Asset("ANIM", "anim/kurikara.zip"),
   	Asset("ANIM", "anim/swap_kurikara.zip"),
	Asset("ATLAS", "images/inventoryimages/kurikara.xml"),
	Asset("IMAGE", "images/inventoryimages/kurikara.tex")
}

local prefabs =
{
	"kurikarafire",
} 


local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_kurikara", "kurikara")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst.fire = SpawnPrefab( "torchfire" )
    local follower = inst.fire.entity:AddFollower()
    follower:FollowSymbol( owner.GUID, "swap_object", 0, -110, 1 )	
end


local function onunequip(inst, owner)
inst.fire:Remove()
    inst.fire = nil
    
    inst.components.burnable:Extinguish()
	owner.components.combat.damage = owner.components.combat.defaultdamage 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")  
end

local function fn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	inst:AddTag("irreplaceable")
	
	inst.AnimState:SetBank("kurikara")
    inst.AnimState:SetBuild("kurikara")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetMultColour(1, 1, 1, 1)
	
	inst:AddTag("shadow")
    inst:AddTag("sharp")
	
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(95)
	inst.components.weapon:SetAttackCallback(
        function(attacker, target)
            if target.components.burnable then
                if math.random() < TUNING.LIGHTER_ATTACK_IGNITE_PERCENT*target.components.burnable.flammability then
                    target.components.burnable:Ignite()
                end
            end
        end
    )
    
    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("rin")
	
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.CHOP, 5)
	
	inst:AddComponent("inspectable")
	inst:AddComponent("heater")
    inst.components.heater.equippedheat = 6
	inst:AddComponent("burnable")
    inst.components.burnable.canlight = false
    inst.components.burnable.fxprefab = nil
    --inst.components.burnable:AddFXOffset(Vector3(0,1.5,-.01))
	inst:AddComponent("lighter")
    
    inst:AddComponent("inventoryitem")
	
	inst.components.inventoryitem.imagename = "kurikara"
	   inst.components.inventoryitem.atlasname = "images/inventoryimages/kurikara.xml"
	   
    
    inst:AddComponent("equippable")
	inst.components.equippable:SetOnPocket( function(owner) inst.components.burnable:Extinguish()  end)
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	inst:AddComponent("dapperness")
    inst.components.dapperness.dapperness = TUNING.CRAZINESS_MED
    
    return inst
end

return Prefab( "common/inventory/kurikara", fn, assets, prefabs)