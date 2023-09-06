;*
;* Functions for working with windows
;*

;  TODO: support multiple displays
; **WARNING**: this centers the Window on the Primary Monitor only
Window_Center(WinTitle) {
    WinGetPos ,, &Width, &Height, WinTitle
    MonitorGetWorkArea( , &Left, &Top, &Right, &Bottom)

    WinMove(
        (Right/2)-(Width/2), (Bottom/2)-(Height/2),
        ; prevent overflowing the work area if the window is moving from a monitor with larger X and/or Y
        Min(Right, Width), Min(Bottom, Height),
        WinTitle
    )
}

; This can be called directly if the Window Name is static (e.g. it's just the name of the program)
Window_FocusOrLaunchByName(WindowName, RunTarget) {
    if WinExist(WindowName) {
        WinActivate(WindowName)
    }
    else{
        Run RunTarget
    }
}

; The Process name is the Executable name
Window_FocusOrLaunchByProcess(ProcessName, RunTarget) {
    Window_FocusOrLaunchByName(Format("ahk_exe {}", ProcessName), RunTarget)
}

; The Folder Path should exclude the Folder Name
Window_FocusOrLaunchInFileExplorer(FolderName, FolderPath) {
    Window_FocusOrLaunchByName(FolderName, Run(Format("explorer.exe {}\{}", FolderPath, FolderName)))
}

; CLSID must be the GUID only (i.e. no surrounding curly braces {})
Window_FocusOrLaunchInFileExplorerByClsid(Title, CLSID) {
    Window_FocusOrLaunchByName(
        Format("{} ahk_exe explorer.exe", Title), ; filter by (Title AND Process)
        Format("explorer.exe shell:::{{1}}", CLSID)
    )
}

; TODO: add support for multiple monitors
; **WARNING**: this assumes the active Window is on the Primary Monitor
Window_VerticallyMaximize(WinTitle) {
    MonitorGetWorkArea( , &Left, &Top, &Right, &Bottom)
    WinGetPos(&X, &Y, &Width, &Height, WinTitle)
    WinMove(X, 0, , Bottom, WinTitle)
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