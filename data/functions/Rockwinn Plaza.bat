TITLE (Rockwinn Plaza) - Rockwinn Plaza ^| %player.name% the %player.race% %player.class%
SET refunded=false
SET refundPrice=0

:MAIN
MODE con: cols=110 lines=18
CLS
SET RETURN=MAIN
ECHO.
TYPE "%cd%\data\assets\ui\rwp.txt"
ECHO.
ECHO You enter the bustling street, inspecting each vendors stall closely.
ECHO %displayMessage%
ECHO +------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------+
ECHO + [1 / ALCHEMIST ] ^| [2 / BLACKSMITH ] ^| [3 / WIZARD ] ^| [Q / LEAVE ]                                        +
ECHO +------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :VENDOR_ALCHEMIST
IF /I "%CH%" == "2" GOTO :VENDOR_BLACKSMITH
IF /I "%CH%" == "3" GOTO :VENDOR_WIZARD
IF /I "%CH%" == "Q" GOTO :AUTOSAVE

:VENDOR_ALCHEMIST
TITLE (Rockwinn Plaza) - Alchemist ^| %player.name% the %player.race% %player.class%
MODE con: cols=100 lines=22
SET RETURN=VENDOR_ALCHEMIST
ECHO.
TYPE "%cd%\data\assets\npcs\alchemist.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HEALTH TONIC: %vendor.alchemist.health_tonic_price% LUNIS
ECHO ^| MAGICKA TONIC: %vendor.alchemist.magicka_tonic_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + [1 / HEALING TONIC ] ^| [2 / MAGICKA TONIC ] ^| [Q / GO BACK ]                                     +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :ALCHEMIST_BUY_HEALING_TONIC
IF /I "%CH%" == "2" GOTO :ALCHEMIST_BUY_MAGICKA_TONIC
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:ALCHEMIST_BUY_HEALING_TONIC
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_HEALTH_TONIC %vendor.alchemist.health_tonic_price%
GOTO :VENDOR_ALCHEMIST

:ALCHEMIST_BUY_MAGICKA_TONIC
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_MAGICKA_TONIC %vendor.alchemist.magicka_tonic_price%
GOTO :VENDOR_ALCHEMIST

REM Blacksmith Vendor.
:VENDOR_BLACKSMITH
TITLE (Rockwinn Plaza) - Blacksmith ^| %player.name% the %player.race% %player.class%
CLS
SET RETURN=VENDOR_BLACKSMITH
MODE con: cols=109 lines=19
ECHO.
TYPE "%cd%\data\assets\npcs\blacksmith.txt"
ECHO.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO ^| Select a TYPE of item to view.
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO + [1 / WEAPONS ] ^| [2 / ARMORS ] ^| [Q / BACK ]
ECHO +-----------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_TYPE_WEAPONS
IF /I "%CH%" == "2" GOTO :BLACKSMITH_TYPE_ARMOR
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

REM Display the "weapons" type.
:BLACKSMITH_TYPE_WEAPONS
MODE con: cols=100 lines=19
CLS
SET RETURN=BLACKSMITH_TYPE_WEAPONS
ECHO.
TYPE "%cd%\data\assets\ui\weapons.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a CATEGORY of weapon to view.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SWORDS ] ^| [2 / AXE ] ^| [3 / MACES ] ^| [4 / BOWS ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_CATEGORY_SWORDS
IF /I "%CH%" == "2" GOTO :BLACKSMITH_CATEGORY_AXES
IF /I "%CH%" == "3" GOTO :BLACKSMITH_CATEGORY_MACES
IF /I "%CH%" == "4" GOTO :BLACKSMITH_CATEGORY_BOWS
IF /I "%CH%" == "Q" GOTO :VENDOR_BLACKSMITH
GOTO :INVALID_INPUT

:BLACKSMITH_CATEGORY_SWORDS
MODE con: cols=100 lines=22
CLS
SET RETURN=BLACKSMITH_CATEGORY_SWORDS
ECHO.
TYPE "%cd%\data\assets\ui\swords.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a SWORD to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| LONGSWORD: %vendor.blacksmith_long_sword_price% LUNIS.
ECHO ^| SHORTSWORD: %vendor.blacksmith_short_sword_price% LUNIS.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LONGSWORD ] ^| [2 / SHORTSWORD ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_LONG_SWORD
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_SHORT_SWORD
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONS
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_LONG_SWORD
@REM SET windhelm.global_item_price=vendor.blacksmith_long_sword_price
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_LONGSWORD %vendor.blacksmith_long_sword_price%
GOTO :BLACKSMITH_CATEGORY_SWORDS

:BLACKSMITH_INSPECT_SHORT_SWORD
@REM SET windhelm.global_item_price=%vendor.blacksmith_short_sword_price%
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_SHORTSWORD %vendor.blacksmith_short_sword_price%
GOTO :BLACKSMITH_CATEGORY_SWORDS

:BLACKSMITH_CATEGORY_AXES
MODE con: cols=100 lines=21
CLS
SET RETURN=BLACKSMITH_CATEGORY_AXES
ECHO.
TYPE "%cd%\data\assets\ui\axes.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select an AXE to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| GREAT AXE: %vendor.blacksmith_great_axe_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / GREAT AXE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_GREAT_AXE
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONS
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_GREAT_AXE
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_GREATAXE %vendor.blacksmith_great_axe_price%
GOTO :BLACKSMITH_CATEGORY_AXES

:BLACKSMITH_CATEGORY_MACES
MODE con: cols=100 lines=21
CLS
SET RETURN=BLACKSMITH_CATEGORY_MACES
ECHO.
TYPE "%cd%\data\assets\ui\maces.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a MACE to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| MACE: %vendor.blacksmith_mace_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / MACE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_MACE
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONS
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_MACE
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_GREATAXE %vendor.blacksmith_mace_price%
GOTO :BLACKSMITH_CATEGORY_MACES

:BLACKSMITH_CATEGORY_BOWS
MODE con: cols=100 lines=21
CLS
SET RETURN=BLACKSMITH_CATEGORY_BOWS
ECHO.
TYPE "%cd%\data\assets\ui\bows.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a BOW to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| WOODEN BOW: %vendor.blacksmith_wooden_bow_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WOODEN BOW ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_BOW
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONS
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_BOW
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_WOODEN_BOW %vendor.blacksmith_wooden_bow_price%
GOTO :BLACKSMITH_CATEGORY_BOWS

:BLACKSMITH_TYPE_ARMOR
MODE con: cols=100 lines=19
CLS
SET RETURN=BLACKSMITH_TYPE_ARMOR
ECHO.
TYPE "%cd%\data\assets\ui\armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a CATEGORY of armor to view.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LIGHT ] ^| [2 / MEDIUM ] ^| [3 / HEAVY ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
IF /I "%CH%" == "2" GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
IF /I "%CH%" == "3" GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
IF /I "%CH%" == "Q" GOTO :VENDOR_BLACKSMITH
GOTO :INVALID_INPUT

:BLACKSMITH_CATEGORY_LIGHT_ARMOR
MODE con: cols=115 lines=25
CLS
SET RETURN=BLACKSMITH_CATEGORY_LIGHT_ARMOR
ECHO.
TYPE "%cd%\data\assets\ui\light_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an ARMOR SET to purchase.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| CACTUS ARMOR: %vendor.blacksmith_cactus_armor_price% LUNIS.
ECHO ^| GUARD ARMOR: %vendor.blacksmith_guard_armor_price% LUNIS.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CACTUS ARMOR ] ^| [2 / GUARD ARMOR ] ^| [Q / BACK ]
ECHO +-----------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_CACTUS_ARMOR
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_GUARD_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_CACTUS_ARMOR
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_CACTUS_ARMOR %vendor.blacksmith_cactus_armor_price%
GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR

:BLACKSMITH_INSPECT_GUARD_ARMOR
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_GUARD_ARMOR %vendor.blacksmith_guard_armor_price%
GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR

:BLACKSMITH_CATEGORY_MEDIUM_ARMOR
MODE con: cols=125 lines=22
CLS
SET RETURN=BLACKSMITH_CATEGORY_MEDIUM_ARMOR
ECHO.
TYPE "%cd%\data\assets\ui\medium_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an ARMOR SET to purchase.
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| STONE: %vendor.blacksmith_stone_armor_price% LUNIS.
ECHO ^| IRON: %vendor.blacksmith_iron_armor_price% LUNIS.
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / STONE ARMOR ] ^| [2 / IRON ARMOR ] ^| [Q / BACK ]
ECHO +---------------------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_STONE_ARMOR
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_IRON_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_STONE_ARMOR
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_STONE_ARMOR %vendor.blacksmith_stone_armor_price%
GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR

:BLACKSMITH_INSPECT_IRON_ARMOR
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_IRON_ARMOR %vendor.blacksmith_iron_armor_price%
GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR

:BLACKSMITH_CATEGORY_HEAVY_ARMOR
MODE con: cols=115 lines=25
CLS
SET RETURN=BLACKSMITH_CATEGORY_HEAVY_ARMOR
ECHO.
TYPE "%cd%\data\assets\ui\heavy_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an ARMOR SET to purchase.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| STEEL: %vendor.blacksmith_steel_armor_price% LUNIS.
ECHO ^| SCALE: %vendor.blacksmith_scale_armor_price% LUNIS.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / STEEL ARMOR ] ^| [2 / SCALE ARMOR ] ^| [Q / BACK ]
ECHO +-----------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_STEEL_ARMOR
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_SCALE_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_STEEL_ARMOR
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_STEEL_ARMOR %vendor.blacksmith_steel_armor_price%
GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR

:BLACKSMITH_INSPECT_SCALE_ARMOR
CALL "%winLoc%\data\functions\global_modules.bat" INSPECT_SCALE_ARMOR %vendor.blacksmith_scale_armor_price%
GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR

:VENDOR_WIZARD
ECHO NOT IMPLEMENTED
PAUSE
GOTO :%RETURN%

:INVALID_INPUT
ECHO %CH% is not a valid choice.
PAUSE
GOTO :%RETURN%

REM Saves Merchant data.
:AUTOSAVE
SET SLOPr=SAVE
CALL "%cd%\data\functions\SLOP.bat"
GOTO :EOF