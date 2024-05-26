; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
; NOTE(Everton): For this to work correctly need powertoys to be one with the following remaps:
;     - Shift -> k
;     - CapsLock -> Esc

A_HotkeyInterval := 0  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 20000

; TODO: Test if setdelay -1 once solves the s up:: bug, where hold tagert champions only keep being down despite 's' being up

LEAGUE_PROCESS_NAME := "League of Legends (TM) Client"
#HotIf WinActive(LEAGUE_PROCESS_NAME)

WinWaitActive LEAGUE_PROCESS_NAME

active_pid := WinGetPID(LEAGUE_PROCESS_NAME)
prio := "High"
if ProcessSetPriority(prio, active_pid) {
    MsgBox "Success: Its priority was changed to " prio 
} else {
    MsgBox "Error: Its priority could not be changed to " prio
}

Esc:: {
  SendInput "{Esc}{y}"
}

CapsLock::j

$s:: {
    SetKeyDelay -1
    shift_down :=  GetKeyState("Shift", "P")
    rbutton_down :=  GetKeyState("RButton", "P")
    if (shift_down or rbutton_down) {
        Send "{c}"
    }
    send "{s down}{c}"
}

$s up:: {
    SetKeyDelay -1
    shift_down :=  GetKeyState("Shift", "P")
    rbutton_down :=  GetKeyState("RButton", "P")
    if (shift_down or rbutton_down) {
        Send "{c}"
    } else {
        Send "{c}{s up}"
    }
}


$Shift:: {
  SetKeyDelay -1
  s_down :=  GetKeyState("s", "P")
  if (not s_down) {
      send "{s down}"
  }
}

$Shift Up:: {
  SetKeyDelay -1
  s_down :=  GetKeyState("s", "P")
  if (not s_down) {

    Send "{s up}"
  }
}

':: Shift

; *s up:: SendInput "{blind up}"
; *s:: SendInput "{blind down}{s}"


; s & RButton:: {
;     SendInput "{u}"
;     if (GetKeyState("Shift", "P")) {
;         SendInput "{u}"
;     } else {
;     }
; }



$RButton:: {
    SetKeyDelay -1
    SetMouseDelay -1
    if (GetKeyState("s")) {
        SendInput "{u}"
    } else {
        SendInput "{s down}{u}{s up}"
    }
}

#HotIf ; Only active during league

#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
#HotIf ; Only when league not active 

SetCapsLockState "AlwaysOff"
Esc::Esc
Shift::Shift
CapsLock::Esc
