FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEPENDS += "gpioplus libgpiod"

SRC_URI += " \
	      file://0001-Limit-power-actions-when-the-host-is-off.patch \
	   "

EXTRA_OEMESON:append = " \
                         -Dhost-gpios=enabled \
                         -Dboot-count-max-allowed=1 \
                         -Donly-run-apr-on-power-loss=true \
                       "

FILES:${PN} += "${systemd_system_unitdir}/*"
FILES:${PN}-host += "${bindir}/phosphor-host-condition-gpio"
SYSTEMD_SERVICE:${PN}-host += "phosphor-host-condition-gpio@.service"

pkg_postinst:${PN}-obmc-targets:prepend() {
    mkdir -p $D$systemd_system_unitdir/multi-user.target.requires
    LINK="$D$systemd_system_unitdir/multi-user.target.requires/phosphor-host-condition-gpio@0.service"
    TARGET="../phosphor-host-condition-gpio@.service"
    ln -s $TARGET $LINK
}

pkg_prerm:${PN}-obmc-targets:prepend() {
    LINK="$D$systemd_system_unitdir/multi-user.target.requires/phosphor-host-condition-gpio@0.service"
    rm $LINK
}
