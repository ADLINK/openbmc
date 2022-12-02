FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://0001-amperecpu-Add-Ampere-CPU-daemon.patch \
            file://0002-amperecpu-Scan-CPU-sensors-in-the-first-power-on.patch \
            file://0003-amperecpu-Support-PresenceGpio-option.patch \
            file://0004-Support-value-chassisOn-for-powerState-option.patch \
            file://0005-adcsensor-Disable-io_uring-build.patch \
            file://0006-chassisintrusionsensor-hwmon-adding.patch \
            file://0007-chassisintrusionsensor-add-ReArm-property.patch \
           "

PACKAGECONFIG[amperecpusensor] = "-Dampere-cpu=enabled, -Dampere-cpu=disabled"
SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'amperecpusensor', \
                                               'xyz.openbmc_project.amperecpusensor.service', \
                                               '', d)}"
