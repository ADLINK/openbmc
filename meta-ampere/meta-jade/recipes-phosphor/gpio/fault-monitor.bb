SUMMARY = "MTJade fault-led application"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit obmc-phosphor-systemd

DEPENDS += "virtual/obmc-gpio-monitor"
RDEPENDS:${PN} += "virtual/obmc-gpio-monitor"

S = "${WORKDIR}"
SRC_URI += "file://toggle_fault_led.sh"

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ${WORKDIR}/toggle_fault_led.sh \
        ${D}${bindir}/toggle_fault_led.sh
}

OBMC_FAULT_MONITOR_INSTANCES = "s0_fault_alert_start s0_fault_alert_stop s1_fault_alert_start s1_fault_alert_stop"

SYSTEMD_ENVIRONMENT_FILE:${PN} += "obmc/gpio/s0_fault_alert_start \
                                   obmc/gpio/s0_fault_alert_stop \
                                   obmc/gpio/s1_fault_alert_start \
                                   obmc/gpio/s1_fault_alert_stop \
                                  "

TMPL = "phosphor-gpio-monitor@.service"
INSTFMT = "phosphor-gpio-monitor@{0}.service"
TGT = "multi-user.target"
FMT = "../${TMPL}:${TGT}.requires/${INSTFMT}"

SYSTEMD_SERVICE:${PN} += "ampere_fault_led_start@.service \
                          ampere_fault_led_stop@.service \
                         "
SYSTEMD_LINK:${PN} += "${@compose_list(d, 'FMT', 'OBMC_FAULT_MONITOR_INSTANCES')}"

