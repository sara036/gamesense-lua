---[ Vars ]---
local client_set_event_callback, globals_tickcount, ui_get, ui_new_hotkey, ui_reference, ui_set = client.set_event_callback, globals.tickcount, ui.get, ui.new_hotkey, ui.reference, ui.set

local tickcount = globals_tickcount()
local disabled = false
local delta = 15
local off = 'Off'
--------------

---[ Menu ]---
local AntiScreenshot = ui_new_hotkey('MISC', 'Miscellaneous', 'Anti Screenshot', false, 0x7B)
--------------

---[ Default ]---
local defaultvalues = {
    [ui_reference('VISUALS', 'Player ESP', 'Teammates')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Glow')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Dormant')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Bounding box')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Health bar')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Name')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Flags')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Weapon text')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Weapon icon')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Ammo')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Distance')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Hit marker')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Visualize aimbot')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Visualize aimbot (safe point)')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Visualize sounds')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Line of sight')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Money')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Skeleton')] = false,
    [ui_reference('VISUALS', 'Player ESP', 'Out of FOV arrow')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Player')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Player behind wall')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Teammate')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Teammate behind wall')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Local player')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Local player fake')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Hands')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Disable model occlusion')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Shadow')] = false,
    [ui_reference('VISUALS', 'Colored models', 'Props')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Radar')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Dropped weapons')] = off,
    [ui_reference('VISUALS', 'Other ESP', 'Dropped weapon ammo')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Grenades')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Inaccuracy overlay')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Recoil overlay')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Bomb')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Grenade trajectory')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Grenade proximity warning')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Spectators')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Penetration reticle')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Hostages')] = false,
    [ui_reference('VISUALS', 'Other ESP', 'Danger Zone items')] = false,
    [ui_reference('VISUALS', 'Effects', 'Remove flashbang effects')] = false,
    [ui_reference('VISUALS', 'Effects', 'Remove smoke grenades')] = false,
    [ui_reference('VISUALS', 'Effects', 'Remove fog')] = false,
    [ui_reference('VISUALS', 'Effects', 'Remove skybox')] = false,
    [ui_reference('VISUALS', 'Effects', 'Visual recoil adjustment')] = off,
    [ui_reference('VISUALS', 'Effects', 'Transparent walls')] = 100,
    [ui_reference('VISUALS', 'Effects', 'Transparent props')] = 100,
    [ui_reference('VISUALS', 'Effects', 'Brightness adjustment')] = off,
    [ui_reference('VISUALS', 'Effects', 'Remove scope overlay')] = false,
    [ui_reference('VISUALS', 'Effects', 'Disable post processing')] = false,
    [ui_reference('VISUALS', 'Effects', 'Force third person (alive)')] = false,
    [ui_reference('VISUALS', 'Effects', 'Force third person (dead)')] = false,
    [ui_reference('VISUALS', 'Effects', 'Disable rendering of teammates')] = false,
    [ui_reference('VISUALS', 'Effects', 'Bullet tracers')] = false,
    [ui_reference('VISUALS', 'Effects', 'Bullet impacts')] = false,
    [ui_reference('RAGE', 'Aimbot', 'Enabled')] = false,
    [ui_reference('MISC', 'Miscellaneous', 'Override FOV')] = 90,
    [ui_reference('MISC', 'Miscellaneous', 'Override zoom FOV')] = 100,
    [ui_reference('MISC', 'Miscellaneous', 'Log weapon purchases')] = false,
    [ui_reference('MISC', 'Miscellaneous', 'Log damage dealt')] = false,
    [ui_reference('MISC', 'Miscellaneous', 'Persistent kill feed')] = false,
    [ui_reference('MISC', 'Movement', 'No fall damage')] = false,
}
-----------------

---[ Functions ] ---
local visualsvalues = {}

local function on_paint()
    if not disabled and ui_get(AntiScreenshot) and globals_tickcount() - tickcount > delta + 15 then
        for ref, defaultvalues in pairs(defaultvalues) do
            visualsvalues[ref] = ui_get(ref)
            ui_set(ref, defaultvalues)
        end
        disabled = true
        tickcount = globals_tickcount()
    elseif disabled and globals_tickcount() - tickcount > delta then
        for ref, visualsvalues in pairs(visualsvalues) do
            ui_set(ref, visualsvalues)
        end
        i = 0
        tickcount = globals_tickcount()
        visualsvalues = {}
    end
end

client_set_event_callback('paint', on_paint)
--------------------