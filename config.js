module.exports = {
    // Bell sound effect to use
    // See `:help bell` for instances where the bell sound would be used
    //"oni.audio.bellUrl": string

    // The default config is an opinionated, prescribed set of plugins. This is on by default to provide
    // a good out-of-box experience, but will likely conflict with a Vim/Neovim veteran's finely honed config.
    //
    // Set this to 'false' to avoid loading the default config, and load settings from init.vim instead.
    "oni.useDefaultConfig": true,

    // By default, user's init.vim is not loaded, to avoid conflicts.
    // Set this to `true` to enable loading of init.vim.
    "oni.loadInitVim": true,

    // Sets the `popupmenu_external` option in Neovim
    // This will override the default UI to show a consistent popupmenu,
    // whether using Oni's completion mechanisms or VIMs
    //
    // Use caution when changing the `menuopt` parameters if using
    // a custom init.vim, as that may cause problematic behavior
    //"oni.useExternalPopupMenu": boolean

    // If true, hide Menu bar by default
    // (can still be activated by pressing 'Alt')
    //"oni.hideMenu": boolean

    // glob pattern of files to exclude from fuzzy finder (Ctrl-P)
    //"oni.exclude": string[]

    // Editor settings

    "editor.backgroundOpacity": 1.0,
    "editor.backgroundImageUrl": "",
    //"editor.backgroundImageSize": string

    //"editor.quickInfo.enabled": boolean
    // Delay (in ms) for showing QuickInfo, when the cursor is on a term
    //"editor.quickInfo.delay": number

    //"editor.completions.enabled": boolean
    //"editor.errors.slideOnFocus": boolean
    //"editor.formatting.formatOnSwitchToNormalMode": boolean // TODO: Make this setting reliable. If formatting is slow, it will hose edits... not fun

    // If true (default), ligatures are enabled
    "editor.fontLigatures": true,
    "editor.fontSize": 14,
    "editor.fontFamily": "Fira Code Retina",

    // If true (default), the buffer scroll bar will be visible
    "editor.scrollBar.visible": true,

    // Command to list files for 'quick open'
    // For example, to use 'ag': ag --nocolor -l .
    //
    // The command must emit a list of filenames
    //
    // IE, Windows:
    // "editor.quickOpen.execCommand": "dir /s /b"
    // "editor.quickOpen.execCommand": "ag --nocolor -l",

    "editor.fullScreenOnStart": true,

    "editor.cursorLine": true,
    "editor.cursorLineOpacity": .8,

    //"editor.cursorColumn": boolean
    //"editor.cursorColumnOpacity": number

    "statusbar.enabled": true
}
