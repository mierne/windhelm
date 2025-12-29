TITLE (SLoP) - Intialization
REM Save, Load, order (and initialization) Program

REM Variables needed to make Windhelm work are loaded here.
:BASE_SET
SET "player.message=..."
SET "windhelm.inventory_call=passive"
REM Other values
SET "windhelm.vn=UNSTABLE-0.4.0_00-251228"
SET "windhelm.ut=Stargazer"
SET windhelm.enable_stability_warning=1
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
SET windhelm.item_short_sword_damage=5
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
SET "windhelm.item_oracle_hjraldir_name=Oracle of Hjraldir"
SET "windhelm.item_oracle_hjraldir_type=Staff"
SET "windhelm.item_oracle_hjraldir_category=Staves"
SET "windhelm.item_oracle_hjraldir_damage_type=magical"
REM Special weapon item data
REM Spell data
SET "windhelm.spell_firebolt_name=Firebolt"
SET windhelm.spell_firebolt_damage=15
SET windhelm.spell_firebolt_modifier=0
SET windhelm.spell_firebolt_mgk_cost=-50
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
SET wait="%winLoc%\data\scripts\wait.vbs"
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
ECHO %player.health%
ECHO %player.magicka%
ECHO %player.damage%
ECHO %player.damage_heavy%
ECHO %player.armor_class%
ECHO %player.class%
ECHO %player.coins%
ECHO %player.xp%
ECHO %player.xp_required%
ECHO %player.level%
ECHO %player.magicka_max%
ECHO %player.health_max%
ECHO %player.weapon_type%
ECHO %player.weapon_damage_type%
ECHO %player.origin%
ECHO %player.armor_prot%
ECHO %player.armor_resistance_type%
ECHO %player.skill_damage%
ECHO %player.skill_magicka%
ECHO %player.skill_speech%
ECHO %player.skill_athletics%
ECHO %player.skill_intelligence%
ECHO %player.skill_destruction%
ECHO %player.skill_restoration%
ECHO %player.reputation%
ECHO %player.magicSchool_AlterationSkill%
ECHO %player.magicSchool_DestructionSkill%
ECHO %player.magicSchool_RestorationSkill%
ECHO %player.ruins_unlocked%
ECHO %player.bandits_slain%
ECHO %player.total_deaths%
ECHO %player.iridescent_ab_defeated%
ECHO %player.quests_primary_quest%
ECHO %player.quests_secondary_quest%
ECHO %player.quests_completed%
ECHO %player.quests_slay_5_bandits_completed%
ECHO %player.catalogue_unlocked%
ECHO %player.catalogue_locked%
ECHO %player.catalogue_bandit_encountered%
ECHO %player.catalogue_abyss_guardian_encountered%
ECHO %player.catalogue_wandering_trader_encountered%
ECHO %player.catalogue_bandit%
ECHO %player.catalogue_abyss_guardian%
ECHO %player.catalogue_wandering_trader%
ECHO %player.ifor_cleared_level1%
ECHO %player.ifor_cleared_level2%
ECHO %player.ifor_cleared_level3%
ECHO %player.ifor_cleared_level4%
ECHO %player.ifor_level2_secret_unlocked%
ECHO %player.ifor_cleared_boss%
ECHO %player.ifor_level_1_searched%
ECHO %player.ifor_level_1_location%
ECHO %player.ifor_level_2_searched%
ECHO %player.ifor_level_2_location%
ECHO %player.ifor_level_3_searched%
ECHO %player.ifor_level_3_location%
ECHO %player.ifor_level_4_searched%
ECHO %player.ifor_level_4_location%
ECHO %player.pe_abgu_cleared%
ECHO %player.scene_1_examine_plants%
ECHO %player.scene_1_examine_barrels%
ECHO %player.scene_1_examine_wagon%
ECHO %player.hazard_spotted_pod_known%
ECHO %player.s1_exwag_inspect_area%
ECHO %player.armor_equipped%
ECHO %player.weapon_equipped%
ECHO %player.spell_equipped%
ECHO %player.item_cactus_armor_owned%
ECHO %player.item_guard_armor_owned%
ECHO %player.item_stone_armor_owned%
ECHO %player.item_steel_armor_owned%
ECHO %player.item_iron_armor_owned%
ECHO %player.item_long_sword_owned%
ECHO %player.item_scale_armor_owned%
ECHO %player.item_short_sword_owned%
ECHO %player.item_great_axe_owned%
ECHO %player.item_mace_owned%
ECHO %player.item_wooden_bow_owned%
ECHO %player.item_tonic_healing_owned%
ECHO %player.item_tonic_magicka_owned%
ECHO %pulse.ifor_area_boss_defeated%
ECHO %pulse.ifor_level_1_ecount%
ECHO %pulse.ifor_level_2_ecount%
ECHO %pulse.ifor_level_3_ecount%
ECHO %pulse.ifor_level_4_ecount%
)>"%cd%\data\player\savedata.txt"
GOTO :loadData

:loadData
(
SET /P player.health=
SET /P player.magicka=
SET /P player.damage=
SET /P player.damage_heavy=
SET /P player.armor_class=
SET /P player.class=
SET /P player.coins=
SET /P player.xp=
SET /P player.xp_required=
SET /P player.level=
SET /P player.magicka_max=
SET /P player.health_max=
SET /P player.weapon_type=
SET /P player.weapon_damage_type=
SET /P player.origin=
SET /P player.armor_prot=
SET /P player.armor_resistance_type=
SET /P player.skill_damage=
SET /P player.skill_magicka=
SET /P player.skill_speech=
SET /P player.skill_athletics=
SET /P player.skill_intelligence=
SET /P player.skill_destruction=
SET /P player.skill_restoration=
SET /P player.reputation=
SET /P player.magicSchool_AlterationSkill=
SET /P player.magicSchool_DestructionSkill=
SET /P player.magicSchool_RestorationSkill=
SET /P player.ruins_unlocked=
SET /P player.bandits_slain=
SET /P player.total_deaths=
SET /P player.iridescent_ab_defeated=
SET /P player.quests_primary_quest=
SET /P player.quests_secondary_quest=
SET /P player.quests_completed=
SET /P player.quests_slay_5_bandits_completed=
SET /P player.catalogue_unlocked=
SET /P player.catalogue_locked=
SET /P player.catalogue_bandit_encountered=
SET /P player.catalogue_abyss_guardian_encountered=
SET /P player.catalogue_wandering_trader_encountered=
SET /P player.catalogue_bandit=
SET /P player.catalogue_abyss_guardian=
SET /P player.catalogue_wandering_trader=
SET /P player.ifor_cleared_level1=
SET /P player.ifor_cleared_level2=
SET /P player.ifor_cleared_level3=
SET /P player.ifor_cleared_level4=
SET /P player.ifor_level2_secret_unlocked=
SET /P player.ifor_cleared_boss=
SET /P player.ifor_level_1_searched=
SET /P player.ifor_level_1_location=
SET /P player.ifor_level_2_searched=
SET /P player.ifor_level_2_location=
SET /P player.ifor_level_3_searched=
SET /P player.ifor_level_3_location=
SET /P player.ifor_level_4_searched=
SET /P player.ifor_level_4_location=
SET /P player.pe_abgu_cleared=
SET /P player.scene_1_examine_plants=
SET /P player.scene_1_examine_barrels=
SET /P player.scene_1_examine_wagon=
SET /P player.hazard_spotted_pod_known=
SET /P player.s1_exwag_inspect_area=
SET /P player.armor_equipped=
SET /P player.weapon_equipped=
SET /P player.spell_equipped=
SET /P player.item_cactus_armor_owned=
SET /P player.item_guard_armor_owned=
SET /P player.item_stone_armor_owned=
SET /P player.item_steel_armor_owned=
SET /P player.item_iron_armor_owned=
SET /P player.item_long_sword_owned=
SET /P player.item_scale_armor_owned=
SET /P player.item_short_sword_owned=
SET /P player.item_great_axe_owned=
SET /P player.item_mace_owned=
SET /P player.item_wooden_bow_owned=
SET /P player.item_tonic_healing_owned=
SET /P player.item_tonic_magicka_owned=
SET /P pulse.ifor_area_boss_defeated=
SET /P pulse.ifor_level_1_ecount=
SET /P pulse.ifor_level_2_ecount=
SET /P pulse.ifor_level_3_ecount=
SET /P pulse.ifor_level_4_ecount=
)<"%cd%\data\player\savedata.txt"
GOTO :EOF

:GAME_INIT
:PLAYER_INIT_STATS
SET player.health=100
SET player.magicka=100
SET player.damage=3
SET player.damage_heavy=10
SET player.armor_class=0
SET "player.class=None"
SET player.coins=250
SET player.xp=0
SET player.xp_required=5000
SET player.level=1
SET player.magicka_max=100
SET player.health_max=100
SET "player.weapon_type=Melee"
SET "player.weapon_damage_type=physical"
SET "player.origin=None"
REM Player armor value. Used to modify attack damages against the Player.
SET player.armor_prot=0
SET "player.armor_resistance_type=physical"
SET player.skill_damage=2
SET player.skill_magicka=2
SET player.skill_speech=2
SET player.skill_athletics=2
SET player.skill_intelligence=2
SET player.skill_destruction=2
SET player.skill_restoration=2
SET player.reputation=2
SET player.magicSchool_AlterationSkill=2
SET player.magicSchool_DestructionSkill=2
SET player.magicSchool_RestorationSkill=2
REM Location unlocks
SET player.ruins_unlocked=0
REM "Player statistics tracking
SET player.bandits_slain=0
SET player.total_deaths=0
SET player.iridescent_ab_defeated=0
REM "Player quest tracking
SET "player.quests_primary_quest=No active quest."
SET "player.quests_secondary_quest=No active quest."
SET player.quests_completed=0
SET player.quests_slay_5_bandits_completed=0
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
REM Player exploration data
SET player.ifor_cleared_level1=0
SET player.ifor_cleared_level2=0
SET player.ifor_cleared_level3=0
SET player.ifor_cleared_level4=0
SET player.ifor_level2_secret_unlocked=0
SET player.ifor_cleared_boss=0
SET player.ifor_level_1_searched=0
SET "player.ifor_level_1_location=NotStarted"
SET player.ifor_level_2_searched=0
SET "player.ifor_level_2_location=NotStarted"
SET player.ifor_level_3_searched=0
SET "player.ifor_level_3_location=NotStarted"
SET player.ifor_level_4_searched=0
SET "player.ifor_level_4_location=NotStarted"
SET player.pe_abgu_cleared=0
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