#!/bin/bash

iso="windows.iso"
config="addons/autounattend.xml"
output="winstall.iso"

OPTIONS="c:i:o:h"
LONGOPTS="config:,iso:,output:,help"

use_custom_config=false
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")

if [[ $? -ne 0 ]]; then
    echo "No arguments provided, exiting."
	exit 2
fi

eval set -- "$PARSED"

while true; do
    case "$1" in
		-c|--config)
            config="$2"
            use_custom_config=true
            shift 2
            ;;
		-i|--iso)
			iso="$2"
			shift 2
			;;
        -o|--output)
            output="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [--config <path> | --iso <path> | --output <path>]"
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Invalid option: $1"
            exit 1
            ;;
    esac
done

if ! [ -d "win11" ]; then
    mkdir "win11"
fi

config_dir="addons"

if ! [ -f "$config" ] && [ "$use_custom_config" = true ]; then
    echo "Provided config file "$config" doesn't exist! Aborting."
    exit 1
fi

if [ "$use_custom_config" = true ]; then
    if ! [ -d "addons/custom" ]; then
        mkdir -p "addons/custom"
    fi

    cp "$config" "addons/custom/autounattend.xml"
    config_dir="addons/custom"
fi

if ! [ -f "$iso" ]; then
    echo "Provided iso file "$iso" doesn't exist! Aborting."
    exit 1
fi

sudo mount -o loop "$iso" win11

xorriso -as mkisofs \
    -iso-level 4 \
    -rock \
    -disable-deep-relocation \
    -untranslated-filenames \
    -b boot/etfsboot.com \
    -no-emul-boot \
    -boot-load-size 8 \
    -eltorito-alt-boot \
    -eltorito-platform efi \
    -b efi/microsoft/boot/efisys_noprompt.bin \
    -V "CCCOMA_X64FRE_EN-GB_DV9" \
    -volset "CCCOMA_X64FRE_EN-GB_DV9" \
    -publisher "MICROSOFT CORPORATION" \
    -p "MICROSOFT CORPORATION, ONE MICROSOFT WAY, REDMOND WA 98052, (425) 882-8080" \
    -A "CDIMAGE 2.56 (01/01/2005 TM)" \
    -o "$output" \
    win11 $config_dir