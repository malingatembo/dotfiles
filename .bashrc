# .bashrc

###################################################################################################
###                             CUSTOM CHANGES - START                                          ###
###################################################################################################
#
##====================================================##
##                                                    ##
##         [ IMPORTANT COMMAND LOG NOTES START ]      ##
##                                                    ##
##====================================================##
#
# Swapped the esc and capslock
#   command
#       gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
#   reverse
#       gsettings set org.gnome.desktop.input-sources xkb-options "@as []"
#
#
#
# Bind Ctrl-l to clear the terminal
 if [ -n "$STY" ]; then
     bind '"\C-l": "clear\n"'
     fi


#source ~/.git-completion.bash
source ~/.git-prompt.sh

# Enable color support
use_color=true

# Define color codes
BOLD='\[\e[1m\]'
NORMAL='\[\e[0m\]'
RED='\[\e[91m\]'
ORANGE='\[\e[38;5;208m\]'
BEIGE='\[\e[38;5;223m\]'
BLUE='\[\e[38;5;33m\]'
GREEN='\[\e[92m\]'
CYAN='\[\e[96m\]'
PURPLE='\[\e[95m\]'
YELLOW='\[\e[93m\]'

# Set prompt colors based on machine type
# Detect machine type by hostname
case "$(hostname)" in
    # Raspberry Pi cluster (green theme)
    c00|w0[1-4]|pi*)
        BRACKET_COLOR="${GREEN}"
        USER_COLOR="${CYAN}"
        AT_COLOR="${BEIGE}"
        HOST_COLOR="${PURPLE}"
        PATH_COLOR="${BEIGE}"
        ;;
    # VMs (yellow theme)
    vm*|.*\.local)
        BRACKET_COLOR="${YELLOW}"
        USER_COLOR="${ORANGE}"
        AT_COLOR="${BEIGE}"
        HOST_COLOR="${CYAN}"
        PATH_COLOR="${BEIGE}"
        ;;
    # Laptop/default (red theme - original)
    *)
        BRACKET_COLOR="${RED}"
        USER_COLOR="${ORANGE}"
        AT_COLOR="${BEIGE}"
        HOST_COLOR="${BLUE}"
        PATH_COLOR="${BEIGE}"
        ;;
esac

# Set the prompt string with machine-specific colors
PS1="${BOLD}${BRACKET_COLOR}[${USER_COLOR}\u${AT_COLOR}@${HOST_COLOR}\h ${PATH_COLOR}\W\$(__git_ps1 \" (%s)\")${BRACKET_COLOR}]${PATH_COLOR}\$ ${NORMAL}"

# Git lol
#git config --global alias.hist "log --pretty=format:'%Cgreen%h%Creset %ai | %s %Cblue[%an] %Cred%d' --date=short -n 10 --color"
#git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit --all"

# Source rc file for upshift
# source /home/lpiwowar/.local/bin/rhos-rc.sh

alias slist="cat ~/.ssh/config"
alias eslist="vim ~/.ssh/config"
alias gdm='git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d'
alias lg='lazygit'
#alias kink='kinit mtembo@IPA.REDHAT.COM'
alias ciseko='cd $HOME/projects/work/rhoso-psi-install/'

# Pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# Restart your shell for the changes to take effect.

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

#eval "$(pyenv virtualenv-init -)"

###################################################################################################
###                              CUSTOM CHANGES - END                                           ###
###################################################################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
                if [ -f "$rc" ]; then
                        . "$rc"
                fi
        done
fi

# get more options for clearing the screen 
bind -x '"\C-k": clear'


# Check if the aliases file exists and source it
if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

#unset rc

# Generated for envman. Do not edit.
#[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export EDITOR=vim
export PATH=$PATH:/usr/local/go/bin


# Trust Red Hats certificates
export REQUESTS_CA_BUNDLE=/etc/ssl/certs


# Nix
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
# End Nix

# Correct Claude Code Vertex AI Configuration
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_VERTEX_PROJECT_ID=itpc-gcp-core-pe-eng-claude

# Claude Code/NPM PATH configuration
export PATH=$PATH:$HOME/.npm-global/bin
# BEGIN ANSIBLE MANAGED BLOCK
if [ -f ~/.oc_completion ]; then
  source ~/.oc_completion
fi
# END ANSIBLE MANAGED BLOCK
