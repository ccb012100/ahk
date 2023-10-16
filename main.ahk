#Warn
#SingleInstance Force
#Requires AutoHotkey >=2.0

SetWorkingDir(A_ScriptDir)

g_USER_HOME_DIR := "C:\Users\" . A_UserName
g_APP_DATA_LOCAL_DIR := g_user_home_dir . "\AppData\Local"
g_themes := {}

#Include Themes/Custom.ahk

#Include Windows.ahk

#Include JumpApp/JumpApp.ahk ; must come *after* Windows.ahk

; Active Window has WinTitle "A"

; Key codes
;  !   Alt
;  #   Win
;  ^   Ctrl
;  +   Shift

try {
    ^!+F5::Reload           ; 🔃 Meh+F5 :: Reload this script
    ^!+Q::SendInput "!{F4}" ; 🛑 Meh+Q  :: (Q)uit the focused application by sending Alt+F4
    ^!+R::Reload            ; 🔃 Meh+R  :: Reload this script

    ; ✍🏽 Meh+F2 :: Edit this script
    ;*      I could also just use the command `Edit`, but I don't want to
    ;*      have to worry about the file association for *.ahk files
    ^!+F2::Run Format( "C:\Program Files\Microsoft VS Code\Code.exe {}", A_ScriptDir )

    ; 📶 Meh+B :: Open (B)luetooth settings
    ^!+B::Window_FocusOrLaunchByName(
        'Settings ahk_exe ApplicationFrameHost.exe', ; filter on Title and Process
        'ms-settings:bluetooth'
    )

    ; 🎯 Meh+C :: (C)enter the active window
    ^!+C::{
        if WinExist( "A" )
            Window_Center "A"
    }

    ; 📁 Meh+D :: (E)xplorer
    ^!+E::Window_FocusOrLaunchInFileExplorerByClsid( "Downloads", "088e3905-0323-4b02-9826-5d99428e115f" )

    ; 👀 Meh+F :: (F)ocus on current window (hide all other windows)
    ^!+F::{
        KeyWait "Alt", "L"
        KeyWait "Control", "L"
        SendInput "#{Home}"
    }

    ; 🙈 Meh+H :: (H)ide the active window
    ^!+H::{
        if WinExist( "A" )
            WinMinimize "A"
    }

    ; 🦘 Meh+J :: (J)ump to Application
    ^!+J::JumpApp_Activate

    ; ⏯️ Meh+M :: (M)ove Window to the back
    ^!+M::SendInput "!{Escape}"

    ; ✈️ Meh+O :: (O)verview
    ^!+O::{
        ;* We have to wait for Control and Alt to be released because
        ;* the combination <Shift>+<Alt>+<Ctrl>+<Win> opens Microsoft Office.
        ;* see: <https://superuser.com/a/1477395> for details.
        KeyWait "Alt", "L"
        KeyWait "Control", "L"
        SendInput "#{Tab}"
    }

    ; ⏯️🎧 Meh+P :: (P)lay/Pause
    ^!+P::SendInput "{Media_Play_Pause}"

    ; 🎧 Meh+S :: (S)potify
    ^!+S::{
        spotify_exe := "Spotify.exe"

        if A_UserName == "chris" {
            ;* To run an an app installed through the Microsoft Store:
            ;*
            ;* - Win+R -> shell:AppsFolder
            ;* - Find the app, right-click and choose "Create shortcut"
            spotify_exe_path := "C:\Users\chris\Links\Spotify"
        }
        else{
            spotify_exe_path := A_AppData . "\Spotify\Spotify.exe"
        }
        Window_FocusOrLaunchByProcess( "Spotify.exe", spotify_exe_path)
    }

    ; 📺 Meh+T :: (T)erminal
    ^!+T::{
        ; kmonad doesn't seem to coexist well with Wezterm, so we use Windows Terminal instead if it's running
        if WinExist( "ahk_exe kmonad.exe" ) {
            Window_FocusOrLaunchByProcess( "WindowsTerminal.exe", "wt" )
        }
        else{
            Window_FocusOrLaunchByProcess( "wezterm-gui.exe", "C:\Program Files\WezTerm\wezterm-gui.exe" )
        }
    }

    ; TODO: toggle back to previous size ("restore")
    ; ↕ Meh+V :: (V)ertically maximize the active window
    ^!+V::Window_VerticallyMaximize "A"

    ; 🔍 Meh+W :: Show info for the window under the cursor
    ^!+W::Window_WatchCursor

    ; 🔊 Meh+<EQUALS> :: Volume Up (+)
    ^!+=::SendInput "{Volume_Up}"

    ; 🔊 Meh+<MINUS> :: Volume Down (-)
    ^!+-::SendInput "{Volume_Down}"

    ;* Move window Left/Right to next display.
    ;*
    ;* We have to wait for Control and Alt to be released because
    ;* the combination <Shift>+<Alt>+<Ctrl>+<Win> opens Microsoft Office.
    ;* see: <https://superuser.com/a/1477395> for details.

    ; 👈🏽🗔 Meh+, :: Move Window to next display on Left
    ^!+,::{
        KeyWait "Alt", "L"
        KeyWait "Control", "L"
        SendInput("+#{Left}")
    }
    ;; 🗔👉🏽 Meh+. :: Move Window to next display on Right
    ^!+.::{
        KeyWait "Alt", "L"
        KeyWait "Control", "L"
        SendInput "+#{Right}"
    }

    ;; 📉 Meh+/ or Meh+z (i.e. both Meh keys simultaneously) - Task Manager
    ^!+z::
    ^!+/::{
        ; this will error out if the user does not allow running taskmgr as Administrator
        try{
            Window_FocusOrLaunchByName( 'ahk_class TaskManagerWindow', 'taskmgr.exe' )
        }
        catch{
            ; TODO: handle user cancellation
        }
    }
}
catch as e {
    MsgBox Format( "An error was thrown:`nLine {}: {}", e.Line, e.Message )
}
