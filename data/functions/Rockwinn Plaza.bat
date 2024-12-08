TITLE (Rockwinn Plaza) - Rockwinn Plaza ^| %player.name% the %player.class%

SET refunded=false
SET refundPrice=0

REM Main Menu.
:MAIN
MODE con: cols=127 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\rwp.txt"
ECHO.
ECHO You enter the bustling street, inspecting each vendors stall closely.
ECHO %displayMessage%
REM CORRECT THESE VARIABLES AND NAMES.
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
ECHO + [1 / ALCHEMIST ] ^| [2 / BLACKSMITH ] ^| [3 / LOREKEEPER ] ^| [4 / WIZARD ] ^| [E / LEAVE ]                    +
ECHO +-----------------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1234E /N /M ">"
IF ERRORLEVEL 5 GOTO :AUTOSAVE
IF ERRORLEVEL 4 GOTO :VENDOR_WIZARD
IF ERRORLEVEL 2 GOTO :VENDOR_BLACKSMITH
IF ERRORLEVEL 1 GOTO :VENDOR_ALCHEMIST

REM Alchemist Vendor.
:VENDOR_ALCHEMIST
TITLE (Rockwinn Plaza) - Alchemist ^| %player.name% the %player.class%
MODE con: cols=100 lines=22
REM --
ECHO.
TYPE "%cd%\data\ascii\npcs\alchemist.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HEALING TONIC: %vendor.alchemist.healing_tonic_stock% STOCKED, PRICE: %vendor.alchemist.healing_tonic_price% LUNIS
ECHO ^| STAMINA TONIC: %vendor.alchemist.stamina_tonic_stock% STOCKED, PRICE: %vendor.alchemist.stamina_tonic_price% LUNIS
ECHO ^| MAGICKA TONIC: %vendor.alchemist.magicka_tonic_stock% STOCKED, PRICE: %vendor.alchemist.magicka_tonic_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + [1 / HEALING TONIC ] ^| [2 / STAMINA TONIC ] ^| [3 / MAGICKA TONIC ] ^| [E / GO BACK ]              +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123E /N /M ">"
IF ERRORLEVEL 4 GOTO :MAIN
IF ERRORLEVEl 3 GOTO :ALCHEMIST_BUY_MAGICKA_TONIC
IF ERRORLEVEL 2 GOTO :ALCHEMIST_BUY_STAMINA_TONIC
IF ERRORLEVEL 1 GOTO :ALCHEMIST_BUY_HEALING_TONIC

REM Purchase Magicka Tonic
:ALCHEMIST_BUY_MAGICKA_TONIC
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

REM Purchase Stamina Tonic
:ALCHEMIST_BUY_STAMINA_TONIC
IF %vendor.alchemist.stamina_tonic_stock% LSS 1 (
    SET displayMessage=Sorry, we're sold out of that Tonic.
    GOTO :VENDOR_ALCHEMIST
) ELSE (
    IF %player.coins% LSS %vendor.alchemist_stamina_tonic_price% (
        SET displayMessage=Sorry, you can't afford that Tonic.
        GOTO :VENDOR_ALCHEMIST
    ) ELSE (
        SET /A player.coins=!player.coins! -%vendor.alchemist.stamina_tonic_price%
        SET /A player.item_tonic_stamina_owned=!player.item_tonic_stamina_owned! +1
        SET /A vendor.alchemist_stamina_tonic_stock=!vendor.alchemist_stamina_tonic_stock! -1
        SET displayMessage=Purchased 1 Stamina Tonic for %vendor.alchemist_stamina_tonic_price%.
        GOTO :VENDOR_ALCHEMIST
    )
)

REM Purchase Healing Tonic
:ALCHEMIST_BUY_STAMINA_TONIC
IF %vendor.alchemist.healing_tonic_stock% LSS 1 (
    SET displayMessage=Sorry, we're sold out of that Tonic.
    GOTO :VENDOR_ALCHEMIST
) ELSE (
    IF %player.coins% LSS %vendor.alchemist_healing_tonic_price% (
        SET displayMessage=Sorry, you can't afford that Tonic.
        GOTO :VENDOR_ALCHEMIST
    ) ELSE (
        SET /A player.coins=!player.coins! -%vendor.alchemist.healing_tonic_price%
        SET /A player.item_tonic_healing_owned=!player.item_tonic_healing_owned! +1
        SET /A vendor.alchemist_healing_tonic_stock=!vendor.alchemist_healing_tonic_stock! -1
        SET displayMessage=Purchased 1 Healing Tonic for %vendor.alchemist_healing_tonic_price%.
        GOTO :VENDOR_ALCHEMIST
    )
)

REM Blacksmith Vendor.
:VENDOR_BLACKSMITH
TITLE (Rockwinn Plaza) - Blacksmith ^| %player.name% the %player.class%
MODE con: cols=109 lines=22
ECHO.
TYPE "%cd%\data\ascii\npcs\blacksmith.txt"
ECHO.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO ^| Select a TYPE of item to view.
ECHO +-----------------------------------------------------------------------------------------------------------+
ECHO + [1 / WEAPONS ] ^| [2 / ARMORS ] ^| [Q / BACK ]
ECHO +-----------------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEL 2 GOTO :BLACKSMITH_TYPE_ARMOR
IF ERRORLEVEL 1 GOTO :BLACKSMITH_TYPE_WEAPONS

REM Display the "weapons" type.
:BLACKSMITH_TYPE_WEAPONS
MODE con: cols=100 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\swords.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a CATEGORY of weapon to view.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SWORDS ] ^| [2 / AXE ] ^| [3 / MACES ] ^| [4 / BOWS ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 5 GOTO :VENDOR_BLACKSMITH
IF ERRORLEVEl 4 GOTO :BLACKSMITH_CATEGORY_BOWS
IF ERRORLEVEL 3 GOTO :BLACKSMITH_CATEGORY_MACES
IF ERRORLEVEL 2 GOTO :BLACKSMITH_CATEGORY_AXES
IF ERRORLEVEL 1 GOTO :BLACKSMITH_CATEGORY_SWORDS

:BLACKSMITH_CATEGORY_SWORDS
MODE con: cols=100 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\swords.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a SWORD to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| LONG SWORD: %vendor.blacksmith_long_sword_stock% STOCKED, PRICE: %vendor.blacksmith_long_sword_price% LUNIS.
ECHO ^| SHORT SWORD: %vendor.blacksmith_short_sword_stock% STOCKED, PRICE: %vendor.blacksmith_short_sword_price% LUNIS.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LONG SWORD ] ^| [2 / SHORT SWORD ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :VENDOR_BLACKSMITH
IF ERRORLEVEL 2 GOTO :BLACKSMITH_INSPECT_SHORT_SWORD
IF ERRORLEVEL 1 GOTO :BLACKSMITH_INSPECT_LONG_SWORD

:BLACKSMITH_INSPECT_LONG_SWORD
CLS
MODE con: cols=101 lines=23
ECHO.
TYPE "%cd%\data\assets\ui\long_sword.txt"
ECHO.
ECHO Inspecting the Long Sword.
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_long_sword_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_long_sword_stamina_usage%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
CHOICE /C 12 /N /M ">"
IF ERRORLEVEL 2 GOTO :BLACKSMITH_CATEGORY_SWORDS
IF ERRORLEVEL 1 GOTO :BLACKSMITH_BUY_LONG_SWORD

:BLACKSMITH_BUY_Long_SWORD
REM Check if the Blacksmith has this item in stock.
IF %vendor.blacksmith_long_sword_stock% LEQ 0 (
    REM There is none of this item in stock.
    SET displayMessage=Sorry, we're sold out of this weapon.
    GOTO :BLACKSMITH_CATEGORY_SWORDS
) ELSE (
    REM Check if the Player can afford this item.
    IF %player.coins% LSS %vendor.blacksmith_long_sword_price% (
        REM THe Player cannot afford this item.
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_SWORDS
    ) ELSE (
        REM Purchase the item.
        SET /A player.item_long_sword_owned=!player.item_long_sword_owned! +1
        SET /A vendor.blacksmith_long_sword_stock=!vendor.blacksmith_long_sword_stock! -1
        SET /A player.coins=!player.coins! -%blacksmith_long_sword_price%
        SET displayMessage=Purchased 1 Long Sword for %vendor.blacksmith_long_sword_price%.
        GOTO :BLACKSMITH_CATEGORY_SWORDS
    )
)

:BLACKSMITH_INSPECT_SHORT_SWORD
CLS
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\short_sword.txt"
ECHO.
ECHO Showing detailed information for the Short Sword.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_short_sword_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_short_sword_stamina_usage%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
CHOICE /C 12 /N /M ">"
IF ERRORLEVEL 2 GOTO :BLACKSMITH_CATEGORY_SWORDS
IF ERRORLEVEl 1 GOTO :BLACKSMITH_BUY_SHORT_SWORD

:BLACKSMITH_BUY_SHORT_SWORD
REM Check if the Blacksmith has this item in stock.
IF %vendor.blacksmith_short_sword_stock% LEQ 0 (
    REM There is none of this item in stock.
    SET displayMessage=Sorry, we're sold out of this weapon.
    GOTO :BLACKSMITH_CATEGORY_SWORDS
) ELSE (
    REM Check if the Player can afford this item.
    IF %player.coins% LSS %vendor.blacksmith_short_sword_price% (
        REM THe Player cannot afford this item.
        SET displayMessage=Sorry, you can't afford this weapon.
        GOTO :BLACKSMITH_CATEGORY_SWORDS
    ) ELSE (
        REM Purchase the item.
        SET /A player.item_short_sword_owned=!player.item_short_sword_owned! +1
        SET /A vendor.blacksmith_short_sword_stock=!vendor.blacksmith_short_sword_stock! -1
        SET /A player.coins=!player.coins! -%blacksmith_short_sword_price%
        SET displayMessage=Purchased 1 Short Sword for %vendor.blacksmith_short_sword_price%.
        GOTO :BLACKSMITH_CATEGORY_SWORDS
    )
)

:BLACKSMITH_CATEGORY_AXES
MODE con: cols=100 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\axes.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select an AXE to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| GREAT AXE: %vendor.blacksmith_great_axe_stock% STOCKED, PRICE: %vendor.blacksmith_great_axe_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / GREAT AXE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :VENDOR_BLACKSMITH
IF ERRORLEVEL 1 GOTO :BLACKSMITH_INSPECT_GREAT_AXE

:BLACKSMITH_INSPECT_GREAT_AXE
CLS
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\great_axe.txt"
ECHO.
ECHO Showing detailed information for the Great Axe.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_great_axe_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_great_axe_stamina_usage%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
CHOICE /C 12 /N /M ">"
IF ERRORLEVEL 2 GOTO :BLACKSMITH_CATEGORY_AXES
IF ERRORLEVEl 1 GOTO :BLACKSMITH_BUY_GREAT_AXE

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
MODE con: cols=100 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\mace.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a SWORD to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| MACE: %vendor.blacksmith_mace_stock% STOCKED, PRICE: %vendor.blacksmith_mace_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / MACE ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :VENDOR_BLACKSMITH
IF ERRORLEVEL 2 GOTO :BLACKSMITH_INSPECT_MACE

:BLACKSMITH_INSPECT_MACE
CLS
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\mace.txt"
ECHO.
ECHO Showing detailed information for the Great Axe.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_mace_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_mace_stamina_usage%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
CHOICE /C 12 /N /M ">"
IF ERRORLEVEL 2 GOTO :BLACKSMITH_CATEGORY_MACES
IF ERRORLEVEl 1 GOTO :BLACKSMITH_BUY_MACE

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
MODE con: cols=100 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\wooden_bow.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a SWORD to purchase.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| MACE: %vendor.blacksmith_wooden_bow_stock% STOCKED, PRICE: %vendor.blacksmith_wooden_bow_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WOODEN BOW ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :VENDOR_BLACKSMITH
IF ERRORLEVEL 2 GOTO :BLACKSMITH_INSPECT_BOW

:BLACKSMITH_INSPECT_BOW
CLS
MODE con: cols=111 lines=20
ECHO.
TYPE "%cd%\data\assets\ui\wooden_bow.txt"
ECHO.
ECHO Showing detailed information for the Wooden Bow.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_wooden_bow_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_wooden_bow_stamina_usage%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
CHOICE /C 12 /N /M ">"
IF ERRORLEVEL 2 GOTO :BLACKSMITH_CATEGORY_BOWS
IF ERRORLEVEl 1 GOTO :BLACKSMITH_BUY_BOW

:BLACKSMITH_BUY_MACE
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

REM Saves Merchant data.
:AUTOSAVE
SET SLOPr=SAVE
CALL "%cd%\data\functions\SLOP.bat"
GOTO :EOF