FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

RDEPENDS:${PN} += "bash"

SRC_URI:append = " \
                  file://mctp-local.service \
                 "

SRCREV = "69ed224ff9b5206ca7f3a5e047a9da61377d2ca7"

SYSTEMD_SERVICE:${PN} += "mctp-local.service"

EXTRA_OEMESON:append = " \
                        -Dtests=false \
                       "

do_install:append() {
    install -m 0644 ${WORKDIR}/mctp-local.service ${D}${systemd_system_unitdir}/
}

