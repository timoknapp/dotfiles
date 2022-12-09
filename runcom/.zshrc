# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Source the dotfiles (order matters)
# Completions must be initalized before oh-my-zsh
for DOTFILE in "$DOTFILES_DIR"/system/.{grep,prompt,completion,macos,oh-my-zsh,alias}; do
# for DOTFILE in "$DOTFILES_DIR"/system/.{grep,prompt,completion,macos,alias}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

if is-macos; then
 for DOTFILE in "$DOTFILES_DIR"/system/.{alias.macos,macos}; do
   [ -f "$DOTFILE" ] && . "$DOTFILE"
 done
fi

# Hook for extra/custom stuff

# DOTFILES_EXTRA_DIR="$HOME/.extra"

# if [ -d "$DOTFILES_EXTRA_DIR" ]; then
#   for EXTRAFILE in "$DOTFILES_EXTRA_DIR"/runcom/*.sh; do
#     [ -f "$EXTRAFILE" ] && . "$EXTRAFILE"
#   done
# fi

# Clean up
unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE EXTRAFILE

#set emacs keybindings
bindkey -e

bindkey '^[[3~' delete-char

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
