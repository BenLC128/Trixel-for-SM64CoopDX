-- name: [CS] Trixel
-- description: The jester from the very niche W.I.P. video game "Wild Card Chaos." !\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/wiki/API-Documentation

    Use this if you're curious on how anything here works >v<
	(This is an edited version of the Template File by Squishy)
]]

local TEXT_MOD_NAME = "[CS] Trixel"

-- Stops mod from loading if Character Select isn't on
if not _G.charSelectExists then
    djui_popup_create("\\#ffffff\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("trixel_geo") -- Located in "actors"

local TEX_JOKERGRAFFITI = get_texture_info("graphfeete")

local TEX_CUSTOM_LIFE_ICON = get_texture_info("life-icon") -- Located in "textures"

-- All Located in "sound" Name them whatever you want. Remember to include the .ogg extension
local VOICETABLE_CHAR = {
    [CHAR_SOUND_OKEY_DOKEY] =        'va_happy1.ogg', -- Starting game
	[CHAR_SOUND_LETS_A_GO] =         'va_happy2.ogg', -- Starting level
	[CHAR_SOUND_GAME_OVER] =         'Silent.ogg', -- Game Overed
	[CHAR_SOUND_PUNCH_YAH] =         'sound_enemyslap.ogg', -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] =         'sound_enemyslap.ogg', -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] =         'sound_enemyslap.ogg', -- Punch 3
	[CHAR_SOUND_YAH_WAH_HOO] =       'sfx_jump.ogg', -- First Jump Sounds
	[CHAR_SOUND_HOOHOO] =            'sfx_jump.ogg', -- Second jump sound
	[CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'va_happy1.ogg', 'va_happy2.ogg','va_happy3.ogg'}, -- Triple jump sounds
	[CHAR_SOUND_UH] =                'sfx_bump.ogg', -- Soft wall bonk
	[CHAR_SOUND_UH2] =               'Silent.ogg', -- Quick ledge get up
	[CHAR_SOUND_UH2_2] =             'Silent.ogg', -- Landing after long jump
	[CHAR_SOUND_DOH] =               'sfx_bump.ogg', -- Hard wall bonk
	[CHAR_SOUND_OOOF] =              'sfx_bump.ogg', -- Attacked in air
	[CHAR_SOUND_OOOF2] =             'sfx_bump.ogg', -- Land from hard bonk
	[CHAR_SOUND_HAHA] =              'Silent.ogg', -- Landing triple jump
	[CHAR_SOUND_HAHA_2] =            {'va_happy1.ogg', 'va_happy2.ogg','va_happy3.ogg'}, -- Landing in water from big fall
	[CHAR_SOUND_YAHOO] =             'va_happy1.ogg', -- Long jump
	[CHAR_SOUND_DOH] =               'sfx_bump.ogg', -- Long jump wall bonk
	[CHAR_SOUND_WHOA] =              'sfx_bump.ogg', -- Grabbing ledge
	[CHAR_SOUND_EEUH] =              'Silent.ogg', -- Climbing over ledge
	[CHAR_SOUND_WAAAOOOW] =          'va_hurt3.ogg', -- Falling a long distance
	[CHAR_SOUND_TWIRL_BOUNCE] =      'va_happy2.ogg', -- Bouncing off of a flower spring
	[CHAR_SOUND_GROUND_POUND_WAH] =  'Silent.ogg', -- Ground Pound after startup
	[CHAR_SOUND_WAH2] =              'Silent.ogg', -- Throwing something
	[CHAR_SOUND_HRMM] =              'sfx_jump.ogg', -- Lifting something
	[CHAR_SOUND_HERE_WE_GO] =        'va_happy3.ogg', -- Star get
	[CHAR_SOUND_SO_LONGA_BOWSER] =   {'va_happy1.ogg', 'va_happy2.ogg','va_happy3.ogg'}, -- Throwing Bowser
--DAMAGE
	[CHAR_SOUND_ATTACKED] =          'sfx_bump.ogg', -- Damaged
	[CHAR_SOUND_PANTING] =           'sfx_jump.ogg', -- Low health
	[CHAR_SOUND_PANTING_COLD] =      'sfx_bump.ogg', -- Getting cold
	[CHAR_SOUND_ON_FIRE] =           'va_hurt1.ogg', -- Burned
--SLEEP SOUNDS
	[CHAR_SOUND_IMA_TIRED] =         'Silent.ogg', -- Mario feeling tired
	[CHAR_SOUND_YAWNING] =           'Silent.ogg', -- Mario yawning before he sits down to sleep
	[CHAR_SOUND_SNORING1] =          'Silent.ogg', -- Snore Inhale
	[CHAR_SOUND_SNORING2] =          'Silent.ogg', -- Exhale
	[CHAR_SOUND_SNORING3] =          'Silent.ogg', -- Sleep talking / mumbling
--COUGHING (USED IN THE GAS MAZE)
	[CHAR_SOUND_COUGHING1] =         'sfx_bump.ogg', -- Cough take 1
	[CHAR_SOUND_COUGHING2] =         'sfx_bump.ogg', -- Cough take 2
	[CHAR_SOUND_COUGHING3] =         'sfx_bump.ogg', -- Cough take 3
--DEATH
	[CHAR_SOUND_DYING] =             'Silent.ogg', -- Dying from damage
	[CHAR_SOUND_DROWNING] =          'Silent.ogg', -- Running out of air underwater
	[CHAR_SOUND_MAMA_MIA] =          'Silent.ogg' -- Booted out of level
}

-- All Located in "actors"
local CAPTABLE_CHAR = {
    normal = smlua_model_util_get_id("cap_geo"),
    wing = smlua_model_util_get_id("wingcap_geo"),
    metal = smlua_model_util_get_id("metalcap_geo"),
}

local PALETTE_CHAR = {
		[PANTS]  = "3855FF",
		[SHIRT]  = "FFD800",
		[GLOVES] = "D9E0FF",
		[SHOES]  = "59D34E",
		[HAIR]   = "000000",
		[SKIN]   = "D83131",
		[CAP]    = "000000",
		[EMBLEM] = "D9E0FF"
}

local HM_CHARNAME2= {
    label = {
        left = get_texture_info("LeftHealth"),
        right = get_texture_info("RightHealth"),
    },
    pie = {
        [1] = get_texture_info("Pie1"),
        [2] = get_texture_info("Pie2"),
        [3] = get_texture_info("Pie3"),
        [4] = get_texture_info("Pie4"),
        [5] = get_texture_info("Pie5"),
        [6] = get_texture_info("Pie6"),
        [7] = get_texture_info("Pie7"),
        [8] = get_texture_info("Pie8"),
    }
}

local CSloaded = false
local function on_character_select_load()
    CT_CHARNAME2 = _G.charSelect.character_add("Trixel", {"A rebellious jester who tried","overthrowing a Diarchy","after rejecting him.","What a silly guy!"}, "BenLC", {r = 255, g = 255, b = 255}, E_MODEL_CUSTOM_MODEL, CT_CHARNAME2, TEX_CUSTOM_LIFE_ICON)
    _G.charSelect.character_add_caps(E_MODEL_CUSTOM_MODEL, CAPTABLE_CHAR)
    _G.charSelect.character_add_voice(E_MODEL_CUSTOM_MODEL, VOICETABLE_CHAR)
    _G.charSelect.character_add_celebration_star(E_MODEL_CUSTOM_MODEL, E_MODEL_CUSTOM_STAR, TEX_CUSTOM_STAR_ICON)
    _G.charSelect.character_add_palette_preset(E_MODEL_CUSTOM_MODEL, PALETTE_CHAR)
    _G.charSelect.character_add_health_meter(CT_CHARNAME2, HM_CHARNAME2)
	_G.charSelect.character_add_graffiti(CT_CHARNAME2, TEX_JOKERGRAFFITI)

    CSloaded = true
end

local function on_character_sound(m, sound)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.snore(m) end
end

hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)