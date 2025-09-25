# What is winstall?
Winstall is a simple collection of bash scripts for making custom Windows 11 ISO files for the purpose of automated unattended Windows 11 installations.
Currently winstall is confirmed to work on apt-based Linux distros such as Ubuntu and Debian.

Winstall is especially useful for hobbyists and other similar non-enterprise users who need to manage multiple Windows installations with various tweaks.

# Usage
## 1. Clone this repo

## 2. Download Windows 11 ISO
Download Windows 11 ISO file manually from https://www.microsoft.com/en-us/software-download/windows11 and save the downloaded ISO file to the root of this repository and rename it to `windows.iso`.

## 3. (OPTIONAL): Configure autounattend.xml
Autounattend.xml is the configuration file that makes Windows 11 install fully automatic.
You can generate your own custom configuration easily at https://schneegans.de/windows/unattend-generator/ or use the default one provided by this repository in `addons` directory.

**IMPORTANT:** Note that the default autounattend.xml provided by this repo chooses the target disk for installation automatically. If you have multiple disks and want to choose a spesific disk, you should use a custom autounattend.xml. 

To use your own `autounattend.xml`, replace the one provided by this repository with yours in the `addons` directory.

## 4. Build and run
First run `./build.sh` to create `winstall.iso`. You can use the created **winstall.iso** as such for virtual machine installations. If you don't know how to do that, learn to use the original Windows 11 ISO first.

**Optional:** If you want to install baremetal devices such as laptops, you have to plug in your installation media such as an USB stick. Then run `./burn.sh`.

Now you are ready to us your new automated Windows 11 install media.

Make sure that the USB is booted in UEFI mode on the target device. The rest will be handled by the automatic windows installation if all steps were done correctly and the target device is supported and correctly configured from the BIOS.

### Quick reference examples for basic use
Usage: build.sh [--config <path> | --iso <path> | --output <path> | --help]

With custom iso path and custom autounattend.xml path:
```bash
./build.sh -i <original-windows-iso-file-path> -c <path-to-custom-xml-config>
```

With custom iso path and custom output path:
```bash
./build.sh -i <original-windows-iso-file-path> -o <path-to-output-iso>
```

# Pro tips
The default autounattend.xml has a source url to the config on line 3 of the xml config. Using it saves a lot of time for creating customizations based on the defaults chosen by this repository.

# Acknowledgements
Thanks to https://blog.linux-ng.de/author/marcel/ for creating their great blog post about Windows 11 ISO creation: https://blog.linux-ng.de/2025/01/02/build-unattended-windows-iso/ 