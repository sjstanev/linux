#!/bin/bash

# Run this script with sudo

set -e

function usage() {
  echo "Usage: $0 [nvidia|nouveau]"
  exit 1
}

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

if [ $# -ne 1 ]; then
  usage
fi

DRIVER="$1"

if [[ "$DRIVER" == "nvidia" ]]; then
  echo "[INFO] Installing NVIDIA driver..."
  ubuntu-drivers autoinstall

  echo "[INFO] Blacklisting nouveau..."
  cat > /etc/modprobe.d/blacklist-nouveau.conf <<EOF
blacklist nouveau
options nouveau modeset=0
EOF

elif [[ "$DRIVER" == "nouveau" ]]; then
  echo "[INFO] Removing NVIDIA driver..."
  apt remove --purge -y '^nvidia-.*'

  echo "[INFO] Un-blacklisting nouveau..."
  rm -f /etc/modprobe.d/blacklist-nouveau.conf

else
  usage
fi

echo "[INFO] Rebuilding initramfs..."
update-initramfs -u

echo "[INFO] Done. You should now reboot."
read -p "Reboot now? (y/N): " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  reboot
else
  echo "Reboot manually for changes to take effect."
fi
