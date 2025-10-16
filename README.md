# Dotfiles

Personal dotfiles for consistent development environment across Ubuntu and Fedora servers.

## Quick Start

```bash
# Clone this repository
git clone <your-repo-url> ~/dotfiles

# Install Ansible (if not already installed)
# Ubuntu/Debian:
sudo apt install -y ansible
# Fedora/RHEL:
sudo dnf install -y ansible

# Run the playbook
cd ~/dotfiles/ansible
ansible-playbook playbook.yml --ask-become-pass

# Reload your shell
source ~/.bashrc
```

## What's Included

- **Bash configuration** (`.bashrc`, `.bash_profile`, `.bashrc_extension`)
- **Vim configuration** (`.vimrc`) with enhanced status line
- **Tmux configuration** (`.tmux.conf`) with session persistence
- **Ansible playbook** for automated deployment
- **Python development environment** with pip and essential packages

## Features

### Core Features
- Automated deployment across Ubuntu and Fedora
- Symlink-based workflow for easy git management
- Automatic backups before deployment
- OS-specific package installation

### Bash
- Custom colored prompt with git branch display
- Custom aliases and shortcuts
- Git integration with completion

### Vim (Enhanced Terminal Experience)
- **vim-airline**: Beautiful enhanced status line with powerline fonts
- **NERDTree**: File explorer tree view (Ctrl+n)
- **Python support**: jedi-vim autocomplete + black formatter
- **Syntax checking**: syntastic for multiple languages
- **Git integration**: vim-fugitive
- **Color schemes**: gruvbox, zenburn, and more
- **Smart features**: relative line numbers, auto-indent, custom keybindings

### Tmux
- Session persistence (auto-save/restore)
- Auto-save every 15 minutes
- Vim-style pane navigation
- Custom key bindings (Ctrl+a prefix)

## Documentation

- **[USER_MANUAL.md](USER_MANUAL.md)** - Complete usage guide and troubleshooting
- **[NOTES.md](NOTES.md)** - Technical notes and debugging reference

## Repository Structure

```
dotfiles/
├── .bashrc              # Main bash configuration
├── .bash_profile        # Bash login profile
├── .bashrc_extension    # Additional aliases
├── .vimrc               # Vim configuration
├── .tmux.conf           # Tmux configuration
├── ansible/
│   ├── playbook.yml     # Main deployment playbook
│   └── inventory/
│       └── hosts        # Server inventory
├── .gitignore           # Git ignore rules
├── README.md            # This file
├── USER_MANUAL.md       # User guide
└── NOTES.md             # Technical notes
```

## Usage

### Deploy to Current Machine

```bash
cd ~/dotfiles/ansible
ansible-playbook playbook.yml --ask-become-pass
```

### Deploy to Remote Server

```bash
# Add server to inventory
echo "myserver ansible_host=192.168.1.100 ansible_user=username" >> ansible/inventory/hosts

# Deploy
ansible-playbook -i ansible/inventory/hosts playbook.yml --ask-become-pass
```

### Update Dotfiles

```bash
# Edit any dotfile (changes reflect in repo due to symlinks)
vim ~/.bashrc

# Commit and push
cd ~/dotfiles
git add .
git commit -m "Update configuration"
git push

# On other servers
cd ~/dotfiles
git pull
source ~/.bashrc
```

## Tmux Session Persistence

Sessions automatically save every 15 minutes and restore after reboot:

```bash
# After system restart, just run:
tmux

# Your previous session will auto-restore in 1-2 seconds
```

Manual save/restore:
- Save: `Ctrl+a` then `Ctrl+s`
- Restore: `Ctrl+a` then `Ctrl+r`

## Requirements

- Git
- Ansible 2.9+
- Python 3
- Tmux (installed by playbook)
- Vim (installed by playbook)

## Supported Systems

- ✅ Ubuntu 20.04+
- ✅ Debian 10+
- ✅ Fedora 35+
- ✅ RHEL 8+
- ✅ Rocky Linux 8+

## License

Personal use only.

## Author

mtembo
