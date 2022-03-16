FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

RRECOMMENDS:${PN} += "ipmitool"
RDEPENDS:${PN} += "bash"

PACKAGECONFIG:append = " dynamic-sensors"
HOSTIPMI_PROVIDER_LIBRARY += "libdynamiccmds.so"

SRC_URI += "\
            file://0001-Allow-user-access-from-external-repos.patch \
            file://0002-Disable-SDR-and-SEL-ipmi-commands-in-dynamic-library.patch \
            file://0003-Response-thresholds-for-Get-SDR-command.patch \
            file://0004-dbus-sdr-support-static-FRU-s-ID-configuration.patch \
            file://0005-Change-method-for-NMI-triggering.patch \
            file://0006-dcmihandler-Change-Get-DCMI-sensor-info-privilege-to.patch \
            file://0007-dcmi-Support-fully-power-limit-setting-commands.patch \
            file://ampere-phosphor-softpoweroff \
            file://ampere.xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service \
           "

AMPERE_SOFTPOWEROFF_TMPL = "ampere.xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service"

do_install:append(){
    install -d ${D}${includedir}/phosphor-ipmi-host
    install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
    install -m 0755 ${WORKDIR}/ampere-phosphor-softpoweroff ${D}/${bindir}/phosphor-softpoweroff
    install -m 0644 ${WORKDIR}/${AMPERE_SOFTPOWEROFF_TMPL} ${D}${systemd_unitdir}/system/xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service
}
