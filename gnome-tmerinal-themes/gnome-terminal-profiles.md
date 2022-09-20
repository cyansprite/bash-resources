# Export Gnome Terminal Profile

copied from [Original Gist](https://gist.githubusercontent.com/fdaciuk/9ec4d8afc32063a6f74a21f8308e3807/raw/d13fb74d53d0c00b6646445052b4811886067042/gnome-terminal-profiles.md)

List profiles

```
dconf dump /org/gnome/terminal/legacy/profiles:/
```

Determine the terminal profile string for the profile you will need. This is the terminal profile that I will export:

```
[:1430663d-083b-4737-a7f5-8378cc8226d1]
foreground-color='#C3C3C7C7D1D1'
visible-name='Material Colors'
palette=['#070736364141', '#EBEB60606B6B', '#C3C3E8E88D8D', '#F7F7EBEB9595', '#8080CBCBC3C3', '#FFFF24249090', '#AEAEDDDDFFFF', '#FFFFFFFFFFFF', '#00002B2B3636', '#EBEB60606B6B', '#C3C3E8E88D8D', '#F7F7EBEB9595', '#7D7DC6C6BFBF', '#6C6C7171C3C3', '#343443434D4D', '#FFFFFFFFFFFF']
default-size-columns=100
default-size-rows=28
use-system-font=false
use-theme-colors=false
font='Source Code Pro 10'
allow-bold=false
bold-color-same-as-fg=true
bold-color='#FFFFFFFFFFFF'
background-color='#1E1E28282C2C'
audible-bell=false
scrollbar-policy='never'
```

And the string that I will need to use to export is

```
:1430663d-083b-4737-a7f5-8378cc8226d1
```

The command to export that profile is (note the ending slash)

```
dconf dump /org/gnome/terminal/legacy/profiles:/:1430663d-083b-4737-a7f5-8378cc8226d1/ > material-theme-profile.dconf
```

To restore the profile

```
dconf load /org/gnome/terminal/legacy/profiles:/:1430663d-083b-4737-a7f5-8378cc8226d1/ < material-theme-profile.dconf
```

# Edit configurations

If you want to edit some configuration from terminal, you can use the command:

```
dconf write /org/gnome/terminal/legacy/profiles:/YOUR_PROFILE_ID/PROPERTY_NAME "'New value'"
```

When:

1. `YOUR_PROFILE_ID` is your profile ID ¯\\_(ツ)_/¯;
2. `PROPERTY_NAME` is the name of the property you want to change;
3. `New value` is the new value for the property.

Example: let's see you want to update font configuration. Let's set `Fira Mono` for **font face**, and `12` for **font size**. Just use the command:

```
dconf write /org/gnome/terminal/legacy/profiles:/:1430663d-083b-4737-a7f5-8378cc8226d1/font "'Fira Mono for Powerline Regular 12'"
```
