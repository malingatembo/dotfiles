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
MAGENTA='\[\e[38;5;201m\]'
PINK='\[\e[38;5;213m\]'
CRIMSON='\[\e[38;5;196m\]'
HOTPINK='\[\e[38;5;198m\]'
LIME='\[\e[38;5;118m\]'
GOLD='\[\e[38;5;220m\]'
CORAL='\[\e[38;5;209m\]'
TEAL='\[\e[38;5;37m\]'
LAVENDER='\[\e[38;5;183m\]'
NEONGREEN='\[\e[38;5;46m\]'

# Array of 20 PS1 color themes
declare -a PS1_THEMES=(
    # 1. Ocean Blue
    "${RED}:${ORANGE}:${BEIGE}:${BLUE}:${BEIGE}"
    # 2. Forest Green
    "${GREEN}:${CYAN}:${BEIGE}:${PURPLE}:${BEIGE}"
    # 3. Sunset
    "${YELLOW}:${ORANGE}:${BEIGE}:${CYAN}:${BEIGE}"
    # 4. Purple Haze
    "${PURPLE}:${CYAN}:${BEIGE}:${YELLOW}:${BEIGE}"
    # 5. Mint Fresh
    "${CYAN}:${GREEN}:${BEIGE}:${BLUE}:${BEIGE}"
    # 6. Fire Engine 🔥
    "${RED}:${YELLOW}:${BEIGE}:${ORANGE}:${BEIGE}"
    # 7. Electric Blue
    "${BLUE}:${CYAN}:${BEIGE}:${PURPLE}:${BEIGE}"
    # 8. Lemon Lime
    "${YELLOW}:${GREEN}:${BEIGE}:${CYAN}:${BEIGE}"
    # 9. Grape Soda
    "${PURPLE}:${PURPLE}:${BEIGE}:${CYAN}:${BEIGE}"
    # 10. Tangerine Dream
    "${ORANGE}:${YELLOW}:${BEIGE}:${RED}:${BEIGE}"
    # 11. Inferno 🔥🔥
    "${CRIMSON}:${ORANGE}:${GOLD}:${YELLOW}:${CORAL}"
    # 12. Volcano 🔥
    "${RED}:${CRIMSON}:${ORANGE}:${GOLD}:${ORANGE}"
    # 13. Hot Magenta 🔥
    "${MAGENTA}:${HOTPINK}:${BEIGE}:${CRIMSON}:${PINK}"
    # 14. Neon Nights 🔥
    "${NEONGREEN}:${MAGENTA}:${BEIGE}:${CYAN}:${YELLOW}"
    # 15. Solar Flare 🔥
    "${GOLD}:${ORANGE}:${BEIGE}:${CRIMSON}:${YELLOW}"
    # 16. Tropical Heat
    "${CORAL}:${HOTPINK}:${BEIGE}:${TEAL}:${GOLD}"
    # 17. Candy Rush
    "${HOTPINK}:${LAVENDER}:${BEIGE}:${CYAN}:${PINK}"
    # 18. Laser Show 🔥
    "${CYAN}:${MAGENTA}:${BEIGE}:${NEONGREEN}:${HOTPINK}"
    # 19. Phoenix Rising 🔥
    "${CRIMSON}:${GOLD}:${ORANGE}:${RED}:${YELLOW}"
    # 20. Matrix Glitch
    "${NEONGREEN}:${LIME}:${BEIGE}:${TEAL}:${GREEN}"
)

# Randomly select a theme (or use hostname-based selection)
if [[ -f ~/.ps1_theme_index ]]; then
    # Use saved theme index for consistency across sessions
    THEME_INDEX=$(cat ~/.ps1_theme_index)
else
    # Generate random theme and save it
    THEME_INDEX=$((RANDOM % 20))
    echo "$THEME_INDEX" > ~/.ps1_theme_index
fi

# Parse selected theme
IFS=':' read -r BRACKET_COLOR USER_COLOR AT_COLOR HOST_COLOR PATH_COLOR <<< "${PS1_THEMES[$THEME_INDEX]}"

# Set the prompt string with randomly selected colors
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
