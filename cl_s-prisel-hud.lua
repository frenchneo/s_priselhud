local config = {}
-- The background colors of all backgrounds (Black default)
config.backColor = Color(25, 25, 25)
config.borderRadius = 4
-- The color of the bar of the health (Red default)
config.hpColor = Color(58, 193, 58)
-- The color of the bar of the armor (Blue default)
config.armorColor = Color(33, 150, 243)
-- The color of the bar of the hunger (Hunger default)
config.hungerColor = Color(63, 34, 4)
config.hungerMod = false

local hide = {
    CHudHealth = true,
    CHudBattery = true,
    DarkRP_HUD = true,
    DarkRP_Hungermod = true,
    CHudAmmo = true,
    CHudSecondaryAmmo = true
}

hook.Add("HUDShouldDraw", "S:Prisel:HUD:Hook:HUDShouldDraw", function(name)
    if (hide[name]) then return false end
end)

hook.Add("HUDPaint", "S:Prisel:HUD:Hook:HUDPaint", function()
    --[[-------------------------------------------------------------------------
		Gauche math.Round
	---------------------------------------------------------------------------]]
    draw.RoundedBox(config.borderRadius, 5 + 50, ScrH() - 50, 200, 20, config.backColor)
    draw.RoundedBox(config.borderRadius, 5 + 50, ScrH() - (5 + 42) * 2, 200, 20, config.backColor)
    draw.RoundedBox(config.borderRadius, 5 + 50, ScrH() - (5 + 42) * 3, 200, 20, config.backColor)
    draw.RoundedBox(config.borderRadius, 5 + 50, ScrH() - 50, math.Clamp(LocalPlayer():Armor() * 2, 0, 200), 20, config.armorColor)
    draw.RoundedBox(config.borderRadius, 5 + 50, ScrH() - (5 + 42) * 2, math.Clamp(LocalPlayer():getDarkRPVar("Energy") * 2, 0, 200), 20, config.hungerColor)
    draw.RoundedBox(config.borderRadius, 5 + 50, ScrH() - (5 + 42) * 3, math.Clamp(LocalPlayer():Health() * 2, 0, 200), 20, config.hpColor)
    draw.SimpleText(LocalPlayer():Armor() .. "", "Trebuchet24", 155, ScrH() - 40, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(math.Round(LocalPlayer():getDarkRPVar("Energy")) .. "", "Trebuchet24", 155, ScrH() - 84.2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(LocalPlayer():Health() .. "", "Trebuchet24", 155, ScrH() - 131, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(Material("materials/prisel-hud/sante.png"))
    surface.DrawTexturedRect(5, ScrH() - 150, 40, 40)
    surface.SetMaterial(Material("materials/prisel-hud/faim.png"))
    surface.DrawTexturedRect(5, ScrH() - 105, 40, 40)
    surface.SetMaterial(Material("materials/prisel-hud/armure.png"))
    surface.DrawTexturedRect(5, ScrH() - 60, 40, 40)
    -----------------------------------------------------------------------------
		--Droite
	---------------------------------------------------------------------------]]
    draw.RoundedBox(config.borderRadius, ScrW() - 5 - 200 - 50, ScrH() - 49, 200, 20, config.backColor)
    draw.RoundedBox(config.borderRadius, ScrW() - 5 - 200 - 50, ScrH() - (5 + 42) * 2, 200, 20, config.backColor)
    draw.RoundedBox(config.borderRadius, ScrW() - 5 - 200 - 50, ScrH() - (5 + 42) * 3, 200, 20, config.backColor)
    draw.SimpleText("PRISEL.FR", "Trebuchet24", ScrW() - 5 - 150, ScrH() - 39, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(LocalPlayer():getDarkRPVar("money") .. " €", "Trebuchet18", ScrW() - 5 - 200, ScrH() - 84, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(LocalPlayer():getDarkRPVar("salary") .. " €/Heure", "Trebuchet18", ScrW() - 5 - 90, ScrH() - 84, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(string.upper(LocalPlayer():getDarkRPVar("job")), "Trebuchet18", ScrW() - 5 - 90, ScrH() - 130, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(string.upper(LocalPlayer():Nick()), "Trebuchet18", ScrW() - 5 - 200, ScrH() - 130, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(Material("materials/prisel-hud/prisel-icon.png"))
    surface.DrawTexturedRect(ScrW() - 5 - 40, ScrH() - 59, 40, 40)
    surface.SetMaterial(Material("materials/prisel-hud/portefeuille.png"))
    surface.DrawTexturedRect(ScrW() - 5 - 40, ScrH() - 105, 40, 40)
    surface.SetMaterial(Material("materials/prisel-hud/job.png"))
    surface.DrawTexturedRect(ScrW() - 5 - 40, ScrH() - 151, 40, 40)
    -----------------------------------------------------------------------------
    if !LocalPlayer():Alive() then return end
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    if LocalPlayer():GetActiveWeapon():Clip1() ~= -1 then
        draw.RoundedBox(0, ScrW() / 2 - 100, ScrH() - 45, 200, 40, config.backColor)
        draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1() .. "/" .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "DermaLarge", ScrW() / 2, ScrH() - 25, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)