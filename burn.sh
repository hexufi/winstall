#!/bin/bash

disks=$(lsblk -dpno NAME,TYPE | awk '$2 == "disk" {print $1}')

# Check if any disks are found
if [[ -z "$disks" ]]; then
    echo "No disks found! Aborting burning."
    exit 1
fi

echo "Enter the number of disk you want to use for burning windows ISO:"
select disk in $disks; do
    if [[ -n "$disk" ]]; then
        echo "Selected disk for iso burning: $disk"
        selected_disk=$disk
        break
    else
        echo "Invalid selection, try again."
    fi
done

read -p "Winstall ISO will be burned to device $selected_disk. All data will be lost for the selected device. Continue? (yes/no): " confirm
        case "$confirm" in
            [Yy][Ee][Ss]|[Yy])
                echo "Confirmed. Using $disk."
                sudo dd if="$PWD/winstall.iso" of="$selected_disk" bs=4M status=progress && sync
                ;;
            [Nn][Oo]|[Nn])
                echo "Aborting ISO burning."
                ;;
            *)
                echo "Invalid response. Please type yes or no."
                ;;
        esac

