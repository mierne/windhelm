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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------+
ECHO + [1 / ALCHEMIST ] ^| [2 / BLACKSMITH ] ^| [3 / WIZARD ] ^| [Q / LEAVE ]                                        +
ECHO +------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :VENDOR_ALCHEMIST
IF /I "%CH%" == "2" GOTO :VENDOR_BLACKSMITH
IF /I "%CH%" == "3" GOTO :VENDOR_WIZARD
IF /I "%CH%" == "Q" GOTO :AUTOSAVE
GOTO :INVALID_INPUT

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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HEALING TONIC: %vendor.alchemist.health_tonic_stock% STOCKED, PRICE: %vendor.alchemist.health_tonic_price% LUNIS
ECHO ^| MAGICKA TONIC: %vendor.alchemist.magicka_tonic_stock% STOCKED, PRICE: %vendor.alchemist.magicka_tonic_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + [1 / HEALING TONIC ] ^| [2 / MAGICKA TONIC ] ^| [Q / GO BACK ]                                     +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :ALCHEMIST_BUY_HEALING_TONIC
IF /I "%CH%" == "2" GOTO :ALCHEMIST_BUY_MAGICKA_TONIC
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:ALCHEMIST_BUY_HEALING_TONIC
CLS
SET RETURN=ALCHEMIST_BUY_HEALING_TONIC
MODE con: cols=103 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\health_tonic.txt"
ECHO.
ECHO Showing detailed information for the Healing Tonic.
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_healing_owned%
ECHO ^| MODIFIER: +%windhelm.item_tonic_healing_modifier% HP
ECHO ^| CATEGORY: %windhelm.item_tonic_healing_category%
ECHO ^| TYPE: %windhelm.item_tonic_healing_type%
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO [E / PURCHASE (%vendor.alchemist.health_tonic_price% LUNIS) ] ^| [Q / BACK ]
SET /P CH=">"
IF /I "%CH%" == "E" GOTO :ALCHEMIST_CONFIRM_HEALING_TONIC
IF /I "%CH%" == "Q" GOTO :VENDOR_ALCHEMIST
GOTO :INVALID_INPUT

:ALCHEMIST_CONFIRM_HEALING_TONIC
IF %vendor.alchemist.health_tonic_stock% LSS 1 (
    SET displayMessage=Sorry, I'm sold out of that one.
    GOTO :VENDOR_ALCHEMIST
) ELSE (
    IF %player.coins% LSS %vendor.alchemist.health_tonic_price% (
        SET displayMessage=You can't afford that Tonic.
        GOTO :VENDOR_ALCHEMIST
    ) ELSE (
        SET /A player.coins=!player.coins! -%vendor.alchemist.health_tonic_price%
        SET /A player.item_tonic_healing_owned=!player.item_tonic_healing_owned! +1
        SET /A vendor.alchemist.health_tonic_stock=!vendor.alchemist.health_tonic_stock! -1
        SET displayMessage=Purchased 1 Health Tonic for %vendor.alchemist.health_tonic_price%.
        GOTO :VENDOR_ALCHEMIST
    )
)

REM Purchase Magicka Tonic
:ALCHEMIST_BUY_MAGICKA_TONIC
SET RETURN=ALCHEMIST_BUY_MAGICKA_TONIC
MODE con: cols=115 lines=22
ECHO.
TYPE "%cd%\data\assets\ui\magicka_tonic.txt"
ECHO.
ECHO Showing detailed information for the Magicka Tonic.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_magicka_owned%
ECHO ^| MODIFIER: +%windhelm.item_tonic_magicka_modifier% HP
ECHO ^| CATEGORY: %windhelm.item_tonic_magicka_category%
ECHO ^| TYPE: %windhelm.item_tonic_magicka_type%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO [E / PURCHASE (%vendor.alchemist.magicka_tonic_price% LUNIS) ] ^| [Q / BACK ]
SET /P CH=">"
IF /I "%CH%" == "E" GOTO :ALCHEMIST_CONFIRM_MAGICKA_TONIC
IF /I "%CH%" == "Q" GOTO :VENDOR_ALCHEMIST
GOTO :INVALID_INPUT

:ALCHEMIST_CONFIRM_MAGICKA_TONIC
IF %vendor.alchemist.magicka_tonic_stock% LSS 1 (
    SET displayMessage=Sorry, we're sold out of that Tonic.
    GOTO :VENDOR_ALCHEMIST
) ELSE (
    IF %player.coins% LSS %vendor.alchemist_magicka_tonic_price% (
        SET displayMessage=Sorry, you can't afford that Tonic.
        GOTO :VENDOR_ALCHEMIST
    ) ELSE (
        SET /A player.coins=!player.coins! -%vendor.alchemist.magicka_tonic_price%
        SET /A player.item_tonic_magicka_owned=!player.item_tonic_magicka_owned! +1
        SET /A vendor.alchemist_magicka_tonic_stock=!vendor.alchemist_magicka_tonic_stock! -1
        SET displayMessage=Purchased 1 Magicka Tonic for %vendor.alchemist_magicka_tonic_price%.
        GOTO :VENDOR_ALCHEMIST
    )
)

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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a SWORD to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| LONG SWORD: %vendor.blacksmith_long_sword_stock% STOCKED, PRICE: %vendor.blacksmith_long_sword_price% LUNIS.
ECHO ^| SHORT SWORD: %vendor.blacksmith_short_sword_stock% STOCKED, PRICE: %vendor.blacksmith_short_sword_price% LUNIS.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LONGSWORD ] ^| [2 / SHORTSWORD ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_LONG_SWORD
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_SHORT_SWORD
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONScc
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_LONG_SWORD
CLS
SET RETURN=BLACKSMITH_INSPECT_LONG_SWORD
MODE con: cols=101 lines=24
ECHO.
TYPE "%cd%\data\assets\ui\long_sword.txt"
ECHO.
ECHO Inspecting the longsword.
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_long_sword_damage%
ECHO ^| CATEGORY: %windhelm.item_long_sword_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_long_sword_damage_type%
ECHO ^| OWNED: %player.item_long_sword_owned%
ECHO ^| PRICE: %vendor.blacksmith_long_sword_price%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +---------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_LONG_SWORD
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_SWORDS
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_LONG_SWORD
IF %player.coins% LSS %vendor.blacksmith_long_sword_price% (
    SET displayMessage=You cannot afford this item.
    GOTO :BLACKSMITH_CATEGORY_SWORDS
) ELSE (
    SET /A player.coins=%player.coins% -%vendor.blacksmith_long_sword_price%
    SET /A player.item_long_sword_owned=%player.item_long_sword_owned% +1
    SET itemPurchased=Purchased [1] longsword.
    GOTO :BLACKSMITH_CATEGORY_SWORDS
)

:BLACKSMITH_INSPECT_SHORT_SWORD
CLS
SET RETURN=BLACKSMITH_INSPECT_SHORT_SWORD
MODE con: cols=111 lines=22
ECHO.
TYPE "%cd%\data\assets\ui\short_sword.txt"
ECHO.
ECHO Showing detailed information for the shortsword.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_short_sword_damage%
ECHO ^| CATEGORY: %windhelm.item_short_sword_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_short_sword_damage_type%
ECHO ^| OWNED: %player.item_short_sword_owned%
ECHO ^| PRICE: %vendor.blacksmith_short_sword_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_SHORT_SWORD
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_SWORDS
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_SHORT_SWORD
IF %player.coins% LSS %vendor.blacksmith_short_sword_price% (
    SET displayMessage=You cannot afford this item.
    GOTO :BLACKSMITH_CATEGORY_SWORDS
) ELSE (
    SET /A player.coins=%player.coins% -%vendor.blacksmith_short_sword_price%
    SET /A player.item_short_sword_owned=%player.item_short_sword_owned% +1
    SET displayMessage=Purchased [1] shortsword.
    GOTO :BLACKSMITH_CATEGORY_SWORDS
)

:BLACKSMITH_CATEGORY_AXES
MODE con: cols=100 lines=21
CLS
SET RETURN=BLACKSMITH_CATEGORY_AXES
ECHO.
TYPE "%cd%\data\assets\ui\axes.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select an AXE to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| GREAT AXE: %vendor.blacksmith_great_axe_stock% STOCKED, PRICE: %vendor.blacksmith_great_axe_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / GREAT AXE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_GREAT_AXE
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONS
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_GREAT_AXE
CLS
SET RETURN=BLACKSMITH_INSPECT_GREAT_AXE
MODE con: cols=111 lines=21
ECHO.
TYPE "%cd%\data\assets\ui\great_axe.txt"
ECHO.
ECHO Showing detailed information for the Great Axe.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_great_axe_damage%
ECHO ^| CATEGORY: %windhelm.item_great_axe_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_great_axe_damage_type%
ECHO ^| OWNED: %player.item_great_axe_owned%
ECHO ^| PRICE: %vendor.blacksmith_great_axe_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_GREAT_AXE
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_AXES
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_GREAT_AXE
REM Check if the Blacksmith has this item in stock.
IF %vendor.blacksmith_great_axe_stock% LEQ 0 (
    REM There is none of this item in stock.
    SET displayMessage=Sorry, we're sold out of this weapon.
    GOTO :BLACKSMITH_CATEGORY_AXES
) ELSE (
    REM Check if the Player can afford this item.
    IF %player.coins% LSS %vendor.blacksmith_great_axe_price% (
        REM THe Player cannot afford this item.
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_AXES
    ) ELSE (
        REM Purchase the item.
        SET /A player.item_great_axe_owned=!player.item_great_axe_owned! +1
        SET /A vendor.blacksmith_great_axe_stock=!vendor.blacksmith_great_axe_stock! -1
        SET /A player.coins=!player.coins! -%blacksmith_great_axe_price%
        SET displayMessage=Purchased 1 Great Axe for %vendor.blacksmith_great_axe_price%.
        GOTO :BLACKSMITH_CATEGORY_AXES
    )
)

:BLACKSMITH_CATEGORY_MACES
MODE con: cols=100 lines=21
CLS
SET RETURN=BLACKSMITH_CATEGORY_MACES
ECHO.
TYPE "%cd%\data\assets\ui\maces.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a MACE to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| MACE: %vendor.blacksmith_mace_stock% STOCKED, PRICE: %vendor.blacksmith_mace_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / MACE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_MACE
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONS
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_MACE
CLS
SET RETURN=BLACKSMITH_INSPECT_MACE
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\mace.txt"
ECHO.
ECHO Showing detailed information for the Great Axe.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_mace_damage%
ECHO ^| CATEGORY: %windhelm.item_mace_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_mace_damage_type%
ECHO ^| OWNED: %player.item_mace_owned%
ECHO ^| PRICE: %vendor.blacksmith_mace_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_MACE
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_MACES
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_MACE
REM Check if the Blacksmith has this item in stock.
IF %vendor.blacksmith_mace_stock% LEQ 0 (
    REM There is none of this item in stock.
    SET displayMessage=Sorry, we're sold out of this weapon.
    GOTO :BLACKSMITH_CATEGORY_MACES
) ELSE (
    REM Check if the Player can afford this item.
    IF %player.coins% LSS %vendor.blacksmith_mace_price% (
        REM THe Player cannot afford this item.
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_MACES
    ) ELSE (
        REM Purchase the item.
        SET /A player.item_mace_owned=!player.item_mace_owned! +1
        SET /A vendor.blacksmith_mace_stock=!vendor.blacksmith_mace_stock! -1
        SET /A player.coins=!player.coins! -%blacksmith_mace_price%
        SET displayMessage=Purchased 1 Mace for %vendor.blacksmith_mace_price%.
        GOTO :BLACKSMITH_CATEGORY_MACES
    )
)

:BLACKSMITH_CATEGORY_BOWS
MODE con: cols=100 lines=21
CLS
SET RETURN=BLACKSMITH_CATEGORY_BOWS
ECHO.
TYPE "%cd%\data\assets\ui\bows.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a BOW to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| WOODEN BOW: %vendor.blacksmith_wooden_bow_stock% STOCKED, PRICE: %vendor.blacksmith_wooden_bow_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WOODEN BOW ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_BOW
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_WEAPONS
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_BOW
CLS
SET RETURN=BLACKSMITH_INSPECT_BOW
MODE con: cols=111 lines=21
ECHO.
TYPE "%cd%\data\assets\ui\wooden_bow.txt"
ECHO.
ECHO Showing detailed information for the Wooden Bow.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_wooden_bow_damage%
ECHO ^| CATEGORY: %windhelm.item_wooden_bow_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_wooden_bow_damage_type%
ECHO ^| OWNED: %player.item_wooden_bow_owned%
ECHO ^| PRICE: %vendor.blacksmith_wooden_bow_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_BOW
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_BOWS
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_BOW
REM Check if the Blacksmith has this item in stock.
IF %vendor.blacksmith_wooden_bow_stock% LEQ 0 (
    REM There is none of this item in stock.
    SET displayMessage=Sorry, we're sold out of this weapon.
    GOTO :BLACKSMITH_CATEGORY_BOWS
) ELSE (
    REM Check if the Player can afford this item.
    IF %player.coins% LSS %vendor.blacksmith_wooden_bow_price% (
        REM THe Player cannot afford this item.
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_BOWS
    ) ELSE (
        REM Purchase the item.
        SET /A player.item_wooden_bow_owned=!player.item_wooden_bow_owned! +1
        SET /A vendor.blacksmith_wooden_bow_stock=!vendor.blacksmith_wooden_bow_stock! -1
        SET /A player.coins=!player.coins! -%blacksmith_wooden_bow_price%
        SET displayMessage=Purchased 1 Wooden Bow for %vendor.blacksmith_wooden_bow_price%.
        GOTO :BLACKSMITH_CATEGORY_BOWS
    )
)

:BLACKSMITH_TYPE_ARMOR
MODE con: cols=100 lines=19
CLS
SET RETURN=BLACKSMITH_TYPE_ARMOR
ECHO.
TYPE "%cd%\data\assets\ui\armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an ARMOR SET to purchase.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| CACTUS ARMOR: %vendor.blacksmith_cactus_armor_stock% STOCKED, PRICE: %vendor.blacksmith_cactus_armor_price% LUNIS.
ECHO ^| GUARD ARMOR: %vendor.blacksmith_guard_armor_stock% STOCKED, PRICE: %vendor.blacksmith_guard_armor_price% LUNIS.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CACTUS ARMOR ] ^| [2 / GUARD ARMOR ] ^| [Q / BACK ]
ECHO +-----------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_CACTUS_ARMOR
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_GUARD_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_CACTUS_ARMOR
CLS
SET RETURN=BLACKSMITH_INSPECT_CACTUS_ARMOR
MODE con: cols=122 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\cactus_armor.txt"
ECHO.
ECHO Showing detailed information for the Cactus Armor set.
ECHO +------------------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_cactus_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_cactus_armor_category%
ECHO ^| OWNED: %player.item_cactus_armor_owned%
ECHO ^| PRICE: %vendor.blacksmith_cactus_armor_price%
ECHO +------------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +------------------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_CACTUS_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_CACTUS_ARMOR
IF %vendor.blacksmith_cactus_armor_stock% LEQ 0 (
    SET displayMessage=Sorry, we're sold out of this set.
    GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
) ELSE (
    IF %player.coins% LSS %vendor.blacksmith_cactus_armor_price% (
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
    ) ELSE (
        SET /A player.item_cactus_armor_owned=!player.item_cactus_armor_owned! +1
        SET /A vendor.blacksmith_cactus_armor_stock=!vendor.blacksmith_cactus_armor_stock! -1
        SET /A player.coins=!player.coins! -%vendor.blacksmith_cactus_armor_price%
        SET displayMessage=Purchased 1 Cactus Armor set for %vendor.blacksmith_cactus_armor_price%.
        GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
    )
)

:BLACKSMITH_INSPECT_GUARD_ARMOR
CLS
SET RETURN=BLACKSMITH_INSPECT_GUARD_ARMOR
MODE con: cols=112 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\guard_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set.
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_guard_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_guard_armor_category%
ECHO ^| OWNED: %player.item_guard_armor_owned%
ECHO ^| PRICE: %vendor.blacksmith_guard_armor_price%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_GUARD_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_GUARD_ARMOR
IF %vendor.blacksmith_guard_armor_stock% LEQ 0 (
    SET displayMessage=Sorry, we're sold out of this set.
    GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
) ELSE (
    IF %player.coins% LSS %vendor.blacksmith_guard_armor_price% (
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
    ) ELSE (
        SET /A player.item_guard_armor_owned=!player.item_guard_armor_owned! +1
        SET /A vendor.blacksmith_guard_armor_stock=!vendor.blacksmith_guard_armor_stock! -1
        SET /A player.coins=!player.coins! -%vendor.blacksmith_guard_armor_price%
        SET displayMessage=Purchased 1 Guard Armor set for %vendor.blacksmith_guard_armor_price%.
        GOTO :BLACKSMITH_CATEGORY_LIGHT_ARMOR
    )
)

:BLACKSMITH_CATEGORY_MEDIUM_ARMOR
MODE con: cols=125 lines=22
CLS
SET RETURN=BLACKSMITH_CATEGORY_MEDIUM_ARMOR
ECHO.
TYPE "%cd%\data\assets\ui\medium_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an ARMOR SET to purchase.
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| STONE: %vendor.blacksmith_stone_armor_stock% STOCKED, PRICE: %vendor.blacksmith_stone_armor_price% LUNIS.
ECHO ^| IRON: %vendor.blacksmith_iron_armor_stock% STOCKED, PRICE: %vendor.blacksmith_iron_armor_price% LUNIS.
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / STONE ARMOR ] ^| [2 / IRON ARMOR ] ^| [Q / BACK ]
ECHO +---------------------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_STONE_ARMOR
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_IRON_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_STONE_ARMOR
CLS
SET RETURN=BLACKSMITH_INSPECT_STONE_ARMOR
MODE con: cols=112 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\stone_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set.
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_stone_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_stone_armor_category%
ECHO ^| OWNED: %player.item_stone_armor_owned%
ECHO ^| PRICE: %vendor.blacksmith_stone_armor_price%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_STONE_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_STONE_ARMOR
IF %vendor.blacksmith_stone_armor_stock% LEQ 0 (
    SET displayMessage=Sorry, we're sold out of this set.
    GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
) ELSE (
    IF %player.coins% LSS %vendor.blacksmith_stone_armor_price% (
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
    ) ELSE (
        SET /A player.item_stone_armor_owned=!player.item_stone_armor_owned! +1
        SET /A vendor.blacksmith_stone_armor_stock=!vendor.blacksmith_stone_armor_stock! -1
        SET /A player.coins=!player.coins! -%vendor.blacksmith_stone_armor_price%
        SET displayMessage=Purchased 1 Stone Armor set for %vendor.blacksmith_stone_armor_price%.
        GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
    )
)

:BLACKSMITH_INSPECT_IRON_ARMOR
CLS
SET RETURN=BLACKSMITH_INSPECT_IRON_ARMOR
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\iron_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_iron_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_iron_armor_category%
ECHO ^| OWNED: %player.item_iron_armor_owned%
ECHO ^| PRICE: %vendor.blacksmith_iron_armor_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_IRON_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_IRON_ARMOR
IF %vendor.blacksmith_iron_armor_stock% LEQ 0 (
    SET displayMessage=Sorry, we're sold out of this set.
    GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
) ELSE (
    IF %player.coins% LSS %vendor.blacksmith_iron_armor_price% (
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
    ) ELSE (
        SET /A player.item_iron_armor_owned=!player.item_iron_armor_owned! +1
        SET /A vendor.blacksmith_iron_armor_stock=!vendor.blacksmith_iron_armor_stock! -1
        SET /A player.coins=!player.coins! -%vendor.blacksmith_iron_armor_price%
        SET displayMessage=Purchased 1 Iron Armor set for %vendor.blacksmith_iron_armor_price%.
        GOTO :BLACKSMITH_CATEGORY_MEDIUM_ARMOR
    )
)

:BLACKSMITH_CATEGORY_HEAVY_ARMOR
MODE con: cols=115 lines=25
CLS
SET RETURN=BLACKSMITH_CATEGORY_HEAVY_ARMOR
ECHO.
TYPE "%cd%\data\assets\ui\heavy_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an ARMOR SET to purchase.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| STEEL: %vendor.blacksmith_steel_armor_stock% STOCKED, PRICE: %vendor.blacksmith_steel_armor_price% LUNIS.
ECHO ^| SCALE: %vendor.blacksmith_scale_armor_stock% STOCKED, PRICE: %vendor.blacksmith_scale_armor_price% LUNIS.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / STEEL ARMOR ] ^| [2 / SCALE ARMOR ] ^| [Q / BACK ]
ECHO +-----------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_INSPECT_STEEL_ARMOR
IF /I "%CH%" == "2" GOTO :BLACKSMITH_INSPECT_SCALE_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_TYPE_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_INSPECT_STEEL_ARMOR
CLS
SET RETURN=BLACKSMITH_INSPECT_STEEL_ARMOR
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\steel_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_steel_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_steel_armor_category%
ECHO ^| OWNED: %player.item_steel_armor_owned%
ECHO ^| PRICE: %vendor.blacksmith_steel_armor_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_STEEL_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_STEEL_ARMOR
IF %vendor.blacksmith_steel_armor_stock% LEQ 0 (
    SET displayMessage=Sorry, we're sold out of this set.
    GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
) ELSE (
    IF %player.coins% LSS %vendor.blacksmith_steel_armor_price% (
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
    ) ELSE (
        SET /A player.item_steel_armor_owned=!player.item_steel_armor_owned! +1
        SET /A vendor.blacksmith_steel_armor_stock=!vendor.blacksmith_steel_armor_stock! -1
        SET /A player.coins=!player.coins! -%vendor.blacksmith_steel_armor_price%
        SET displayMessage=Purchased 1 Iron Armor set for %vendor.blacksmith_steel_armor_price%.
        GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
    )
)


:BLACKSMITH_INSPECT_SCALE_ARMOR
CLS
SET RETURN=BLACKSMITH_INSPECT_SCALE_ARMOR
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\scale_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_scale_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_scale_armor_category%
ECHO ^| OWNED: %player.item_scale_armor_owned%
ECHO ^| PRICE: %vendor.blacksmith_scale_armor_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :BLACKSMITH_BUY_SCALE_ARMOR
IF /I "%CH%" == "Q" GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
GOTO :INVALID_INPUT

:BLACKSMITH_BUY_SCALE_ARMOR
IF %vendor.blacksmith_scale_armor_stock% LEQ 0 (
    SET displayMessage=Sorry, we're sold out of this set.
    GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
) ELSE (
    IF %player.coins% LSS %vendor.blacksmith_scale_armor_price% (
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
    ) ELSE (
        SET /A player.item_scale_armor_owned=!player.item_scale_armor_owned! +1
        SET /A vendor.blacksmith_scale_armor_stock=!vendor.blacksmith_scale_armor_stock! -1
        SET /A player.coins=!player.coins! -%vendor.blacksmith_scale_armor_price%
        SET displayMessage=Purchased 1 Scale Armor set for %vendor.blacksmith_scale_armor_price%.
        GOTO :BLACKSMITH_CATEGORY_HEAVY_ARMOR
    )
)

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

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i