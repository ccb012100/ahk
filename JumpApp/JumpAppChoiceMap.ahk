;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;             Map (Dictionary) used in                ;;;
;;;                 the JumpApp GUI                     ;;;
;;;                                                     ;;;
;;;       Key : display value for the select list       ;;;
;;;     Value : the callback to run                     ;;;
;;;                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

JumpApp__BuildChoiceMap() {
    return Map(
        "c -> Chrome",
            () => Window_FocusOrLaunchByProcess("chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe"),
        "f -> Firefox",
            () => Window_FocusOrLaunchByProcess(
                "firefox.exe",
                Format("{}\Mozilla Firefox\firefox.exe", g_APP_DATA_LOCAL_DIR)
            ),
        "g -> GitHub Desktop",
            () => Window_FocusOrLaunchByName(
                "GitHub Desktop",
                Format("{}\GitHubDesktop\GitHubDesktop.exe", g_USER_HOME_DIR)
            ),
        ; TODO: handle scenario where A_UserName is different than the display name explorer uses
        "h -> Home Folder",
            () => Window_FocusOrLaunchInFileExplorerByClsid(A_UserName, "59031a47-3f72-44a7-89c5-5595fe6b30ee"),
        "m -> Microsoft Edge",
            () => Window_FocusOrLaunchByProcess(
                "msedge.exe",
                "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe --profile-directory=Default"
            ),
        "n -> Notepad++",
            () => Window_FocusOrLaunchByProcess(
                "notepad++.exe",
                "C:\Program Files\Notepad++\notepad++.exe"
            ),
        "o -> Outlook",
            () => Window_FocusOrLaunchByProcess(
                "outlook.exe",
                "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
            ),
        "p -> Notepad",
            () => Window_FocusOrLaunchByProcess(
                "notepad.exe",
                Format("{}\system32\notepad.exe", A_WinDir)
            ),
        "s -> Visual Studio",
            () => Window_FocusOrLaunchByProcess(
                "devenv.exe",
                "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe"
            ),
        "t -> Teams",
            () => Window_FocusOrLaunchByProcess(
                "teams.exe",
                Format('{}\Microsoft\Teams\Update.exe --processStart "Teams.exe"', g_APP_DATA_LOCAL_DIR)
            ),
        "v -> VS Code",
            () => Window_FocusOrLaunchByProcess("code.exe", "C:\Program Files\Microsoft VS Code\Code.exe"),
    )
}