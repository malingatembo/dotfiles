# Dotfiles Deployment Guide

Quick reference for deploying dotfiles to different environments.

## Quick Start - Three Essential Commands

```bash
# Deploy to localhost (laptop)
cd ~/projects/personal/dotfiles/ansible && ansible-playbook -i inventory/hosts-laptop playbook.yml

# Deploy to external VM (after editing inventory/hosts-vms with VM details)
cd ~/projects/personal/dotfiles/ansible && ansible-playbook -i inventory/hosts-vms playbook.yml -l vms --ask-become-pass

# Deploy to all Pis
cd ~/projects/personal/dotfiles/ansible && ansible-playbook -i inventory/hosts-pis playbook.yml -l pi_cluster --extra-vars "ansible_become_pass=123qwe"
```

---

## Prerequisites

- SSH access to target machines
- Ansible installed on your laptop
- Sudo/root access on target machines

## Available Inventories

- **hosts-pis** - Raspberry Pi cluster (c00, w01-w04)
- **hosts-vms** - Virtual machines (edit with your VM details)
- **hosts-laptop** - Local laptop deployment

---

## Deploying to Raspberry Pis

### Deploy to all Pis (c00, w01-w04)
```bash
cd ~/projects/personal/dotfiles/ansible
ansible-playbook -i inventory/hosts-pis playbook.yml -l pi_cluster --extra-vars "ansible_become_pass=123qwe"
```

### Deploy to controller only (c00)
```bash
ansible-playbook -i inventory/hosts-pis playbook.yml -l controller --extra-vars "ansible_become_pass=123qwe"
```

### Deploy to workers only (w01-w04)
```bash
ansible-playbook -i inventory/hosts-pis playbook.yml -l workers --extra-vars "ansible_become_pass=123qwe"
```

### Deploy to single Pi
```bash
ansible-playbook -i inventory/hosts-pis playbook.yml -l w01 --extra-vars "ansible_become_pass=123qwe"
```

---

## Deploying to VMs

### 1. Edit VM inventory file
```bash
vim inventory/hosts-vms
```

Add your VMs:
```ini
[vms]
vm1 ansible_host=192.168.1.50 ansible_user=your_username
vm2 ansible_host=192.168.1.51 ansible_user=your_username
```

### 2. Clone dotfiles repo on VMs
```bash
# Single VM
ansible -i inventory/hosts-vms vm1 -m shell -a "git clone https://github.com/malingatembo/dotfiles.git ~/dotfiles"

# All VMs
ansible -i inventory/hosts-vms vms -m shell -a "git clone https://github.com/malingatembo/dotfiles.git ~/dotfiles"
```

### 3. Deploy to VMs
```bash
# All VMs (will prompt for sudo password)
ansible-playbook -i inventory/hosts-vms playbook.yml -l vms --ask-become-pass

# Single VM
ansible-playbook -i inventory/hosts-vms playbook.yml -l vm1 --ask-become-pass
```

---

## Deploying to Laptop (Local)

```bash
ansible-playbook -i inventory/hosts-laptop playbook.yml
```

---

## Testing Connection

### Test Pis
```bash
ansible -i inventory/hosts-pis pi_cluster -m ping
```

### Test VMs
```bash
ansible -i inventory/hosts-vms vms -m ping
```

---

## Updating Dotfiles

### Pull latest changes on Pis
```bash
ansible -i inventory/hosts-pis pi_cluster -m shell -a "cd ~/dotfiles && git pull" --extra-vars "ansible_become_pass=123qwe"
```

### Pull latest changes on VMs
```bash
ansible -i inventory/hosts-vms vms -m shell -a "cd ~/dotfiles && git pull"
```

### Re-run deployment after updates
```bash
# Pis
ansible-playbook -i inventory/hosts-pis playbook.yml -l pi_cluster --extra-vars "ansible_become_pass=123qwe"

# VMs
ansible-playbook -i inventory/hosts-vms playbook.yml -l vms --ask-become-pass
```

---

## What Gets Installed

Every deployment includes:

- **Random PS1 theme** - Unique color scheme per machine (20 themes available)
- **Tmux configuration** - With mouse support and session persistence
  - Mouse scrolling enabled
  - Shift+mouse for text selection
  - tmux-resurrect (save/restore sessions)
  - tmux-continuum (auto-save every 15 min)
- **Vim setup** - Enhanced with plugins
  - vim-airline (status line)
  - NERDTree (file explorer - Ctrl+n)
  - jedi-vim (Python autocomplete)
  - black (Python formatter)
  - syntastic (syntax checking)
  - vim-fugitive (git integration)
  - gruvbox & zenburn themes
- **Packages** - tmux, vim, neovim, git, curl, python3, pip, build tools
- **Git prompt** - Shows current branch in bash prompt

---

## Changing PS1 Theme

Each machine gets a random theme on first deployment. To change:

```bash
# On the target machine
rm ~/.ps1_theme_index
source ~/.bashrc
```

Available themes: Ocean Blue, Forest Green, Sunset, Purple Haze, Mint Fresh, Fire Engine🔥, Electric Blue, Lemon Lime, Grape Soda, Tangerine Dream, Inferno🔥🔥, Volcano🔥, Hot Magenta🔥, Neon Nights🔥, Solar Flare🔥, Tropical Heat, Candy Rush, Laser Show🔥, Phoenix Rising🔥, Matrix Glitch

---

## Troubleshooting

### SSH Connection Issues
```bash
# Test SSH manually
ssh user@hostname

# Test with Ansible
ansible -i inventory/hosts-pis w01 -m ping
```

### Playbook Fails on Package Installation
- Check internet connection on target machine
- Verify sudo password is correct
- Some packages may not be available on all OS versions (errors are ignored)

### Tmux Plugins Not Loading
```bash
# Reload tmux config
tmux
Ctrl-a r

# Or manually install plugins
~/.tmux/plugins/tpm/bin/install_plugins
```

### Vim Plugins Not Working
```bash
# Manually install/update plugins
vim +PlugInstall +qall
vim +PlugUpdate +qall
```

---

## Quick Reference

### Pi Cluster
- Controller: c00@10.0.0.100
- Workers: w01-w04@10.0.0.{101-104}
- Password: 123qwe

### Useful Commands
```bash
# Check all Pis are reachable
ansible -i inventory/hosts-pis pi_cluster -m ping

# Run command on all Pis
ansible -i inventory/hosts-pis pi_cluster -m shell -a "hostname"

# Check tmux version
ansible -i inventory/hosts-pis pi_cluster -m shell -a "tmux -V"

# Check vim plugins
ansible -i inventory/hosts-pis pi_cluster -m shell -a "ls ~/.vim/plugged"
```

---

## Repository

GitHub: https://github.com/malingatembo/dotfiles

To make changes:
1. Edit files in `/home/mtembo/projects/personal/dotfiles/`
2. Commit and push to GitHub
3. Pull on target machines
4. Re-run deployment
