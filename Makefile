SHELL = /bin/zsh
ZSH=/usr/local/bin/zsh
SHELLS=/private/etc/shells
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos) #if you want linux support add linux here
PATH := $(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link #mackup

core-macos: brew-macos zsh change-shell

packages: brew-packages brew-cask-packages code-packages

macos-system: macos-dock macos-system-defaults macos-system-extras

macos-dock:
	/bin/bash macos/dock.sh
macos-system-defaults:
	/bin/bash macos/defaults.sh
macos-system-extras:
	/bin/bash macos/rectangle.sh

stow-macos: brew-macos
	is-executable stow || brew install stow

sudo:
ifndef CI
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow --adopt -t $(HOME) runcom
	stow --adopt -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew-macos:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby

zsh: ZSH_DIR="$(XDG_CONFIG_HOME)/oh-my-zsh"
zsh: brew-$(OS)
	if ! grep -q $(ZSH) $(SHELLS); then brew install zsh && sudo append $(ZSH) $(SHELLS); fi
	[[ -d $(ZSH_DIR) ]] || curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | ZSH=$(ZSH_DIR) sh

change-shell: zsh
ifndef CI
	echo "ZSH $(ZSH) $(SHELLS)"
	chsh -s $(ZSH)
endif

brew-packages: brew-$(OS)
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

brew-cask-packages: brew-macos
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile

code-packages: brew-macos
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done

mackup: link
	# Necessary until [#632](https://github.com/lra/mackup/pull/632) is fixed
	ln -s ~/.config/mackup/.mackup.cfg ~
	ln -s ~/.config/mackup/.mackup ~

test:
	bats test/*.bats