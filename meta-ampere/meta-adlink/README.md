OpenBMC Port to ADLINK COM-HPC-ALT Systems
==========================================

This subtree contains the port of OpenBMC to ADLINK COM-HPC-ALT Ampere Altra based systems. These include:

- Ampere Altra Dev Kit
- Ampere Altra Developer Platform
- AVA Developer Platform

Known Issues
------------
- SMPro (SoC/Core/DIMM) sensors occasionally return bogus results, for example temperature readings of 127 degC or 511 degC.
- SMPro (SoC/Core/DIMM) sensors occasionally stop refreshing due to I2C I/O errors that persist until the machine is power cycled.
- Fan control (/usr/share/swampd/config.json) should be tuned/calibrated for each system's fan configuration.
- SOL doesn't work.
- Inventory is missing many items.
- BMC MAC address is the same across all systems.
- Fan detection isn't working - missing fans are shown as having a high rpm.
- The BMC MAC address is the same on all machines. Ideally should probably generate a unique address from the product or board serial number.
