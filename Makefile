SHELL = /bin/zsh
OS:=$(shell bin/is-supported bin/is-macos macos linux)
DOTFILES_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
HOMEBREW_PREFIX:=$(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local)
PATH:=$(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)

export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link #mackup link

core-macos: brew zsh

packages: brew-packages code-packages

macos-system: macos-dock macos-system-defaults macos-system-extras

macos-dock:
	/bin/bash macos/dock.sh
macos-system-defaults:
	/bin/bash macos/defaults.sh
macos-system-extras:
	/bin/bash macos/rectangle.sh
	/bin/bash macos/meetingbar.sh
	/bin/bash macos/amphetamine.sh
	/bin/bash macos/touchid.sh
	/bin/bash macos/dev-workspace.sh
	/bin/bash macos/spotify.sh

stow-macos: brew
	is-executable stow || brew install stow

sudo:
ifndef CI
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	$(HOMEBREW_PREFIX)/bin/stow --adopt -t $(HOME) runcom
	$(HOMEBREW_PREFIX)/bin/stow --adopt -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	$(HOMEBREW_PREFIX)/bin/stow --delete -t $(HOME) runcom
	$(HOMEBREW_PREFIX)/bin/stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	/bin/bash $(DOTFILES_DIR)/install/base.sh
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

zsh: SHELLS=/private/etc/shells
zsh: ZSH_BIN=$(HOMEBREW_PREFIX)/bin/zsh
zsh: ZSH_DIR=$(XDG_CONFIG_HOME)/oh-my-zsh
zsh: ZSH_CUSTOM=$(ZSH_DIR)/custom
zsh: ZSH_CUSTOM_THEMES=$(ZSH_CUSTOM)/themes
zsh: ZSH_CUSTOM_PLUGINS=$(ZSH_CUSTOM)/plugins
zsh: BREW_BIN=$(HOMEBREW_PREFIX)/bin/brew
zsh: brew
	if ! grep -q $(ZSH_BIN) $(SHELLS); then \
		$(BREW_BIN) install zsh && \
		sudo append $(ZSH_BIN) $(SHELLS) && \
		chsh -s $(ZSH_BIN); \
	fi
	[[ -d "$(ZSH_DIR)" ]] || curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | ZSH=$(ZSH_DIR) sh
	cp $(DOTFILES_DIR)/install/fonts/* ~/Library/Fonts
	[[ -d "$(ZSH_CUSTOM_THEMES)/powerlevel10k" ]] && echo "Powerlevel10k is already installed." || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $(ZSH_CUSTOM_THEMES)/powerlevel10k
	[[ -d "$(ZSH_CUSTOM_PLUGINS)/zsh-autosuggestions" ]] && echo "zsh-autosuggestions is already installed." || git clone https://github.com/zsh-users/zsh-autosuggestions $(ZSH_CUSTOM_PLUGINS)/zsh-autosuggestions

rbenv: brew
	is-executable rbenv || brew install rbenv

ruby: LATEST_RUBY=$(shell rbenv install -l | grep -v - | tail -1)
ruby: brew rbenv
	rbenv install -s $(LATEST_RUBY)
	rbenv global $(LATEST_RUBY)

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

code-packages: brew
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done

mackup: link
	# Necessary until [#632](https://github.com/lra/mackup/pull/632) is fixed
	ln -s ~/.config/mackup/.mackup.cfg ~
	ln -s ~/.config/mackup/.mackup ~

test:
	bats test/*.bats
