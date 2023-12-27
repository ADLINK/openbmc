FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG:remove = " intelcpusensor"
PACKAGECONFIG:append = " nvmesensor"

SRC_URI += " \
            file://0001-amperecpu-Add-Ampere-CPU-daemon.patch \
            file://0002-amperecpu-Scan-CPU-sensors-in-the-first-power-on.patch \
            file://0003-amperecpu-change-condition-to-re-scan-CPU-devices.patch \
            file://0004-Remove-throwing-exception-when-can-not-write-data-to.patch \
            file://0005-adcsensor-Add-support-DevName-option.patch \
            file://0006-ADC-Match-InterfaceAdded-signal.patch \
            file://0007-Support-configuration-Max-Min-values-from-EM.patch \
           "

PACKAGECONFIG[amperecpusensor] = "-Dampere-cpu=enabled, -Dampere-cpu=disabled"
SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'amperecpusensor', \
                                               'xyz.openbmc_project.amperecpusensor.service', \
                                               '', d)}"
