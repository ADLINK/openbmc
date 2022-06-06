FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
             file://eid_to_name.json \
           "

do_install:append() {
    install -d ${D}/${datadir}/pldm
    install ${WORKDIR}/eid_to_name.json ${D}/${datadir}/pldm/
}
