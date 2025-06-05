REM Go to the label set in Pulse Engine
GOTO :%PELH%

:IFOR_SUBLEVEL
SET /A IR=%RANDOM% %%50
IF %IR% GEQ 35 (
    SET /A player.item_steel_armor_owned=!player.item_steel_armor_owned! +1
    SET /A player.coins=!player.coins! +250
    SET displayMessage=Found 1 Steel Armor and 250 LUNIS.
    GOTO :EOF
) ELSE IF %IR% GEQ 20 (
    SET /A player.item_short_sword_owned=!player.item_short_sword_owned! +1
    SET /A player.coins=!player.coins! +100
    SET displayMessage=Found 1 Short Sword and 100 LUNIS.
    GOTO :EOF
) ELSE (
    SET /A player.coins=!player.coins! +75
    SET displayMessage=Found 75 LUNIS.
    GOTO :EOF
)