#!/usr/bin/env bash
efibootmgr -c -d /dev/sda -p 1 -L "ArchLinux Stubby" -l /arch/stubby/vmlinuz-linux.efi --unicode "resume_offset=173448623 root=UUID=5aec2940-d221-4f08-bcc6-f56256034b07 rw rootflags=subvol=/root loglevel=3 quiet NVreg_PreserveVideoMemoryAllocations=1 nvidia-drm.modeset=1 nowatchdog zswap.enabled=1 mitigations=on initrd=\arch\stubby\amd-ucode.img initrd=\arch\stubby\initramfs-linux.img"

