FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://comhpcalt.cfg \
	    file://aspeed-bmc-adlink-comhpcalt.dts \
           "

#do_patch[postfuncs] += "copy_dts_file"

do_patch:apend(){
        cp -f ${WORKDIR}/aspeed-bmc-adlink-comhpcalt.dts ${S}/arch/arm/boot/dts/
}

copy_dts_file(){
        cp -f ${WORKDIR}/aspeed-bmc-adlink-comhpcalt.dts ${S}/arch/arm/boot/dts/
}
