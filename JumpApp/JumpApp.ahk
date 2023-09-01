;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;             Jump to an application                  ;;;
;;;                                                     ;;;
;;;         Displays a list of applications.            ;;;
;;;                                                     ;;;
;;;        Clicking the associated key for an           ;;;
;;;         application brings it into focus            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Include JumpAppChoiceMap.ahk

; Theming
JumpApp__theme := {}
JumpApp__theme.GuiBackgroundColor       := g_themes.dracula.Background
JumpApp__theme.GuiFontColor             := g_themes.dracula.Pink
JumpApp__theme.ListBoxBackgroundColor   := g_themes.dracula.Comment

try {
    JumpApp__gui := Gui()
    JumpApp__gui.BackColor := JumpApp__theme.GuiBackgroundColor

    ; -Caption :: remove title bar and a thick window border/edge
    ; -SysMenu :: omit the system menu and icon in the window's upper left corner
    ;;         :: omit the minimize, maximize, and close buttons in the title bar.
    ; +AlwaysOnTop :: what it sounds like
    ; +Owner :: Make the GUI owned by the script's main window to prevent display of a taskbar button.
    JumpApp__gui.Opt("-Caption -SysMenu +AlwaysOnTop +Owner")
    JumpApp__gui.SetFont("s14 c" . JumpApp__theme.GuiFontColor, "JetBrains Mono")

    JumpApp__listBoxItems := [] ; used to
    JumpApp__choiceMap := JumpApp__BuildChoiceMap()

    for mapKey in JumpApp__choiceMap
        JumpApp__listBoxItems.Push(mapKey)

    ; TODO: remove color on ListBox border
    JumpApp__listBox := JumpApp__gui.Add(
        "ListBox",
        "sort" . " w400" . " r" . JumpApp__choiceMap.Count . " Background" . JumpApp__theme.ListBoxBackgroundColor,
        JumpApp__listBoxItems
    )

    ; Register event hooks

    ;; "Escape" event is fired on [Esc] key press
    JumpApp__gui.OnEvent("Escape", (*) => JumpApp__gui.Hide())

    ;; "Change" Event is fired when the ListBox selection changes; the selected item is in ListBox.Text
    ;; Use the selected item to get the associated callback from the choice map and pass it to JumpApp__JumpToSelection
    JumpApp__listBox.OnEvent("Change",(*) => JumpApp__JumpToSelection(JumpApp__choiceMap[JumpApp__listBox.Text]))
}
catch as e {
    MsgBox "An error was thrown:`nLine " . e.Line . ": " . e.Message
}

JumpApp_Activate() {
    JumpApp__gui.Show()
}

; TODO(maybe): figure out how to make it differentiate between upper/lowercase versions of the same letter
; TODO(maybe): if there are multiple of the same process, show selection list to choose
JumpApp__JumpToSelection(Callback) {
    Callback()

    JumpApp__gui.Hide()
}