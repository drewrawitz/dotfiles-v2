#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Include z, yo
. ~/dotfiles/z.sh

# Enable extended globbing
setopt extendedglob

# Disable auto correct
setopt nocorrectall;
setopt correct

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

bindkey "^R" history-incremental-search-backward

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# Aliases
  # Tmux
  alias tmux='TERM=xterm-256color; tmux'

  # Clear
  alias c='clear'

  # Git
  alias gst='git status'

# Functions
  # http://hamberg.no/erlend/posts/2013-01-18-mkcd.html
  # Do 'mkdir' & 'cd' operation in one go
  take(){
    mkdir -p "${1}"
    cd "${1}"
  }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Mongo DB
export PATH=~/mongodb/bin:$PATH

# Composer
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Dotfiles bin folder
export PATH="$HOME/dotfiles/bin:$PATH"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
