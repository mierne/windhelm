TITLE (SLoP) - Intialization
REM Save, Load, order (and initialization) Program

REM Variables needed to make Windhelm work are loaded here.
:BASE_SET
SET "player.message=..."
SET "windhelm.inventory_call=passive"
REM Other values
SET "windhelm.vn=STABLE-0.4.0_00-260123"
SET "windhelm.ut=Stargazer"
SET windhelm.enable_stability_warning=0
rem Enemy favored element determines which they are immune to
SET "windhelm.foe_bandit_favored_element=None"
SET "windhelm.foe_abyssal_guardian_favored_element=None"
rem Player skill level up cost
SET windhelm.skill_damage_level_cost=6
SET windhelm.skill_speech_level_cost=9
SET windhelm.skill_athletics_level_cost=10
SET windhelm.skill_intelligence_level_cost=10
SET windhelm.skill_destruction_level_cost=20
SET windhelm.skill_restoration_level_cost=20
rem Windhelm weapon item table
SET "windhelm.item_long_sword_name=Longsword"
SET windhelm.item_long_sword_damage=8
SET "windhelm.item_long_sword_type=weapon"
SET "windhelm.item_long_sword_category=swords"
SET "windhelm.item_long_sword_damage_type=physical"
SET "windhelm.item_short_sword_name=Shortsword"
SET windhelm.item_short_sword_damage=7
SET "windhelm.item_short_sword_type=weapon"
SET "windhelm.item_short_sword_category=swords"
SET "windhelm.item_short_sword_damage_type=physical"
SET "windhelm.item_great_axe_name=Great Axe"
SET windhelm.item_great_axe_damage=17
SET "windhelm.item_great_axe_type=weapon"
SET "windhelm.item_great_axe_category=axes"
SET "windhelm.item_great_axe_damage_type=physical"
SET "windhelm.item_hand_axe_name=Hand Axe"
SET windhelm.item_hand_axe_damage=13
SET "windhelm.item_hand_axe_type=weapon"
SET "windhelm.item_hand_axe_category=axes"
SET "windhelm.item_hand_axe_damage_type=physical"
SET "windhelm.item_mace_name=mace"
SET windhelm.item_mace_damage=12
SET "windhelm.item_mace_type=weapon"
SET "windhelm.item_mace_category=maces"
SET "windhelm.item_mace_damage_type=physical"
SET "windhelm.item_wooden_bow_name=Wooden Bow"
SET windhelm.item_wooden_bow_damage=15
SET "windhelm.item_wooden_bow_type=weapon"
SET "windhelm.item_wooden_bow_category=bows"
SET "windhelm.item_wooden_bow_damage_type=physical"
rem Staves item data
set "windhelm.item_oracle_of_hjralder_name=Oracle of Hjralder"
SET "windhelm.item_oracle_of_hjralder_type=Staff"
SET "windhelm.item_oracle_of_hjralder_category=Staves"
SET "windhelm.item_oracle_of_hjralder_damage_type=physical"
set windhelm.item_oracle_of_hjralder_int_modifier=2
set windhelm.item_oracle_of_hjralder_damage=5
REM Special weapon item data
REM Spell data
SET "windhelm.spell_firebolt_name=Firebolt"
SET windhelm.spell_firebolt_damage=12
SET windhelm.spell_firebolt_modifier=0
SET windhelm.spell_firebolt_mgk_cost=45
SET "windhelm.spell_firebolt_type=spell"
SET "windhelm.spell_firebolt_school=Destruction"
SET "windhelm.spell_firebolt_damage_type=magical"
SET "windhelm.spell_healing_hands_name=Healing Hands"
SET windhelm.spell_healing_hands_damage=0
SET "windhelm.spell_healing_hands_type=spell"
SET "windhelm.spell_healing_hands_school=Restoration"
SET "windhelm.spell_healing_hands_damage_type=magical"
REM Armor item data
SET "windhelm.item_cactus_armor_name=Cactus Armor"
SET windhelm.item_cactus_armor_prot=3
SET "windhelm.item_cactus_armor_type=armor"
SET "windhelm.item_cactus_armor_category=light armor"
SET "windhelm.item_cactus_armor_type_resistance=physical"
SET "windhelm.item_stone_armor_name=Stone Armor"
SET windhelm.item_stone_armor_prot=5
SET "windhelm.item_stone_armor_type=armor"
SET "windhelm.item_stone_armor_category=medium armor"
SET "windhelm.item_stone_armor_type_resistance=physical"
SET "windhelm.item_guard_armor_name=Guard Armor"
SET windhelm.item_guard_armor_prot=7
SET "windhelm.item_guard_armor_type=armor"
SET "windhelm.item_guard_armor_category=light armor"
SET "windhelm.item_guard_armor_type_resistance=physical"
SET "windhelm.item_steel_armor_name=Steel Armor"
SET windhelm.item_steel_armor_prot=9
SET "windhelm.item_steel_armor_type=armor"
SET "windhelm.item_steel_armor_category=heavy armor"
SET "windhelm.item_steel_armor_type_resistance=physical"
SET "windhelm.item_scale_armor_name=Scale Armor"
SET windhelm.item_scale_armor_prot=15
SET "windhelm.item_scale_armor_type=armor"
SET "windhelm.item_scale_armor_category=heavy armor"
SET "windhelm.item_scale_armor_type_resistance=physical"
SET "windhelm.item_iron_armor_name=Iron Armor"
SET windhelm.item_iron_armor_prot=8
SET "windhelm.item_iron_armor_type=armor"
SET "windhelm.item_iron_armor_category=medium armor"
SET "windhelm.item_iron_armor_type_resistance=physical"
REM Tonic item data
SET "windhelm.item_tonic_healing_name=Health Tonic"
SET windhelm.item_tonic_healing_modifier=20
SET "windhelm.item_tonic_healing_type=consumable"
SET "windhelm.item_tonic_healing_category=tonics"
SET "windhelm.item_tonic_magicka_name=Magicka Tonic"
SET windhelm.item_tonic_magicka_modifier=15
SET "windhelm.item_tonic_magicka_type=consumable"
SET "windhelm.item_tonic_magicka_category=tonics"
REM Effect data
REM Imbue data
REM Script paths
SET "wait=%winLoc%\data\scripts\wait.vbs"
set "waitani=%winLoc%\data\assets\ui\animated\ANI_travel.bat"
REM Global Modules placeholder values
SET windhelm.global_item_price=0
SET windhelm.global_item_damage=0
SET windhelm.global_item_modifier=20
SET windhelm.global_item_prot=0
SET "windhelm.global_item_type=none"
SET "windhelm.global_item_category=none"
SET "windhelm.global_item_name=none"
SET windhelm.transition_delay=300
rem Die values
set dieroll=0

:SETTINGS_LOADER
(
SET /P windhelm.theme_color=
SET /P windhelm.transition_delay=
)<"%winLoc%\data\settings.txt"
GOTO :callCheck

:callCheck
IF "%SLOPr%" == "SAVE" (
    GOTO :saveData
) ELSE IF "%SLOPr%" == "LOAD" (
    GOTO :loadData
) ELSE IF "%SLOPr%" == "INIT" (
    GOTO :GAME_INIT
) ELSE (
    echo SLoP encountered an error on line 143.
    echo SLOPr was an unknown value.
    pause
    exit /b
)

:saveData
(
echo %player.name%
echo %player.health%
echo %player.magicka%
echo %player.damage%
echo %player.damage_heavy%
echo %player.spell_damage%
echo %player.spell_healing%
echo %player.spell_cost%
echo %player.armor_class%
echo %player.initiative%
echo %player.class%
echo %player.coins%
echo %player.xp%
echo %player.xp_required%
echo %player.level%
echo %player.explore_last_location%
echo %player.current_act%
echo %player.magicka_max%
echo %player.health_max%
echo %player.weapon_type%
echo %player.weapon_damage_type%
echo %player.origin%
echo %player.armor_prot%
echo %player.armor_resistance_type%
echo %player.skill_damage%
echo %player.skill_speech%
echo %player.skill_athletics%
echo %player.skill_intelligence%
echo %player.skill_destruction%
echo %player.skill_restoration%
echo %player.reputation%
echo %player.act_1_cave_unlocked%
echo %player.act_1_next_act_unlocked%
echo %player.bandits_slain%
echo %player.total_deaths%
echo %player.iridescent_ab_defeated%
echo %player.catalogue_unlocked%
echo %player.catalogue_locked%
echo %player.catalogue_bandit_encountered%
echo %player.catalogue_abyss_guardian_encountered%
echo %player.catalogue_wandering_trader_encountered%
echo %player.catalogue_bandit%
echo %player.catalogue_abyss_guardian%
echo %player.catalogue_wandering_trader%
echo %player.iridescent_forest_level%
echo %player.iridescent_forest_level_total%
echo %player.iridescent_forest_level_1_enemy_remaining%
echo %player.iridescent_forest_level_1%
echo %player.iridescent_forest_level_1_location%
echo %player.scene_1_examine_plants%
echo %player.scene_1_examine_barrels%
echo %player.scene_1_examine_wagon%
echo %player.hazard_spotted_pod_known%
echo %player.s1_exwag_inspect_area%
echo %player.armor_equipped%
echo %player.weapon_equipped%
echo %player.spell_equipped%
echo %player.spell_equipped_type%
echo %player.item_cactus_armor_owned%
echo %player.item_guard_armor_owned%
echo %player.item_stone_armor_owned%
echo %player.item_steel_armor_owned%
echo %player.item_iron_armor_owned%
echo %player.item_long_sword_owned%
echo %player.item_scale_armor_owned%
echo %player.item_short_sword_owned%
echo %player.item_great_axe_owned%
echo %player.item_mace_owned%
echo %player.item_wooden_bow_owned%
echo %player.item_tonic_healing_owned%
echo %player.item_tonic_magicka_owned%
echo %player.spell_learned_firebolt%
echo %player.spell_learned_healing_hands%
)>"%cd%\data\player\savedata.txt"
GOTO :loadData

:loadData
(
set /p player.name=
set /p player.health=
set /p player.magicka=
set /p player.damage=
set /p player.damage_heavy=
set /p player.spell_damage=
set /p player.spell_healing=
set /p player.spell_cost=
set /p player.armor_class=
set /p player.initiative=
set /p player.class=
set /p player.coins=
set /p player.xp=
set /p player.xp_required=
set /p player.level=
set /p player.explore_last_location=
set /p player.current_act=
set /p player.magicka_max=
set /p player.health_max=
set /p player.weapon_type=
set /p player.weapon_damage_type=
set /p player.origin=
set /p player.armor_prot=
set /p player.armor_resistance_type=
set /p player.skill_damage=
set /p player.skill_speech=
set /p player.skill_athletics=
set /p player.skill_intelligence=
set /p player.skill_destruction=
set /p player.skill_restoration=
set /p player.reputation=
set /p player.act_1_cave_unlocked=
set /p player.act_1_next_act_unlocked=
set /p player.bandits_slain=
set /p player.total_deaths=
set /p player.iridescent_ab_defeated=
set /p player.catalogue_unlocked=
set /p player.catalogue_locked=
set /p player.catalogue_bandit_encountered=
set /p player.catalogue_abyss_guardian_encountered=
set /p player.catalogue_wandering_trader_encountered=
set /p player.catalogue_bandit=
set /p player.catalogue_abyss_guardian=
set /p player.catalogue_wandering_trader=
set /p player.iridescent_forest_level=
set /p player.iridescent_forest_level_total=
set /p player.iridescent_forest_level_1_enemy_remaining=
set /p player.iridescent_forest_level_1=
set /p player.iridescent_forest_level_1_location=
set /p player.scene_1_examine_plants=
set /p player.scene_1_examine_barrels=
set /p player.scene_1_examine_wagon=
set /p player.hazard_spotted_pod_known=
set /p player.s1_exwag_inspect_area=
set /p player.armor_equipped=
set /p player.weapon_equipped=
set /p player.spell_equipped=
set /p player.spell_equipped_type=
set /p player.item_cactus_armor_owned=
set /p player.item_guard_armor_owned=
set /p player.item_stone_armor_owned=
set /p player.item_steel_armor_owned=
set /p player.item_iron_armor_owned=
set /p player.item_long_sword_owned=
set /p player.item_scale_armor_owned=
set /p player.item_short_sword_owned=
set /p player.item_great_axe_owned=
set /p player.item_mace_owned=
set /p player.item_wooden_bow_owned=
set /p player.item_tonic_healing_owned=
set /p player.item_tonic_magicka_owned=
set /p player.spell_learned_firebolt=
set /p player.spell_learned_healing_hands=
)<"%cd%\data\player\savedata.txt"
GOTO :EOF

:GAME_INIT
:PLAYER_INIT_STATS
SET player.health=100
SET player.magicka=100
SET player.damage=2
SET player.damage_heavy=10
set player.spell_damage=0
set player.spell_healing=0
set player.spell_cost=50
SET player.armor_class=0
set player.initiative=10
SET "player.class=None"
SET player.coins=250
SET player.xp=0
SET player.xp_required=5000
SET player.level=1
set "player.explore_last_location=explore"
set "player.current_act=Act 1"
SET player.magicka_max=100
SET player.health_max=100
SET "player.weapon_type=Melee"
SET "player.weapon_damage_type=physical"
SET "player.origin=None"
REM Player armor value. Used to modify attack damages against the Player.
SET player.armor_prot=0
SET "player.armor_resistance_type=physical"
SET player.skill_damage=2
SET player.skill_speech=2
SET player.skill_athletics=2
SET player.skill_intelligence=2
SET player.skill_destruction=2
SET player.skill_restoration=2
SET player.reputation=2
REM Location unlocks
set "player.act_1_cave_unlocked=???"
set "player.act_1_next_act_unlocked=???"
REM "Player statistics tracking
SET player.bandits_slain=0
SET player.total_deaths=0
SET player.iridescent_ab_defeated=0
REM Misc
REM Player beasitary
SET player.catalogue_unlocked=0
SET player.catalogue_locked=3
SET player.catalogue_bandit_encountered=0
SET player.catalogue_abyss_guardian_encountered=0
SET player.catalogue_wandering_trader_encountered=0
SET "player.catalogue_bandit=???"
SET "player.catalogue_abyss_guardian=???"
SET "player.catalogue_wandering_trader=???"
REM Exploration data for Iridescent Forest\Level 1
set player.iridescent_forest_level=1
set player.iridescent_forest_level_total=5
set player.iridescent_forest_level_1_enemy_remaining=5
set "player.iridescent_forest_level_1=incomplete"
set "player.iridescent_forest_level_1_location=NotStarted"
rem Player sublevel scene data
set "player.scene_1_examine_plants=incomplete"
set "player.scene_1_examine_barrels=incomplete"
set "player.scene_1_examine_wagon=incomplete"
rem Known hazards to the player
set player.hazard_spotted_pod_known=0
rem Nodes completed
set "player.s1_exwag_inspect_area=incomplete"
GOTO :PLAYER_INIT_INVENTORY

:PLAYER_INIT_INVENTORY
SET "player.armor_equipped=None"
SET "player.weapon_equipped=None"
SET "player.spell_equipped=None"
set "player.spell_equipped_type=None"
SET player.item_cactus_armor_owned=0
SET player.item_guard_armor_owned=0
SET player.item_stone_armor_owned=0
SET player.item_steel_armor_owned=0
SET player.item_iron_armor_owned=0
SET player.item_long_sword_owned=0
SET player.item_scale_armor_owned=0
SET player.item_short_sword_owned=0
SET player.item_great_axe_owned=0
SET player.item_mace_owned=0
SET player.item_wooden_bow_owned=0
SET player.item_tonic_healing_owned=0
SET player.item_tonic_magicka_owned=0
set player.spell_learned_firebolt=0
set player.spell_learned_healing_hands=0
set player.item_oracle_hjralder_owned=0
REM Pulse Engine level data
SET "pulse.ifor_area_boss_defeated=False"
SET pulse.ifor_level_1_ecount=1
SET pulse.ifor_level_2_ecount=3
SET pulse.ifor_level_3_ecount=4
SET pulse.ifor_level_4_ecount=1
GOTO :INIT_MERCHANTS

REM Setup Merchant inventories & Prices
:INIT_MERCHANTS
REM Blacksmith Shop Base Prices.
SET vendor.blacksmith_long_sword_price=220
SET vendor.blacksmith_short_sword_price=190
SET vendor.blacksmith_great_axe_price=700
SET vendor.blacksmith_mace_price=280
SET vendor.blacksmith_wooden_bow_price=125
SET vendor.blacksmith_cactus_armor_price=89
SET vendor.blacksmith_guard_armor_price=126
SET vendor.blacksmith_stone_armor_price=225
SET vendor.blacksmith_steel_armor_price=700
SET vendor.blacksmith_iron_armor_price=422
SET vendor.blacksmith_scale_armor_price=2000
REM Blacksmith Sellback Prices.
SET vendor.blacksmith_long_sword_sbp=190
SET vendor.blacksmith_short_sword_sbp=140
SET vendor.blacksmith_great_axe_sbp=500
SET vendor.blacksmith_mace_sbp=215
SET vendor.blacksmith_wooden_bow_sbp=80
SET vendor.blacksmith_cactus_armor_sbp=60
SET vendor.blacksmith_guard_armor_sbp=80
SET vendor.blacksmith_stone_armor_sbp=115
SET vendor.blacksmith_steel_armor_sbp=620
SET vendor.blacksmith_iron_armor_sbp=318
SET vendor.blacksmith_scale_armor_sbp=1622
REM Alchemist Shop Base Prices.
SET vendor.alchemist.health_tonic_price=25
SET vendor.alchemist.magicka_tonic_price=25

if "%SLOPr%" == "INIT" (
    goto :eof
) else (
    goto :saveData
)