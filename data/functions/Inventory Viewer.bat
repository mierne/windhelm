TITLE (WINDHELM) Inventory Viewer ^| %player.name% the %player.class%

REM Return to simplicity
:IVM
MODE con: cols=100 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\inventory.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a TYPE of item to view.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WEAPONS ] ^| [2 / ARMORS ] ^| [3 / TONICS ] ^| [Q / EXIT ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 123Q /N /M ">"
IF ERRORLEVEL 4 GOTO :EOF
IF ERRORLEVEL 3 GOTO :VIEW_TYPE_TONICS
IF ERRORLEVEL 2 GOTO :VIEW_TYPE_ARMORS
IF ERRORLEVEL 1 GOTO :VIEW_TYPE_WEAPONS


REM Displays the categories of weapons and allows the Player to view their owned items in each.
:VIEW_TYPE_WEAPONS
MODE con: cols=100 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\weapons.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select a CATEGORY of WEAPON to view.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SWORDS ] ^| [2 / AXES ] ^| [3 / MACES ] ^| [4 / BOWS ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1234Q /N /M ">"
IF ERRORLEVEL 5 GOTO :IVM
IF ERRORLEVEL 4 GOTO :VIEW_CATEGORY_BOWS
IF ERRORLEVEL 3 GOTO :VIEW_CATEGORY_MACES
IF ERRORLEVEL 2 GOTO :VIEW_CATEGORY_AXES
IF ERRORLEVEL 1 GOTO :VIEW_CATEGORY_SWORDS

REM Displays weapons in the "swords" category.
:VIEW_CATEGORY_SWORDS
MODE con: cols=100 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\swords.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LONG SWORD (%player.item_long_sword_owned%) ] ^| [2 / SHORT SWORD (%player.item_short_sword_owned%) ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :VIEW_TYPE_WEAPONS
IF ERRORLEVEL 2 GOTO :INSPECT_SHORT_SWORD
IF ERRORLEVEL 1 GOTO :INSPECT_LONG_SWORD

REM Displays detailed information of the specific weapon.
:INSPECT_LONG_SWORD
CLS
MODE con: cols=101 lines=22
ECHO.
TYPE "%cd%\data\assets\ui\long_sword.txt"
ECHO.
ECHO Showing detailed information for the Long Sword.
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_long_sword_owned%
ECHO ^| DAMAGE: %windhelm.item_long_sword_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_long_sword_stamina_usage%
ECHO ^| CATEGORY: %windhelm.item_long_sword_category%
ECHO ^| TYPE: %windhelm.item_long_sword_type%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_SWORDS
IF ERRORLEVEL 2 GOTO :UNEQUIP_LONG_SWORD
IF ERRORLEVEL 1 GOTO :EQUIP_LONG_SWORD

REM Attempts to equip the Long Sword as the Player's active weapon.
:EQUIP_LONG_SWORD
REM First check that it or some other weapon isn't already equipped.
IF %player.weapon_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_long_sword_owned% GTR 0 (
        PAUSE
        REM The Player owns more than zero of this item.
        SET player.weapon_equipped=%windhelm.item_long_sword_name%
        SET player.damage=%windhelm.item_long_sword_damage%
        SET player.attack_stamina_usage=%windhelm.item_long_sword_stamina_usage%
        SET displayMessage=Equipped the Long Sword^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a weapon equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Long Sword from the Player's weapon equipment slot.
:UNEQUIP_LONG_SWORD
REM Check if this is even the active weapon.
IF NOT %player.weapon_equipped% == "Long Sword" (
    REM This isn't the active weapon.
    SET displayMessage=You do not have the Long Sword equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the weapon.
    SET player.weapon_equipped=EMPTY
    SET player.damage=5
    SET player.attack_stamina_usage=1
    SET displayMessage=Unequipped the Long Sword.
    GOTO :IVM
)

REM Displays detailed information of the specific weapon.
:INSPECT_SHORT_SWORD
CLS
MODE con: cols=111 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\short_sword.txt"
ECHO.
ECHO Showing detailed information for the Short Sword.
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_short_sword_owned%
ECHO ^| DAMAGE: %windhelm.item_short_sword_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_short_sword_stamina_usage%
ECHO ^| CATEGORY: %windhelm.item_short_sword_category%
ECHO ^| TYPE: %windhelm.item_short_sword_type%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_SWORDS
IF ERRORLEVEL 2 GOTO :UNEQUIP_SHORT_SWORD
IF ERRORLEVEL 1 GOTO :EQUIP_SHORT_SWORD

REM Attempts to equip the Long Sword as the Player's active weapon.
:EQUIP_SHORT_SWORD
REM First check that it or some other weapon isn't already equipped.
IF %player.weapon_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_short_sword_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.weapon_equipped=%windhelm.item_short_sword_name%
        SET player.damage=%windhelm.item_short_sword_damage%
        SET player.attack_stamina_usage=%windhelm.item_short_sword_stamina_usage%
        SET displayMessage=Equipped the Short Sword^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a weapon equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Short Sword from the Player's weapon equipment slot.
:UNEQUIP_SHORT_SWORD
REM Check if this is even the active weapon.
IF NOT %player.weapon_equipped% == "Short Sword" (
    REM This isn't the active weapon.
    SET displayMessage=You do not have the Short Sword equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the weapon.
    SET player.weapon_equipped=EMPTY
    SET player.damage=5
    SET player.attack_stamina_usage=1
    SET displayMessage=Unequipped the Short Sword.
    GOTO :IVM
)

REM Displays weapons in the "axes" category.
:VIEW_CATEGORY_AXES
MODE con: cols=100 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\axes.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / GREAT AXE (%player.item_great_axe_owned%) ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :VIEW_TYPE_WEAPONS
IF ERRORLEVEL 1 GOTO :INSPECT_GREAT_AXE

REM Displays detailed information of the specific weapon.
:INSPECT_GREAT_AXE
CLS
MODE con: cols=100 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\great_axe.txt"
ECHO.
ECHO Showing detailed information for the Great Axe.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_great_axe_owned%
ECHO ^| DAMAGE: %windhelm.item_great_axe_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_great_axe_stamina_usage%
ECHO ^| CATEGORY: %windhelm.item_great_axe_category%
ECHO ^| TYPE: %windhelm.item_great_axe_type%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_AXES
IF ERRORLEVEL 2 GOTO :UNEQUIP_GREAT_AXE
IF ERRORLEVEL 1 GOTO :EQUIP_GREAT_AXE

REM Attempts to equip the Great Axe as the Player's active weapon.
:EQUIP_GREAT_AXE
REM First check that it or some other weapon isn't already equipped.
IF %player.weapon_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_great_axe_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.weapon_equipped=%windhelm.item_great_axe_name%
        SET player.damage=%windhelm.item_great_axe_damage%
        SET player.attack_stamina_usage=%windhelm.item_great_axe_stamina_usage%
        SET displayMessage=Equipped the Great Axe^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a weapon equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Great Axe from the Player's weapon equipment slot.
:UNEQUIP_GREAT_AXE
REM Check if this is even the active weapon.
IF NOT %player.weapon_equipped% == "Great Axe" (
    REM This isn't the active weapon.
    SET displayMessage=You do not have the Great Axe equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the weapon.
    SET player.weapon_equipped=EMPTY
    SET player.damage=5
    SET player.attack_stamina_usage=1
    SET displayMessage=Unequipped the Great Axe.
    GOTO :IVM
)

REM Displays weapons in the "maces" category.
:VIEW_CATEGORY_MACES
MODE con: cols=100 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\maces.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / MACE (%player.item_mace_owned%) ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :VIEW_TYPE_WEAPONS
IF ERRORLEVEL 1 GOTO :INSPECT_MACE

REM Displays detailed information of the specific weapon.
:INSPECT_MACE
CLS
MODE con: cols=100 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\mace.txt"
ECHO.
ECHO Showing detailed information for the Mace.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_mace_owned%
ECHO ^| DAMAGE: %windhelm.item_mace_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_mace_stamina_usage%
ECHO ^| CATEGORY: %windhelm.item_mace_category%
ECHO ^| TYPE: %windhelm.item_mace_type%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_MACES
IF ERRORLEVEL 2 GOTO :UNEQUIP_MACE
IF ERRORLEVEL 1 GOTO :EQUIP_MACE

REM Attempts to equip the Mace as the Player's active weapon.
:EQUIP_MACE
REM First check that it or some other weapon isn't already equipped.
IF %player.weapon_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_mace_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.weapon_equipped=%windhelm.item_mace_name%
        SET player.damage=%windhelm.item_mace_damage%
        SET player.attack_stamina_usage=%windhelm.item_mace_stamina_usage%
        SET displayMessage=Equipped the Mace^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a weapon equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Mace from the Player's weapon equipment slot.
:UNEQUIP_MACE
REM Check if this is even the active weapon.
IF NOT %player.weapon_equipped% == "Mace" (
    REM This isn't the active weapon.
    SET displayMessage=You do not have the Mace equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the weapon.
    SET player.weapon_equipped=EMPTY
    SET player.damage=5
    SET player.attack_stamina_usage=1
    SET displayMessage=Unequipped the Mace.
    GOTO :IVM
)

REM Displays weapons in the "bows" category.
:VIEW_CATEGORY_BOWS
MODE con: cols=100 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\bows.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WOODEN BOW (%player.item_wooden_bow_owned%) ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :VIEW_TYPE_WEAPONS
IF ERRORLEVEL 1 GOTO :INSPECT_WOODEN_BOW

REM Displays detailed information of the specific weapon.
:INSPECT_WOODEN_BOW
CLS
MODE con: cols=105 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\wooden_bow.txt"
ECHO.
ECHO Showing detailed information for the Wooden Bow.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_wooden_bow_owned%
ECHO ^| DAMAGE: %windhelm.item_wooden_bow_damage%
ECHO ^| STAMINA USAGE: %windhelm.item_wooden_bow_stamina_usage%
ECHO ^| CATEGORY: %windhelm.item_wooden_bow_category%
ECHO ^| TYPE: %windhelm.item_wooden_bow_type%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_BOWS
IF ERRORLEVEL 2 GOTO :UNEQUIP_WOODEN_BOW
IF ERRORLEVEL 1 GOTO :EQUIP_WOODEN_BOW

REM Attempts to equip the Wooden Bow as the Player's active weapon.
:EQUIP_WOODEN_BOW
REM First check that it or some other weapon isn't already equipped.
IF %player.weapon_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_wooden_bow_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.weapon_equipped=%windhelm.item_wooden_bow_name%
        SET player.damage=%windhelm.item_wooden_bow_damage%
        SET player.attack_stamina_usage=%windhelm.item_wooden_bow_stamina_usage%
        SET displayMessage=Equipped the Wooden Bow^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a weapon equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Wooden Bow from the Player's weapon equipment slot.
:UNEQUIP_WOODEN_BOW
REM Check if this is even the active weapon.
IF NOT %player.weapon_equipped% == "Wooden Bow" (
    REM This isn't the active weapon.
    SET displayMessage=You do not have the Wooden Bow equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the weapon.
    SET player.weapon_equipped=EMPTY
    SET player.damage=5
    SET player.attack_stamina_usage=1
    SET displayMessage=Unequipped the Wooden Bow.
    GOTO :IVM
)

REM Displays the categories of armor and allows the Player to view their owned items in each.
:VIEW_TYPE_ARMORS
MODE con: cols=103 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\armors.txt"
ECHO.
ECHO %displayMessage%
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO ^| Select a CATEGORY of ARMOR to view.
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LIGHT ARMOR ] ^| [2 / HEAVY ARMOR ] ^| [3 / GREAT ARMOR ] ^| [4 / CRUDE ARMOR ] ^| [Q / BACK ]
ECHO +-----------------------------------------------------------------------------------------------------+
CHOICE /C 1234Q /N /M ">"
IF ERRORLEVEL 5 GOTO :IVM
IF ERRORLEVEL 4 GOTO :VIEW_CATEGORY_CRUDE_ARMOR
IF ERRORLEVEL 3 GOTO :VIEW_CATEGORY_GREAT_ARMOR
IF ERRORLEVEL 2 GOTO :VIEW_CATEGORY_HEAVY_ARMOR
IF ERRORLEVEL 1 GOTO :VIEW_CATEGORY_LIGHT_ARMOR

REM Displays armor in the "light armor" category.
:VIEW_CATEGORY_LIGHT_ARMOR
MODE con: cols=105 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\light_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CACTUS ARMOR (%player.item_cactus_armor_owned%) ] ^| [2 / GUARD ARMOR (%player.item_guard_armor_owned%) ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :VIEW_TYPE_ARMORS
IF ERRORLEVEL 2 GOTO :INSPECT_GUARD_ARMOR
IF ERRORLEVEL 1 GOTO :INSPECT_CACTUS_ARMOR

REM Displays detailed information of the specific armor.
:INSPECT_CACTUS_ARMOR
CLS
MODE con: cols=122 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\cactus_armor.txt"
ECHO.
ECHO Showing detailed information for Cactus Armor.
ECHO +------------------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_cactus_armor_owned%
ECHO ^| PROTECTION: %windhelm.item_cactus_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_cactus_armor_category%
ECHO ^| TYPE: %windhelm.item_cactus_armor_type%
ECHO +------------------------------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_LIGHT_ARMOR
IF ERRORLEVEL 2 GOTO :UNEQUIP_CACTUS_ARMOR
IF ERRORLEVEL 1 GOTO :EQUIP_CACTUS_ARMOR

REM Attempts to equip the Cactus Armor as the Player's active armor.
:EQUIP_CACTUS_ARMOR
REM First check that it or some other armor isn't already equipped.
IF %player.armor_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_cactus_armor_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.armor_equipped=%windhelm.item_cactus_armor_name%
        SET player.armor_prot=%windhelm.item_cactus_armor_damage%
        SET displayMessage=Equipped Cactus Armor^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a armor equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Cactus Armor from the Player's armor equipment slot.
:UNEQUIP_CACTUS_ARMOR
REM Check if this is even the active armor.
IF NOT %player.armor_equipped% == "Cactus Armor" (
    REM This isn't the active armor.
    SET displayMessage=You do not have Cactus Armor equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the armor.
    SET player.armor_equipped=EMPTY
    SET player.armor_prot=0
    SET displayMessage=Unequipped Cactus Armor.
    GOTO :IVM
)

REM Displays detailed information of the specific armor.
:INSPECT_GUARD_ARMOR
CLS
MODE con: cols=112 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\guard_armor.txt"
ECHO.
ECHO Showing detailed information for Guard Armor.
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_guard_armor_owned%
ECHO ^| PROTECTION: %windhelm.item_guard_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_guard_armor_category%
ECHO ^| TYPE: %windhelm.item_guard_armor_type%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_LIGHT_ARMOR
IF ERRORLEVEL 2 GOTO :UNEQUIP_GUARD_ARMOR
IF ERRORLEVEL 1 GOTO :EQUIP_GUARD_ARMOR

REM Attempts to equip the Guard Armor as the Player's active armor.
:EQUIP_GUARD_ARMOR
REM First check that it or some other armor isn't already equipped.
IF %player.armor_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_guard_armor_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.armor_equipped=%windhelm.item_guard_armor_name%
        SET player.armor_prot=%windhelm.item_guard_armor_damage%
        SET displayMessage=Equipped Guard Armor^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a armor equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Guard Armor from the Player's armor equipment slot.
:UNEQUIP_GUARD_ARMOR
REM Check if this is even the active armor.
IF NOT %player.armor_equipped% == "Guard Armor" (
    REM This isn't the active armor.
    SET displayMessage=You do not have Guard Armor equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the armor.
    SET player.armor_equipped=EMPTY
    SET player.armor_prot=0
    SET displayMessage=Unequipped Guard Armor.
    GOTO :IVM
)

REM Displays armor in the "heavy armor" category.
:VIEW_CATEGORY_HEAVY_ARMOR
MODE con: cols=112 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\heavy_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / STEEL ARMOR (%player.item_steel_armor_owned%) ] ^| [2 / IRON ARMOR (%player.item_iron_armor_owned%) ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :VIEW_TYPE_ARMORS
IF ERRORLEVEL 2 GOTO :INSPECT_IRON_ARMOR
IF ERRORLEVEL 1 GOTO :INSPECT_STEEL_ARMOR

REM Displays detailed information of the specific armor.
:INSPECT_STEEL_ARMOR
CLS
MODE con: cols=106 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\steel_armor.txt"
ECHO.
ECHO Showing detailed information for Steel Armor.
ECHO +--------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_steel_armor_owned%
ECHO ^| PROTECTION: %windhelm.item_steel_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_steel_armor_category%
ECHO ^| TYPE: %windhelm.item_steel_armor_type%
ECHO +--------------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_HEAVY_ARMOR
IF ERRORLEVEL 2 GOTO :UNEQUIP_STEEL_ARMOR
IF ERRORLEVEL 1 GOTO :EQUIP_STEEL_ARMOR

REM Attempts to equip the Steel Armor as the Player's active armor.
:EQUIP_STEEL_ARMOR
REM First check that it or some other armor isn't already equipped.
IF %player.armor_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_steel_armor_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.armor_equipped=%windhelm.item_steel_armor_name%
        SET player.armor_prot=%windhelm.item_steel_armor_damage%
        SET displayMessage=Equipped Steel Armor^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a armor equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Steel Armor from the Player's armor equipment slot.
:UNEQUIP_STEEL_ARMOR
REM Check if this is even the active armor.
IF NOT %player.armor_equipped% == "Steel Armor" (
    REM This isn't the active armor.
    SET displayMessage=You do not have Steel Armor equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the armor.
    SET player.armor_equipped=EMPTY
    SET player.armor_prot=0
    SET displayMessage=Unequipped Steel Armor.
    GOTO :IVM
)

REM Displays detailed information of the specific armor.
:INSPECT_IRON_ARMOR
CLS
MODE con: cols=100 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\iron_armor.txt"
ECHO.
ECHO Showing detailed information for Iron Armor.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_iron_armor_owned%
ECHO ^| PROTECTION: %windhelm.item_iron_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_iron_armor_category%
ECHO ^| TYPE: %windhelm.item_iron_armor_type%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_HEAVY_ARMOR
IF ERRORLEVEL 2 GOTO :UNEQUIP_IRON_ARMOR
IF ERRORLEVEL 1 GOTO :EQUIP_IRON_ARMOR

REM Attempts to equip the Iron Armor as the Player's active armor.
:EQUIP_IRON_ARMOR
REM First check that it or some other armor isn't already equipped.
IF %player.armor_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_iron_armor_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.armor_equipped=%windhelm.item_iron_armor_name%
        SET player.armor_prot=%windhelm.item_iron_armor_damage%
        SET displayMessage=Equipped Iron Armor^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a armor equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Iron Armor from the Player's armor equipment slot.
:UNEQUIP_IRON_ARMOR
REM Check if this is even the active armor.
IF NOT %player.armor_equipped% == "Iron Armor" (
    REM This isn't the active armor.
    SET displayMessage=You do not have Iron Armor equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the armor.
    SET player.armor_equipped=EMPTY
    SET player.armor_prot=0
    SET displayMessage=Unequipped Iron Armor.
    GOTO :IVM
)

REM Displays armor in the "great armor" category.
:VIEW_CATEGORY_GREAT_ARMOR
MODE con: cols=110 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\great_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / SCALE ARMOR (%player.item_scale_armor_owned%) ] ^| [Q / BACK ]
ECHO +------------------------------------------------------------------------------------------------------------+
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :VIEW_TYPE_ARMORS
IF ERRORLEVEL 1 GOTO :INSPECT_SCALE_ARMOR

REM Displays detailed information of the specific armor.
:INSPECT_SCALE_ARMOR
CLS
MODE con: cols=105 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\scale_armor.txt"
ECHO.
ECHO Showing detailed information for Scale Armor.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_scale_armor_owned%
ECHO ^| PROTECTION: %windhelm.item_scale_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_scale_armor_category%
ECHO ^| TYPE: %windhelm.item_scale_armor_type%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_GREAT_ARMOR
IF ERRORLEVEL 2 GOTO :UNEQUIP_SCALE_ARMOR
IF ERRORLEVEL 1 GOTO :EQUIP_SCALE_ARMOR

REM Attempts to equip the Scale Armor as the Player's active armor.
:EQUIP_SCALE_ARMOR
REM First check that it or some other armor isn't already equipped.
IF %player.armor_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_scale_armor_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.armor_equipped=%windhelm.item_scale_armor_name%
        SET player.armor_prot=%windhelm.item_scale_armor_damage%
        SET displayMessage=Equipped Scale Armor^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a armor equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Scale Armor from the Player's armor equipment slot.
:UNEQUIP_SCALE_ARMOR
REM Check if this is even the active armor.
IF NOT %player.armor_equipped% == "Scale Armor" (
    REM This isn't the active armor.
    SET displayMessage=You do not have Scale Armor equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the armor.
    SET player.armor_equipped=EMPTY
    SET player.armor_prot=0
    SET displayMessage=Unequipped Scale Armor.
    GOTO :IVM
)

REM Displays armor in the "crude armor" category.
:VIEW_CATEGORY_CRUDE_ARMOR
MODE con: cols=112 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\crude_armor.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| Select an item to inspect.
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / STONE ARMOR (%player.item_stone_armor_owned%) ] ^| [Q / BACK ]
ECHO +--------------------------------------------------------------------------------------------------------------+
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :VIEW_TYPE_ARMORS
IF ERRORLEVEL 1 GOTO :INSPECT_STONE_ARMOR

REM Displays detailed information of the specific armor.
:INSPECT_STONE_ARMOR
CLS
MODE con: cols=112 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\stone_armor.txt"
ECHO.
ECHO Showing detailed information for Stone Armor.
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_stone_armor_owned%
ECHO ^| PROTECTION: %windhelm.item_stone_armor_prot%
ECHO ^| CATEGORY: %windhelm.item_stone_armor_category%
ECHO ^| TYPE: %windhelm.item_stone_armor_type%
ECHO +--------------------------------------------------------------------------------------------------------------+
ECHO [E / EQUIP ] ^| [U / UNEQUIP ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_CATEGORY_CRUDE_ARMOR
IF ERRORLEVEL 2 GOTO :UNEQUIP_STONE_ARMOR
IF ERRORLEVEL 1 GOTO :EQUIP_STONE_ARMOR

REM Attempts to equip the Stone Armor as the Player's active armor.
:EQUIP_STONE_ARMOR
REM First check that it or some other armor isn't already equipped.
IF %player.armor_equipped% == EMPTY (
    REM There's nothing equipped in this slot, now make sure the Player owns at least one of this item.
    IF %player.item_stone_armor_owned% GTR 0 (
        REM The Player owns more than zero of this item.
        SET player.armor_equipped=%windhelm.item_stone_armor_name%
        SET player.armor_prot=%windhelm.item_stone_armor_damage%
        SET displayMessage=Equipped Stone Armor^!
        GOTO :IVM
    ) ELSE (
        REM The Player does not own at least one of this item.
        SET displayMessage=You do not have any of this item to equip.
        GOTO :IVM
    )
) ELSE (
    REM There's already something in this equipment slot.
    SET displayMessage=You already have a armor equipped^!
    GOTO :IVM
)

REM Attempts to unequip the Stone Armor from the Player's armor equipment slot.
:UNEQUIP_STONE_ARMOR
REM Check if this is even the active armor.
IF NOT %player.armor_equipped% == "Stone Armor" (
    REM This isn't the active armor.
    SET displayMessage=You do not have Stone Armor equipped.
    GOTO :IVM
) ELSE (
    REM Unequip the armor.
    SET player.armor_equipped=EMPTY
    SET player.armor_prot=0
    SET displayMessage=Unequipped Stone Armor.
    GOTO :IVM
)

REM Displays the categories of weapons and allows the Player to view their owned items in each.
:VIEW_TYPE_TONICS
MODE con: cols=116 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\tonics.txt"
ECHO.
ECHO %displayMessage%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| ARMOR: %player.armor_equipped% ^| WEAPON: %player.weapon_equipped%
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| Select a TONIC to inspect.
ECHO +------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / HEALTH TONIC (%player.item_tonic_healing_owned%) ] ^| [2 / STAMINA TONIC (%player.item_tonic_stamina_owned%) ] ^| [3 / MAGICKA TONIC (%player.item_tonic_magicka_owned%) ] ^| [4 / XP TONIC (%player.item_tonic_xp_owned%) ] ^| [Q / BACK ]
ECHO +------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1234Q /N /M ">"
IF ERRORLEVEL 5 GOTO :IVM
IF ERRORLEVEL 4 GOTO :INSPECT_TONIC_XP
IF ERRORLEVEL 3 GOTO :INSPECT_TONIC_MAGICKA
IF ERRORLEVEL 2 GOTO :INSPECT_TONIC_STAMINA
IF ERRORLEVEL 1 GOTO :INSPECT_TONIC_HEALING

REM Displays detailed information of the specific tonic.
:INSPECT_TONIC_HEALING
CLS
MODE con: cols=103 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\health_tonic.txt"
ECHO.
ECHO Showing detailed information for the Health Tonic.
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_healing_owned%
ECHO ^| MODIFIER: %windhelm.item_tonic_healing_modifier%
ECHO ^| CATEGORY: %windhelm.item_tonic_healing_category%
ECHO ^| TYPE: %windhelm.item_tonic_healing_type%
ECHO +-----------------------------------------------------------------------------------------------------+
ECHO [E / CONSUME ] ^| [U / DISCARD ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_TYPE_TONICS
IF ERRORLEVEL 2 GOTO :DISCARD_TONIC_HEALING
IF ERRORLEVEL 1 GOTO :CONSUME_TONIC_HEALING

:CONSUME_TONIC_HEALING
REM Check if the Player owns any of this item.
IF %player.item_tonic_healing_owned% LEQ 0 (
    REM The Player doesn't have any of this Tonic.
    SET displayMessage=You do not have any of this Tonic to consume.
    GOTO :IVM
) ELSE (
    REM Now check if the Player actually needs to consume the Tonic.
    IF %player.health% EQU %player.health_max% (
        REM Player is at max health.
        SET displayMessage=Your health is already full.
        GOTO :IVM
    ) ELSE (
        REM Heal the Player for the value provided by the Tonics modifier.
        SET /A player.health=!player.health! +%windhelm.item_tonic_healing_modifier%
        SET /A player.item_tonic_healing_owned=!player.item_tonic_healing_owned! -1
        REM Ensure the Player's health does not exceed their cap.
        IF %player.health% GTR %player.health_max% (
            REM Player health is above their cap.
            SET player.health=%player.health_max%
            SET displayMessage=Healed for %windhelm.item_tonic_healing_modifier% HP.
            GOTO :IVM
        )
    )
)

REM Displays detailed information of the specific tonic.
:INSPECT_TONIC_STAMINA
CLS
MODE con: cols=117 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\stamina_tonic.txt"
ECHO.
ECHO Showing detailed information for the Stamina Tonic.
ECHO +-------------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_stamina_owned%
ECHO ^| MODIFIER: %windhelm.item_tonic_stamina_modifier%
ECHO ^| CATEGORY: %windhelm.item_tonic_stamina_category%
ECHO ^| TYPE: %windhelm.item_tonic_stamina_type%
ECHO +-------------------------------------------------------------------------------------------------------------------+
ECHO [E / CONSUME ] ^| [U / DISCARD ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_TYPE_TONICS
IF ERRORLEVEL 2 GOTO :DISCARD_TONIC_STAMINA
IF ERRORLEVEL 1 GOTO :CONSUME_TONIC_STAMINA

:CONSUME_TONIC_STAMINA
REM Check if the Player owns any of this item.
IF %player.item_tonic_stamina_owned% LEQ 0 (
    REM The Player doesn't have any of this Tonic.
    SET displayMessage=You do not have any of this Tonic to consume.
    GOTO :IVM
) ELSE (
    REM Now check if the Player actually needs to consume the Tonic.
    IF %player.stamina% EQU %player.stamina_max% (
        REM Player is at max health.
        SET displayMessage=Your health is already full.
        GOTO :IVM
    ) ELSE (
        REM Heal the Player for the value provided by the Tonics modifier.
        SET /A player.stamina=!player.stamina! +%windhelm.item_tonic_stamina_modifier%
        SET /A player.item_tonic_stamina_owned=!player.item_tonic_stamina_owned! -1
        REM Ensure the Player's health does not exceed their cap.
        IF %player.stamina% GTR %player.stamina_max% (
            REM Player health is above their cap.
            SET player.stamina=%player.stamina_max%
            SET displayMessage=Replenished %windhelm.item_tonic_stamina_modifier% stamina.
            GOTO :IVM
        )
    )
)

REM Displays detailed information of the specific tonic.
:INSPECT_TONIC_MAGICKA
CLS
MODE con: cols=115 lines=21
ECHO.
TYPE "%cd%\data\assets\ui\magicka_tonic.txt"
ECHO.
ECHO Showing detailed information for the Magicka Tonic.
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_magicka_owned%
ECHO ^| MODIFIER: %windhelm.item_tonic_magicka_modifier%
ECHO ^| CATEGORY: %windhelm.item_tonic_magicka_category%
ECHO ^| TYPE: %windhelm.item_tonic_magicka_type%
ECHO +-----------------------------------------------------------------------------------------------------------------+
ECHO [E / CONSUME ] ^| [U / DISCARD ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_TYPE_TONICS
IF ERRORLEVEL 2 GOTO :DISCARD_TONIC_MAGICKA
IF ERRORLEVEL 1 GOTO :CONSUME_TONIC_MAGICKA

:CONSUME_TONIC_MAGICKA
REM Check if the Player owns any of this item.
IF %player.item_tonic_magicka_owned% LEQ 0 (
    REM The Player doesn't have any of this Tonic.
    SET displayMessage=You do not have any of this Tonic to consume.
    GOTO :IVM
) ELSE (
    REM Now check if the Player actually needs to consume the Tonic.
    IF %player.stamina% EQU %player.stamina_max% (
        REM Player is at max health.
        SET displayMessage=Your health is already full.
        GOTO :IVM
    ) ELSE (
        REM Heal the Player for the value provided by the Tonics modifier.
        SET /A player.stamina=!player.stamina! +%windhelm.item_tonic_magicka_modifier%
        SET /A player.item_tonic_magicka_owned=!player.item_tonic_magicka_owned! -1
        REM Ensure the Player's health does not exceed their cap.
        IF %player.stamina% GTR %player.stamina_max% (
            REM Player health is above their cap.
            SET player.stamina=%player.stamina_max%
            SET displayMessage=Replenished %windhelm.item_tonic_magicka_modifier% stamina.
            GOTO :IVM
        )
    )
)

REM Displays detailed information of the specific tonic.
:INSPECT_TONIC_XP
CLS
MODE con: cols=100 lines=19
ECHO.
TYPE "%cd%\data\assets\ui\xp_tonic.txt"
ECHO.
ECHO Showing detailed information for the Magicka Tonic.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| AMOUNT: %player.item_tonic_xp_owned%
ECHO ^| MODIFIER: %windhelm.item_tonic_xp_modifier%
ECHO ^| CATEGORY: %windhelm.item_tonic_xp_category%
ECHO ^| TYPE: %windhelm.item_tonic_xp_type%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO [E / CONSUME ] ^| [U / DISCARD ] ^| [Q / BACK ]
CHOICE /C EUQ /N /M ">"
IF ERRORLEVEl 3 GOTO :VIEW_TYPE_TONICS
IF ERRORLEVEL 2 GOTO :DISCARD_TONIC_XP
IF ERRORLEVEL 1 GOTO :CONSUME_TONIC_XP

:CONSUME_TONIC_XP
REM Check if the Player owns any of this item.
IF %player.item_tonic_xp_owned% LEQ 0 (
    REM The Player doesn't have any of this Tonic.
    SET displayMessage=You do not have any of this Tonic to consume.
    GOTO :IVM
) ELSE (
    REM Consume the Tonic and add the XP to the Player's XP counter.
    SET /A player.item_tonic_xp_owned=!player.item_tonic_xp_owned! -1
    SET /A player.xp=!player.xp! +%windhlem.item_tonic_xp_modifier%
    SET displayMessage=Gained %windhelm.item_tonic_xp_modifier% XP.
    GOTO :IVM
)