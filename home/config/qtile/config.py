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

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
# from libqtile.utils import guess_terminal

mod = "mod4"
terminal = 'kitty'
browser = 'qutebrowser'

keys = [
    # Power Control
    Key([mod, "control"], "q", lazy.shutdown(), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "q", lazy.spawn('lockscreen'), desc="Spawn a command using a prompt widget"),
    Key([mod, "control"], "r", lazy.restart(), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),

    # Rofi
    Key([mod], "r", lazy.spawn('rofi -show run -show-icons'), desc="Spawn a command using a prompt widget"),
    Key([mod], "space", lazy.spawn('rofi -show drun -show-icons'), desc="Move window focus to other window"),
    Key([mod, "shift"], "Return", lazy.spawn('rofi -show drun -show-icons'), desc="Move window focus to other window"),

    # Launch Apps
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch terminal"),

    # Backlight
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 5"), desc="Launch terminal"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 5"), desc="Launch terminal"),
    Key([mod, "shift"], "bracketright", lazy.spawn("xbacklight -inc 5"), desc="Launch terminal"),
    Key([mod, "shift"], "bracketleft", lazy.spawn("xbacklight -dec 5"), desc="Launch terminal"),

    # Volume
    Key([], "XF86AudioMute", lazy.spawn("pactl -- set-sink-mute @DEFAULT_SINK@ toggle"), desc="Launch terminal"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset 'Master' 5%+"), desc="Launch terminal"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset 'Master' 5%-"), desc="Launch terminal"),

    # Media Controls
    Key([], "XF86AudioPlay", lazy.spawn("playerctl --player=%any play-pause")), # Play Pause
    Key([], "XF86AudioNext", lazy.spawn("playerctl --player=%any next")), # Next song
    Key([], "XF86AudioPrev", lazy.spawn("playerctl --player=%any previous")), # Previous Song

    # Other Function Row
    # Key([], "XF86ModeLock", lazy.spawn("amixer sset 'Master' 5%-"), desc="Launch terminal"),

    # Window Control
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "f", lazy.window.toggle_floating()),

    # Qtile Control
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "control"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
]

groups = [Group(i) for i in "1234567890"]

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
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

# COLORS
colors = {'bg': "#282828",
          'fg': '#ebdbb2',
          'fg0': '#fbf1c7',
          'bg_h': '#1d2021',
          'bg_s': '#1d2021',
          'red': "#cc241d",
          'green': "#98971a",
          'yellow': "#d79921",
          'blue': "#458588",
          'purple': "#b16286",
          'aqua': "#689d6a",
          'orange': '#d65d0e',
          'gray': "#928374"}

layouts = [
    layout.Columns(border_focus=colors['red'],
                   border_normal=colors['fg'],
                   border_focus_stack=[colors['fg'], colors['fg0']],
                   border_width=2,
                   margin=3,
                   margin_on_single=0),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Noto Mono Bold",
    fontsize=12,
    padding=3,
    background=colors['bg'],
    foreground=colors['fg'],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper='/home/Quinn/.config/qtile/background.png',
        wallpaper_mode='stretch',
        top=bar.Bar(
            [
                widget.Image(
                    filename='/home/Quinn/.config/qtile/Arch-Logo.png'
                ),
                widget.Sep(),
                #widget.TextBox("Layout:"),
                #widget.CurrentLayout(),
                #widget.Sep(),
                widget.GroupBox(
                    active=colors['fg'],
                    highlight_method='line',
                    inactive=colors['gray'],
                    this_current_screen_border=colors['fg'],
                    this_screen_border=colors['fg'],
                    hide_unused=False,
                    visible_groups=['1', '2', '3', '8', '9', '0'],
                    margin=3,
                    borderwidth=2,
                ),
                widget.Sep(),
                widget.Prompt(),
                widget.TextBox("CPU:"),
                widget.CPUGraph(
                    border_color=colors['fg'],
                    graph_color=colors['blue'],
                    fill_color=colors['blue'],
                    line_width=1,
                    border_width=1,
                ),
                widget.TextBox("RAM:"),
                widget.MemoryGraph(
                    border_color=colors['fg'],
                    graph_color=colors['red'],
                    fill_color=colors['red'],
                    line_width=1,
                    border_width=1,
                ),
                widget.TextBox("Net:"),
                widget.NetGraph(
                    border_color=colors['fg'],
                    graph_color=colors['aqua'],
                    fill_color=colors['aqua'],
                    line_width=1,
                    border_width=1,
                ),
                #widget.TextBox("HDD:"),
                #widget.HDDBusyGraph(
                #    border_color=colors['fg'],
                #    graph_color=colors['aqua'],
                #    fill_color=colors['yellow'],
                #    line_width=1,
                #    border_width=1,
                #),
                widget.Sep(),
                widget.Spacer(
                    length=bar.STRETCH,
                ),
                widget.Sep(),
                widget.Wlan(
                    format='WiFi: \'{essid}\' - {percent:2.0%}',
                    interface='wlp0s20f3',
                ),
                widget.Net(
                    format=" D:{down} U:{up}",
                    update_interval=5,
                ),
                widget.Sep(),
                widget.Backlight(
                    backlight_name='intel_backlight',
                    format='BL: {percent:2.0%}'
                ),
                widget.Sep(),
                widget.Volume(
                    fmt='Vol: {}'
                ),
                widget.Sep(),
                widget.Battery(
                    notify_below=10,
                    format='Bat: {char} {percent:2.0%} {hour:d}:{min:02d}',
                ),
                widget.Sep(),
                widget.Clock(
                    font='Noto Sans Bold',
                    format="%A, %B %d, %H:%M"
                ),
                widget.Sep(),
                widget.QuickExit(
                    default_text='[X]',
                    countdown_format='[{}]',
                ),
                widget.Spacer(
                    length=3,
                ),
            ],
            24,
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            border_color=4*[colors['fg']],
            background=colors['bg']+'00',
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
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
