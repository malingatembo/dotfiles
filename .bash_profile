# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

if [ -e /home/mtembo/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mtembo/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
