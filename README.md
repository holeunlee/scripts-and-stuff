# scripts-and-stuff

A small collection of utility scripts for Linux infrastructure management.

## Scripts

### `kvm-virsh-list-vms.sh`
Lists all running KVM/QEMU virtual machines on a libvirt host with a quick summary of each VM's resources and network info.

**Output per VM:**
- vCPU count
- Allocated RAM (in MB)
- MAC address
- Bridge / VLAN
- IP address (via ARP lookup)

**Usage:**
```bash
bash kvm-virsh-list-vms.sh
```

**Requirements:** `virsh`, `arp` — must be run on the KVM host as a user with libvirt access (or root).
