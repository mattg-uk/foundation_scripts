# Foundation Scripts

This project installs my personal system configuration on Kubuntu 24.10.

These scripts are here to make convenient the establishment of a development
system on Kubuntu 24.10. They _might_ work on other Linux distros.

They will install:
  - basic development tools for C/C++, Rust and Python
  - quickly install neovim, alactritty and sane / IDE configs
  - install hyprland, and build / install hyprpanel and swww

It will also be necessary to install graphics drivers, i.e. for nvidia,
refer to the manafacturer documentation and hyprland website.

## Usage

All the scripts require sudo privileges. These scripts have been tested with
Kubuntu 24.10, on a fresh 'from .iso' install. 

_Please note: There are a *lot* of dependencies for Hyprpanel, and it will
take quite some time to download and compile them_

## Development Environment

This script will install an 'IDE' like environment: toolchains,
alactritty terminal, neovim editor and Hyprland compositing window manager.

`git clone https://github.com/mattg-uk/foundation_scripts`

`cd foundation_scripts`

`sudo ./development.sh`

## Running individual scripts

The scripts can also be run individually.

  - `editor_environment.sh`
  - `install_hyperland.sh`

assume that `basic_system.sh` has already been run.

### Basic system

Runs sudo update and upgrade, and installs toolchains. Configures basic folders
in /home and adds them to the .bashrc. It automates routine installation of
C/C++, Rust, and python-venv: these are dependencies for the other scripts.

`sudo ./basic_system.sh`

`. .bashrc`

### Editor environment

This script installs Alacritty, Neovim, and configuration files.

`sudo ./editor_environment.sh`

### Install hyprland 

This script will install Hyprland - login is possible then possible from sddm.
There is a basic configuration - but be careful of monitor settings.

Hyprpanel will be installed, along with SWWW. These extra tools allow for  
bluetooth, volume, and networking control from the system tray, etc.

`sudo ./install_hyprland.sh`

_Note: Ubuntu / Kubuntu do not contain Hyprpanel in 24.10;
if the dependencies of the sources for Hyprpanel and SWWW change substantially,
then this from-source build may break._

## Finishing configuration

Alacritty will receive a configuration, as will Neovim; but the LSP / DAP
Linting plugins must be installed using Mason when 'nvim' is run.

`:Mason`

The first time nvim is opened, packer will run to install plugins. This
will trigger a large number of packages to be installed, particularly
for treesitter. If the downloads do not all finish, close and re-open
neovim - repeatedly. 

Wallpaper can be installed in Hyprland using swww; I use wallpaper from
KDE. The hyprpanel bar can be configured by clicking on the 'Arch' icon.
