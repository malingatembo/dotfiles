# Dotfiles User Manual

## Overview
This repository contains dotfiles and an Ansible playbook for setting up a consistent development environment across Fedora and Ubuntu servers.

## What's Included
- `.bashrc` - Bash shell configuration with custom prompt, aliases, and environment variables
- `.bash_profile` - Bash profile for login shells
- `.bashrc_extension` - Additional bash aliases (sourced by .bashrc)
- `.vimrc` - Vim editor configuration
- `.tmux.conf` - Tmux terminal multiplexer configuration with resurrect/continuum plugins
- Ansible playbook - Automated deployment script

## Quick Start

### First Time Setup on a New Server

1. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install Ansible** (if not already installed):

   On Ubuntu/Debian:
   ```bash
   sudo apt update && sudo apt install -y ansible
   ```

   On Fedora/RHEL:
   ```bash
   sudo dnf install -y ansible
   ```

3. **Run the Ansible playbook:**
   ```bash
   cd ~/dotfiles/ansible
   ansible-playbook playbook.yml --ask-become-pass
   ```

   Enter your sudo password when prompted.

4. **Restart your shell or source the new config:**
   ```bash
   source ~/.bashrc
   ```

### What the Playbook Does

The Ansible playbook will automatically:

1. **Install required packages** (OS-specific):
   - tmux
   - vim
   - neovim
   - curl
   - git
   - powerline fonts

2. **Create symlinks** from your home directory to the dotfiles repo:
   - `~/.bashrc` → `~/dotfiles/.bashrc`
   - `~/.bash_profile` → `~/dotfiles/.bash_profile`
   - `~/.vimrc` → `~/dotfiles/.vimrc`
   - `~/.tmux.conf` → `~/dotfiles/.tmux.conf`

3. **Backup existing dotfiles** to `~/.dotfiles_backup_<timestamp>/`

4. **Install Tmux Plugin Manager (TPM)** and plugins:
   - tmux-sensible
   - tmux-resurrect (save/restore tmux sessions)
   - tmux-continuum (automatic session saving)

5. **Install Vim-Plug** and Vim plugins

## Updating Dotfiles

### On Your Main Machine

1. Edit files in `~/dotfiles/`
2. Commit and push changes:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update configurations"
   git push
   ```

### On Other Servers

1. Pull latest changes:
   ```bash
   cd ~/dotfiles
   git pull
   ```

2. Re-run the playbook (optional, if you added new files):
   ```bash
   cd ~/dotfiles/ansible
   ansible-playbook playbook.yml --ask-become-pass
   ```

3. Reload your shell:
   ```bash
   source ~/.bashrc
   ```

## Tmux Session Persistence

Your tmux sessions are configured to persist across reboots:

- **Auto-save**: Sessions automatically save every 15 minutes
- **Restore after reboot**:
  ```bash
  # Just run tmux (don't use 'tmux attach')
  tmux
  # Your previous session will auto-restore within 1-2 seconds
  ```

- **Manual save**: `Ctrl+a` then `Ctrl+s`
- **Manual restore**: `Ctrl+a` then `Ctrl+r`

**Note**: Session files are stored in `~/.local/share/tmux/resurrect/`

## Key Bindings and Features

### Tmux (Prefix: Ctrl+a)
- `Ctrl+a` + `v` - Split window vertically
- `Ctrl+a` + `h` - Split window horizontally
- `Ctrl+a` + `r` - Reload tmux config
- `Ctrl+h/j/k/l` - Navigate panes (vim-style)
- `Ctrl+a` + `Ctrl+s` - Save session
- `Ctrl+a` + `Ctrl+r` - Restore session

### Bash Aliases (from .bashrc_extension)
- `ll` - List all files with details
- `la` - List all files including hidden
- `cls`, `claer` - Clear terminal
- `vin` - Open neovim
- `lg` - Launch lazygit
- `mytmux` - Attach to tmux session

## File Structure

```
~/dotfiles/
├── .bashrc                    # Main bash configuration
├── .bash_profile              # Bash login profile
├── .bashrc_extension          # Additional aliases
├── .vimrc                     # Vim configuration
├── .tmux.conf                 # Tmux configuration
├── ansible/
│   ├── playbook.yml           # Main playbook
│   └── roles/
│       └── dotfiles/
│           └── tasks/
│               └── main.yml   # Deployment tasks
├── USER_MANUAL.md             # This file
├── NOTES.md                   # Debugging notes
└── README.md                  # Project overview
```

## Troubleshooting

### Symlinks not working?
Check if symlinks exist:
```bash
ls -la ~ | grep '\->'
```

Re-run the playbook:
```bash
cd ~/dotfiles/ansible
ansible-playbook playbook.yml --ask-become-pass
```

### Tmux plugins not loading?
Install plugins manually:
```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

### Tmux sessions not restoring?
1. Check if continuum is running:
   ```bash
   tmux show-option -g @continuum-restore
   # Should show: on
   ```

2. Check saved sessions:
   ```bash
   ls -lah ~/.local/share/tmux/resurrect/
   ```

3. Manual restore:
   - Start tmux: `tmux`
   - Press `Ctrl+a` then `Ctrl+r`

### Vim plugins not installed?
Run inside Vim:
```vim
:PlugInstall
```

### Ansible playbook fails?
Run with verbose output:
```bash
ansible-playbook playbook.yml --ask-become-pass -vvv
```

## OS-Specific Notes

### Ubuntu/Debian
- Package manager: `apt`
- Powerline fonts package: `fonts-powerline`

### Fedora/RHEL
- Package manager: `dnf`
- Powerline fonts package: `powerline-fonts`

The playbook automatically detects your OS and uses the appropriate package manager.

## Advanced Usage

### Deploy to Remote Server
```bash
# Add server to inventory
echo "myserver ansible_host=192.168.1.100 ansible_user=username" > ansible/inventory/hosts

# Run playbook on remote server
ansible-playbook -i ansible/inventory/hosts playbook.yml --ask-become-pass
```

### Skip Package Installation
```bash
ansible-playbook playbook.yml --ask-become-pass --skip-tags "packages"
```

### Backup Before Running
The playbook automatically creates backups, but for extra safety:
```bash
cp ~/.bashrc ~/.bashrc.manual.backup
cp ~/.vimrc ~/.vimrc.manual.backup
cp ~/.tmux.conf ~/.tmux.conf.manual.backup
```

## Support

For issues or questions, see `NOTES.md` for debugging tips and common issues.
