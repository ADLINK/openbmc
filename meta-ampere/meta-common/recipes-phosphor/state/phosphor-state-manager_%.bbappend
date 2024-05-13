FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG:append = " host-gpio"

SRC_URI += " \
              file://ampere-phosphor-reboot-host@.service \
              file://phosphor-discover-system-state-override.conf \
              file://0001-Limit-power-actions-when-the-host-is-off.patch \
              file://0002-Prevent-services-enter-failed-state-while-restarting.patch \
	      file://ampere_phosphor-service-monitor-default.json \
           "

EXTRA_OEMESON:append = " \
                         -Dboot-count-max-allowed=1 \
                       "

FILES:${PN} += "${systemd_system_unitdir}/*"
FILES:${PN}-discover += "${systemd_system_unitdir}/phosphor-discover-system-state@0.service.d"

do_install:append() {
    install -m 0644 ${WORKDIR}/ampere-phosphor-reboot-host@.service ${D}${systemd_unitdir}/system/phosphor-reboot-host@.service

    install -d ${D}${systemd_system_unitdir}/phosphor-discover-system-state@0.service.d
    install -m 644 ${WORKDIR}/phosphor-discover-system-state-override.conf \
        ${D}${systemd_system_unitdir}/phosphor-discover-system-state@0.service.d

    install -d ${D}${sysconfdir}/phosphor-systemd-target-monitor
    install -m 0644 ${WORKDIR}/ampere_phosphor-service-monitor-default.json \
        ${D}${sysconfdir}/phosphor-systemd-target-monitor/phosphor-service-monitor-default.json
}
