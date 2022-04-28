FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://0001-mtd-spi-spi-nor-core-Check-the-4byte-opcode-supporti.patch \
           "
