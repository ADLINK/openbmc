FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"
FILESEXTRAPATHS:append := "${THISDIR}/${PN}/mctp-ctrl:"
FILESEXTRAPATHS:append := "${THISDIR}/${PN}/nmi-manager:"

PACKAGECONFIG += " mctp-ctrl nmi-manager"

PACKAGECONFIG[mctp-ctrl] = "-Dmctp-ctrl=enabled -Dmctp-delay-before-add-terminus=1000 \
                            -Dmctp-delay-before-add-second-terminus=0 \
                            -Dmctp-checking-s1-ready-time-out=20000, \
                            -Dmctp-ctrl=disabled"

SRC_URI += " \
             file://ampere_slave_present.sh \
             file://ampere_s1_ready.sh \
             file://nmi.service \
           "

do_install:append () {
    install -d ${D}/${sbindir}
    install -m 0755 ${WORKDIR}/ampere_slave_present.sh ${D}/${sbindir}/ampere_slave_present.sh
    install -m 0755 ${WORKDIR}/ampere_s1_ready.sh ${D}/${sbindir}/ampere_s1_ready.sh

    install -m 0755 ${WORKDIR}/nmi.service ${D}${systemd_unitdir}/system/nmi.service
}
