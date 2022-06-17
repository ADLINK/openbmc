FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

EXTRA_OEMESON:append = " \
     -Dredfish-bmc-journal=enabled \
     -Dhttp-body-limit=65 \
     -Dredfish-dump-log=enabled \
     -Dredfish-allow-deprecated-power-thermal=disabled \
     "

SRC_URI += " \
            file://0001-support-BootProgress-OemLastState.patch \
            file://0002-LogService-Add-CPER-logs-crashdumps-to-FaultLog.patch \
            file://0003-LogService-Support-download-FaultLog-data-via-Additi.patch \
            file://0004-Support-Redfish-Hostinterface-schema.patch \
            file://0005-Support-HostInterface-privilege-role.patch \
            file://0006-Check-HostName-valid-on-PATCH-operation.patch \
            file://0007-Disable-patching-to-IPv4Address-when-DHCP-is-enabled.patch \
            file://0008-Prevent-the-Operator-user-to-flash-the-firmware.patch \
            file://0009-Redfish-Add-message-registries-for-Ampere-events.patch\
            file://0010-chassis-Methods-to-PhysicalSecurity-s-properties.patch \
            file://0011-Support-remove-user-s-web-session.patch \
            file://0012-Enable-vm-nbdproxy-for-Redfish-Virtual-Media.patch \
            file://0013-Prevent-showing-sensors-not-belong-to-the-chassis-in.patch \
           "
