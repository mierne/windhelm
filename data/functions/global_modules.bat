REM WINDHELM -- Global Modules for Vendors

:vendor
SET windhelm.global_item_price=%2
goto :%1

:INSPECT_HEALTH_TONIC
CLS
SET "RETURN=INSPECT_HEALTH_TONIC"
MODE con: cols=103 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\health_tonic.txt"
ECHO.
ECHO Showing detailed information for the Healing Tonic. ^| %displayMessage% 
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_healing_owned%
ECHO ^| MODIFIER: +%windhelm.item_tonic_healing_modifier% HP
ECHO ^| CATEGORY: %windhelm.item_tonic_healing_category%
ECHO ^| TYPE: %windhelm.item_tonic_healing_type%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO [P / PURCHASE ] ^| [Q / BACK ]
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_HEALTH_TONIC
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_HEALTH_TONIC
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_tonic_healing_owned+=1
        SET "displayMessage=Purchased 1 Healing Tonic for %windhelm.global_item_price% Lunis."
        goto :INSPECT_HEALTH_TONIC
)

:INSPECT_MAGICKA_TONIC
SET RETURN=INSPECT_MAGICKA_TONIC
MODE con: cols=115 lines=22
ECHO.
TYPE "%cd%\data\assets\ui\magicka_tonic.txt"
ECHO.
ECHO Showing detailed information for the Magicka Tonic. ^| %displayMessage% 
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_magicka_owned%
ECHO ^| MODIFIER: +%windhelm.item_tonic_magicka_modifier% HP
ECHO ^| CATEGORY: %windhelm.item_tonic_magicka_category%
ECHO ^| TYPE: %windhelm.item_tonic_magicka_type%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO [P / PURCHASE ] ^| [Q / BACK ]
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_MAGICKA_TONIC
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_MAGICKA_TONIC
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_tonic_magicka_owned+=1
        set "displayMessage=Purchased 1 Magicka Tonic for %windhelm.global_item_price% Lunis."
        goto :INSPECT_MAGICKA_TONIC
)

:INSPECT_LONGSWORD
SET "RETURN=INSPECT_LONGSWORD"
MODE con: cols=101 lines=24
ECHO.
TYPE "%winLoc%\data\assets\ui\long_sword.txt"
ECHO.
ECHO Inspecting the Long Sword for purchase. ^| %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_long_sword_damage%
ECHO ^| CATEGORY: %windhelm.item_long_sword_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_long_sword_damage_type%
ECHO ^| OWNED: %player.item_long_sword_owned%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +---------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_LONGSWORD
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_LONGSWORD
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_long_sword_owned+=1
        SET "displayMessage=Purchased 1 longsword for %windhelm.global_item_price% Lunis."
        goto :INSPECT_LONGSWORD
)

:INSPECT_SHORTSWORD
CLS
SET "RETURN=INSPECT_SHORTSWORD"
MODE con: cols=111 lines=22
ECHO.
TYPE "%cd%\data\assets\ui\short_sword.txt"
ECHO.
ECHO Showing detailed information for the shortsword ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_short_sword_damage%
ECHO ^| CATEGORY: %windhelm.item_short_sword_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_short_sword_damage_type%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_SHORTSWORD
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_SHORTSWORD
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_short_sword_owned+=1
        SET "displayMessage=Purchased 1 shortsword for %windhelm.global_item_price% Lunis."
        goto :INSPECT_SHORTSWORD
)


:INSPECT_GREATAXE
CLS
SET RETURN=INSPECT_GREATAXE
MODE con: cols=111 lines=21
ECHO.
TYPE "%cd%\data\assets\ui\great_axe.txt"
ECHO.
ECHO Showing detailed information for the Greataxe. ^| %displayMessage% 
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_great_axe_damage%
ECHO ^| CATEGORY: %windhelm.item_great_axe_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_great_axe_damage_type%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_great_axe_owned%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_GREATAXE
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_GREATAXE
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_great_axe_owned+=1
        SET "displayMessage=Purchased 1 great axe for %windhelm.global_item_price% Lunis."
        goto :INSPECT_GREATAXE
)

:INSPECT_MACE
CLS
SET RETURN=INSPECT_MACE
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\mace.txt"
ECHO.
ECHO Showing detailed information for the Great Axe. ^| %displayMessage% 
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_mace_damage%
ECHO ^| CATEGORY: %windhelm.item_mace_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_mace_damage_type%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_mace_owned%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_MACE
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_MACE
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_mace_owned+=1
        SET "displayMessage=Purchased 1 mace for %windhelm.global_item_price% Lunis."
        goto :INSPECT_MACE
)

:INSPECT_WOODEN_BOW
CLS
SET RETURN=INSPECT_WOODEN_BOW
MODE con: cols=111 lines=21
ECHO.
TYPE "%cd%\data\assets\ui\wooden_bow.txt"
ECHO.
ECHO Showing detailed information for the Wooden Bow. ^| %displayMessage% 
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_wooden_bow_damage%
ECHO ^| CATEGORY: %windhelm.item_wooden_bow_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_wooden_bow_damage_type%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_wooden_bow_owned%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_WOODEN_BOW
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_WOODEN_BOW
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_wooden_bow_owned+=1
        SET "displayMessage=Purchased 1 wooden bow for %windhelm.global_item_price% Lunis."
        goto :INSPECT_WOODEN_BOW
)

:INSPECT_CACTUS_ARMOR
CLS
SET RETURN=INSPECT_CACTUS_ARMOR
MODE con: cols=122 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\cactus_armor.txt"
ECHO.
ECHO Showing detailed information for the Cactus Armor set. ^| %displayMessage% 
ECHO +------------------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_cactus_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_cactus_armor_category%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_cactus_armor_owned%
ECHO +------------------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +------------------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_CACTUS_ARMOR
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_CACTUS_ARMOR
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_cactus_armor_owned+=1
        SET "displayMessage=Purchased 1 Cactus Armor set for %windhelm.global_item_price% Lunis."
        goto :INSPECT_CACTUS_ARMOR
)

:INSPECT_GUARD_ARMOR
CLS
SET RETURN=INSPECT_GUARD_ARMOR
MODE con: cols=112 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\guard_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set. ^| %displayMessage% 
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_guard_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_guard_armor_category%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_guard_armor_owned%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_GUARD_ARMOR
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_GUARD_ARMOR
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_guard_armor_owned+=1
        SET "displayMessage=Purchased 1 Guard Armor set for %windhelm.global_item_price% Lunis."
        goto :INSPECT_GUARD_ARMOR
)

:INSPECT_STONE_ARMOR
CLS
SET RETURN=INSPECT_STONE_ARMOR
MODE con: cols=112 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\stone_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set. ^| %displayMessage% 
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_stone_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_stone_armor_category%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_stone_armor_owned%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_STONE_ARMOR
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_STONE_ARMOR
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_stone_armor_owned+=1
        SET "displayMessage=Purchased 1 Stone Armor set for %windhelm.global_item_price% Lunis."
        goto :INSPECT_STONE_ARMOR
)
:INSPECT_IRON_ARMOR
CLS
SET RETURN=INSPECT_IRON_ARMOR
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\iron_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set. ^| %displayMessage% 
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_iron_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_iron_armor_category%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_iron_armor_owned%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_IRON_ARMOR
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_IRON_ARMOR
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_iron_armor_owned+=1
        SET "displayMessage=Purchased 1 Iron Armor set for %windhelm.global_item_price% Lunis."
        goto :INSPECT_IRON_ARMOR
)

:INSPECT_STEEL_ARMOR
CLS
SET RETURN=INSPECT_STEEL_ARMOR
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\steel_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set. ^| %displayMessage% 
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_steel_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_steel_armor_category%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_steel_armor_owned%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_STEEL_ARMOR
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_STEEL_ARMOR
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_steel_armor_owned+=1
        SET "displayMessage=Purchased 1 Steel Armor set for %windhelm.global_item_price% Lunis."
        goto :INSPECT_STEEL_ARMOR
)

:INSPECT_SCALE_ARMOR
CLS
SET RETURN=INSPECT_SCALE_ARMOR
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\scale_armor.txt"
ECHO.
ECHO Showing detailed information for the Guard Armor set. ^| %displayMessage% 
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| PROTECTION: %windhelm.item_scale_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_scale_armor_category%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| OWNED: %player.item_scale_armor_owned%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [P / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "P" GOTO :PURCHASE_SCALE_ARMOR
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_SCALE_ARMOR
IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        set /a player.coins-=windhelm.global_item_price
        set /a player.item_scale_armor_owned+=1
        SET "displayMessage=Purchased 1 Scale Armor set for %windhelm.global_item_price% Lunis."
        goto :INSPECT_GREATAXE
)

:INVALID_INPUT
set "displayMessage="%CH%" is not a valid input."
GOTO :%RETURN%

:CANNOT_AFFORD_ITEM
SET "displayMessage=You can't afford this item."
GOTO :%RETURN%

:CLEANUP
GOTO :EOF