# Dotfiles Technical Notes & Debugging Guide

## Purpose
This file contains technical notes, debugging tips, and implementation details for future reference when troubleshooting or extending the dotfiles setup.

---

## Architecture Overview

### Repository Location
- **Primary repo**: `/home/mtembo/projects/personal/dotfiles/` (this location)
- **Old location**: `~/.config/dotfiles/` (legacy, may have symlinks pointing here)

### How Symlinks Work
The Ansible playbook creates symlinks from home directory to the repo:
```
~/.bashrc → ~/dotfiles/.bashrc
~/.vimrc → ~/dotfiles/.vimrc
~/.tmux.conf → ~/dotfiles/.tmux.conf
```

This means:
- Editing `~/.bashrc` edits the file in the repo
- Changes appear in `git status` immediately
- Easy to commit and push changes

---

## Tmux Session Persistence

### Key Findings (Oct 2025)

**Problem**: Sessions disappear after reboot
**Root Cause**: `@continuum-boot 'on'` only works on macOS, not Linux

### How It Actually Works

1. **tmux-resurrect**: Saves session state to files
   - Location: `~/.local/share/tmux/resurrect/`
   - Symlink: `last` → most recent save file
   - Format: `tmux_resurrect_YYYYMMDDTHHMMSS.txt`

2. **tmux-continuum**: Automates resurrect
   - Auto-saves every 15 minutes
   - Auto-restores when tmux server starts

3. **Important**: After reboot, tmux server is dead
   - User must manually run `tmux` (not `tmux attach`)
   - Continuum detects new server start
   - Automatically runs restore script after 1-2 seconds

### Configuration in .tmux.conf
```tmux
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'    # Auto-restore on start
set -g @continuum-boot 'on'        # Only works on macOS!
```

### Debugging Tmux Persistence

1. **Check if plugins are loaded**:
   ```bash
   tmux list-keys | grep -i resurrect
   # Should show C-s (save) and C-r (restore) bindings
   ```

2. **Check continuum options**:
   ```bash
   tmux show-option -g @continuum-restore
   tmux show-option -g @continuum-save-interval
   ```

3. **Check saved sessions**:
   ```bash
   ls -lah ~/.local/share/tmux/resurrect/
   cat ~/.local/share/tmux/resurrect/last
   ```

4. **Check if restore script path is set**:
   ```bash
   tmux show-option -g @resurrect-restore-script-path
   # Should point to: ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
   ```

5. **Manually trigger save/restore**:
   ```bash
   # From within tmux:
   Ctrl+a Ctrl+s  # Save
   Ctrl+a Ctrl+r  # Restore
   ```

6. **Check continuum status in status bar**:
   ```bash
   tmux show-option -g status-right
   # Should include: #($CURRENT_DIR/scripts/continuum_save.sh)
   ```

### Common Issues

**Issue**: No restore after `tmux kill-server`
- **Cause**: Restore only happens when tmux server *just* started
- **Solution**: Run `tmux` (not `tmux attach`), wait 1-2 seconds

**Issue**: `~/.tmux/resurrect/` doesn't exist
- **Cause**: Sessions saved to `~/.local/share/tmux/resurrect/` instead
- **Solution**: This is correct! Modern resurrect uses XDG base dir

**Issue**: Plugins not loading
- **Cause**: TPM not installed or not initialized
- **Solution**:
  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
  ```

**Issue**: Auto-restore not working
- **Check 1**: Is there a halt file?
  ```bash
  ls ~/tmux_no_auto_restore
  # Should not exist. If it does, delete it.
  ```
- **Check 2**: Multiple tmux servers running?
  ```bash
  ps aux | grep tmux
  # Continuum disables auto-restore if multiple servers detected
  ```

---

## Ansible Playbook Details

### Design Decisions

1. **Idempotent**: Can run multiple times safely
2. **OS-Agnostic**: Detects Fedora vs Ubuntu automatically
3. **Backup-First**: Always backs up existing files
4. **Symlink-Based**: Enables easy git workflow

### OS Detection
```yaml
when: ansible_os_family == "Debian"   # Ubuntu
when: ansible_os_family == "RedHat"   # Fedora/RHEL
```

### Package Mapping
| Package | Ubuntu | Fedora |
|---------|--------|--------|
| Powerline Fonts | fonts-powerline | powerline-fonts |
| Package Manager | apt | dnf |

### Execution Flow

1. Install OS-specific packages
2. Create directory structure
3. Backup existing dotfiles to `~/.dotfiles_backup_<timestamp>/`
4. Create symlinks from `~` to `~/dotfiles/`
5. Install vim-plug
6. Install Vim plugins
7. Clone TPM (Tmux Plugin Manager)
8. Install tmux plugins

### Running Playbook Locally
```bash
cd ~/dotfiles/ansible
ansible-playbook playbook.yml --ask-become-pass
```

### Running on Remote Server
```bash
# Create inventory file
cat > ansible/inventory/hosts << EOF
myserver ansible_host=192.168.1.100 ansible_user=username
EOF

# Run playbook
ansible-playbook -i ansible/inventory/hosts playbook.yml --ask-become-pass
```

---

## Bashrc Architecture

### Load Order
1. `.bash_profile` sources `.bashrc`
2. `.bashrc` contains main config
3. `.bashrc` sources `.bashrc_extension` (if exists)
4. System sources `~/.bash_aliases` (if exists)

### Custom Additions
Located in `.bashrc` between markers:
```bash
###  CUSTOM CHANGES - START  ###
# Your stuff here
###  CUSTOM CHANGES - END    ###
```

### Important Features
- **Git prompt**: Shows current branch in prompt
- **Color prompt**: Custom colored PS1
- **Ctrl+k**: Alternative clear binding
- **Nix integration**: If Nix is installed
- **Claude Code config**: Vertex AI environment variables

---

## Vim Configuration

### Plugin Manager: vim-plug
- Install location: `~/.vim/autoload/plug.vim`
- Plugins directory: `~/.vim/plugged/`

### Installing Plugins
```vim
:PlugInstall
:PlugUpdate
:PlugClean
```

### Common Plugins (check .vimrc for actual list)
- vim-airline: Status bar
- nerdtree: File explorer
- Various syntax highlighting plugins

---

## Git Workflow

### Making Changes

```bash
cd ~/dotfiles

# Edit any dotfile
vim .bashrc

# Changes immediately reflect in ~/ due to symlinks

# Commit changes
git status
git add .bashrc
git commit -m "Update bashrc: add new alias"
git push
```

### Deploying to New Server

```bash
# On new server
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles/ansible
ansible-playbook playbook.yml --ask-become-pass
```

### Syncing Changes

```bash
# On other servers
cd ~/dotfiles
git pull
# Optionally re-run playbook if structure changed
```

---

## Debugging Checklist

### Symlinks Not Working?
```bash
ls -la ~/ | grep '\->'
# Should see symlinks pointing to ~/dotfiles/

# Fix: Re-run playbook
cd ~/dotfiles/ansible
ansible-playbook playbook.yml --ask-become-pass
```

### Bash Changes Not Taking Effect?
```bash
# Reload shell
source ~/.bashrc

# Or start new shell
exec bash
```

### Tmux Config Not Loading?
```bash
# Inside tmux
Ctrl+a r   # Reload config

# Or restart tmux
tmux kill-server
tmux
```

### Ansible Playbook Fails?
```bash
# Run with verbose output
ansible-playbook playbook.yml --ask-become-pass -vvv

# Check syntax
ansible-playbook playbook.yml --syntax-check

# Dry run
ansible-playbook playbook.yml --check
```

---

## Future Improvements

### Potential Enhancements
1. Add support for additional shells (zsh, fish)
2. Include SSH config management
3. Add neovim config (separate from vim)
4. Include git config (.gitconfig)
5. Add script to auto-start tmux on login (systemd user service)
6. Include tool-specific configs (.ripgreprc, .fdignore, etc.)

### Auto-start Tmux on Login (Not Implemented Yet)

**Option 1: Bashrc Auto-attach**
Add to `.bashrc`:
```bash
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
```

**Option 2: Systemd User Service**
Create `~/.config/systemd/user/tmux.service`:
```ini
[Unit]
Description=Start tmux in detached session

[Service]
Type=forking
ExecStart=/usr/bin/tmux new-session -s default -d
ExecStop=/usr/bin/tmux kill-session -t default

[Install]
WantedBy=default.target
```

Enable:
```bash
systemctl --user enable tmux.service
systemctl --user start tmux.service
```

---

## Known Issues

1. **Bashrc line 99 bind warning**:
   - Warning: `bind: warning: line editing not enabled`
   - Harmless, appears when running from non-interactive shell
   - Can be fixed by wrapping bind commands in interactive check

2. **Old dotfiles location**:
   - Previous setup in `~/.config/dotfiles/`
   - May have symlinks pointing there
   - Run playbook to update symlinks

3. **Tmux boot on Linux**:
   - `@continuum-boot 'on'` doesn't work on Linux
   - Must manually start tmux after reboot
   - Consider implementing systemd service

---

## References

- Tmux Resurrect: https://github.com/tmux-plugins/tmux-resurrect
- Tmux Continuum: https://github.com/tmux-plugins/tmux-continuum
- TPM: https://github.com/tmux-plugins/tpm
- Vim-Plug: https://github.com/junegunn/vim-plug
- Ansible Docs: https://docs.ansible.com/

---

## Change Log

- **2025-10-16**: Initial dotfiles repo created
  - Migrated from `~/.config/dotfiles/` to `~/projects/personal/dotfiles/`
  - Added comprehensive Ansible playbook
  - Fixed tmux persistence issues
  - Added USER_MANUAL.md and NOTES.md
