# README

[Autohotkey](https://www.autohotkey.com/) (AHK) scripts

## Scripts

### `main.ahk`

The script that should be run directly, analogous to the `main` method in a program. Consists of a series of Hotkeys
wrapped in a `try`/`catch` block to display any errors in a `MsgBox`.

### `Windows.ahk`

Functions for working with `Window`s (activating, hiding, resizing, moving, _etc._)

### JumpApp

A GUI app used for switching to specific programs, after launching them if necessary. Similar to `rofi` on Linux, or
`PowerToys Run` on Windows.

When the GUI is activated, the user selects an app by pressing the key associated with it. It's launched itself by a
hotkey, making this JumpApp a 'modal' design.

### `Themes` directory

Themes used for styling `Gui` components.

## Style Guide

Everything in AHK is both global and case-insensitive, so it requires discipline and conventions to keep things
organized and understandable.

---

**Global variables** should be snake-cased and prefixed with `g_`.

- example: `g_themes`, `g_`

**Variables** should be snake-cased.

- example: `foo`, `bar`, `baz_bat`

**Public Methods** should be Pascal-cased and prefixed with the script name and an underscore (`_`).

- example: the method `BarBaz()` in `Foo.ahk` would be `Foo_BarBaz()`

**Private**/**internal** methods and variables should be prefixed by the script name and _two_ (2) underscores (`__`).

- example: the method `Quux()` in `Foo.ahk` would be `Foo__Quux()`

**Consts** should be all caps.

- example: `g_USER_HOME_DIR`, `Foo_DATE_FORMAT`

---

Note that these rules compose.

## TODO

- [ ] `Meh-V` -> Restore window size on 2nd click
- [ ] Send active window to back (i.e. behind all open windows)
  - `WinMoveBottom("A")` is not what I want; it works more like `Alt-Esc`

### `Windows.ahk`

- [ ] `Window_VerticallyMaximize` - support multiple displays
- [ ] `Window_Center` - support multiple displays
- [ ] Cycle through Windows of active app (same as `` alt-` `` in **Mac**/**Linux**)

### `JumpApp.ahk`

- [ ] `JumpApp__JumpToSelection` - show selection list if the selected process has multiple windows
- [ ] Opening **Home** folder - handle scenario where `A_UserName` is different than the display name **Explorer** uses

### Themes

- [ ] Detect system light/dark setting