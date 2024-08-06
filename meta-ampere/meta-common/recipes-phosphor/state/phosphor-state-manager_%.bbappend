FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG:append = " host-gpio"

SRC_URI += " \
              file://ampere-phosphor-reboot-host@.service \
	   "

EXTRA_OEMESON:append = " \
                         -Dboot-count-max-allowed=1 \
                       "

FILES:${PN} += "${systemd_system_unitdir}/*"

do_install:append() {
    install -m 0644 ${WORKDIR}/ampere-phosphor-reboot-host@.service ${D}${systemd_unitdir}/system/phosphor-reboot-host@.service
}
