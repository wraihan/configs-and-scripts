#!/bin/sh

qemu-system-x86_64 -enable-kvm -daemonize \
  -M type=pc,vmport=off \
  -m 256M -cpu host -smp 4 \
  -usb -device usb-tablet \
  -vga qxl -display gtk,gl=on,show-cursor=on \
  -display spice-app,gl=on \
  -spice unix=on,addr=/tmp/vm_spice.socket,disable-ticketing=on \
  -nic user,ipv6=off,model=pcnet,id=nic0 \
  -device sb16 -device adlib \
  -drive index=0,media=cdrom,readonly=on,file=$HOME/VM/DOS/live/FD14LIVE.iso \
  -drive index=1,media=disk,if=ide,format=qcow2,aio=native,cache.direct=on,file=$HOME/VM/DOS/freedos.qcow2

# https://freedos.org/books/
