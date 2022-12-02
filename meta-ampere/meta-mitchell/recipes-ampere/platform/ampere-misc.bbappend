FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"
FILESEXTRAPATHS:append := "${THISDIR}/${PN}/mctp-ctrl:"
FILESEXTRAPATHS:append := "${THISDIR}/${PN}/peripheral-manager:"

PACKAGECONFIG[ampere-trst-wa] = "-Dampere-trst-wa=enabled, -Dampere-trst-wa=disabled"

PACKAGECONFIG = " mctp-ctrl peripheral-manager state-logger ampere-cpld-fwupdate ampere-trst-wa"
PACKAGECONFIG[mctp-ctrl] = "-Dmctp-ctrl=enabled -Dmctp-delay-before-add-terminus=1000 \
                            -Dmctp-delay-before-add-second-terminus=0 \
                            -Dmctp-checking-s1-ready-time-out=20000, \
                            -Dmctp-ctrl=disabled"

SRC_URI += " \
             file://ampere_slave_present.sh \
             file://ampere_s1_ready.sh \
             file://peripheral_config.json \
           "

SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains("PACKAGECONFIG", "ampere-trst-wa", "ampere-trst-wa.service", "", d)}"

do_install:append () {
    install -d ${D}/${sbindir}
    install -m 0755 ${WORKDIR}/ampere_slave_present.sh ${D}/${sbindir}/ampere_slave_present.sh
    install -m 0755 ${WORKDIR}/ampere_s1_ready.sh ${D}/${sbindir}/ampere_s1_ready.sh

    install -d ${D}/etc/peripheral
    install -m 0644 -D ${WORKDIR}/peripheral_config.json ${D}/etc/peripheral/config.json
}
