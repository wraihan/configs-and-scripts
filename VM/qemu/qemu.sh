#!/bin/sh

qemu-system-x86_64 -enable-kvm -daemonize \
  -machine type=q35,vmport=off,accel=kvm \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd \
  -drive if=pflash,format=raw,file=$HOME/VM/qemu/OVMF_VARS.4m.fd \
  -m 2G -cpu host -smp 4 \
  -usb -device usb-tablet -device virtio-balloon -device virtio-serial-pci \
  -vga qxl -display gtk,gl=on,show-cursor=on \
  -display spice-app,gl=on -device virtio-serial-pci \
  -spice unix=on,addr=/tmp/vm_spice.socket,disable-ticketing=on \
  -chardev spicevmc,id=spicechannel0,name=vdagent \
  -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
  -nic user,model=virtio-net-pci,id=nic0,hostfwd=tcp::60022-:22 \
  -device nvme,serial=myvirtdev,drive=nvm \
  -drive index=0,media=disk,if=none,id=nvm,format=qcow2,aio=native,cache.direct=on,file=$HOME/VM/qemu/disk.img \
  -drive index=1,media=cdrom,readonly=on,file=/var/lib/libvirt/images/void-live-x86_64-20250202-xfce.iso


  # (on `-spice` line, add `,sasl=on` for GSSAPI authentication)
  #-spice addr=0.0.0.0,tls-port=5901,x509-dir=$HOME/pki/openssl/qemu,disable-ticketing=on \
  #-nic bridge,br=virbr0,model=virtio-net-pci \
