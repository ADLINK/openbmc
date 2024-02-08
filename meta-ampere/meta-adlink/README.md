OpenBMC Port to ADLINK COM-HPC-ALT Systems
==========================================

This subtree contains the port of OpenBMC to ADLINK COM-HPC-ALT Ampere
Altra based systems. These include:

- Ampere Altra Dev Kit
- Ampere Altra Developer Platform
- AVA Developer Platform

Known Issues
------------
- SMPro (SoC/Core/DIMM) sensors occasionally return bogus results, for
  example temperature readings of 127 degC or 511 degC.
- SMPro (SoC/Core/DIMM) sensors occasionally stop refreshing due to I2C
  I/O errors that persist until the machine is power cycled.
- Fan control (/usr/share/swampd/config.json) should be tuned/calibrated
  for each system's fan configuration.
- SOL doesn't work.
- Inventory is missing many items.
- Fan detection isn't working - missing fans are shown as having a high rpm.
- The BMC MAC address is the same on all machines. Ideally should probably
  generate a unique address from the product or board serial number.

Flash Sizes
-----------

The default configuration builds a 32MB firmware image, which fits in the
SPI-NOR EEPROMs that ADLINK ships with their systems. However, it's a tight
fit and several potentially useful packages are removed, plus the filesystem
doesn't have much space left.

If you have a 64MB (512Mb) or 128MB (1Gb) EEPROM, you can build firmware
images for them by overriding the default `FLASH_SIZE`.
After running `. setup comhpcalt` edit conf/local.conf (i.e.
build/comhpcalt/conf/local.conf) and add a line:
```
FLASH_SIZE = "65536"
```
Or:
```
FLASH_SIZE = "131072"
```

Building
--------

Run the following to build a firmware image:

```
. setup comhpcalt
bitbake obmc-phosphor-image
```

If you're building on a system with a relatively large number of cores compared to memory (such as 8 cores and 32GB RAM)
you'll probably want to reduce the default parallelism during the build to avoid running out of memory.

Do this by adding the following to conf/local.conf after running `. setup comhpcalt` e.g.:
```
BB_NUMBER_THREADS = "2"
PARALLEL_MAKE = "-j 2"
```
