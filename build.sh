#!/bin/bash
if ! [ -d "win11" ]; then
    mkdir "win11"
fi

sudo mount -o loop windows.iso win11

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
    -o winstall.iso \
    win11 addons