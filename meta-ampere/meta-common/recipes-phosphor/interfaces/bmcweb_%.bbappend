FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

EXTRA_OEMESON:append = " \
     -Dinsecure-tftp-update=disabled \
     -Dbmcweb-logging=enabled \
     -Dredfish-bmc-journal=enabled \
     -Dhttp-body-limit=65 \
     -Dvm-nbdproxy=enabled \
     -Dredfish-dump-log=enabled \
     "

SRC_URI += " \
            file://0001-Re-enable-vm-nbdproxy-for-Virtual-Media.patch \
            file://0002-Redfish-Add-message-registries-for-Ampere-event.patch \
            file://0003-Report-boot-progress-code-to-Redfish.patch \
            file://0004-LogService-Add-CPER-logs-crashdumps-to-FaultLog.patch \
            file://0005-Add-function-to-get-AdditionalDataURI-of-FaultLog.patch \
            file://0006-IntrusionSensor-patch-handler-and-IntrusionSensorReArm-support.patch \
            file://0007-Support-Redfish-Hostinterface-schema.patch \
            file://0008-Support-HostInterface-privilege-role.patch \
            file://0009-Revert-Implement-If-Match-header-in-Http-layer.patch \
            file://0010-Check-HostName-valid-on-PATCH-operation.patch \
           "
