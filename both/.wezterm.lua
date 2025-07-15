
local wezterm = require 'wezterm'
local action = wezterm.action

local config = wezterm.config_builder()

config.leader = { key = 'a', mods = 'CTRL' }

config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = true
config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 120
config.initial_rows = 40
config.scrollback_lines = 9999
config.tab_bar_at_bottom = true
--config.window_decorations = "RESIZE"

-- Color scheme configuration based on OS and shell
local function get_color_scheme()
    if wezterm.target_triple:match("windows") then
        -- On Windows, check if we're in WSL
        local success, stdout = wezterm.run_child_process({"cmd", "/c", "wsl", "echo", "$WSL_DISTRO_NAME"})
        if success and stdout:match("Ubuntu") then
            return "Ubuntu"
        else
            -- Running in cmd.exe or powershell on Windows
            return 'Campbell (Gogh)'
        end
    else
        -- On Linux, use default
        return 'Catppuccin Mocha (Gogh)'
    end
end

config.color_scheme = get_color_scheme()


if wezterm.target_triple:match("windows") then
    config.default_prog = { 'pwsh.exe', '-NoLogo' }

    config.launch_menu = {
        {
            label = 'pwsh',
            args = { 'pwsh.exe', '-NoLogo' },
        },
        {
            label = 'cmd',
            args = { 'cmd.exe'},
        },
        {
            label = 'VS 2022 Developer PowerShell',
            args = {
                'pwsh.exe',
                '-noe',
                '-c',
                '&{Import-Module """C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll"""; Enter-VsDevShell 82e6e2da}'
            },
        }
    }
end

config.keys = {
    -- tabs
    {
        key = 'c',
        mods = 'LEADER',
        action = action.SpawnTab 'CurrentPaneDomain',
    },

    -- launcher
    {
        key = 'T',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.ShowLauncher
    },

    -- new window
    {
        key = 'n',
        mods = 'LEADER',
        action = action.SpawnWindow,
    },

    -- pane navigation (vim-style)
    {
        key = 'h',
        mods = 'LEADER',
        action = action.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = action.ActivatePaneDirection 'Right',
    },

    -- split panes
    {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '-',
        mods = 'LEADER',
        action = action.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- zoom pane
    {
        key = 'z',
        mods = 'LEADER',
        action = action.TogglePaneZoomState,
    },

    -- last window (similar to C-^)
    {
        key = '6',
        mods = 'LEADER|CTRL',
        action = action.ActivateLastTab,
    },

    -- pane resizing
    {
        key = 'UpArrow',
        mods = 'LEADER|CTRL',
        action = action.AdjustPaneSize { 'Up', 2 },
    },
    {
        key = 'DownArrow',
        mods = 'LEADER|CTRL',
        action = action.AdjustPaneSize { 'Down', 2 },
    },
    {
        key = 'LeftArrow',
        mods = 'LEADER|CTRL',
        action = action.AdjustPaneSize { 'Left', 2 },
    },
    {
        key = 'RightArrow',
        mods = 'LEADER|CTRL',
        action = action.AdjustPaneSize { 'Right', 2 },
    },
}

config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = action.CompleteSelection 'ClipboardAndPrimarySelection',
    },
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = action({ PasteFrom = "Clipboard" }),
    },
    -- and make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = action.OpenLinkAtMouseCursor,
    },
    {
        event = { Down = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = action.Nop,
    },
}




-- handlers
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
wezterm.log_info('in handler')
    local title = tab_title(tab)

    wezterm.log_info(title)
    if tab.is_active then
        return {
            { Background = { Color = 'blue' } },
            { Text = ' ' .. title .. ' ' },
        }
    end
    return title
end
)

-- functions

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end


return config

