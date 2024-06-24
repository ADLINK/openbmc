FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
             file://firmware_update.sh \
             file://0001-BMC-Updater-Support-update-on-BMC-Alternate-device.patch \
           "

PACKAGECONFIG:append = " flash_bios"

RDEPENDS:${PN} += "bash"

do_install:append() {
    install -d ${D}/usr/sbin
    install -m 0755 ${WORKDIR}/firmware_update.sh ${D}/usr/sbin/firmware_update.sh
}
