OpenBMC Port to ADLINK COM-HPC-ALT Systems
==========================================

This subtree contains the port of OpenBMC to ADLINK COM-HPC-ALT Ampere Altra based systems. These include:

- Ampere Altra Dev Kit
- Ampere Altra Developer Platform
- AVA Developer Platform

The build defaults to a 64MB flash size.

Known Issues
------------
- SMPro (SoC/Core/DIMM) sensors occasionally return bogus results, for example temperature readings of 127 degC or 511 degC.
- SMPro (SoC/Core/DIMM) sensors occasionally stop refreshing due to I2C I/O errors that persist until the machine is power cycled.
- Fan control (/usr/share/swampd/config.json) should be tuned/calibrated for each system's fan configuration.
- SOL doesn't work.
- Inventory is missing many items.
- Fan detection isn't working - missing fans are shown as having a high rpm.
- The BMC MAC address is the same on all machines. Ideally should probably generate a unique address from the product or board serial number.

Customizing build for a 32MB flash size
----------------------------------------

The default configuration fits in 64MB flash.
To fit in 32MB (which is the size of the EEPROM ADLINK ships with
their boards) several packages need to be removed, and kernel and
utility builds need to be reduced in size.

Key files to change if you have a 32MB flash are:

meta-ampere/meta-adlink/conf/machine/comhpcalt.conf

Remove:
- lmsensors
- ampere-ipmi-oem
- phosphor-ipmi-blobs
- phosphor-ipmi-blobs-binarystore
- logger-systemd

meta-ampere/meta-adlink/recipes-ampere/packagegroups/packagegroup-ampere-apps.bb

Remove:
- ampere-hostctrl
- obmc-phosphor-buttons-signals
- obmc-phosphor-buttons-handler
- ac01-boot-progress
- phosphor-post-code-manager
- phosphor-host-postd

Change the flash layout include lines in the devicetree source file:
recipes-kernel/linux/linux-aspeed/aspeed-bmc-adlink-comhpcalt.dts

Add or remove kernel options in recipes-kernel/linux/linux-aspeed/comhpcalt.cfg

For a 128MB flash, again update the devicetree source and update the FLASH_SIZE in comhpcalt.conf
