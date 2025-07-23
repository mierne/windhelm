REM WINDHELM -- Global Modules for Vendors
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:vendor
REM Determines which Vendor will be used to make a transaction
IF %VENDOR.ITEM% == INSPECT_LONGSWORD (
    GOTO :INSPECT_LONGSWORD
) ELSE IF %VENDOR.ITEM% == INSPECT_SHORTSWORD (
    GOTO :INSPECT_SHORTSWORD
)

:INSPECT_LONGSWORD
SET RETURN=INSPECT_LONGSWORD
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
ECHO ^| STOCK: %windhelm.global_item_stock%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +---------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :PURCHASE_LONGSWORD
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_LONGSWORD
IF %windhelm.global_item_stock% LSS 1 (
    GOTO :NOT_IN_STOCK
) ELSE (
    IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        SET /A player.coins=!player.coins! -%windhelm.global_item_price%
        SET /A player.item_long_sword_owned=!player.item_long_sword_owned% +1
        SET /A windhelm.global_item_stock=!windhelm.global_item_stock! -1
        SET displayMessage=Purchased 1 Long Sword for %windhelm.global_item_price%.
        GOTO :INSPECT_LONGSWORD
    )
)

:INSPECT_SHORTSWORD
CLS
SET RETURN=INSPECT_SHORTSWORD
MODE con: cols=111 lines=22
ECHO.
TYPE "%cd%\data\assets\ui\short_sword.txt"
ECHO.
ECHO Showing detailed information for the Short Sword. ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %windhelm.item_short_sword_damage%
ECHO ^| CATEGORY: %windhelm.item_short_sword_category%
ECHO ^| DAMAGE TYPE: %windhelm.item_short_sword_damage_type%
ECHO ^| PRICE: %windhelm.global_item_price%
ECHO ^| STOCK: %windhelm.global_item_stock%
ECHO +-------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / PURCHASE ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :PURCHASE_SHORTSWORD
IF /I "%CH%" == "Q" GOTO :CLEANUP
GOTO :INVALID_INPUT

:PURCHASE_LONGSWORD
IF %windhelm.global_item_stock% LSS 1 (
    GOTO :NOT_IN_STOCK
) ELSE (
    IF %player.coins% LSS %windhelm.global_item_price% (
        GOTO :CANNOT_AFFORD_ITEM
    ) ELSE (
        SET /A player.coins=!player.coins! -%windhelm.global_item_price%
        SET /A player.item_short_sword_owned=!player.item_short_sword_owned% +1
        SET /A windhelm.global_item_stock=!windhelm.global_item_stock! -1
        SET displayMessage=Purchased 1 Short Sword for %windhelm.global_item_price%.
        GOTO :INSPECT_LONGSWORD
    )
)

:INVALID_INPUT
set displayMessage="%CH%" is not a valid input.
GOTO :%RETURN%

:NOT_IN_STOCK
SET displayMessage=This item isn't in stock.
GOTO :%RETURN%

:CANNOT_AFFORD_ITEM
SET displayMessage=You can't afford this item.
GOTO :%RETURN%

:CLEANUP
IF %VENDOR.VENDOR% == HIDDEN_MERCHANT (
    SET pulse.amcr_hidden_merchant_longsowrd_price=%windhelm.global_item_stock%
    GOTO :EOF
) ELSE IF %VENDOR.VENDOR% == BLACKSMITH (
    IF %VENDOR.ITEM% == INSPECT_LONGSWORD (
        SET vendor.blacksmith_long_sword_stock=%windhelm.global_item_stock%
        GOTO :EOF
    ) ELSE IF %VENDOR.ITEM% == INSPECT_SHORTSWORD (
        SET vendor.blacksmith_short_sword_stock=%windhelm.global_item_stock%
        GOTO :EOF
    ) ELSE (
        PAUSE
    )
) ELSE (
    PAUSE
)