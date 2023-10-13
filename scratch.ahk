#Warn
#SingleInstance Force
#Requires AutoHotkey >=2.0

;* Simple template for quickly testing/iterating AHK functionality

try{
    ^!+R::Reload    ; Reload this script
    ^!+W::Window_WatchCursor ; Show info for the window under the cursor

    ;* scratch code goes here

}
catch as e {
    MsgBox Format("An error was thrown:`nLine {}: {}", e.Line, e.Message)
}

; Print id, class, title, and control for the Window under the mouse cursor. Useful for debugging/developing
; copied from <https://www.autohotkey.com/docs/v2/lib/MouseGetPos.htm>
Window_WatchCursor() {
    MouseGetPos , , &id, &control

    title := WinGetTitle(id)

    ToolTip
    (
        "ahk_id: " . id .
        "`nahk_class: " . WinGetClass(id) .
        "`nTitle: " . WinGetTitle(id) .
        "`nControl: " . control
        "`nProcess Name: " . WinGetProcessName(title)
    )

    SetTimer () => ToolTip(), -5000 ; display Tooltip for 5 seconds
}