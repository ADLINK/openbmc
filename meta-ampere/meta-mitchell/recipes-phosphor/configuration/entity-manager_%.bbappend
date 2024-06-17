FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
            file://mtmitchell_mb.json \
            file://mtmitchell_bmc.json \
            file://blacklist.json \
            file://mtmitchell_bp.json \
            file://mtmitchell_x16_riser.json \
           "

do_install:append() {
     install -d ${D}${datadir}/${PN}
     install -m 0444 ${WORKDIR}/blacklist.json ${D}${datadir}/${PN}
     install -d ${D}${datadir}/${PN}/configurations
     install -m 0444 ${WORKDIR}/mtmitchell_mb.json ${D}${datadir}/${PN}/configurations
     install -m 0444 ${WORKDIR}/mtmitchell_bmc.json ${D}${datadir}/${PN}/configurations
     install -m 0444 ${WORKDIR}/mtmitchell_bp.json ${D}${datadir}/${PN}/configurations
     install -m 0444 ${WORKDIR}/mtmitchell_x16_riser.json ${D}${datadir}/${PN}/configurations
     rm -f ${D}${datadir}/${PN}/configurations/nvme_p4000.json
}
