# Foundation Installation Scripts

Bringing up a convenient development system from scratch can be time-consuming.

These scripts are here to make convenient the establishment of a development
system on Kubuntu 24.10.

They include:
  - basic_system.sh : basic development tools for C/C++, Rust and Python
  - editor_environment.sh : quickly install neovim, alactritty and configs
  - install_hyperland.sh : installs hyprland, hyprpanel, and swww
  - development.sh : installs all of the above

  - nvidia.sh : installs nvidia 560 driver and modeset files (run separately)

## Usage

All the scripts require sudo privileges, and drop those privileges, when
required, to perform steps as the SUDO_USER.

### Driver script

The nvidia script copies default minimal scripts into /etc - if you have
exisiting or alternative configuration for nvidia drivers, do not use this
script.

`sudo nvidia.sh`

### Development Environment

This script will install a full 'IDE' like environment including the toolchain
and the neovim editor. 

`sudo development.sh`

#### Hyprpanel / SWWW

Hyprland is installed so that login is possible from sddm to allow a tiling
environment. 

_Note: Ubuntu / Kubuntu do not contain Hyprpanel in 24.10;
if the dependencies of the sources for Hyprpanel and SWWW change substantially,
then the from-source builds may break._

#### Finishing configuration

Alacritty will receive a configuration, as will Neovim; but the LSP / DAP
Linting plugins must be installed using Mason when 'nvim' is run.

`:Mason`

The first time nvim is opened, packer will run to install plugins. This
will trigger a large number of packages to be installed, particularly
for treesitter. If the downloads do not all finish, close and re-open
neovim.

Wallpaper can be installed in Hyprland using swww; I use wallpaper from
KDE. The hyprpanel bar can be configured by clicking on the 'Arch' icon.
