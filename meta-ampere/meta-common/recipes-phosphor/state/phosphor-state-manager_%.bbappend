FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEPS_CFG = "resetreason.conf"
DEPS_TGT = "phosphor-discover-system-state@.service"
SYSTEMD_OVERRIDE:${PN}-discover:append = "${DEPS_CFG}:${DEPS_TGT}.d/${DEPS_CFG}"

FILES:${PN} += "${systemd_system_unitdir}/*"

SRC_URI += " \
             file://0001-Limit-power-actions-when-the-host-is-off.patch \
           "
