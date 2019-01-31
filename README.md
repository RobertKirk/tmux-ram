# Tmux Ram Usage

Plug and play RAM percentage and icon indicator for Tmux, can be used in `status-right` and `status-left`.

Very much inspired by tmux-ram, and most of the structure is copied from there.

## Installation
### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'RobertKirk/tmux-ram'

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-right`, they should now be visible.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/RobertKirk/tmux-ram ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/ram.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

If format strings are added to `status-right`, they should now be visible.

## Usage

Add any of the supported format strings (see below) to the existing `status-right` tmux option.
Example:

    # in .tmux.conf
    set -g status-right '#{ram_bg_color} ram: #{ram_icon} #{ram_percentage} | %a %h-%d %H:%M '

### Supported Options

This is done by introducing 8 new format strings that can be added to
`status-right` option:

 - `#{ram_icon}` - will display a ram status icon
 - `#{ram_percentage}` - will show ram percentage (averaged across cores)
 - `#{ram_bg_color}` - will change the background color based on the ram percentage
 - `#{ram_fg_color}` - will change the foreground color based on the ram percentage

## Changing default

By default, these icons are displayed:

 - low: "="
 - medium: "≡"
 - high: "≣"

And these colors are used:

 - low: `#[fg=green]` `#[bg=green]`
 - medium: `#[fg=yellow]` `#[bg=yellow]`
 - high: `#[fg=red]` `#[bg=red]`

Note that these colors depend on your terminal / X11 config.

You can change these defaults by adding the following to `.tmux.conf`:

```
set -g @ram_low_icon "ᚋ"
set -g @ram_medium_icon "ᚌ"
set -g @ram_high_icon "ᚍ"

set -g @ram_low_fg_color "#[fg=#00ff00]"
set -g @ram_medium_fg_color "#[fg=#ffff00]"
set -g @ram_high_fg_color "#[fg=#ff0000]"

set -g @ram_low_bg_color "#[bg=#00ff00]"
set -g @ram_medium_bg_color "#[bg=#ffff00]"
set -g @ram_high_bg_color "#[bg=#ff0000]"
```

Don't forget to reload tmux environment (`$ tmux source-file ~/.tmux.conf`)
after you do this.

### Maintainer

 - [Robert Kirk](https://github.com/RobertKirk)

### License

[MIT](LICENSE.md)
