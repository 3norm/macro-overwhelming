#Requires AutoHotkey v2.0.9
#SingleInstance force
#Warn All, Off
#Include <items>
#include <OCR>
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetMouseDelay -1
SetControlDelay -1
SetKeyDelay -1

 ; possible automatic link sender for Discord plebs? Might be bannable on Discord.
 ; Each line of chat is 18 pixels tall, with 0 padding between them.
 ; On my 2560 x 1440 screen, the chat gui starts about 37 pixels below the top of the screen, and the actual lines
 ; begin 3 pixels below that. Chat is 0.3 of your screen width.


if not FileExist("conf.ini") {
    sourceFile := FileOpen("resourcdefaultconf.ini", "r")
    if not FileExist(".\resources\defaultconf.ini") {
        MsgBox("defaultconf.ini not present, please reinstall the program.", "Error")
    } else {
        FileCopy(".\balancedtotem\resources\defaultconf.ini", ".\resources\conf.ini", 0)
    }
}

CurrentLoadout := IniRead("conf.ini", "Loadouts", "CurrentLoadout")

BiomesList := Map(
    "Night", IniRead("conf.ini", "Biomes", "Night"),
    "Blizzard", IniRead("conf.ini", "Biomes", "Blizzard"),
    "FlareBiome", IniRead("conf.ini", "Biomes", "FlareBiome"),
    "Nature", IniRead("conf.ini", "Biomes", "Nature"),
    "Stormsurge", IniRead("conf.ini", "Biomes", "Stormsurge"),
    "StarryNight", IniRead("conf.ini", "Biomes", "StarryNight"),
    "Irradiated", IniRead("conf.ini", "Biomes", "Irradiated"),
    "PureVsCorruptWar", IniRead("conf.ini", "Biomes", "PureVsCorruptWar"),
    "HolyVsUnholyWar", IniRead("conf.ini", "Biomes", "HolyVsUnholyWar"),
    "AngelsDescent", IniRead("conf.ini", "Biomes", "AngelsDescent"),
    "VoidInfiltration", IniRead("conf.ini", "Biomes", "VoidInfiltration"),
    "CultistLegion", IniRead("conf.ini", "Biomes", "CultistLegion"),
    "Darkness", IniRead("conf.ini", "Biomes", "Darkness"),
    "BlindingLight", IniRead("conf.ini", "Biomes", "BlindingLight")
)


/*
I know there is an easier method to do this with much less code, but I do not care.
The E means enabled.
*/
Slots := {
    _1: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot1E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot1")%,
        key: "1"
    },
    _2: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot2E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot2")%,
        key: "2"
    },
    _3: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot3E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot3")%,
        key: "3"
    },
    _4: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot4E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot4")%,
        key: "4"
    },
    _5: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot5E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot5")%,
        key: "5"
    },
    _6: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot6E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot6")%,
        key: "6"
    },
    _7: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot7E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot7")%,
        key: "7"
    },
    _8: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot8E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot8")%,
        key: "8"
    },
    _9: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot9E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot9")%,
        key: "9"
    },
    _10: {
        enabled: IniRead("conf.ini", CurrentLoadout, "Slot10E"),
        item: Items.%IniRead("conf.ini", CurrentLoadout, "Slot10")%,
        key: "0"
    },

}

GameLink := IniRead("conf.ini", "Application", "GameLink")
/*
    Color for inventory is aaffff
    Color for inventory while depressed is 77b3b3
    A position of a pixel is 116, 618

    I want to check if the inventory is gone for more than 10 minutes, and if it is, it ends the game because it is broken.
*/

DevMode := IniRead("conf.ini", "Application", "Devmode"),

WINDOW_TITLE := "Roblox"
WINDOW_CLASS := "WINDOWSCLIENT"
global DeadTimer := 0

RETREAT := [IniRead("conf.ini", "Movement", "Retreat"), "s"]
telePort := [
    IniRead("conf.ini", "Events", "TeleportEnabled"),
    IniRead("conf.ini", "Events", "Torment"), 
    IniRead("conf.ini", "Events", "EventItem")
]

biomeHop := IniRead("conf.ini", "Biomes", "BiomeHop") 
logWins := IniRead("conf.ini", "Biomes", "LogWins") 
logLosses := IniRead("conf.ini", "Biomes", "LogLosses") 
toggle := false

queue := []

/*
LOOP_NUMBER() 
{
    if (CURRENT_BUFF.durationMs > CURRENT_BUFF.coolDownMs) {
        value := Ceil(CURRENT_BUFF.durationMs / (50 + CURRENT_WEAPON.coolDownMs))
    } else {
        value := Ceil(CURRENT_BUFF.coolDownMs / (50 + CURRENT_WEAPON.coolDownMs))
    }
    if value > 50 {
        value := 50
    }
    return value
}
*/

XButton2:: {
    Global toggle
    toggle := !toggle
    if (Toggle) {
        SoundPlay "*48"
    } else {
        SoundPlay "*16"
    }
}

Ins:: {
    ExitApp
} 

; Sleep 5000 ; Unneeded because now it's better to start instantly.

While (True) {
    DeadTimer := 0
    if (toggle) {
        if not WinExist("ahk_class " . WINDOW_CLASS) {
            Reconnect()
        }
    }
    Loop 10 {
        if WinExist("ahk_class " . WINDOW_CLASS) {
            Loop 10 {
                if WinExist("ahk_class " . WINDOW_CLASS) {
                    if (telePort[1] and WinExist("ahk_class " . WINDOW_CLASS)) {
                        if RETREAT[1] = 1 {
                            SafeSend("{" . RETREAT[2] . " up}", WINDOW_CLASS)
                        }
                        if (telePort[2]) {
                            ClickTorment()
                        } else {
                            ClickStandard()
                        }
                    }
                    Loop 10 {
                        CurrentSlot := Slots._%A_Index%
                        if WinExist("ahk_class " . WINDOW_CLASS) {
                            if (CurrentSlot.enabled and WinExist("ahk_class " . WINDOW_CLASS)) {
                                QueueSummon(CurrentSlot)
                                if BiomeHop = True {
                                    Check_Chat
                                }
                                AttemptLeave
                                if (telePort[1] and telePort[2]) {
                                    Dead_Timer()
                                    Boss_Timer()
                                    Inventory_Timer()
                                    Check_Chat_Active()
                                    ClickTorment()
                                } else if (telePort[1] and telePort[2] = false) {
                                    ClickStandard()
                                }
                            }
                        }          
                    }
                }
            }
            if (telePort[1] = true) {
                counterlol := 0
                counterlol++
                if (counterlol = 10) {
                    ClickSuspiciousInvite
                    counterlol := 0
                }
            }
        }
    }
}
; This is really stupid, but I will do it.



Check_Chat() {
    MiningNotif := 0
    ChatLinePixelHeight := 18
    ChatStartHeight := 37
    static coolDown := false
    results := Array()
    if WinExist("ahk_class " . WINDOW_CLASS) and toggle and biomeHop and not coolDown {
        ; You have to alt tab just in case the window is frozen.
        if not coolDown {
            Send("{Alt down}")
            Send("{Tab}")
            Send("{Shift down}")
            Send("{Tab}")
            Send("{Shift up}")
            Send("{Alt up}")
        }
        WinActivate
        SafeSend("/", WINDOW_CLASS)
        Delay(500)
        Loop 18 { ; The amount of lines in chat
            mathsss := (37+(18*A_Index-18))
            result := OCR.FromRect(0, mathsss, 776, 18,,)
            results.InsertAt(A_Index, result.text)
        }
        if DevMode {
            Loop results.Length {
                    MsgBox mathsss . ", " . results[A_Index]
            }
        }
        Loop 2 { ; Without this there are random spaces which clutter up the chat, for some reason, and Backspace 4 didn't work to fix it, so I'm using a loop.
            SafeSend("{Backspace}", WINDOW_CLASS)
            Delay(1)
        } 
        SafeSend("{Enter}", WINDOW_CLASS)
        for name, boole in BiomesList {
            for _, phrase in Biomes.%name%.items {
                for _, resulters in results {
                    if DevMode {
                        asdasdasd := results[A_Index]
                        msgBox(phrase . ", " . name . ", " . boole ", " . asdasdasd,)
                    }
                    if not Trim(resulters) = "" {
                        if (boole and InStr( StrReplace(StrLower(resulters), A_Space), StrReplace(StrLower(phrase), A_Space)) and coolDown = false) {
                            coolDown := true
                            SetTimer CooldownFalse, 60000
                            CooldownFalse() {
                                coolDown := false
                            }
                            if logWins = True {
                                TimeString := FormatTime()
                                FileAppend("`n" . TimeString . ", got `n", "mo_wins.log")
                                Loop results.Length {
                                    FileAppend("Line " . Integer(A_Index) . ", " . results[A_Index] . "`n", "mo_wins.log")
                                }
                            }
                        } else if (!boole and InStr(StrReplace(StrLower(resulters), A_Space), StrReplace(StrLower(phrase), A_Space)) and coolDown = false and WinExist("ahk_class " . WINDOW_CLASS)) {
                            ; msgBox phrase . ", " . name . ", " . boole, ", " . asdasdasd
                            if logLosses {
                                TimeString := FormatTime()
                                FileAppend("`n" . TimeString . ", got `n", "mo_losses.log")
                                Loop results.Length {
                                    FileAppend("Line " . Integer(A_Index) . ", " . results[A_Index] . "`n", "mo_losses.log")
                                }
                            }
                            if (WinExist("ahk_class " . WINDOW_CLASS) and coolDown = false) {
                                if not coolDown {
                                    WinClose
                                    break
                                } 
                            }
                        }
                    }
                }
            }
        }
    } else if MiningNotif {
        testVar := 1+1
    }
}
     ; Now I want to check if results has any text in it equal to a biome I have at 1 first, then biomes I have at 0.
        /*
        for _, phrase in CancelText {
            if (InStr(StrReplace(StrLower(result.Text), A_Space), StrReplace(StrLower(phrase), A_Space)) and coolDown = false) {
                coolDown := true
                SetTimer CooldownFalse, 30000
                CooldownFalse() {
                    coolDown := false
                }
            } else {
                for _, phrase in BiomeKeywords {
                    if (InStr(StrReplace(StrLower(result.Text), A_Space), StrReplace(StrLower(phrase), A_Space)) and coolDown = false) {
                        if (WinExist("ahk_class " . WINDOW_CLASS) and coolDown = false) {
                            try WinClose    
                        }
                    }   
                }    
            }
            
        }
        */
        ; The rectangle should start 0, 37. 
        ; OCR.FromRect(X, Y, W, H, lang?, scale:=1)
        ; You can use rectangles for every chat line, maybe.
        ; Black and white filter makes this more reliable.


ResetCharacter() {
    SafeSend("{Escape}", WINDOW_CLASS)
    Delay(50)
    SafeSend("R", WINDOW_CLASS)
    SafeSend("{Enter}", WINDOW_CLASS)
}

Dead_Timer() {
    static Timer := 0
    InventoryLocation := PixelGetColor(116, 618)
    if (InventoryLocation = 0xaaffff or InventoryLocation = 0x77b3b3) {
        Timer := 0 
    } else {
        Timer++
    }
    if (DeadTimer = 300) {
        if WinExist("ahk_class " . WINDOW_CLASS) {
            WinClose("ahk_class " . WINDOW_CLASS)
        }
    }
}

Boss_Timer() {
    global RETREAT
    static Timer := 0
    BOSS_HEALTH_LOCATION := [670, 1274]
    Boss_Health_Colors := [0xc83d26, 0x2c2c2c]
    get_Color_Boss := PixelGetColor(BOSS_HEALTH_LOCATION[1], BOSS_HEALTH_LOCATION[2])
    if (get_Color_Boss = Boss_Health_Colors[1] or get_Color_Boss = Boss_Health_Colors[2]) {
        Timer++
    } else {
        Timer := 0
        SafeSend("{" . RETREAT[2] . " up}", WINDOW_CLASS)
        RETREAT[2] := "S"
    }
    if (Timer = 100 or Timer = 200 or Timer = 300 or Timer = 400) {
        ResetCharacter
        SafeSend("{" . RETREAT[2] . " up}", WINDOW_CLASS)
        RETREAT[2] := "W"
    } if (Timer = 6000) {
        if WinExist("ahk_class " . WINDOW_CLASS) {
            WinClose("ahk_class " . WINDOW_CLASS)
        }
    }
}



Inventory_Timer() {
    static Timer := 0
    ; This is dependant on having 9 items in your inventory. 
    ; Once you can set the opacity of the inventory to one, I'm planning to change it to just use the background
    INVENTORY_ONE_POSITION := [993, 1377]
    INVENTORY_ONE_COLOR := 0xFFFFFF
    get_Color_Inventory := PixelGetColor(INVENTORY_ONE_POSITION[1], INVENTORY_ONE_POSITION[2])
    if (get_Color_Inventory = INVENTORY_ONE_COLOR) {
        Timer := 0 
    } else {
        Timer++
    }
    if (Timer = 100 or Timer = 200) {
        ResetCharacter
    } 
    if (Timer = 500) {
        if WinExist("ahk_class " . WINDOW_CLASS) {
            WinClose("ahk_class " . WINDOW_CLASS)
        }
    }

}

Check_Chat_Active() {
    ; 1d1d1d is background color
    ; FFFF00
    if WinExist("ahk_class " . WINDOW_CLASS) and toggle {
        SafeSend("/", WINDOW_CLASS)
        color := PixelGetColor(10, 70)
        SafeSend("{Enter}", WINDOW_CLASS)
        Delay(10)
        if (color = 0xFFFF00) {
            If WinExist("ahk_class " . WINDOW_CLASS) {
                ; WinClose
                ClickSuspiciousInvite
                SafeSend("/", WINDOW_CLASS)
                Delay(27500)
                Check_Chat_Active()
            } else if (color = 0x1d1d1d) {
                Delay(1000)
                Check_Chat_Active
            }
        }
    }
}

Reconnect() {
    if not WinExist("ahk_class " . WINDOW_CLASS) {
        Run("msedge.exe " . GameLink . " --new-window")
        WinWait("ahk_exe msedge.exe", , 60) ; Screw it. I'm closing the random microsoft edge windows. 
        WinWait("ahk_class " . WINDOW_CLASS, , 60) 
        WinClose("ahk_exe msedge.exe") ; This seems to close the last focused window of edge.
        if telePort[1] = true {
            Sleep 20000
            ClickSuspiciousInvite
        }
    }
}

ClickTorment() {
    if WinExist("ahk_class " . WINDOW_CLASS) and toggle {
        Click Random(1509 - 10, 1509 + 10), Random(332 - 10, 332 + 10)
    }
}

ClickStandard() {
    if WinExist("ahk_class " . WINDOW_CLASS) and toggle {
        Click Random(1024 - 10, 1024 + 10), Random(325 - 10, 325 + 10)
    }
}

ClickSuspiciousInvite() {
    if WinExist("ahk_class " . WINDOW_CLASS) and toggle {
        Loop 10 {
            CurrentSlot := Slots._%A_Index%
            if ((CurrentSlot.item = Items.%telePort[3]%) and WinExist("ahk_class " . WINDOW_CLASS)) {
                SafeSend(CurrentSlot.Key, "WINDOW_CLASS")
                if WinExist("ahk_class " . WINDOW_CLASS) {
                    centers := GetWinCenter(WINDOW_CLASS) 
                }
                SafeClick(Random(centers[1] + 10, centers[1] - 10), Random(centers[2] + 10, centers[2] - 10), WINDOW_CLASS)
                SafeClick(Random(centers[1] + 10, centers[1] - 10), Random(centers[2] + 10, centers[2] - 10), WINDOW_CLASS)
                Sleep 2000
                SafeSend("/", WINDOW_CLASS)
                Sleep 100
                SafeSend("Confirm", WINDOW_CLASS)
                SafeSend("{Enter}", WINDOW_CLASS)
                Break
            }
        }
    }
}


AttemptLeave() {
    if WinExist("ahk_class " . WINDOW_CLASS) and toggle {
        SafeClick(1161, 783, WINDOW_CLASS)
    }
}

QueueSummon(slot) {
    ; if toggle is true add this to queue
    if toggle {
        Summon(slot.item, slot.key)
        ; SetTimer(QueueSummon(slot), slot.item.coolDownMs)
    }
}

SafeWinActivate(windowClass){
    if WinExist("ahk_class " . windowClass) {
        WinActivate "ahk_class " . windowClass
    }
}

SafeClick(x, y, windowClass) {
    SafeWinActivate(windowClass)
    Click x, y
}

SafeSend(key, windowClass) {
    SafeWinActivate(windowClass)
    Send key
}

DoTheStuff(key) {
    If (Toggle = true)
        SafeSend(key, WINDOW_CLASS) 
}

Summon(weapon, slot) {
    global RETREAT
    static summons := 0
    centers := Array()
    if WinExist("ahk_class " . WINDOW_CLASS) and toggle {
        hasShield := true
        if WinExist("ahk_class " . WINDOW_CLASS) {
            centers := GetWinCenter(WINDOW_CLASS) 
        }
        if RETREAT[1] = true {
            SafeSend("{Space}", WINDOW_CLASS)
			SafeSend("q", WINDOW_CLASS)
            SafeSend("{" . RETREAT[2] . " down}", WINDOW_CLASS)
            summons++
        }
        if weapon.hasFunc = false {
            SafeClick(Random(centers[1] + 10, centers[1] - 10), Random(centers[2] + 10, centers[2] - 10), WINDOW_CLASS)
            SafeSend("zxc", WINDOW_CLASS)
            SafeSend(slot, WINDOW_CLASS)
            SafeClick(Random(centers[1] + 10, centers[1] - 10), Random(centers[2] + 10, centers[2] - 10), WINDOW_CLASS)
            SafeSend("zxc", WINDOW_CLASS)
            SafeSend(slot, WINDOW_CLASS)
        } else {
            EquinoxBallista(slot, centers)
        }
        
        if RETREAT[1] and summons = 8 {
            SafeSend("{" . RETREAT[2] . " up}", WINDOW_CLASS)
        }
        if hasShield {
            SafeSend("f", WINDOW_CLASS)
        }
        ; Delay(weapon.coolDownMs / 2)
        ; SetTimer(Summon(weapon, slot), slot.item.coolDownMs)
    }
}


/* Unneeded and un-used function.
Buff(item) {
    GetWinCenter(WINDOW_CLASS, &centerX, &centerY) 
    SafeSend(item.slot, WINDOW_CLASS)
    SafeClick(centerX, centerY, WINDOW_CLASS)
    SafeSend(item.slot, WINDOW_CLASS)
    ; Delay(item.coolDownMs)
    SafeClick(centerX, centerY, WINDOW_CLASS)
    SafeSend(item.coolDownMs, WINDOW_CLASS)
}
*/

Delay(time) {
    DllCall("QueryPerformanceFrequency", "Int64*", &freq := 0)
    DllCall("QueryPerformanceCounter", "Int64*", &countatstart := 0)
    ; sleep, % (time - 15)

    loop {
        DllCall("QueryPerformanceCounter", "Int64*", &countrnow := 0)
        timepassed := ((countrnow - countatstart) / freq)*1000
        if (timepassed > time) {
            break
        }   
    }
    ; ToolTip, % timepassed, 100, 100, 1
}

GetWinCenter(MyWINDOW_CLASS) {
    WinGetPos &x, &y, &width, &height, "ahk_class " . WINDOW_CLASS

    ; Calculate the center coordinates
    centerX := x + (width // 2)
    centerY := y + (height // 2)
    centers := [x + (width // 2), y + (height // 2)]
    return centers
}

GetControlCenter(MyWINDOW_CLASS) {
    ControlGetPos &x, &y, &width, &height, "ahk_class WINDOW_CLASS"

    ; Calculate the center coordinates
    centerX := x + (width // 2)
    centerY := y + (height // 2)
}


; Define the number of slots in your inventory
slots := 10

; Define the queue to store weapons

; Loop through each slot in your inventory

