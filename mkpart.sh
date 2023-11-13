#!/bin/bash

# Check for root
if [ $(id -u) -ne 0 ]; then
    echo "Please run this as root"
    exit 1
fi

# Check for required commands
REQUIRED_COMMANDS=("id" "lsblk" "wipefs" "sfdisk" "mkfs.ext4" "mkdir" "echo")
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd command not found. Please install it and try again."
        exit 1
    fi
done

display_help() {
    echo "Usage: $0 <device> <mountpoint> [wipe]"
    echo "example: bash mkpart.sh /dev/sdb /mnt/data wipe"
}

# Check if device name and mount point are provided
if [ $# -lt 2 ]; then
    display_help
    exit 1
fi

# Check if wipe flag is correct
if [ -n "$3" ] && [ "$3" != "wipe" ]; then
    display_help
    exit 1
fi

# Store the device name
DEVICE=$1

# Check if device exists
if [ ! -e $DEVICE ]; then
    echo "Device $DEVICE does not exist."
    exit 1
fi

# Check if device has existing partitions
if [ "$3" != "wipe" ]; then
    if [ -n "$(lsblk -rno NAME $DEVICE | grep -v $(basename $DEVICE))"]; then
        echo "Device $DEVICE has existing partitions."
        exit 1
    fi
elif [ "$3" = "wipe" ]; then
    wipefs --all --force ${DEVICE}*
fi

# Create a new partition
sfdisk --no-reread $DEVICE << EOF
label: dos
,;
EOF

# Format the new partition
mkfs.ext4 ${DEVICE}1

# Create a mount point
mkdir -p $2

# Mount using fstab
echo "${DEVICE}1 $2 ext4 defaults 0 0" >> /etc/fstab