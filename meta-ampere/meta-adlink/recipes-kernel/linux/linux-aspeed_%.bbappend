FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://comhpcalt.cfg \
	    file://aspeed-bmc-adlink-comhpcalt.dts \
            file://aspeed-bmc-adlink-comhpcalt-flash32.dtsi \
            file://aspeed-bmc-adlink-comhpcalt-flash64.dtsi \
            file://aspeed-bmc-adlink-comhpcalt-flash128.dtsi \
           "

do_patch[postfuncs] += "copy_dts_file"

do_patch:apend(){
        if [ "${FLASH_SIZE}" = "32768" ]; then
            FLASH_MB=32
        elif [ "${FLASH_SIZE}" = "65536" ]; then
            FLASH_MB=64
        elif [ "${FLASH_SIZE}" = "131072" ]; then
            FLASH_MB=128
        fi
        cp -f ${WORKDIR}/aspeed-bmc-adlink-comhpcalt.dts ${S}/arch/arm/boot/dts/aspeed/
        cp -f ${WORKDIR}/aspeed-bmc-adlink-comhpcalt-flash${FLASH_MB}.dtsi ${S}/arch/arm/boot/dts/aspeed/aspeed-bmc-adlink-comhpcalt-flash.dtsi
}

copy_dts_file(){
        if [ "${FLASH_SIZE}" = "32768" ]; then
            FLASH_MB=32
        elif [ "${FLASH_SIZE}" = "65536" ]; then
            FLASH_MB=64
        elif [ "${FLASH_SIZE}" = "131072" ]; then
            FLASH_MB=128
        fi
        cp -f ${WORKDIR}/aspeed-bmc-adlink-comhpcalt.dts ${S}/arch/arm/boot/dts/aspeed/
        cp -f ${WORKDIR}/aspeed-bmc-adlink-comhpcalt-flash${FLASH_MB}.dtsi ${S}/arch/arm/boot/dts/aspeed/aspeed-bmc-adlink-comhpcalt-flash.dtsi
}
