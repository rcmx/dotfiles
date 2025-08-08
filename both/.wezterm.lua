
local wezterm = require 'wezterm'
local action = wezterm.action

local config = wezterm.config_builder()


config.leader = { key = 'a', mods = 'CTRL' }

config.adjust_window_size_when_changing_font_size = false
config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 120
config.initial_rows = 40
config.scrollback_lines = 9999
config.enable_scroll_bar = true
config.tab_bar_at_bottom = true
-- config.window_decorations = "RESIZE"

config.inactive_pane_hsb = {
  -- saturation = 0.9,
  brightness = 0.6,
}

config.color_scheme = 'Catppuccin Mocha'

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
    -- switch to previous tab 
    {
        key = 'LeftArrow',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    -- wwitch to next tab 
    {
        key = 'RightArrow',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(1),
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
        action = action.SplitHorizontal,
    },
    {
        key = '-',
        mods = 'LEADER',
        action = action.SplitVertical,
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

    -- resize with Leader + ctrl+arrow (enters resize mode)
    {
        key = 'LeftArrow',
        mods = 'LEADER|CTRL',
        action = wezterm.action.Multiple {
            wezterm.action.AdjustPaneSize { 'Left', 2 },
            wezterm.action.ActivateKeyTable {
                name = 'resize_pane',
                one_shot = false,
                timeout_milliseconds = 3000,
            },
        },
    },
    {
        key = 'RightArrow',
        mods = 'LEADER|CTRL',
        action = wezterm.action.Multiple {
            wezterm.action.AdjustPaneSize { 'Right', 2 },
            wezterm.action.ActivateKeyTable {
                name = 'resize_pane',
                one_shot = false,
                timeout_milliseconds = 3000,
            },
        },
    },
    {
        key = 'UpArrow',
        mods = 'LEADER|CTRL',
        action = wezterm.action.Multiple {
            wezterm.action.AdjustPaneSize { 'Up', 2 },
            wezterm.action.ActivateKeyTable {
                name = 'resize_pane',
                one_shot = false,
                timeout_milliseconds = 3000,
            },
        },
    },
    {
        key = 'DownArrow',
        mods = 'LEADER|CTRL',
        action = wezterm.action.Multiple {
            wezterm.action.AdjustPaneSize { 'Down', 2 },
            wezterm.action.ActivateKeyTable {
                name = 'resize_pane',
                one_shot = false,
                timeout_milliseconds = 3000,
            },
        },
    },
}

config.key_tables = {
  resize_pane = {
    -- ctrl+arrow keys for resizing (while in resize mode)
    { key = 'LeftArrow', mods = 'CTRL', action = wezterm.action.AdjustPaneSize { 'Left', 2 } },
    { key = 'RightArrow', mods = 'CTRL', action = wezterm.action.AdjustPaneSize { 'Right', 2 } },
    { key = 'UpArrow', mods = 'CTRL', action = wezterm.action.AdjustPaneSize { 'Up', 2 } },
    { key = 'DownArrow', mods = 'CTRL', action = wezterm.action.AdjustPaneSize { 'Down', 2 } },
    -- exit resize mode
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  },
}


local function copy_or_paste(window, pane)
    local sel = window:get_selection_text_for_pane(pane)
    if sel and sel ~= "" then
        -- Text is selected, use copy action 
        window:perform_action(action.Copy, pane)
        window:perform_action(action.ClearSelection, pane)
    else
        -- No text selected, paste from clipboard
        window:perform_action(action.PasteFrom 'Clipboard', pane)
    end
end

config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = action.ExtendSelectionToMouseCursor 'Cell',
    },
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action_callback(copy_or_paste),
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

wezterm.on('new-tab', function(tab, pane)
end)


-- handlers
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
--     -- wezterm.log_info('in handler')
--     local title = tab_title(tab)
--
--     -- wezterm.log_info(title)
--     if tab.is_active then
--         return {
--             { Background = { Color = 'blue' } },
--             { Text = ' ' .. title .. ' ' },
--         }
--     end
--     return title
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

