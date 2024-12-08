SET player.message=Looting has been disabled while Combat Engine is being updated.
GOTO :EOF

REM Check that this enemy has not been looted previously.
IF %enLooted% EQU 1 (
    REM This enemy has been looted, do not proceed.
    SET player.message=You have already looted this enemy.
    GOTO :EOF
) ELSE (
    REM This enemy has not been looted, proceed.
    SET enLooted=1
    GOTO :generic_loot
)

REM Generic loot table for any enemy.
:generic_loot
SET /A A=%RANDOM% %%10
IF %A% GTR 8 (
    REM Rare loot
    SET lootFound=Found 600 coins!
    SET /A player.coins=!player.coins! +600
    GOTO :EOF
) ELSE IF %A% LSS 4 (
    REM Uncommon loot
    SET lootFound=Found a Long Sword!
    SET /A player_longSword_owned=!player_longSword_owned! +1
    GOTO :EOF
) ELSE (
    REM Common loot
    SET lootFound=Found a Short Sword and 25 coins!
    SET /A player_shortSword_owned=!player_shortSword_owned! +1
    SET /A player_coins=!player_coins! +25
    GOTO :EOF
)