# .files

These are my dotfiles. Take anything you want, but at your own risk.

It targets macOS systems, but it should work on \*nix as well (with `apt-get`).

## Package overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://caskroom.github.io) (packages: [Caskfile](./install/Caskfile))
- [Mackup](https://github.com/lra/mackup) (sync application settings)

## Install

On a sparkling fresh installation of macOS:

    sudo softwareupdate -i -a
    xcode-select --install

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS).
Then, install this repo with `curl` available:

    bash -c "`curl -fsSL https://raw.githubusercontent.com/timoknapp/.files/master/remote-install.sh`"

This will clone (using `git`), or download (using `curl` or `wget`), this repo to `~/.dotfiles`. Alternatively, clone manually into the desired location:

    git clone https://github.com/timoknapp/.files.git ~/.dotfiles

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview), and symlink [runcom](./runcom) and [config](./config) (using [stow](https://www.gnu.org/software/stow/)):

    cd ~/.dotfiles
    make

## Post-install
- `make macos-system` (set [Dock items](./macos/dock.sh) and [macOS defaults](./macos/defaults.sh) and [macOS defaults](./macos/rectangle.sh))
or run
- `dotfiles dock` (set [Dock items](./macos/dock.sh))
- `dotfiles macos` (set [macOS defaults](./macos/defaults.sh))

!!TODO!!
- Mackup
  - Log in to Dropbox (and wait until synced)
  - `ln -s ~/.config/mackup/.mackup.cfg ~` (until [#632](https://github.com/lra/mackup/pull/632) is fixed)
  - `mackup restore`

## The `dotfiles` command

    $ dotfiles help
    Usage: dotfiles <command>

    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE (code) and Git GUI (stree)
       help             This help message
       macos            Apply macOS system defaults
       test             Run tests
       update           Update packages and pkg managers (OS, brew, npm, gem)

## Tools installed
If you want to review the tools which are part of the setup go:
- [here (brew)](https://github.com/timoknapp/.files/blob/master/install/Brewfile)
- [here (brew cask)](https://github.com/timoknapp/.files/blob/master/install/Caskfile)

## Customize/extend

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`. The runcom `.bash_profile` sources all `~/.extra/runcom/*.sh` files.

## Additional resources

- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [Homebrew](https://brew.sh)
- [Homebrew Cask](http://caskroom.io)
- [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
- [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
