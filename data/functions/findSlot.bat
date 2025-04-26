REM (WELP) Woefully Expansive Lazy Picker

REM Enchantment got dropped xD!!
REM I however think this slot could be useful for other systems in the future, so it's staying.


IF NOT %player.inventory_slot_1% == "EMPTY" (
    REM Slot is not empty and cannot be used. Check next slot.
    IF NOT %player.inventory_slot_2% == "EMPTY" (
        REM Slot is not empty and cannot be used. Check next slot.
        IF NOT %player.inventory_slot_3% == "EMPTY" (
            REM Slot is not empty and cannot be used. Check next slot.
            IF NOT %player.inventory_slot_4% == "EMPTY" (
                REM Slot is not empty and cannot be used. Check next slot.
                IF NOT %player.inventory_slot_5% == "EMPTY" (
                    REM Slot is not empty and cannot be used. Check next slot.
                    IF NOT %player.inventory_slot_6% == "EMPTY" (
                        REM Slot is not empty and cannot be used. Check next slot.
                        IF NOT %player.inventory_slot_7% == "EMPTY" (
                            REM Slot is not empty and cannot be used. Check next slot.  
                            IF NOT %player.inventory_slot_8% == "EMPTY" (
                                REM Slot is not empty and cannot be used. Check next slot.
                                IF NOT %player.inventory_slot_9% == "EMPTY" (
                                    REM Slot is not empty and cannot be used. Check next slot.
                                    IF NOT %player.inventory_slot_10% == "EMPTY" (
                                        REM Slot is not empty and cannot be used. Check next slot.
                                        IF NOT %player.inventory_slot_11% == "EMPTY" (
                                            REM Slot is not empty and cannot be used. Check next slot.
                                            IF NOT %player.inventory_slot_12% == "EMPTY" ( 
                                                REM Slot is not empty and cannot be used. Check next slot.
                                                IF NOT %player.inventory_slot_13% == "EMPTY" (
                                                    REM Slot is not empty and cannot be uesed. Check next slot.
                                                    IF NOT %player.inventory_slot_14% == "EMPTY" (
                                                        REM Slot is not empty and cannot be used. Check next slot.
                                                        IF NOT %player.inventory_slot_15% == "EMPTY" (
                                                            REM Slot is not empty and cannot be used. Final slot.
                                                            SET wiz.usable_slot=NONE
                                                            GOTO :EOF
                                                        ) ELSE (
                                                            REM Slot is empty and can be used.
                                                            SET wiz.usable_slot=player.inventory_slot_15
                                                            GOTO :EOF
                                                        )
                                                    ) ELSE (
                                                        REM Slot is empty and can be used.
                                                        SET wiz.usable_slot=player.inventory_slot_14
                                                        GOTO :EOF
                                                    )
                                                ) ELSE (
                                                    REM Slot is empty and can be used.
                                                    SET wiz.usable_slot=player.inventory_slot_13
                                                    GOTO :EOF
                                                )
                                            ) ELSE (
                                                REM Slot is empty and can be used.
                                                SET wiz.usable_slot=player.inventory_slot_12
                                                GOTO :EOF
                                            )
                                        ) ELSE (
                                            REM Slot is empty and can be used.
                                            SET wiz.usable_slot=player.inventory_slot_11
                                            GOTO :EOF
                                        )
                                    ) ELSE (
                                        REM Slot is empty and can be used.
                                        SET wiz.usable_slot=player.inventory_slot_10
                                        GOTO :EOF
                                    )
                                ) ELSE (
                                    REM Slot is empty and can be used.
                                    SET wiz.usable_slot=player.inventory_slot_9
                                    GOTO :EOF
                                )
                            ) ELSE (
                                REM Slot is empty and can be used.
                                SET wiz.usable_slot=player.inventory_slot_8
                                GOTO :EOF
                            )
                        ) ELSE (
                            REM Slot is empty and can be used.
                            SET wiz.usable_slot=player.inventory_slot_7
                            GOTO :EOF
                        )
                    ) ELSE (
                        REM Slot is empty and can be used.
                        SET wiz.usable_slot=player.inventory_slot_6
                        GOTO :EOF
                    )
                ) ELSE (
                    REM Slot is empty and can be used.
                    SET wiz.usable_slot=player.inventory_slot_5
                    GOTO :EOF
                )
            ) ELSE (
                REM Slot is empty and can be used.
                SET wiz.usable_slot=player.inventory_slot_4
                GOTO :EOF
            )
        ) ELSE (
            REM Slot is empty and can be used.
            SET wiz.usable_slot=player.inventory_slot_3
            GOTO :EOF
        )
    ) ELSE (
        REM Slot is empty and can be used.
        SET wiz.usable_slot=player.inventory_slot_2
        GOTO :EOF
    )
) ELSE (
    REM Slot is empty and can be used.
    SET wiz.usable_slot=player.inventory_slot_1
    GOTO :EOF
)