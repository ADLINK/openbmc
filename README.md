# OpenBMC

[![Build Status](https://openpower.xyz/buildStatus/icon?job=openbmc-build)](https://openpower.xyz/job/openbmc-build/)

OpenBMC is a Linux distribution for management controllers used in devices such
as servers, top of rack switches or RAID appliances. It uses
[Yocto](https://www.yoctoproject.org/),
[OpenEmbedded](https://www.openembedded.org/wiki/Main_Page),
[systemd](https://www.freedesktop.org/wiki/Software/systemd/), and
[D-Bus](https://www.freedesktop.org/wiki/Software/dbus/) to allow easy
customization for your platform.

This repository provides early access to Ampere Computing's BMC implementation
for Ampere's server platform reference designs. It is the intention to submit
all features in this repository to the OpenBMC main project (github/openbmc)
in due course.

For open questions and support, please contact support@amperecomputing.com.

## Setting up your OpenBMC project

### 1) Prerequisite

See the [Yocto documentation](https://docs.yoctoproject.org/ref-manual/system-requirements.html#required-packages-for-the-build-host)
for the latest requirements

#### Ubuntu
```
$ sudo apt install git python3-distutils gcc g++ make file wget \
    gawk diffstat bzip2 cpio chrpath zstd lz4 bzip2
```

#### Fedora
```
$ sudo dnf install git python3 gcc g++ gawk which bzip2 chrpath cpio
hostname file diffutils diffstat lz4 wget zstd rpcgen patch
```

### 2) Download the source
```
git clone https://github.com/bcran/openbmc.git
cd openbmc
```

### 3) Target your hardware
Source the setup script and use one of the following for Ampere's platform:
- mtjade
- mtmitchell
- comhpcalt

For example:
```
. setup mtjade
```

### 4) Build
```
bitbake obmc-phosphor-image
```

On successful build, the BMC image will be located in
```
tmp/deploy/images/<platform>/
```

as
```
obmc-phosphor-image-<platform>-<datetime>.static.mtd
obmc-phosphor-image-<platform>-<datetime>.static.mtd.tar
```

where `<platform>` = mtjade, mtmitchell or comhpcalt

## Installing BMC firmware

If there is no firmware pre-installed on the system, you will need to program it to the BMC's SPI NOR using an external SPI programmer like Dediprog
using obmc-phosphor-image-<platform>.static.mtd.

If a previous version of Ampere's OpenBMC has been installed, perform the following steps to update BMC firmware.

- Open new Redfish token:
```
$ export token=`curl -k -H "Content-Type: application/json" -X POST https://${BMC_IP}/login -d '{"username" :  "root", "password" :  "0penBmc"}' | grep token | awk '{print $2;}' | tr -d '"'`
```

- Use Redfish UpdateService to flash the BMC firmware
```
$ curl -k -H "X-Auth-Token: $token" \
       -H "Content-Type: application/octet-stream" \
       -X POST -T ${BMC_FW}.mtd.tar https://${BMC_IP}/redfish/v1/UpdateService
```

- Reboot BMC to start the firmware update
```
$ curl -c cjar -b cjar -k -H "Content-Type: application/json" -X PUT \
       -d '{"data": "xyz.openbmc_project.State.BMC.Transition.Reboot"}' \
        https://root:0penBmc@${BMC_IP}/xyz/openbmc_project/state/bmc0/attr/RequestedBMCTransition`
```

### Will OpenBMC run on my Acme Server Corp. XYZ5000 motherboard?

This is a common question, particularly regarding boards from popular COTS
(commercial off-the-shelf) vendors such as Supermicro and ASRock.  You can see
the list of supported boards by running `. setup` (with no further arguments) in
the root of the OpenBMC source tree.  Most of the platforms supported by OpenBMC
are specialized servers operated by companies running large datacenters, but
some more generic COTS servers are supported to varying degrees.

If your motherboard is not listed in the output of `. setup` it is not currently
supported.  Porting OpenBMC to a new platform is a non-trivial undertaking,
ideally done with the assistance of schematics and other documentation from the
manufacturer (it is not completely infeasible to take on a porting effort
without documentation via reverse engineering, but it is considerably more
difficult, and probably involves a greater risk of hardware damage).

**However**, even if your motherboard is among those listed in the output of
`. setup`, there are two significant caveats to bear in mind.  First, not all
ports are equally mature -- some platforms are better supported than others, and
functionality on some "supported" boards may be fairly limited.  Second, support
for a motherboard is not the same as support for a complete system -- in
particular, fan control is critically dependent on not just the motherboard but
also the fans connected to it and the chassis that the board and fans are housed
in, both of which can vary dramatically between systems using the same board
model.  So while you may be able to compile and install an OpenBMC build on your
system and get some basic functionality, rough edges (such as your cooling fans
running continuously at full throttle) are likely.

## Features of OpenBMC
## Installing SCP/SYS firmware to EEPROM

To install SCP or SYS firmware to boot EEPROM, need to copy it (in *.slim or *.bin format) into the BMC via scp from BMC console:

```
# scp 10.38.12.53:/tftpboot/altra/altra_scp_1.01.20201019.slim /tmp
```

Then, use the ampere_firmware_upgrade.sh utility to flash the firmware into the Boot EEPROM:

```
# ampere_firmware_upgrade.sh smpmpro /tmp/altra_scp_1.01.20201019.slim 1
```

## Installing UEFI firmware

UEFI firmware can be flashed via Redfish UpdateService interface. It uses the tar format which include the firmware image (in *.img format) and a MANIFEST file. The following steps can be used to create the tar file and install UEFI firmware via Redfish

- Create MANIFEST file with the following content

```
purpose=xyz.openbmc_project.Software.Version.VersionPurpose.Host
version= jade_tianocore_atf_1.99.20201021.img
KeyType=OpenBMC
HashType=RSA-SHA256
MachineName=mtjade
```

- Then create tar file including the firmware image and MANIFEST file:

```
$ tar -cvf jade_tianocore_atf_1.99.20201021.tar jade_tianocore_atf_1.99.20201021.img MANIFEST
```

- Open new Redfish token:

```
$ export token=`curl -k -H "Content-Type: application/json" -X POST https://${BMC_IP}/login -d '{"username" :  "root", "password" :  "0penBmc"}' | grep token | awk '{print $2;}' | tr -d '"'`
```

- Use Redfish UpdateService to flash the UEFI firmware
```
$ curl -k -H "X-Auth-Token: $token" \
       -H "Content-Type: application/octet-stream" \
       -X POST -T jade_tianocore_atf_1.99.20201021.tar \
        https://${BMC_IP}/redfish/v1/UpdateService
```
