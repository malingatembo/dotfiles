# Inventory Templates

This directory contains multiple inventory files for different environments.

## Available Inventories

- **hosts-pis** - Raspberry Pi cluster (5 nodes: c00, w01-w04)
- **hosts-vms** - Virtual machines
- **hosts-laptop** - Local laptop deployment

## Usage

Specify the inventory file at runtime with the `-i` flag:

```bash
# Deploy to Raspberry Pis
ansible-playbook -i inventory/hosts-pis playbook.yml -l pi_cluster

# Deploy to VMs
ansible-playbook -i inventory/hosts-vms playbook.yml

# Deploy locally to laptop
ansible-playbook -i inventory/hosts-laptop playbook.yml
```

## Quick Commands

### Raspberry Pi Cluster
```bash
# All Pis
ansible-playbook -i inventory/hosts-pis playbook.yml -l pi_cluster --extra-vars "ansible_become_pass=PASSWORD"

# Just workers (w01-w04)
ansible-playbook -i inventory/hosts-pis playbook.yml -l workers --extra-vars "ansible_become_pass=PASSWORD"

# Just controller (c00)
ansible-playbook -i inventory/hosts-pis playbook.yml -l controller --extra-vars "ansible_become_pass=PASSWORD"

# Single Pi
ansible-playbook -i inventory/hosts-pis playbook.yml -l w01 --extra-vars "ansible_become_pass=PASSWORD"
```

### Test Connection
```bash
# Ping all Pis
ansible -i inventory/hosts-pis pi_cluster -m ping

# Check which Pis are reachable
ansible -i inventory/hosts-pis all -m ping
```
