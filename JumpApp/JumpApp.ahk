;* Jump to an application via hotkeys
;*
;* - When activated, a GUI is shown with a list of applications.
;* - Each application has an underlined character in its name; the underlined character is that app's hotkey.
;* - Clicking an application's hotkey brings it into focus, launching the app first if it's not already open.
;*

; Theming
JumpApp__theme := {}
JumpApp__theme.GuiBackgroundColor       := g_themes.custom.Background
JumpApp__theme.GuiFontColor             := g_themes.custom.Red

try {
    JumpApp__gui := JumpApp__Init()
}
catch as e {
    MsgBox "An error was thrown:`nLine " . e.Line . ": " . e.Message
}

JumpApp__Init() {
    jaGui := Gui()

    ; "Escape" event is fired on [Esc] key press
    jaGui.OnEvent("Escape", JumpApp__Hide)

    ; -Caption :: remove title bar and a thick window border/edge
    ; -SysMenu :: omit the system menu and icon in the window's upper left corner
    ;          :: omit the minimize, maximize, and close buttons in the title bar.
    ; +AlwaysOnTop :: what it sounds like
    ; +Owner :: Make the GUI owned by the script's main window to prevent display of a taskbar button.
    jaGui.Opt("-Caption -SysMenu +AlwaysOnTop +Owner")
    jaGui.SetFont("s14 c" . JumpApp__theme.GuiFontColor, "JetBrains Mono")
    jaGui.BackColor := JumpApp__theme.GuiBackgroundColor

    jaGui.Add("Text", "", JumpApp__GetAppText())

    return jaGui
}

JumpApp_Activate() {
    jumpApp__Show()
}

; used for dynamically binding hotkeys
JumpApp__isActive := false

JumpApp__Hide(*) {
    if (!JumpApp__isActive)
        MsgBox "Expected JumpApp__isActive to be true!"

    JumpApp__gui.Hide()
    global JumpApp__isActive := false
}

JumpApp__Show() {
    if (JumpApp__isActive)
        MsgBox "Expected JumpApp__isActive to be false!"

    global JumpApp__isActive := true
    jumpApp__gui.Show()
}

JumpApp__Cancel() {
    JumpApp__Hide()
}

; TODO(maybe): if there are multiple of the same process, show selection list to choose
JumpApp__JumpToSelection(Callback) {
    Callback()

    JumpApp__Hide()
}

JumpApp__GetAppText() {
    ; &  => causes the character following it to be underlined
    ; `n => prints a newline
    return "&chrome"
        . "`n" . "&firefox"
        . "`n" . "&github desktop"
        . "`n" . "home folder"
        . "`n" . "&Edge"
        . "`n" . "&explorer"
        . "`n" . "&Notepad"
        . "`n" . "&notepad++"
        . "`n" . "&outlook"
        . "`n" . "&teams"
        . "`n" . "&Visual studio"
        . "`n" . "&vs code"
}

#HotIf JumpApp__isActive ; bind Hotkeys when JumpApp's ListBox is Visible
    ; c -> Chrome
    C::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "chrome.exe",
            "C:\Program Files\Google\Chrome\Application\chrome.exe" )
    }

    ; Shift+E => edge
    +E::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "msedge.exe",
            "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe --profile-directory=Default" )
    }

    ; e -> Explorer.exe
    E::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "ahk_class CabinetWClass ahk_exe explorer.exe",
            "explorer.exe" )
    }

    ; f -> Firefox
    F::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "firefox.exe",
            Format("{}\Mozilla Firefox\firefox.exe", g_APP_DATA_LOCAL_DIR) )
    }

    ; g -> GitHub Desktop
    G::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByName( "GitHub Desktop",
            Format("{}\GitHubDesktop\GitHubDesktop.exe", g_APP_DATA_LOCAL_DIR) )
    }

    ; TODO: handle scenario where A_UserName is different than the display name explorer uses
    ; h -> Home Folder
    H::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchInFileExplorerByClsid( A_UserName,
            "59031a47-3f72-44a7-89c5-5595fe6b30ee" )
    }

    ; Shift+N => Notepad
    +N::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "notepad.exe",
            Format("{}\system32\notepad.exe", A_WinDir) )
    }

    ; n -> Notepad++
    N::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "notepad++.exe",
            "C:\Program Files\Notepad++\notepad++.exe" )
    }

    ; o -> Outlook
    O::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "outlook.exe",
            "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" )
    }

    ; t -> Teams
    t::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "ms-teams.exe",'ms-teams.exe' )
    }

    ; Shift+V => Visual Studio
    +V::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "devenv.exe",
            "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe")
    }

    ; v -> VS Code
    v::{
        JumpApp__JumpToSelection () => Window_FocusOrLaunchByProcess( "code.exe",
            "C:\Program Files\Microsoft VS Code\Code.exe" )
    }
#HotIf