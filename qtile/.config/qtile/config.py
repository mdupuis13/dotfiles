# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import qtile_extras.widget

# for debugging purposes
from libqtile.log_utils import logger

_nord_theme = {
    "background": "#2e3440",  # nord0
    "background_alt": "#81a1c1",
    "background_inactive": "#4c566a",  # nord3
    "border_focus": "#5e81ac",  # nord10
    "border_normal": "#4c566a",  # nord3
    "border_screen_groupbox": "#3b4252",  # nord 1
    "foreground": "#81a1c1",  # nord9
    "foreground_alt": "#2e3440",  # nord0
    "foreground_inactive": "#4c566a",  # nord3
    "primary": "#ebcb8b",  # nord13 yellow
    "alert": "#bf616a",  # nord11 red
    # colors by name
    "bluegray": "#81a1c1",  # nord9 bluegray
    "blue": "#5e81ac",  # nord10 darkish blue
    "red": "#bf616a",  # nord11 red
    "orange": "#d08770",  # nord12 orange
    "yellow": "#ebcb8b",  # nord13 yellow
    "green": "#a3be8c",  # nord14 green
    "purple": "#b48ead",  # nord15 purple
    "lightgray": "#d8dee9",  # nord4
    "lightergray": "#e5e9f0",  # nord5
    "lightestgray": "#eceff4",  # nord6
}

_onedark_theme = {
    "background": "#21252B",  # nord0
    "background_alt": "#ABB2BF",
    "background_inactive": "#1E2227",  # nord3
    "border_focus": "#61AFEF",  # nord10
    "border_normal": "#21252B",  # nord3
    "border_screen_groupbox": "#ABB2BF",  # nord 1
    "foreground": "#D4D8DF",  # nord9
    "foreground_alt": "#21252B",  # nord0
    "foreground_inactive": "#323842",  # nord3
    "primary": "#E5C07B",  # nord13 yellow
    "alert": "#E06C75",  # nord11 red
    # colors by name
    "aqua": "#56B6C2",
    "blue": "#61AFEF",  # nord10 darkish blue
    "red": "#E06C75",  # nord11 red
    "orange": "#FAB387",  # nord12 orange
    "yellow": "#E5C07B",  # nord13 yellow
    "green": "#98C379",  # nord14 green
    "purple": "#C678DD",  # nord15 purple
    "lightgray": "#ABB2BF",  # nord4
    "lightergray": "#D4D8DF",  # nord5
    "lightestgray": "#F6F7F9",  # nord6
}

# my custom colors
colors = _onedark_theme

mod = "mod4"
#my_browser = "/usr/bin/firefox"
my_browser = "flatpak run org.mozilla.firefox"
my_email_client = "/usr/bin/claws-mail"
my_filemanager = "/usr/bin/thunar"
my_terminal = "/usr/bin/kitty"

# Thanks for your code alvaro-jmp !!!
# https://gist.github.com/alvaro-jmp/95bfdff559f85f4c5d0cb04855832894#file-config-py


@lazy.function
def set_all_float_windows_to_non_floating_mode(qtile):
    for window in qtile.current_group.windows:
        if window.floating:
            window.cmd_disable_floating()


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control", "mod1"], "h", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control", "mod1"], "l", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and  unsplit sides of stack"),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen(),
        desc="Toggle between real fullscreen and in-viewport fullscreen"),

    Key([mod], "Return", lazy.spawn(my_terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], 'period', lazy.next_screen(), desc='Next monitor'),
    Key([mod], 'comma', lazy.prev_screen(), desc='Next monitor'),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # Key [mod]+Alt locks workstation
    Key([mod, "mod1"], 'l', lazy.spawn("/usr/bin/light-locker-command -l"),
        desc="Lock workstation"),

    # Set all floating windows to non-floating mode of a group (Mod + Shift + n)
    Key([mod, "shift"], "n", set_all_float_windows_to_non_floating_mode(),
        desc="Set all floating windows to non-floating mode of a group"),

    ############################
    # MD custom application keybinds
    Key([mod], "b", lazy.spawn(my_browser), desc="Starts Firefox"),
    Key([mod], "c", lazy.spawn(my_email_client), desc="Starts email client"),
    Key([mod], "e", lazy.spawn(my_filemanager), desc="Starts file browser"),
    Key([mod], "p", lazy.spawn("/usr/bin/rofi -show drun"), desc="Spawns rofi")

]

groups = [Group("1", label=' '),
          Group("2", label='磊 ', layout="columns"),
          Group("3", label=' '),
          Group("4", label=' '),
          Group("5", label=' '),
          Group("6", label=' '),
          Group("7", label=' '),
          Group("8", label=' ', layout="max")
          ]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            # Key(
            #     [mod, "shift"],
            #     i.name,
            #     lazy.window.togroup(i.name, switch_group=True),
            #     desc="Switch to & move focused window to group {}".format(i.name),
            # ),
            # Or, use below if you prefer not to switch to that group.
            # mod1 + shift + letter of group = move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="Move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    # layout.Columns(
    #     border_focus=colors["border_focus"],
    #     border_normal=colors["border_normal"],
    #     border_focus_stack=["#d75f5f", "#8f3d3d"],
    #     border_width=2,
    #     border_on_single=False,
    #     insert_position=1,  # 0 means right above the current window, 1 means right after
    #     margin=0
    # ),
    layout.MonadThreeCol(
        border_focus=colors["border_focus"],
        border_normal=colors["border_normal"],
        border_width=2,
        margin=0,
        single_border_width=0,
        # single_margin=[5, 440, 5, 440],
        main_centered=True,
        min_ratio=0.45,
        new_client_position="bottom"
    ),
    layout.MonadTall(
        border_focus=colors["border_focus"],
        border_normal=colors["border_normal"],
        border_width=2,
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="DaddyTimeMono Nerd Font",
    # font="sans",
    fontsize=16,
    padding=3,
    foreground=colors["foreground"]
)
extension_defaults = widget_defaults.copy()

sep_size = {"linewidth": 3,
            "padding": 10,
            "size_percent": 85, }

screens = [
    Screen(
        top=bar.Bar([
            widget.TextBox(
                    ' ',
                    fontsize=26,
                    foreground=colors["red"],
                    ),
            qtile_extras.widget.CurrentLayoutIcon(
                # custom_icon_paths="/home/mdupuis/src/gitlab/beautyline",
                foreground=colors["foreground"],
                use_mask=True
            ),
            widget.GroupBox(
                disable_drag=True,
                # highlight_method [block, text, line]
                highlight_method='line',
                active=colors["foreground"],
                inactive=colors["foreground_inactive"],
                other_current_screen_border=colors["border_focus"],
                other_screen_border=colors["foreground_alt"],
                padding_x=5,
                this_current_screen_border=colors["aqua"],
                this_screen_border=colors["background_alt"],
                urgent_border=colors["alert"],
            ),
            widget.Sep(
                foreground=colors["foreground_inactive"],
                **sep_size
            ),
            widget.WindowName(
                for_current_screen=False
            ),
            widget.Chord(
                chords_colors={
                    "launch": (colors["background_alt"], colors["foreground_alt"]),
                },
                foreground=colors["foreground"],
                name_transform=lambda name: name.upper(),
            ),
            widget.WidgetBox(
                close_button_location="right",
                foreground=colors["purple"],
                text_closed="﫭 ",
                text_open="  ",
                widgets=[
                    widget.DF(
                        foreground=colors["purple"],
                        format="~ {r:.0f}%/{s}{m}",
                        partition="/home",
                        update_interval=600,
                        visible_on_warn=False,
                    ),
                    widget.TextBox(
                        '--',
                        foreground=colors["purple"],
                    ),
                    widget.DF(
                        foreground=colors["purple"],
                        format="Photo {r:.0f}%/{s}{m}",
                        partition="/home/mdupuis/Photographie",
                        update_interval=600,
                        visible_on_warn=False,
                    )]),
            widget.Sep(
                foreground=colors["purple"],
                **sep_size
            ),
            widget.CPU(
                foreground=colors["blue"],
                format="  {load_percent:.0f}% ",
                update_interval=2,
            ),
            widget.Memory(
                font='Font Awesome 5 Free Solid',
                foreground=colors["blue"],
                format=" {MemPercent:.0f}% ",
                update_interval=2,
            ),
            widget.ThermalSensor(
                foreground=colors["blue"],
                foreground_alert=colors["alert"],
                format=' {temp:.0f}糖',
                tag_sensor='Package id 0',
                threshold=75,
            ),
            widget.NvidiaSensors(
                foreground=colors["blue"],
                format='   {temp}糖',
                foreground_alert=colors["alert"],
                threshold=85,
            ),
            widget.Sep(
                foreground=colors["blue"],
                **sep_size
            ),
            widget.GenPollText(
                fontsize=16,
                foreground=colors["green"],
                func=lambda: subprocess.check_output(os.path.expanduser(
                    "~/.config/qtile/qtilebar-scripts/openweathermap-fullfeatured.sh")).decode("utf-8"),
                update_interval=600,
            ),
            widget.GenPollText(
                fmt=" {}",
                foreground=colors["green"],
                markup=True,
                func=lambda: subprocess.check_output(os.path.expanduser(
                    "~/.config/qtile/qtilebar-scripts/info-airqualityindex.sh")).decode("utf-8"),
                update_interval=600,
            ),
            widget.Sep(
                foreground=colors["green"],
                **sep_size
            ),
            widget.Volume(
                theme_path="/home/mdupuis/src/gitlab/beautyline",
            ),
            widget.GenPollText(
                fmt="{}",
                foreground=colors["purple"],
                func=lambda: subprocess.check_output(os.path.expanduser(
                    "~/.config/qtile/qtilebar-scripts/alsa-get-volume-level.sh")).decode("utf-8"),
                update_interval=1,
            ),
            widget.Sep(
                foreground=colors["purple"],
                **sep_size
            ),
            widget.CheckUpdates(
                colour_have_updates=colors["orange"],
                colour_no_updates=colors["green"],
                display_format="  {updates}",
                distro='Debian',
                initial_text="  N/A",
                no_update_string="  0",
                update_interval=600
            ),
            widget.GenPollText(
                fmt=" {}",
                #foreground=colors["green"],
                markup=True,
                func=lambda: subprocess.check_output(os.path.expanduser(
                    "~/.config/qtile/qtilebar-scripts/flatpak-updates.sh")).decode("utf-8"),
                update_interval=600,
            ),
            widget.Sep(
                foreground=colors["yellow"],
                **sep_size
            ),
            # widget.QuickExit(fmt=" ⏻ ", countdown_format="[ {}s ]", countdown_start=15),
            # widget.Clock(
            #     foreground=colors["lightgray"],
            #     format="%A, %B %d - %H:%M:%S",
            # ),
            widget.GenPollText(
                fmt="{} ",
                foreground=colors["lightestgray"],
                func=lambda: subprocess.check_output(os.path.expanduser(
                    "~/.config/qtile/qtilebar-scripts/getdate_fr.py")).decode("utf-8"),
                update_interval=1,
            ),
            # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
            # widget.StatusNotifier(),
            widget.Systray(),
        ],
            26,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            background=colors["background"],
            opacity=1
        ),
    ),
    Screen(
        bottom=bar.Bar([
            widget.TextBox(
                ' ',
                fontsize=26,
                foreground=colors["red"],
            ),
            qtile_extras.widget.currentlayout.CurrentLayoutIcon(
                foreground=colors["foreground_inactive"],
                use_mask=True
            ),
            widget.Sep(
                foreground=colors["foreground_inactive"],
                **sep_size
            ),
            widget.WindowName(
                for_current_screen=False
            ),
            # widget.Sep(
            #     foreground=colors["foreground"],
            #     **sep_size
            # ),
            # widget.Mpd2(
            #     foreground=colors["foreground"],
            #     #color_progress=colors["foreground_inactive"],
            #     idle_format=" ﱙ",
            #     no_connection="not connected",
            #     scroll=True,
            #     scroll_clear=True,
            #     scroll_delay=1,
            #     scroll_repeat=True,
            #     scroll_step=10,
            #     status_format="{play_status} {album}/{title}",
            #     width=300
            # ),
            widget.Sep(
                foreground=colors["foreground"],
                **sep_size
            ),
            widget.GenPollText(
                fmt="{}",
                foreground=colors["purple"],
                func=lambda: subprocess.check_output(os.path.expanduser(
                    "~/.config/qtile/qtilebar-scripts/alsa-get-volume-level.sh")).decode("utf-8"),
                update_interval=1,
            ),
            widget.Sep(
                foreground=colors["purple"],
                **sep_size
            ),
            widget.Clock(
                foreground=colors["lightestgray"],
                format="  %H:%M  ",
            ),
        ],
            26,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            background=colors["background"],
            opacity=1
        )
    )
]


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=colors["foreground"],
    border_normal=colors["foreground_inactive"],
    border_width=1,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="qalculate-gtk"),  # galculator
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def start_once():
    # logger.warning("start_once()")

    home = os.path.expanduser('~')
    logger.warning("home is " + home)

    autostart_full_path = home + '/.config/qtile/autostart.sh'
    logger.warning("autostart_full_path is " + autostart_full_path)

    real_autostart = os.path.realpath(autostart_full_path, strict=True)
    logger.warning("real_autostart is " + real_autostart)

    subprocess.Popen(real_autostart)
