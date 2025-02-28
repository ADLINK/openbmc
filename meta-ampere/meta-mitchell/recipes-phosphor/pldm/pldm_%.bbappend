FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
             file://dbus_to_host_effecter.json \
             file://eid_to_name.json \
             file://ampere_pldm_effecter_trigger.sh \
             file://ampere_pldm_event_handler.sh \
           "

do_install:append() {
    install -d ${D}/${datadir}/pldm
    install ${WORKDIR}/eid_to_name.json ${D}/${datadir}/pldm/
    install ${WORKDIR}/dbus_to_host_effecter.json ${D}/${datadir}/pldm/host/

    install -d ${D}/usr/sbin
    install -m 0755 ${WORKDIR}/ampere_pldm_effecter_trigger.sh ${D}/${sbindir}/
    install -m 0755 ${WORKDIR}/ampere_pldm_event_handler.sh ${D}/${sbindir}/
}
