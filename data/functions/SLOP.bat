TITLE (SLoP) - Intialization
REM A.K.A: Save, Load, order (and initialization) Program
REM Updated 13 October 24

REM Global Player, Item, NPC and Game attributes. G-PING.
:BASE_SET
REM Other Variables
SET CE7CALL=0
SET refunded=false
SET refundItem=0
SET refundPrice=0
SET itemStored=false
REM Enemy resistance information. "Favored Element" refers to an element which the enemy is resistant to.
SET windhelm.foe_bandit_favored_element=NONE
SET windhelm.foe_jester_favored_element=NONE
SET windhelm.foe_hunter_favored_element=NONE
SET windhelm.foe_goblin_favored_element=NONE
SET windhelm.foe_gnome_favored_element=NONE
SET windhelm.foe_golem_favored_element=Fire
REM Level up skill costs base
SET windhelm.damage_skill_base_cost_level=2
SET windhelm.stamina_skill_base_cost_level=2
SET windhelm.magicka_skill_base_cost_level=2
SET windhelm.intelligence_skill_base_cost_level=2
REM Reflex scales with athletics, for future reference. That's why it's excluded here.
SET windhelm.damage_athletics_base_cost_level=2
SET windhelm.damage_speech_base_cost_level=2
REM Item Table [ WEAPONS ]
SET windhelm.item_long_sword_name=Long Sword
SET windhelm.item_long_sword_damage=8
SET windhelm.item_long_sword_stamina_usage=12
SET windhelm.item_long_sword_type=weapon
SET windhelm.item_long_sword_category=swords
SET windhelm.item_short_sword_name=Short Sword
SET windhelm.item_short_sword_damage=4
SET windhelm.item_short_sword_stamina_usage=6
SET windhelm.item_short_sword_type=weapon
SET windhelm.item_short_sword_category=swords
SET windhelm.item_great_axe_name=Great Axe
SET windhelm.item_great_axe_damage=17
SET windhelm.item_great_axe_stamina_usage=15
SET windhelm.item_great_axe_type=weapon
SET windhelm.item_great_axe_category=axes
SET windhelm.item_mace_name=mace
SET windhelm.item_mace_damage=12
SET windhelm.item_mace_stamina_usage=15
SET windhelm.item_mace_type=weapon
SET windhelm.item_mace_category=maces
SET windhelm.item_wooden_bow_name=Wooden Bow
SET windhelm.item_wooden_bow_damage=15
SET windhelm.item_wooden_bow_stamina_usage=25
SET windhelm.item_wooden_bow_type=weapon
SET windhelm.item_wooden_bow_category=bows
REM Item Table [ ARMOR ]
SET windhelm.item_cactus_armor_name=Cactus Armor
SET windhelm.item_cactus_armor_prot=3
SET windhelm.item_cactus_armor_type=armor
SET windhelm.item_cactus_armor_category=light armor
SET windhelm.item_stone_armor_name=Stone Armor
SET windhelm.item_stone_armor_prot=5
SET windhelm.item_stone_armor_type=armor
SET windhelm.item_stone_armor_category=crude armor
SET windhelm.item_guard_armor_name=Guard Armor
SET windhelm.item_guard_armor_prot=7
SET windhelm.item_guard_armor_type=armor
SET windhelm.item_guard_armor_category=light armor
SET windhelm.item_steel_armor_name=Steel Armor
SET windhelm.item_steel_armor_prot=9
SET windhelm.item_steel_armor_type=armor
SET windhelm.item_steel_armor_category=heavy armor
SET windhelm.item_scale_armor_name=Scale Armor
SET windhelm.item_scale_armor_prot=15
SET windhelm.item_scale_armor_type=armor
SET windhelm.item_scale_armor_category=ultra heavy armor
SET windhelm.item_iron_armor_name=Iron Armor
SET windhelm.item_iron_armor_prot=8
SET windhelm.item_iron_armor_enchantable=true
SET windhelm.item_iron_armor_type=armor
SET windhelm.item_iron_armor_category=heavy armor
REM Item Table [ TONICS ]
SET windhelm.item_tonic_healing_name=Health Tonic
SET windhelm.item_tonic_healing_modifier=20
SET windhelm.item_tonic_healing_type=consumable
SET windhelm.item_tonic_healing_category=tonics
SET windhelm.item_tonic_stamina_name=Stamina Tonic
SET windhelm.item_tonic_stamina_modifier=10
SET windhelm.item_tonic_stamina_type=consumable
SET windhelm.item_tonic_stamina_category=tonics
SET windhelm.item_tonic_magicka_name=Magicka Tonic
SET windhelm.item_tonic_magicka_modifier=15
SET windhelm.item_tonic_magicka_type=consumable
SET windhelm.item_tonic_magicka_category=tonics
SET windhelm.item_tonic_xp_name=XP Tonic
SET windhelm.item_tonic_xp_modifier=200
SET windhelm.item_tonic_xp_type=consumable
SET windhelm.item_tonic_xp_category=tonics

:callCheck
IF %SLOPr% == SAVE (
    REM Save the Player's data.
    GOTO :saveData
) ELSE IF %SLOPr% == LOAD (
    REM Load the Player's data.
    GOTO :loadData
) ELSE IF %SLOPr% == INIT (
    REM Create a new Player.
    GOTO :PLAYER_INIT_STATS
) ELSE (
    REM Uh oh, something happened! Dispense an error.
    SET errorType=checkTime
    CALL "%cd%\data\functions\errorhandling.bat"
    EXIT /B
)

REM Saves Player & Merchant data.
:saveData
(
ECHO %player.name%
ECHO %player.race%
ECHO %player.personal_p_1%
ECHO %player.personal_p_2%
ECHO %player.possesive_1%
ECHO %player.reflexive_1%
ECHO %player.intensive_1%
ECHO %player.health%
ECHO %player.stamina%
ECHO %player.magicka%
ECHO %player.damage%
ECHO %player.armor%
ECHO %player.class%
ECHO %player.coins%
ECHO %player.xp%
ECHO %player.xp_required%
ECHO %player.level%
ECHO %player.stamina_max%
ECHO %player.magicka_max%
ECHO %player.health_max%
ECHO %player.weapon_type%
ECHO %player.armor_prot%
ECHO %player.attack_stamina_usage%
ECHO %player.skill_damage%
ECHO %player.skill_stamina%
ECHO %player.skill_magicka%
ECHO %player.skill_speech%
ECHO %player.skill_athletics%
ECHO %player.skill_reflex%
ECHO %player.skill_intelligence%
ECHO %player.reputation%
ECHO %player.magicSchool_AlterationSkill%
ECHO %player.magicSchool_DestructionSkill%
ECHO %player.magicSchool_RestorationSkill%
ECHO %player.ruins_unlocked%
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
ECHO %player.item_tonic_stamina_owned%
ECHO %player.item_tonic_magicka_owned%
ECHO %player.item_tonic_xp_owned%
ECHO %vendor.blacksmith_long_sword_price%
ECHO %vendor.blacksmith_short_sword_price%
ECHO %vendor.blacksmith_great_axe_price%
ECHO %vendor.blacksmith_mace_price%
ECHO %vendor.blacksmith_wooden_bow_price%
ECHO %vendor.blacksmith_long_sword_sbp%
ECHO %vendor.blacksmith_short_sword_sbp%
ECHO %vendor.blacksmith_great_axe_sbp%
ECHO %vendor.blacksmith_mace_sbp%
ECHO %vendor.blacksmith_wooden_bow_sbp%
ECHO %vendor.blacksmith_long_sword_stock%
ECHO %vendor.blacksmith_short_sword_stock%
ECHO %vendor.blacksmith_great_axe_stock%
ECHO %vendor.blacksmith_mace_stock%
ECHO %vendor.blacksmith_wooden_bow_stock%
ECHO %vendor.alchemist.health_tonic_price%
ECHO %vendor.alchemist.stamina_tonic_price%
ECHO %vendor.alchemist.magicka_tonic_price%
ECHO %vendor.alchemist.health_tonic_stock%
ECHO %vendor.alchemist.stamina_tonic_stock%
ECHO %vendor.alchemist.magicka_tonic_stock%
)>"%cd%\data\player\savedata.txt"
GOTO :EOF

REM Loads Player stats.
:loadData
(
SET /P player.name=
SET /P player.race=
SET /P player.personal_p_1=
SET /P player.personal_p_2=
SET /P player.possesive_1=
SET /P player.reflexive_1=
SET /P player.intensive_1=
SET /P player.health=
SET /P player.stamina=
SET /P player.magicka=
SET /P player.damage=
SET /P player.armor=
SET /P player.class=
SET /P player.coins=
SET /P player.xp=
SET /P player.xp_required=
SET /P player.level=
SET /P player.stamina_max=
SET /P player.magicka_max=
SET /P player.health_max=
SET /P player.weapon_type=
SET /P player.armor_prot=
SET /P player.attack_stamina_usage=
SET /P player.skill_damage=
SET /P player.skill_stamina=
SET /P player.skill_magicka=
SET /P player.skill_speech=
SET /P player.skill_athletics=
SET /P player.skill_reflex=
SET /P player.skill_intelligence=
SET /P player.reputation=
SET /P player.magicSchool_AlterationSkill=
SET /P player.magicSchool_DestructionSkill=
SET /P player.magicSchool_RestorationSkill=
SET /P player.ruins_unlocked=
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
SET /P player.item_tonic_stamina_owned=
SET /P player.item_tonic_magicka_owned=
SET /P player.item_tonic_xp_owned=
SET /P vendor.blacksmith_long_sword_price=
SET /P vendor.blacksmith_short_sword_price=
SET /P vendor.blacksmith_great_axe_price=
SET /P vendor.blacksmith_mace_price=
SET /P vendor.blacksmith_wooden_bow_price=
SET /P vendor.blacksmith_long_sword_sbp=
SET /P vendor.blacksmith_short_sword_sbp=
SET /P vendor.blacksmith_great_axe_sbp=
SET /P vendor.blacksmith_mace_sbp=
SET /P vendor.blacksmith_wooden_bow_sbp=
SET /P vendor.blacksmith_long_sword_stock=
SET /P vendor.blacksmith_short_sword_stock=
SET /P vendor.blacksmith_great_axe_stock=
SET /P vendor.blacksmith_mace_stock=
SET /P vendor.blacksmith_wooden_bow_stock=
SET /P vendor.alchemist.health_tonic_price=
SET /P vendor.alchemist.stamina_tonic_price=
SET /P vendor.alchemist.magicka_tonic_price=
SET /P vendor.alchemist.health_tonic_stock=
SET /P vendor.alchemist.stamina_tonic_stock=
SET /P vendor.alchemist.magicka_tonic_stock=
)<"%cd%\data\player\savedata.txt"
GOTO :EOF

REM Runs when a new game is started to generate needed variables.
:PLAYER_INIT_STATS
SET player.health=100
SET player.stamina=100
SET player.magicka=100
SET player.damage=5
SET player.armor=0
SET player.class=NONE
SET player.coins=1000
SET player.xp=0
SET player.xp_required=5000
SET player.level=1
SET player.stamina_max=100
SET player.magicka_max=100
SET player.health_max=100
SET player.weapon_type=Melee
REM Player armor value. Used to modify attack damages against the Player.
SET player.armor_prot=0
REM Functions like the armor variable, but for Stamina. When I have "equipped" items implemented better in the future, probably wont need this variable, but for now it is needed.
SET player.attack_stamina_usage=1
REM Skills and other important "social" variables.
SET player.skill_damage=2
SET player.skill_stamina=2
SET player.skill_magicka=2
SET player.skill_speech=2
SET player.skill_athletics=2
SET player.skill_reflex=2
SET player.skill_intelligence=2
SET player.reputation=2
SET player.magicSchool_AlterationSkill=2
SET player.magicSchool_DestructionSkill=2
SET player.magicSchool_RestorationSkill=2
REM Location unlocks
SET player.ruins_unlocked=0
GOTO :PLAYER_INIT_INVENTORY

REM Equipment slots
:PLAYER_INIT_INVENTORY
SET player.armor_equipped=EMPTY
SET player.weapon_equipped=EMPTY
SET player.spell_equipped=EMPTY
REM Default Player inventory
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
SET player.item_tonic_stamina_owned=0
SET player.item_tonic_magicka_owned=0
SET player.item_tonic_xp_owned=0
GOTO :INIT_MERCHANTS

REM Setup Merchant inventories & Prices
:INIT_MERCHANTS
REM Blacksmith Shop Base Prices.
SET vendor.blacksmith_long_sword_price=220
SET vendor.blacksmith_short_sword_price=190
SET vendor.blacksmith_great_axe_price=700
SET vendor.blacksmith_mace_price=280
SET vendor.blacksmith_wooden_bow_price=125
REM Blacksmith Sellback Prices.
SET vendor.blacksmith_long_sword_sbp=190
SET vendor.blacksmith_short_sword_sbp=140
SET vendor.blacksmith_great_axe_sbp=500
SET vendor.blacksmith_mace_sbp=215
SET vendor.blacksmith_wooden_bow_sbp=80
REM Blacksmith Shop Stock.
SET vendor.blacksmith_long_sword_stock=6
SET vendor.blacksmith_short_sword_stock=4
SET vendor.blacksmith_great_axe_stock=5
SET vendor.blacksmith_mace_stock=5
SET vendor.blacksmith_wooden_bow_stock=2
REM Alchemist Shop Base Prices.
SET vendor.alchemist.health_tonic_price=25
SET vendor.alchemist.stamina_tonic_price=25
SET vendor.alchemist.magicka_tonic_price=25
REM Alchemist Item Stock.
SET vendor.alchemist.health_tonic_stock=50
SET vendor.alchemist.stamina_tonic_stock=50
SET vendor.alchemist.magicka_tonic_stock=50
GOTO :saveData